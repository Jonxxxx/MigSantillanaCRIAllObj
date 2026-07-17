pageextension 50104 EXCCRIAbsenceRegistration extends "Absence Registration"
{
    layout
    {
        addafter("Employee No.")
        {
            field(EXCCRIFullName; Rec."Full name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the Full name value for the absence registration.';
            }
            field(EXCCRIToDeduct; Rec."% To deduct")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the percentage To deduct value for the absence registration.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIPostAbsence)
            {
                ApplicationArea = All;
                Caption = 'Post Absence';
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Posts the selected absence records and creates vacation history when applicable.';

                trigger OnAction()
                begin
                    if not Confirm(EXCCRIConfirmPostAbsenceQst) then
                        exit;

                    EXCCRIPayrollSetup.Get();

                    EXCCRIEmployeeAbsence.CopyFilters(Rec);
                    if not EXCCRIEmployeeAbsence.FindSet() then
                        exit;

                    repeat
                        if EXCCRICauseOfAbsence.Get(
                            Rec."Cause of Absence Code")
                        then begin
                            if EXCCRICauseOfAbsence.
                               "Cod. concepto salarial" =
                               EXCCRIPayrollSetup."Concepto Vacaciones"
                            then begin
                                EXCCRIHolidayHistory.Init();
                                EXCCRIHolidayHistory."No. empleado" :=
                                    Rec."Employee No.";
                                EXCCRIHolidayHistory."Fecha Inicio" :=
                                    Rec."From Date";
                                EXCCRIHolidayHistory."Fecha Fin" :=
                                    Rec."To Date";
                                EXCCRIHolidayHistory.Dias :=
                                    Rec.Quantity * -1;

                                if not EXCCRIHolidayHistory.Insert() then
                                    EXCCRIHolidayHistory.Modify();
                            end;

                            EXCCRIEmployeeAbsence.Closed := true;
                            EXCCRIEmployeeAbsence.Modify();
                        end;
                    until EXCCRIEmployeeAbsence.Next() = 0;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        EXCCRIEmployee: Record Employee;
    begin
        exit(EXCCRIEmployee.Get(Rec."Employee No."));
    end;

    var
        EXCCRIHolidayHistory: Record 34002141;
        EXCCRIPayrollSetup: Record 34002103;
        EXCCRICauseOfAbsence: Record "Cause of Absence";
        EXCCRIEmployeeAbsence: Record "Employee Absence";
        EXCCRIConfirmPostAbsenceQst: Label
            'Are you sure you want to post the absences?';
}
