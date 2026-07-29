page 56131 "Distribuccion de Rutas"
{
    // #29481  03/09/2015  FAA   Creada para este desarrollo.

    PageType = List;
    SourceTable = 56071;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field("Nombre de Ruta"; Rec."Nombre de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de Ruta';
                }
                field(CP; Rec.CP)
                {
                    ApplicationArea = All;
                    ToolTip = 'CP';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Region Code';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Country';
                }
                field(Colonia; Rec.Colonia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Colonia';
                }
                field("Tiempo de Envio"; Rec."Tiempo de Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tiempo de Envio';
                }
            }
        }
    }

    actions
    {
    }
}

