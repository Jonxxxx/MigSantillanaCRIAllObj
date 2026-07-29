page 67009 "Rutas - Distribucion Geo."
{
    DataCaptionFields = "Cod. Ruta", "Name of route";
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67009;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Ruta"; Rec."Cod. Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ruta';
                }
                field("Name of route"; Rec."Name of route")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of route';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
            }
        }
    }

    actions
    {
    }
}

