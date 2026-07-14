tableextension 50077 EXCCRIEmployeeAbsence extends "Employee Absence"
{
    fields
    {
        modify("From Date")
        {
            trigger OnAfterValidate()
            begin
                EXCCRIValidateTime();
            end;
        }

        field(34002100; "Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002101; "% To deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002102; "Full name"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Employee No.")));
        }
    }

    local procedure EXCCRIValidateTime()
    var
        EXCCRIDate: Record Date;
        EXCCRIHoliday: Record 34002155;
    begin
        if
            ("From Date" > "To Date") and
            ("From Date" <> 0D) and
            ("To Date" <> 0D)
        then
            Error(
                EXCCRIInvalidDateRangeErr,
                FieldCaption("From Date"),
                FieldCaption("To Date"));

        if ("From Date" = 0D) or ("To Date" = 0D) then
            exit;

        Quantity := 0;
        EXCCRIDate.SetRange(
            "Period Type",
            EXCCRIDate."Period Type"::Date);
        EXCCRIDate.SetRange(
            "Period Start",
            "From Date",
            CalcDate('<-1D>', "To Date"));

        if EXCCRIDate.FindSet() then
            repeat
                if EXCCRIDate."Period No." in [1, 2, 3, 4, 5] then begin
                    EXCCRIHoliday.SetRange(Fecha, EXCCRIDate."Period Start");
                    if not EXCCRIHoliday.FindFirst() then
                        Quantity += 1;
                end;
            until EXCCRIDate.Next() = 0;
    end;

    var
        EXCCRIInvalidDateRangeErr: Label '%1 cannot be greater than %2.';
}
