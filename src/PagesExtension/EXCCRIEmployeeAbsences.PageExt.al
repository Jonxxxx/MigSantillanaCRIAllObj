pageextension 50103 EXCCRIEmployeeAbsences extends "Employee Absences"
{
    layout
    {
        addafter("Cause of Absence Code")
        {
            field(EXCCRIToDeduct; Rec."% To deduct")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the percentage To deduct value for the employee absence.';
            }
        }
    }
}
