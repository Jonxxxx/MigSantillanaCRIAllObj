table 55260 "Contenido Cajas Packing Reg."
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
            DataClassification = CustomerContent;
            Caption = 'No. Packing';
        }
        field(2; "No. Caja"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Caja';
        }
        field(3; "No. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Producto';
        }
        field(4; Descripcion; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(5; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(6; "Cod. Barras"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Barras';
        }
        field(7; "Cod. Unidad de Medida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Unidad de Medida';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No. Producto"));
        }
        field(8; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(9; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Picking';
        }
        field(10; "No. Linea Picking"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea Picking';
            NotBlank = true;
            //TODO Ver: 
            /*
            TableRelation = "Registered Whse. Activity Line"."Line No." WHERE("Activity Type" = FILTER(Pick),
                                                                               "No." = FIELD("No. Picking"),
                                                                               "No. Packing" = FILTER(''),
                                                                               "No. Caja" = FILTER(''),
                                                                               "No. Linea Packing" = FILTER(0));*/

            trigger OnValidate()
            begin
                IF RWAL.GET(RWAL."Activity Type"::Pick, "No. Picking", "No. Linea Picking") THEN BEGIN
                    "No. Producto" := RWAL."Item No.";
                    Cantidad := RWAL.Quantity;
                    "Cod. Unidad de Medida" := RWAL."Unit of Measure Code";
                    Descripcion := RWAL.Description;
                    //TODO Ver: RWAL.VALIDATE("No. Packing", "No. Packing");
                    //TODO Ver: RWAL.VALIDATE("No. Caja", "No. Caja");
                    //TODO Ver: RWAL.VALIDATE("No. Linea Packing", "No. Linea");
                    RWAL.MODIFY(TRUE);
                END;
            end;
        }
        field(11; "Peso Calculado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso Calculado';
        }
        field(12; "Peso de la Caja"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso de la Caja';
        }
        field(13; "Peso real"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso real';
        }
        field(14; Diferencia; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Diferencia';
        }
        field(15; "Serie de etiquetas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie de etiquetas';
        }
        field(16; "No. Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido';
            //TODO Ver: 
            /*
            TableRelation = IF ("Tipo pedido" = CONST(Venta)) "Sales Header"."No." WHERE("Document Type" = CONST(Order),
                                                                                    "Estado packing" = CONST(Listo))
            ELSE IF ("Tipo pedido" = CONST(Consignacion)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(true))
            ELSE IF ("Tipo pedido" = CONST(Transferencia)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(false));*/
        }
        field(17; "No. Linea Pedido"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea Pedido';
            NotBlank = true;
            TableRelation = IF ("Tipo pedido" = CONST(Venta)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("No. Pedido"),
                                                                                         "Type" = CONST(Item))
            ELSE IF ("Tipo pedido" = CONST(Consignacion)) "Transfer Line"."Line No." WHERE("Document No." = FIELD("No. Pedido"))
            ELSE IF ("Tipo pedido" = CONST(Transferencia)) "Transfer Line"."Line No." WHERE("Document No." = FIELD("No. Pedido"));

            trigger OnValidate()
            var
                recLinVta: Record 37;
                recLinTransfer: Record 5741;
            begin
                CASE "Tipo pedido" OF
                    "Tipo pedido"::Venta:
                        BEGIN
                            IF recLinVta.GET(recLinVta."Document Type"::Order, "No. Pedido", "No. Linea Pedido") THEN BEGIN
                                "No. Producto" := recLinVta."No.";
                                Cantidad := recLinVta.Quantity;
                                "Cod. Unidad de Medida" := recLinVta."Unit of Measure Code";
                                Descripcion := recLinVta.Description;
                            END;
                        END;
                    "Tipo pedido"::Consignacion, "Tipo pedido"::Transferencia:
                        BEGIN
                            IF recLinTransfer.GET("No. Pedido", "No. Linea Pedido") THEN BEGIN
                                "No. Producto" := recLinTransfer."Item No.";
                                Cantidad := recLinTransfer.Quantity;
                                "Cod. Unidad de Medida" := recLinTransfer."Unit of Measure Code";
                                Descripcion := recLinTransfer.Description;
                            END;
                        END;
                END;
            end;
        }
        field(20; "Tipo pedido"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo pedido';
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1; "No. Packing", "No. Caja", "No. Picking", "No. Producto", "No. Linea")
        {
        }
        key(Key2; "No. Producto", "No. Picking")
        {
            SumIndexFields = Cantidad;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF LinPack.GET("No. Packing", "No. Caja") THEN
            LinPack.TESTFIELD("Estado Caja", LinPack."Estado Caja"::Abierta);


        IF RWAL.GET(RWAL."Activity Type"::Pick, "No. Picking", "No. Linea Picking") THEN BEGIN
            //TODO Ver: RWAL.VALIDATE("No. Packing", '');
            //TODO Ver: RWAL.VALIDATE("No. Caja", '');
            //TODO Ver: RWAL.VALIDATE("No. Linea Packing", 0);
            RWAL.MODIFY(TRUE);
        END;
    end;

    trigger OnInsert()
    begin
        IF LinPack.GET("No. Packing", "No. Caja") THEN
            LinPack.TESTFIELD("Estado Caja", LinPack."Estado Caja"::Abierta);
    end;

    trigger OnModify()
    begin
        IF LinPack.GET("No. Packing", "No. Caja") THEN
            LinPack.TESTFIELD("Estado Caja", LinPack."Estado Caja"::Abierta);
    end;

    var
        Prod: Record 27;
        LinPack: Record 55256;
        RWAL: Record 5773;
}

