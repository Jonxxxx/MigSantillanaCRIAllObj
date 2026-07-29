page 67044 "Lista materiales"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = Card;
    SourceTable = 67013;
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

