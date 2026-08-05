codeunit 55787 "Headline RC Payroll"
{

    trigger OnRun()
    var
        HeadlineRCOrderProcessor: Record 55849;
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

