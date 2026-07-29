page 34002210 "Lista Lin. Cuest. Evaluacion"
{
    AutoSplitKey = true;
    Caption = 'Profile Questn. Line List';
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = 34002185;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line No.';
                }
                field(Question; Question)
                {
                    ApplicationArea = All;
                    Caption = 'Question';
                    ToolTip = 'Specifies the question in the profile questionnaire.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Caption = 'Answer';
                }
                field("From Value"; Rec."From Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'From Value';
                    Visible = false;
                }
                field("To Value"; Rec."To Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'To Value';
                    Visible = false;
                }
                field("No. of Employee"; Rec."No. of Employee")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. of Employee';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

