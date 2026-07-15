page 34003024 "Lista Campos Requeridos"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Cab. Campos Requeridos";
    Editable = false;
    PageType = List;
    SourceTable = 34003020;
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
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

