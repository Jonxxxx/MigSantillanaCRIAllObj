page 50001 "License Permisions"
{
    PageType = List;
    SourceTable = 2000000043;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object Type';
                }
                field("Object Number"; Rec."Object Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Object Number';
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Read Permission';
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Insert Permission';
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Modify Permission';
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Delete Permission';
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Execute Permission';
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Limited Usage Permission';
                }
            }
        }
    }

    actions
    {
    }
}

