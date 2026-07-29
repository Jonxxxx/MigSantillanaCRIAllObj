page 34002196 "Employee - Job Relation"
{
    PageType = List;
    SourceTable = 34002171;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job No.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task No.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Line Type';
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Unit Price';
                    Visible = false;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Description';
                    Editable = false;
                    Visible = false;
                }
                field("Job Task Name"; Rec."Job Task Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Task Name';
                    Caption = 'Job Task Name';
                    Editable = false;
                    Visible = false;
                }
                field("% to distribute"; Rec."% to distribute")
                {
                    ApplicationArea = All;
                    ToolTip = '% to distribute';
                }
            }
        }
    }

    actions
    {
    }
}

