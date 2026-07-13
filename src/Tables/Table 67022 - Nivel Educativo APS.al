table 67022 "Nivel Educativo APS"
{
    DrillDownPageID = 67099;
    LookupPageID = 67099;

    fields
    {
        field(1; "Codigo"; Code[20])
        {
        }
        field(2; "Descripcion"; Text[100])
        {
        }
        field(3; "Verificaci n cruzada"; Boolean)
        {
        }
        field(4; "Filtros Combinaciones Niveles"; Code[30])
        {
        }
        field(5; "Grupo de Negocio"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
    }

    keys
    {
        key(Key1; "Codigo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }
}

