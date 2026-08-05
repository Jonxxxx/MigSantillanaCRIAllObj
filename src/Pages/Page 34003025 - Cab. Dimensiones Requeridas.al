page 55977 "Cab. Dimensiones Requeridas"
{
    PageType = Document;
    SourceTable = 55974;

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
            part(PartPage; 55978)
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

