table 56032 "Contenido Cajas Packing"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    A adido campos "No. Pedido" "No. linea pedido".
    //                                   Algunos cambios para funcionar correctamente con
    //                                   pedidos si la BBDD no tiene gesti n almac n.
    // 20121       CAT     01/06/15      Reprogramacion en la busqueda por codigo de barras
    // 
    // #2945       JML     10/07/2014    A adido pedidos de consignaci n y transferencia.
    //                                   Nuevo campo tipo de pedido

    Caption = 'Packing Box Content';
    Permissions = TableData 5773 = rimd;

    fields
    {
        field(1; "No. Packing"; Code[20])
        {
        }
        field(2; "No. Caja"; Code[20])
        {
            Caption = 'Box No.';
        }
        field(3; "No. Producto"; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; Descripcion; Text[200])
        {
            Caption = 'Description';
        }
        field(5; "No. Linea"; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Cod. Barras"; Code[30])
        {
            Caption = 'Barcode';

            trigger OnValidate()
            var
                recLinVta: Record 37;
                recLinTransfer: Record 5741;
            begin
                //Codigo de barras
                IF (STRLEN(FORMAT("Cod. Barras"))) > 5 THEN BEGIN
                    ICR.RESET;
                    ICR.SETRANGE("Cross-Reference Type", ICR."Cross-Reference Type"::"Bar Code");
                    ICR.SETRANGE(ICR."Cross-Reference No.", "Cod. Barras");
                    IF ICR.FINDFIRST THEN
                      //se localiza el producto en a linea de picking registrado
                      BEGIN
                        //+#854
                        IF NOT FuncSant.TieneGestionAlmacen THEN BEGIN

                            CASE "Tipo pedido" OF
                                "Tipo pedido"::Venta:
                                    BEGIN

                                        recLinVta.RESET;
                                        IF "No. Linea Pedido" <> 0 THEN
                                            recLinVta.SETRANGE("Line No.", "No. Linea Pedido");
                                        recLinVta.SETRANGE("Document Type", recLinVta."Document Type"::Order);
                                        recLinVta.SETRANGE("Document No.", "No. Pedido");
                                        recLinVta.SETRANGE(Type, recLinVta.Type::Item);
                                        recLinVta.SETRANGE("No.", ICR."Item No.");
                                        IF recLinVta.FINDFIRST THEN BEGIN
                                            "No. Producto" := recLinVta."No.";
                                            "Cod. Unidad de Medida" := recLinVta."Unit of Measure Code";
                                            Descripcion := recLinVta.Description;
                                            "No. Linea Pedido" := recLinVta."Line No.";
                                        END;
                                    END;
                                "Tipo pedido"::Consignacion, "Tipo pedido"::Transferencia:
                                    BEGIN
                                        recLinTransfer.RESET;
                                        recLinTransfer.SETRANGE("Document No.", "No. Pedido");
                                        recLinTransfer.SETRANGE("Item No.", ICR."Item No.");
                                        IF recLinTransfer.FINDFIRST THEN BEGIN
                                            "No. Producto" := recLinTransfer."Item No.";
                                            "Cod. Unidad de Medida" := recLinTransfer."Unit of Measure Code";
                                            Descripcion := recLinTransfer.Description;
                                            "No. Linea Picking" := recLinTransfer."Line No.";
                                        END;
                                    END;
                            END;

                        END
                        ELSE BEGIN
                            //-#854

                            RWAL.RESET;
                            RWAL.SETRANGE(RWAL."Activity Type", RWAL."Activity Type"::Pick);
                            RWAL.SETRANGE(RWAL."No.", "No. Picking");
                            RWAL.SETRANGE(RWAL."Item No.", ICR."Item No.");
                            RWAL.SETRANGE(RWAL."Action Type", RWAL."Action Type"::Take);
                            IF RWAL.FINDFIRST THEN BEGIN
                                "No. Producto" := RWAL."Item No.";
                                //Cantidad := RWAL.Quantity;
                                "Cod. Unidad de Medida" := RWAL."Unit of Measure Code";
                                Descripcion := RWAL.Description;
                                "No. Linea Picking" := RWAL."Line No.";
                                RWAL1.GET(RWAL."Activity Type", RWAL."No.", RWAL."Line No.");
                                RWAL1.VALIDATE("No. Packing", "No. Packing");
                                RWAL1.VALIDATE("No. Caja", "No. Caja");
                                //RWAL1.VALIDATE("No. Linea Packing","No. Linea");
                                RWAL1.MODIFY(TRUE);
                            END
                            ELSE
                                ERROR(Error003, ICR."Item No.", "No. Picking");
                        END; //+#854
                    END
                    ELSE
                        MESSAGE(txt001);
                END
                ELSE BEGIN
                    //+#854
                    IF NOT FuncSant.TieneGestionAlmacen THEN BEGIN

                        CASE "Tipo pedido" OF
                            "Tipo pedido"::Venta:
                                BEGIN
                                    IF recLinVta.GET("No. Pedido", "No. Linea Pedido") THEN BEGIN
                                        CCP.RESET;
                                        CCP.SETRANGE("No. Packing", "No. Packing");
                                        CCP.SETRANGE("No. Producto", "No. Producto");
                                        IF CCP.FINDSET THEN
                                            REPEAT
                                                IF CCP.GETPOSITION <> GETPOSITION THEN
                                                    wCant1 += CCP.Cantidad;
                                            UNTIL CCP.NEXT = 0;
                                        EVALUATE(wCant, "Cod. Barras");

                                        IF recLinVta.Quantity < (wCant1 + wCant) THEN
                                            ERROR(Error004);
                                    END;
                                END;
                            "Tipo pedido"::Consignacion, "Tipo pedido"::Transferencia:
                                BEGIN
                                    IF recLinTransfer.GET("No. Pedido", "No. Linea Pedido") THEN BEGIN
                                        CCP.RESET;
                                        CCP.SETRANGE("No. Packing", "No. Packing");
                                        CCP.SETRANGE("No. Producto", "No. Producto");
                                        IF CCP.FINDSET THEN
                                            REPEAT
                                                IF CCP.GETPOSITION <> GETPOSITION THEN
                                                    wCant1 += CCP.Cantidad;
                                            UNTIL CCP.NEXT = 0;
                                        EVALUATE(wCant, "Cod. Barras");

                                        IF recLinTransfer.Quantity < (wCant1 + wCant) THEN
                                            ERROR(Error004);
                                    END;
                                END;
                        END;
                    END
                    ELSE BEGIN
                        //-#854
                        IF RWAL.GET(RWAL."Activity Type"::Pick, "No. Picking", "No. Linea Picking") THEN BEGIN
                            //Se calcula la cantidad del producto que est'a incluida en otras cajas
                            CCP.RESET;
                            CCP.SETRANGE("No. Packing", "No. Packing");
                            //CCP.SETRANGE("No. Caja","No. Caja");
                            CCP.SETRANGE("No. Producto", "No. Producto");
                            CCP.SETFILTER("No. Linea", '<>%1', "No. Linea");
                            IF CCP.FINDSET THEN
                                REPEAT
                                    wCant1 += CCP.Cantidad;
                                UNTIL CCP.NEXT = 0;
                            EVALUATE(wCant, "Cod. Barras");

                            IF RWAL.Quantity < (wCant1 + wCant) THEN
                                ERROR(Error001);
                        END;
                    END; //+#854
                    EVALUATE(Cantidad, "Cod. Barras");
                END;
            end;
        }
        field(7; "Cod. Unidad de Medida"; Code[20])
        {
            Caption = 'Unit Of Measure Code';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No. Producto"));
        }
        field(8; Cantidad; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            var
                recLinVta: Record 37;
                recLinTransfer: Record 5741;
            begin
                //+#854
                IF NOT FuncSant.TieneGestionAlmacen THEN BEGIN

                    TESTFIELD("No. Linea Pedido");


                    CASE "Tipo pedido" OF
                        "Tipo pedido"::Venta:
                            BEGIN
                                IF recLinVta.GET(recLinVta."Document Type"::Order, "No. Pedido", "No. Linea Pedido") THEN BEGIN
                                    //Se calcula la cantidad del producto que est'a incluida en otras cajas
                                    CCP.RESET;
                                    CCP.SETRANGE("No. Packing", "No. Packing");
                                    CCP.SETRANGE("No. Producto", "No. Producto");
                                    IF CCP.FINDSET THEN
                                        REPEAT
                                            IF CCP.GETPOSITION <> GETPOSITION THEN
                                                wCant1 += CCP.Cantidad;
                                        UNTIL CCP.NEXT = 0;
                                    wCant := Cantidad;

                                    IF recLinVta.Quantity < (wCant1 + wCant) THEN
                                        ERROR(Error002);
                                END;
                            END;
                        "Tipo pedido"::Consignacion, "Tipo pedido"::Transferencia:
                            BEGIN
                                IF recLinTransfer.GET("No. Pedido", "No. Linea Pedido") THEN BEGIN
                                    //Se calcula la cantidad del producto que est'a incluida en otras cajas
                                    CCP.RESET;
                                    CCP.SETRANGE("No. Packing", "No. Packing");
                                    CCP.SETRANGE("No. Producto", "No. Producto");
                                    IF CCP.FINDSET THEN
                                        REPEAT
                                            IF CCP.GETPOSITION <> GETPOSITION THEN
                                                wCant1 += CCP.Cantidad;
                                        UNTIL CCP.NEXT = 0;
                                    wCant := Cantidad;

                                    IF recLinTransfer.Quantity < (wCant1 + wCant) THEN
                                        ERROR(Error002);
                                END;
                            END;
                    END;

                END
                ELSE BEGIN
                    //-#854
                    TESTFIELD("No. Linea Picking");

                    IF RWAL.GET(RWAL."Activity Type"::Pick, "No. Picking", "No. Linea Picking") THEN BEGIN
                        //Se calcula la cantidad del producto que est'a incluida en otras cajas
                        CCP.RESET;
                        CCP.SETRANGE("No. Packing", "No. Packing");
                        CCP.SETRANGE("No. Producto", "No. Producto");
                        CCP.SETFILTER("No. Linea", '<>%1', "No. Linea");
                        CCP.SETRANGE(CCP."No. Linea Picking", "No. Linea Picking");
                        IF CCP.FINDSET THEN
                            REPEAT
                                wCant1 += CCP.Cantidad;
                            UNTIL CCP.NEXT = 0;
                        wCant := Cantidad;

                        IF RWAL.Quantity < (wCant1 + wCant) THEN
                            ERROR(Error001);
                    END;
                END; //+#854
            end;
        }
        field(9; "No. Picking"; Code[20])
        {
            Caption = 'Picking No';
        }
        field(10; "No. Linea Picking"; Integer)
        {
            Caption = 'Picking Line No.';
            TableRelation = "Registered Whse. Activity Line"."Line No." WHERE("Activity Type" = FILTER(Pick),
                                                                               No.=FIELD("No. Picking"),
                                                                               Action Type=FILTER(Take));

            trigger OnValidate()
            begin
                IF RWAL.GET(RWAL."Activity Type"::Pick,"No. Picking","No. Linea Picking") THEN
                  BEGIN
                    "No. Producto" := RWAL."Item No.";
                    //Cantidad := RWAL.Quantity;
                    "Cod. Unidad de Medida" := RWAL."Unit of Measure Code";
                    Descripcion := RWAL.Description;
                    "No. Linea Picking" := RWAL."Line No.";
                    RWAL.VALIDATE("No. Packing","No. Packing");
                    RWAL.VALIDATE("No. Caja","No. Caja");
                   // RWAL.VALIDATE("No. Linea Packing","No. Linea");
                    RWAL.MODIFY(TRUE);
                  END;
            end;
        }
        field(11;"Peso Calculado";Decimal)
        {
            Caption = 'Calculated weight';
        }
        field(12;"Peso de la Caja";Decimal)
        {
            Caption = 'Calculated weight';
        }
        field(13;"Peso real";Decimal)
        {
            Caption = 'Real weight';
        }
        field(14;Diferencia;Decimal)
        {
            Caption = 'Diference';
        }
        field(15;"Serie de etiquetas";Code[20])
        {
            Caption = 'Tag Series';
        }
        field(16;"No. Pedido";Code[20])
        {
            Caption = 'N  Pedido';
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Header"."No." WHERE ("Document Type"=CONST(Order),
                                                                                    Estado packing=CONST(Listo))
                                                                                    ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Header"."No." WHERE ("Pedido Consignacion"=CONST(true),
                                                                                                                                                           Estado packing=CONST(Listo))
                                                                                                                                                           ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Header"."No." WHERE ("Pedido Consignacion"=CONST(false),
                                                                                                                                                                                                                                   Estado packing=CONST(Listo));
        }
        field(17;"No. Linea Pedido";Integer)
        {
            Caption = 'Order Line No.';
            NotBlank = true;
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Line"."Line No." WHERE ("Document Type"=CONST(Order),
                                                                                         Document No.=FIELD("No. Pedido"),
                                                                                         Type=CONST(Item))
                                                                                         ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Line"."Line No." WHERE ("Document No."=FIELD("No. Pedido"),
                                                                                                                                                                     Derived From Line No.=CONST(0))
                                                                                                                                                                     ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Line"."Line No." WHERE ("Document No."=FIELD("No. Pedido"),
                                                                                                                                                                                                                                                  Derived From Line No.=CONST(0));

            trigger OnValidate()
            var
                recLinVta: Record 37;
                recLinTransfer: Record 5741;
            begin
                CASE "Tipo pedido" OF
                  "Tipo pedido"::Venta : BEGIN
                    IF recLinVta.GET(recLinVta."Document Type"::Order,"No. Pedido","No. Linea Pedido") THEN BEGIN
                      "No. Producto"          := recLinVta."No.";
                      Cantidad                := recLinVta.Quantity;
                      "Cod. Unidad de Medida" := recLinVta."Unit of Measure Code";
                      Descripcion             := recLinVta.Description;
                       END;
                    END;
                  "Tipo pedido"::Consignacion,"Tipo pedido"::Transferencia : BEGIN
                    IF recLinTransfer.GET("No. Pedido","No. Linea Pedido") THEN BEGIN
                      "No. Producto"          := recLinTransfer."Item No.";
                      Cantidad                := recLinTransfer.Quantity;
                      "Cod. Unidad de Medida" := recLinTransfer."Unit of Measure Code";
                      Descripcion             := recLinTransfer.Description;
                       END;
                    END;
                END;
            end;
        }
        field(18;"No. Palet";Code[20])
        {
            CalcFormula = Lookup("Lin. Packing"."No. Palet" WHERE ("No."=FIELD("No. Packing"),
                                                                   No. Caja=FIELD("No. Caja")));
            Description = '#842';
            FieldClass = FlowField;
        }
        field(20;"Tipo pedido";Option)
        {
            Caption = 'Tipo pedido';
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1;"No. Packing","No. Caja","No. Picking","No. Pedido","No. Producto","No. Linea")
        {
            SumIndexFields = Cantidad;
        }
        key(Key2;"No. Packing","No. Caja","No. Picking","No. Producto","No. Linea")
        {
            SumIndexFields = Cantidad;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF LinPack.GET("No. Packing","No. Caja") THEN
          LinPack.TESTFIELD("Estado Caja",LinPack."Estado Caja"::Abierta);
    end;

    trigger OnInsert()
    begin
        IF LinPack.GET("No. Packing","No. Caja") THEN
          LinPack.TESTFIELD("Estado Caja",LinPack."Estado Caja"::Abierta);

        CCP.RESET;
        CCP.SETRANGE("No. Packing","No. Packing");
        CCP.SETRANGE("No. Picking","No. Picking");
        CCP.SETRANGE("No. Producto","No. Producto");
        CCP.SETFILTER("No. Linea",'<>%1',"No. Linea");
        IF CCP.FINDFIRST THEN
          ERROR(Error002,CCP."No. Linea");
    end;

    trigger OnModify()
    begin
        IF LinPack.GET("No. Packing","No. Caja") THEN
          LinPack.TESTFIELD("Estado Caja",LinPack."Estado Caja"::Abierta);
    end;

    var
        Prod: Record 27;
        LinPack: Record 56031;
        RWAL: Record 5773;
        ICR: Record 5717;
        RWAL1Record: Record 5773;
        wCant: Decimal;
        txt001: Label 'Barcode Not Found';
        txt002: Label 'Quantity %1 is greater than the remaining tiems to pack in the Posted Picking %2';
        Error001: Label 'Qty. can not exceed the Picking Quantity';
        wCant1: Decimal;
        CCP: Record 56032;
        CantPendEmp: Decimal;
        CantFaltante: Decimal;
        FuncSant: Codeunit 56000;
        Error002: Label 'Este producto ya existe en la linea %1 de este Packing';
        Error003: Label 'El producto %1 no existe en el Picking %2';
        Error004: Label 'Qty. can not exceed the Picking Quantity';
}

