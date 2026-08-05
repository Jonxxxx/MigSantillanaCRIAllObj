table 55647 "Solicitud - Libros presentar"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record 27;
            begin
                IF Item.GET("Cod. Producto") THEN
                    "Descripcion Producto" := Item.Description;
            end;
        }
        field(3; "Descripcion Producto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Producto';
        }
        field(4; "Horas por semana"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas por semana';
        }
        field(5; "Ano adopcion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ano adopcion';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }
}

