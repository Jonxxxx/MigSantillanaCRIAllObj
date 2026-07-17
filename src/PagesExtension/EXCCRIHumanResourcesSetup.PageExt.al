pageextension 50106 EXCCRIHumanResourcesSetup extends "Human Resources Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field(EXCCRICandidateNos; Rec."Candidate Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series used to assign candidate numbers.';
            }
            field(EXCCRIEmployeeActionNos; Rec."No. serie acciones personal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series used to assign employee action numbers.';
            }
            field(EXCCRITrainingNos; Rec."No. serie entrenamientos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series used to assign training numbers.';
            }
        }
    }
}
