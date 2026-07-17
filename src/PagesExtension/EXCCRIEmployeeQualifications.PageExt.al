pageextension 50101 EXCCRIEmployeeQualifications extends "Employee Qualifications"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIAcuerdoDePermanencia; Rec."Acuerdo de permanencia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Acuerdo de permanencia value for the employee qualification.';
            }
        }
    }
}
