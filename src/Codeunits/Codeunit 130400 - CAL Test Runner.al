codeunit 130400 "CAL Test Runner"
{
    Subtype = TestRunner;
    TableNo = 130401;
    TestIsolation = Codeunit;

    trigger OnRun()
    begin
        IF CALTestSuite.GET("Test Suite") THEN BEGIN
            CALTestLine.COPY(Rec);
            CALTestLine.SETRANGE("Test Suite", "Test Suite");
            RunTests;
        END;
    end;

    var
        CALTestSuite Record: 130400;
        CALTestLine Record: 130401;
        CALTestLineFunction Record: 130401;
        CALTestMgt: Codeunit 130401;
        CALTestRunnerPublisher: Codeunit 130403;
        Window: Dialog;
        CompanyWorkDate: Date;
        TestRunNo: Integer;
        MaxLineNo: Integer;
        MinLineNo: Integer;
        "Filter": Text;
        ExecutingTestsMsg: Label 'Executing Tests...\', Locked = true;
        TestSuiteMsg: Label 'Test Suite    #1###################\', Locked = true;
        TestCodeunitMsg: Label 'Test Codeunit #2################### @3@@@@@@@@@@@@@\', Locked = true;
        TestFunctionMsg: Label 'Test Function #4################### @5@@@@@@@@@@@@@\', Locked = true;
        NoOfResultsMsg: Label 'No. of Results with:\', Locked = true;
        WindowUpdateDateTime: DateTime;
        WindowIsOpen: Boolean;
        WindowTestSuite: Code[10];
        WindowTestGroup: Text;
        WindowTestCodeunit: Text;
        WindowTestFunction: Text;
        WindowTestSuccess: Integer;
        WindowTestFailure: Integer;
        WindowTestSkip: Integer;
        SuccessMsg: Label '    Success   #6######\', Locked = true;
        FailureMsg: Label '    Failure   #7######\', Locked = true;
        SkipMsg: Label '    Skip      #8######\', Locked = true;
        WindowNoOfTestCodeunitTotal: Integer;
        WindowNoOfFunctionTotal: Integer;
        WindowNoOfTestCodeunit: Integer;
        WindowNoOfFunction: Integer;

    local procedure RunTests()
    var
        CALTestResult Record: 130405;
        CodeCoverageMgt: Codeunit 9990;
    begin
        WITH CALTestLine DO BEGIN
            OpenWindow;
            MODIFYALL(Result, Result::" ");
            MODIFYALL("First Error", '');
            COMMIT;
            TestRunNo := CALTestResult.LastTestRunNo + 1;
            CompanyWorkDate := WORKDATE;
            Filter := GETVIEW;
            WindowNoOfTestCodeunitTotal := CountTestCodeunitsToRun(CALTestLine);
            SETRANGE("Line Type", "Line Type"::Codeunit);
            IF FIND('-') THEN
                REPEAT
                    IF UpdateTCM THEN
                        CodeCoverageMgt.Start(TRUE);

                    MinLineNo := "Line No.";
                    MaxLineNo := GetMaxCodeunitLineNo(WindowNoOfFunctionTotal);
                    IF Run THEN
                        WindowNoOfTestCodeunit += 1;
                    WindowNoOfFunction := 0;

                    IF CALTestMgt.ISPUBLISHMODE THEN
                        DeleteChildren;

                    CODEUNIT.RUN("Test Codeunit");

                    IF UpdateTCM THEN BEGIN
                        CodeCoverageMgt.Stop;
                        CALTestMgt.ExtendTestCoverage("Test Codeunit");
                    END;
                UNTIL NEXT = 0;

            CloseWindow;
        END;
    end;

    trigger OnBeforeTestRun(CodeunitID: Integer; CodeunitName: Text; FunctionName: Text; FunctionTestPermissions: TestPermissions): Boolean
    begin
        CALTestRunnerPublisher.SetSeed(1);
        APPLICATIONAREA('');
        WORKDATE := CompanyWorkDate;
        UpDateWindow(
          CALTestLine."Test Suite", CALTestLine.Name, CodeunitName, FunctionName,
          WindowTestSuccess, WindowTestFailure, WindowTestSkip,
          WindowNoOfTestCodeunitTotal, WindowNoOfFunctionTotal,
          WindowNoOfTestCodeunit, WindowNoOfFunction);

        InitCodeunitLine;

        IF FunctionName = '' THEN BEGIN
            CALTestLine.Result := CALTestLine.Result::" ";
            CALTestLine."Start Time" := CURRENTDATETIME;
            EXIT(TRUE);
        END;

        IF CALTestMgt.ISPUBLISHMODE THEN
            AddTestMethod(FunctionName)
        ELSE BEGIN
            IF NOT TryFindTestFunctionInGroup(FunctionName) THEN
                EXIT(FALSE);

            InitTestFunctionLine;
            IF NOT CALTestLineFunction.Run OR NOT CALTestLine.Run THEN
                EXIT(FALSE);

            UpDateWindow(
              CALTestLine."Test Suite", CALTestLine.Name, CodeunitName, FunctionName,
              WindowTestSuccess, WindowTestFailure, WindowTestSkip,
              WindowNoOfTestCodeunitTotal, WindowNoOfFunctionTotal,
              WindowNoOfTestCodeunit, WindowNoOfFunction + 1);
        END;

        IF FunctionName = 'OnRun' THEN
            EXIT(TRUE);
        EXIT(CALTestMgt.ISTESTMODE);
    end;

    trigger OnAfterTestRun(CodeunitID: Integer; CodeunitName: Text; FunctionName: Text; FunctionTestPermissions: TestPermissions; IsSuccess: Boolean)
    begin
        IF (FunctionName <> '') AND (FunctionName <> 'OnRun') THEN
            IF IsSuccess THEN
                UpDateWindow(
                  WindowTestSuite, WindowTestGroup, WindowTestCodeunit, WindowTestFunction,
                  WindowTestSuccess + 1, WindowTestFailure, WindowTestSkip,
                  WindowNoOfTestCodeunitTotal, WindowNoOfFunctionTotal,
                  WindowNoOfTestCodeunit, WindowNoOfFunction)
            ELSE
                UpDateWindow(
                  WindowTestSuite, WindowTestGroup, WindowTestCodeunit, WindowTestFunction,
                  WindowTestSuccess, WindowTestFailure + 1, WindowTestSkip,
                  WindowNoOfTestCodeunitTotal, WindowNoOfFunctionTotal,
                  WindowNoOfTestCodeunit, WindowNoOfFunction);

        UpdateCodeunitLine(IsSuccess);

        IF FunctionName = '' THEN
            EXIT;

        UpdateTestFunctionLine(IsSuccess);

        COMMIT;
        APPLICATIONAREA('');
        CLEARLASTERROR;
    end;

    [Scope('Personalization')]
    procedure AddTestMethod(FunctionName: Text[128])
    begin
        WITH CALTestLineFunction DO BEGIN
            CALTestLineFunction := CALTestLine;
            "Line No." := MaxLineNo + 1;
            "Line Type" := "Line Type"::"Function";
            VALIDATE("Function", FunctionName);
            Run := CALTestLine.Run;
            "Start Time" := CURRENTDATETIME;
            "Finish Time" := CURRENTDATETIME;
            INSERT(TRUE);
        END;
        MaxLineNo := MaxLineNo + 1;
    end;

    [Scope('Personalization')]
    procedure InitCodeunitLine()
    begin
        WITH CALTestLine DO BEGIN
            IF CALTestMgt.ISTESTMODE AND (Result = Result::" ") THEN
                Result := Result::Skipped;
            "Finish Time" := CURRENTDATETIME;
            MODIFY;
        END;
    end;

    procedure UpdateCodeunitLine(IsSuccess: Boolean)
    begin
        WITH CALTestLine DO BEGIN
            IF CALTestMgt.ISPUBLISHMODE AND IsSuccess THEN
                Result := Result::" "
            ELSE
                IF Result <> Result::Failure THEN
                    IF IsSuccess THEN
                        Result := Result::Success
                    ELSE BEGIN
                        "First Error" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN("First Error"));
                        Result := Result::Failure
                    END;
            "Finish Time" := CURRENTDATETIME;
            MODIFY;
        END;
    end;

    [Scope('Personalization')]
    procedure InitTestFunctionLine()
    begin
        WITH CALTestLineFunction DO BEGIN
            "Start Time" := CURRENTDATETIME;
            "Finish Time" := "Start Time";
            Result := Result::Skipped;
            MODIFY;
        END;
    end;

    procedure UpdateTestFunctionLine(IsSuccess: Boolean)
    var
        CALTestResult Record: 130405;
    begin
        WITH CALTestLineFunction DO BEGIN
            IF IsSuccess THEN
                Result := CALTestLine.Result::Success
            ELSE BEGIN
                "First Error" := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN("First Error"));
                Result := Result::Failure
            END;
            "Finish Time" := CURRENTDATETIME;
            MODIFY;

            CALTestResult.Add(CALTestLineFunction, TestRunNo);
        END;
    end;

    [Scope('Personalization')]
    procedure TryFindTestFunctionInGroup(FunctionName: Text[128]): Boolean
    begin
        WITH CALTestLineFunction DO BEGIN
            RESET;
            SETVIEW(Filter);
            SETRANGE("Test Suite", CALTestLine."Test Suite");
            SETRANGE("Test Codeunit", CALTestLine."Test Codeunit");
            SETRANGE("Function", FunctionName);
            IF FIND('-') THEN
                REPEAT
                    IF "Line No." IN [MinLineNo .. MaxLineNo] THEN
                        EXIT(TRUE);
                UNTIL NEXT = 0;
            EXIT(FALSE);
        END;
    end;

    [Scope('Personalization')]
    procedure CountTestCodeunitsToRun(var CALTestLine Record: 130401") NoOfTestCodeunits: Integer
    begin
        IF NOT CALTestMgt.ISTESTMODE THEN
            EXIT;

        WITH CALTestLine DO BEGIN
            SETRANGE("Line Type", "Line Type"::Codeunit);
            SETRANGE(Run, TRUE);
            NoOfTestCodeunits := COUNT;
        END;
    end;

    [Scope('Personalization')]
    procedure UpdateTCM(): Boolean
    begin
        EXIT(CALTestMgt.ISTESTMODE AND CALTestSuite."Update Test Coverage Map");
    end;

    local procedure OpenWindow()
    begin
        IF NOT CALTestMgt.ISTESTMODE THEN
            EXIT;

        Window.OPEN(
          ExecutingTestsMsg +
          TestSuiteMsg +
          TestCodeunitMsg +
          TestFunctionMsg +
          NoOfResultsMsg +
          SuccessMsg +
          FailureMsg +
          SkipMsg);
        WindowIsOpen := TRUE;
    end;

    local procedure UpDateWindow(NewWindowTestSuite: Code[10]; NewWindowTestGroup: Text; NewWindowTestCodeunit: Text; NewWindowTestFunction: Text; NewWindowTestSuccess: Integer; NewWindowTestFailure: Integer; NewWindowTestSkip: Integer; NewWindowNoOfTestCodeunitTotal: Integer; NewWindowNoOfFunctionTotal: Integer; NewWindowNoOfTestCodeunit: Integer; NewWindowNoOfFunction: Integer)
    begin
        IF NOT CALTestMgt.ISTESTMODE THEN
            EXIT;

        WindowTestSuite := NewWindowTestSuite;
        WindowTestGroup := NewWindowTestGroup;
        WindowTestCodeunit := NewWindowTestCodeunit;
        WindowTestFunction := NewWindowTestFunction;
        WindowTestSuccess := NewWindowTestSuccess;
        WindowTestFailure := NewWindowTestFailure;
        WindowTestSkip := NewWindowTestSkip;

        WindowNoOfTestCodeunitTotal := NewWindowNoOfTestCodeunitTotal;
        WindowNoOfFunctionTotal := NewWindowNoOfFunctionTotal;
        WindowNoOfTestCodeunit := NewWindowNoOfTestCodeunit;
        WindowNoOfFunction := NewWindowNoOfFunction;

        IF IsTimeForUpdate THEN BEGIN
            IF NOT WindowIsOpen THEN
                OpenWindow;
            Window.UPDATE(1, WindowTestSuite);
            Window.UPDATE(2, WindowTestCodeunit);
            Window.UPDATE(4, WindowTestFunction);
            Window.UPDATE(6, WindowTestSuccess);
            Window.UPDATE(7, WindowTestFailure);
            Window.UPDATE(8, WindowTestSkip);

            IF NewWindowNoOfTestCodeunitTotal <> 0 THEN
                Window.UPDATE(3, ROUND(NewWindowNoOfTestCodeunit / NewWindowNoOfTestCodeunitTotal * 10000, 1));
            IF NewWindowNoOfFunctionTotal <> 0 THEN
                Window.UPDATE(5, ROUND(NewWindowNoOfFunction / NewWindowNoOfFunctionTotal * 10000, 1));
        END;
    end;

    local procedure CloseWindow()
    begin
        IF NOT CALTestMgt.ISTESTMODE THEN
            EXIT;

        IF WindowIsOpen THEN BEGIN
            Window.CLOSE;
            WindowIsOpen := FALSE;
        END;
    end;

    local procedure IsTimeForUpdate(): Boolean
    begin
        IF TRUE IN [WindowUpdateDateTime = 0DT, CURRENTDATETIME - WindowUpdateDateTime >= 1000] THEN BEGIN
            WindowUpdateDateTime := CURRENTDATETIME;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;
}

