table 51017 "Grupo Negocio - Cupon Lote reg"
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
        field(3; "No. Cupon"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No. Lote cupon", "Grupo Negocio", "No. Cupon")
        {
        }
    }

    fieldgroups
    {
    }
}

