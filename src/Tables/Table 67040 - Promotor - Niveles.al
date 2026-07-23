table 67040 "Promotor - Niveles"
{
    DrillDownPageID = 67050;
    LookupPageID = 67050;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";

            trigger OnValidate()
            begin
                IF "Cod. Nivel" <> '' THEN BEGIN
                    Nivel.GET("Cod. Nivel");
                    "Descripcion Nivel" := Nivel.Descripcion;
                END;
            end;
        }
        field(3; "Nombre Promotor"; Text[100])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(4; "Descripcion Nivel"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Nivel")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Nivel: Record 67022;
}

