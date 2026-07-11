table 67019 "Areas de interes padres"
{
    Caption = 'Tandas';

    fields
    {
        field(1; "DNI Padre"; Code[20])
        {
            TableRelation = Padres;
        }
        field(2; "Cod. Area Interes"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Areas de inter s"));

            trigger OnValidate()
            begin
                IF "Cod. Area Interes" <> '' THEN BEGIN
                    DA.RESET;
                    DA.GET(1, "Cod. Area Interes");
                    "Descripcion Area Interes" := DA.Descripcion;
                END;
            end;
        }
        field(3; "Nombre Padre"; Text[60])
        {
            CalcFormula = Lookup(Padres."Full name" WHERE("DNI" = FIELD("DNI Padre")));
            FieldClass = FlowField;
        }
        field(4; "Descripcion Area Interes"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "DNI Padre", "Cod. Area Interes")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
}

