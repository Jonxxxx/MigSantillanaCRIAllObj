table 67046 "Colegio - Ranking - Nivel"
{
    DrillDownPageID = 67036;
    LookupPageID = 67036;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
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
        ConfAPS: Record 67000;
        Col: Record 5050;
        PostCode: Record 225;
        DA: Record 67002;
        "P-LC"Record 67006;
        "P-Ruta"Record 67044;
        RD: Record 67009;
        Nivel: Record 56005;
        Turnos: Page67003;
        Rutas: Page67009;
        Rutas2: Page67008;
}

