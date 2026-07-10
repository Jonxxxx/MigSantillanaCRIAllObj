table 56035 "Contenido Cajas Packing Reg."
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    A adido campos "No. Pedido" "No. linea pedido"
    // #2945       JML     10/07/2014    A adido campos para pedidos de consignaci n y transferencia

    Caption = 'Packing Box Content';

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
        }
        field(7; "Cod. Unidad de Medida"; Code[20])
        {
            Caption = 'Unit Of Measure Code';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD(No. Producto));
        }
        field(8; Cantidad; Decimal)
        {
            Caption = 'Quantity';
        }
        field(9; "No. Picking"; Code[20])
        {
            Caption = 'Picking No';
        }
        field(10; "No. Linea Picking"; Integer)
        {
            Caption = 'Picking Line No.';
            NotBlank = true;
            TableRelation = "Registered Whse. Activity Line"."Line No." WHERE(Activity Type=FILTER(Pick),
                                                                               No.=FIELD(No. Picking),
                                                                               No. Packing=FILTER(''),
                                                                               No. Caja=FILTER(''),
                                                                               No. Linea Packing=FILTER(0));

            trigger OnValidate()
            begin
                IF RWAL.GET(RWAL."Activity Type"::Pick,"No. Picking","No. Linea Picking") THEN
                  BEGIN
                    "No. Producto" := RWAL."Item No.";
                    Cantidad := RWAL.Quantity;
                    "Cod. Unidad de Medida" := RWAL."Unit of Measure Code";
                    Descripcion := RWAL.Description;
                    RWAL.VALIDATE("No. Packing","No. Packing");
                    RWAL.VALIDATE("No. Caja","No. Caja");
                    RWAL.VALIDATE("No. Linea Packing","No. Linea");
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
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Header"."No." WHERE (Document Type=CONST(Order),
                                                                                    Estado packing=CONST(Listo))
                                                                                    ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Header"."No." WHERE (Pedido Consignacion=CONST(true))
                                                                                    ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Header"."No." WHERE (Pedido Consignacion=CONST(false));
        }
        field(17;"No. Linea Pedido";Integer)
        {
            Caption = 'Order Line No.';
            NotBlank = true;
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Line"."Line No." WHERE (Document Type=CONST(Order),
                                                                                         Document No.=FIELD(No. Pedido),
                                                                                         Type=CONST(Item))
                                                                                         ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Line"."Line No." WHERE (Document No.=FIELD(No. Pedido))
                                                                                         ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Line"."Line No." WHERE (Document No.=FIELD(No. Pedido));

            trigger OnValidate()
            var
                recLinVta Record: 37;
                recLinTransfer Record: 5741;
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
        field(20;"Tipo pedido";Option)
        {
            Caption = 'Tipo pedido';
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1;"No. Packing","No. Caja","No. Picking","No. Producto","No. Linea")
        {
        }
        key(Key2;"No. Producto","No. Picking")
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


        IF RWAL.GET(RWAL."Activity Type"::Pick,"No. Picking","No. Linea Picking") THEN
          BEGIN
            RWAL.VALIDATE("No. Packing",'');
            RWAL.VALIDATE("No. Caja",'');
            RWAL.VALIDATE("No. Linea Packing",0);
            RWAL.MODIFY(TRUE);
          END;
    end;

    trigger OnInsert()
    begin
        IF LinPack.GET("No. Packing","No. Caja") THEN
          LinPack.TESTFIELD("Estado Caja",LinPack."Estado Caja"::Abierta);
    end;

    trigger OnModify()
    begin
        IF LinPack.GET("No. Packing","No. Caja") THEN
          LinPack.TESTFIELD("Estado Caja",LinPack."Estado Caja"::Abierta);
    end;

    var
        Prod: Record 27;
        LinPack Record: 56031;
        RWAL Record: 5773;
}

