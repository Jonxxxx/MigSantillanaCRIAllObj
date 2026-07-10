table 51016 "Grupo Negocio - Cupon Lote"
{

    fields
    {
        field(1; "No. Lote cupon"; Integer)
        {
        }
        field(2; "Grupo Negocio"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = FILTER("Grupo de Negocio"));
        }
    }

    keys
    {
        key(Key1; "No. Lote cupon", "Grupo Negocio")
        {
        }
    }

    fieldgroups
    {
    }
}

