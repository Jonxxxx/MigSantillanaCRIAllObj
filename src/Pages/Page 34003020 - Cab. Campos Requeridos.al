page 34003020 "Cab. Campos Requeridos"
{
    PageType = Document;
    SourceTable = 34003020;

    layout
    {
        area(content)
        {
            group(General)
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
            part(PartPage; 34003021)
            {
                SubPageLink = "No. Tabla" = FIELD("No. Tabla");
                SubPageView = SORTING("No. Tabla", "No. Campo")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
    }
}

