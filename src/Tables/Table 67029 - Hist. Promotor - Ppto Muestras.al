table 55496 "Hist. Promotor - Ppto Muestras"
{

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            //TOOD: Ver TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

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
        field(4; "Item Description"; Text[60])
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
            DataClassification = CustomerContent;
            Caption = 'Cantidad camp. anterior';
        }
        field(8; "Cod. producto equivalente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. producto equivalente';
        }
        field(9; Ano; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
            Numeric = true;
        }
    }

    keys
    {
        key(Key1; Ano, "Cod. Promotor", "Cod. Producto")
        {
            SumIndexFields = Quantity;
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

