table 67080 "Solicitud -  Nivel Asistente"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";

            trigger OnValidate()
            var
                Nivel: Record 67022;
            begin
                IF "Cod. Nivel" <> '' THEN BEGIN
                    Nivel.GET("Cod. Nivel");
                    Descripcion := Nivel.Descripcion;
                END;
            end;
        }
        field(3; "Descripcion"; Text[80])
        {
        }
        field(4; "No. Asistentes"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Nivel")
        {
        }
    }

    fieldgroups
    {
    }
}

