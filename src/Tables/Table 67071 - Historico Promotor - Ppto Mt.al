table 55538 "Historico Promotor - Ppto Mt"
{

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            //TODO Ver: TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

            trigger OnValidate()
            begin
                IF Prom.GET("Cod. Promotor") THEN
                    "Nombre Promotor" := Prom.Name;
            end;
        }
        field(2; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF "Cod. Producto" <> '' THEN BEGIN
                    Item.GET("Cod. Producto");
                    "Item Description" := Item.Description;
                END;

                IF ProdEquivalente.GET("Cod. Producto") THEN
                    "Cod. producto equivalente" := ProdEquivalente."Cod. Producto Anterior";
            end;
        }
        field(3; "Nombre Promotor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Promotor';
        }
        field(4; "Item Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(6; "Extended Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Extended Quantity';
        }
        field(7; "Cantidad camp. anterior"; Decimal)
        {
            Caption = 'Cantidad camp. anterior';
            CalcFormula = Sum("Hist. Promotor - Ppto Muestras".Quantity WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                               "Cod. Producto" = FIELD("Cod. producto equivalente")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Cod. producto equivalente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. producto equivalente';
            TableRelation = Item;
        }
        field(9; "Cantidad consumida"; Decimal)
        {
            Caption = 'Cantidad consumida';
            CalcFormula = Sum("Promotor - Entrega Muestras".Cantidad WHERE("Cod. Promotor" = FIELD("Cod. Promotor"),
                                                                            "Cod. Producto" = FIELD("Cod. Producto")));
            FieldClass = FlowField;
        }
        field(10; "Cantidad seleccionada"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad seleccionada';
        }
        field(11; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(20; "Campana"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        Prom: Record 13;
        ProdEquivalente: Record 55472;
}

