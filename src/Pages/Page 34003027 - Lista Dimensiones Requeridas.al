page 34003027 "Lista Dimensiones Requeridas"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Cab. Dimensiones Requeridas";
    Editable = false;
    PageType = List;
    SourceTable = 34003022;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Tabla"; "No. Tabla")
                {
                }
                field(Nombre; Nombre)
                {
                }
                field(Activo; Activo)
                {
                }
            }
        }
    }

    actions
    {
    }
}

