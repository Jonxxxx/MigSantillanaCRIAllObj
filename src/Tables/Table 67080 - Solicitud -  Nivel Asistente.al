table 55547 "Solicitud -  Nivel Asistente"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo APS";

            trigger OnValidate()
            var
                Nivel: Record 55489;
            begin
                IF "Cod. Nivel" <> '' THEN BEGIN
                    Nivel.GET("Cod. Nivel");
                    Descripcion := Nivel.Descripcion;
                END;
            end;
        }
        field(3; "Descripcion"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "No. Asistentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Asistentes';
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

