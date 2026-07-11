table 67041 "Estadistica Ranking Colegio"
{
    Caption = 'Estadistica Ranking Colegio';
    DrillDownPageID = 67057;
    LookupPageID = 67057;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(2; "Grupo de Negocio"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grupo de Negocio));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Nivel Educativo APS".C digo;
        }
        field(4; "Categoria colegio"; Code[4])
        {
            NotBlank = true;
        }
        field(5; Porciento; Decimal)
        {
            Caption = '%';
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Grupo de Negocio", "Cod. Nivel")
        {
        }
    }

    fieldgroups
    {
    }
}

