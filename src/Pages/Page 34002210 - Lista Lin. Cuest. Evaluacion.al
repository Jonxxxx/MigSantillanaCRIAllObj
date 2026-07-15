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
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the profile questionnaire line. This field is used internally by the program.';
                }
                field(Question; Question)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Question';
                    ToolTip = 'Specifies the question in the profile questionnaire.';
                }
                field(Description; Description)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Answer';
                    ToolTip = 'Specifies the profile question or answer.';
                }
                field("From Value"; "From Value")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the value from which the automatic classification of your contacts starts.';
                    Visible = false;
                }
                field("To Value"; "To Value")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the value that the automatic classification of your contacts stops at.';
                    Visible = false;
                }
                field("No. of Employee"; "No. of Employee")
                {
                    ApplicationArea = RelationshipMgmt;
                    ToolTip = 'Specifies the number of contacts that have given this answer.';
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

