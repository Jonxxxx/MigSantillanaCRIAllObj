page 55954 "Dimensiones POS"
{
    // #217374, RRT, 10.09.19: Se aprovecha este desarrollo para renumerar la tabla "Dimensiones POS".

    PageType = List;
    SourceTable = 55930;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Dimension; Rec.Dimension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension';
                }
                field("Valor dimension"; Rec."Valor dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor dimension';
                }
            }
        }
    }

    actions
    {
    }
}

