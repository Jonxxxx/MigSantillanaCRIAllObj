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
                field("No. Tabla"; Rec."No. Tabla")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Tabla';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field(Activo; Rec.Activo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activo';
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

