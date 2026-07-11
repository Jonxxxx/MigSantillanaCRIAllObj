codeunit 130410 "Sys. Warmup Test Runner"
{
    Subtype = TestRunner;
    TestIsolation = Codeunit;

    trigger OnRun()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sys. Warmup Scenarios");
    end;

    [EventSubscriber(ObjectType::Codeunit, 40, 'OnAfterCompanyOpen', '', true, true)]
    local procedure WarmUpOnAfterCompanyOpen()
    var
        O365GettingStarted: Record 1309;
        CompanyInformationMgt: Codeunit 1306;
        PermissionManager: Codeunit 9002;
    begin
        IF NOT GUIALLOWED THEN
            EXIT;

        IF NOT CompanyInformationMgt.IsDemoCompany THEN
            EXIT;

        IF NOT PermissionManager.SoftwareAsAService THEN
            EXIT;

        IF NOT O365GettingStarted.ISEMPTY THEN
            EXIT;

        IF NOT TASKSCHEDULER.CANCREATETASK THEN
            EXIT;

        TASKSCHEDULER.CREATETASK(CODEUNIT::"Sys. Warmup Test Runner", 0, TRUE, COMPANYNAME, CURRENTDATETIME + 10000); // Add 10s
    end;
}

