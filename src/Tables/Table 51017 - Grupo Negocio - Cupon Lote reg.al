table 55178 "Grupo Negocio - Cupon Lote reg"
{

    fields
    {
        field(1; "No. Lote cupon"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Lote cupon';
        }
        field(2; "Grupo Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Negocio';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = FILTER("Grupo de Negocio"));
        }
        field(3; "No. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cupon';
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

