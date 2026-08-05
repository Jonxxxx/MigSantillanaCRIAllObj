page 55974 Campos
{
    Editable = false;
    PageType = List;
    SourceTable = 2000000041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Field Caption';
                }
            }
        }
    }

    actions
    {
    }
}

