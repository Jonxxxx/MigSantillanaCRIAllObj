page 34002209 "Lista Cuestionario Evaluacion"
{
    Caption = 'Profile Questionnaire List';
    Editable = false;
    PageType = List;
    SourceTable = 34002184;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the profile questionnaire.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the profile questionnaire.';
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

