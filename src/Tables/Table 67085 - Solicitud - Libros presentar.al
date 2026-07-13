table 67085 "Solicitud - Libros presentar"
{

    fields
    {
        field(1; "N m. Solicitud"; Code[20])
        {
        }
        field(2; "Cod. Producto"; Code[20])
        {
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
        }
        field(4; "Horas por semana"; Decimal)
        {
        }
        field(5; "A o adopci n"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "N m. Solicitud", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }
}

