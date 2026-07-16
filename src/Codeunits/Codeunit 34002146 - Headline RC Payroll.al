codeunit 34002146 "Headline RC Payroll"
{

    trigger OnRun()
    var
        HeadlineRCOrderProcessor: Record 34002208;
    begin
        HeadlineRCOrderProcessor.GET;
        WORKDATE := HeadlineRCOrderProcessor."Workdate for computations";
        OnComputeHeadlines;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnComputeHeadlines()
    begin
    end;
}

