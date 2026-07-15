page 34003025 "Cab. Dimensiones Requeridas"
{
    PageType = Document;
    SourceTable = 34003022;

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
            part(PartPage; 34003026)
            {
                SubPageLink = "No. Tabla" = FIELD("No. Tabla");
                SubPageView = SORTING("No. Tabla", "Cod. Dimension")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
    }
}

