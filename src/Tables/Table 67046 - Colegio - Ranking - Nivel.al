table 55513 "Colegio - Ranking - Nivel"
{
    DrillDownPageID = 55503;
    LookupPageID = 55503;

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

    var
        ConfAPS: Record 55467;
        Col: Record 5050;
        PostCode: Record 225;
        DA: Record 55469;
        "P-LC": Record 55473;
        "P-Ruta": Record 55511;
        RD: Record 55476;
        Nivel: Record 55230;
        Turnos: Page 55470;
        Rutas: Page 55476;
        Rutas2: Page 55475;
}

