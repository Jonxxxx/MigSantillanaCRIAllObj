table 67041 "Estadistica Ranking Colegio"
{
    Caption = 'Estadistica Ranking Colegio';
    DrillDownPageID = 67057;
    LookupPageID = 67057;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(2; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
            TableRelation = "Nivel Educativo APS".Codigo;
        }
        field(4; "Categoria colegio"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria colegio';
            NotBlank = true;
        }
        field(5; Porciento; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porciento';
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

