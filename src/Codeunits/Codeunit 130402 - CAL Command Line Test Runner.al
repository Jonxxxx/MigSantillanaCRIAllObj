codeunit 130402 "CAL Command Line Test Runner"
{
    Subtype = TestRunner;
    TestIsolation = Codeunit;

    trigger OnRun()
    var
        CALTestEnabledCodeunit: Record 130403;
        CALTestResult: Record 130405;
        CodeCoverageMgt: Codeunit 9990;
        CALTestMgt: Codeunit 130401;
    begin
        SELECTLATESTVERSION;
        TestRunNo := CALTestResult.LastTestRunNo + 1;
        CompanyWorkDate := WORKDATE;

        IF CALTestEnabledCodeunit.FINDSET THEN
            REPEAT
                IF CALTestMgt.DoesTestCodeunitExist(CALTestEnabledCodeunit."Test Codeunit ID") THEN BEGIN
                    CodeCoverageMgt.Start(TRUE);
                    CODEUNIT.RUN(CALTestEnabledCodeunit."Test Codeunit ID");
                    CodeCoverageMgt.Stop;
                    CALTestMgt.ExtendTestCoverage(CALTestEnabledCodeunit."Test Codeunit ID");
                END;
            UNTIL CALTestEnabledCodeunit.NEXT = 0
    end;

    var
        CALTestRunnerPublisher: Codeunit 130403;
        TestRunNo: Integer;
        CompanyWorkDate: Date;

    trigger OnBeforeTestRun(CodeunitID: Integer; CodeunitName: Text; FunctionName: Text; FunctionTestPermissions: TestPermissions): Boolean
    var
        CALTestResult: Record 130405;
    begin
        IF FunctionName = '' THEN
            EXIT(TRUE);

        CALTestRunnerPublisher.SetSeed(1);
        APPLICATIONAREA('');

        WORKDATE := CompanyWorkDate;

        CLEARLASTERROR;
        CALTestResult.Initialize(TestRunNo, CodeunitID, FunctionName, CURRENTDATETIME);
        EXIT(TRUE)
    end;

    trigger OnAfterTestRun(CodeunitID: Integer; CodeunitName: Text; FunctionName: Text; FunctionTestPermissions: TestPermissions; Success: Boolean)
    var
        CALTestResult: Record 130405;
    begin
        IF FunctionName = '' THEN
            EXIT;

        CALTestResult.FINDLAST;
        CALTestResult.Update(Success, CURRENTDATETIME);

        APPLICATIONAREA('');
    end;
}

