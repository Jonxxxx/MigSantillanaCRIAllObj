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
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
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

