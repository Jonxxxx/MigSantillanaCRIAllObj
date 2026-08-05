page 55972 "Cab. Campos Requeridos"
{
    PageType = Document;
    SourceTable = 55972;

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
            part(PartPage; 55973)
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

