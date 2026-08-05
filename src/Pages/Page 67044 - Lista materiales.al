page 55511 "Lista materiales"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = 55480;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
            }
        }
    }

    actions
    {
    }
}

