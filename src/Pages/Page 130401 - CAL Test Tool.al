page 130401 "CAL Test Tool"
{
    AccessByPermission = TableData 130401 = RIMD;
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Test Tool';
    DataCaptionExpression = CurrentSuiteName;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = Table130401;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            field(CurrentSuiteName; CurrentSuiteName)
            {
                ApplicationArea = All;
                Caption = 'Suite Name';

                trigger OnLookup(var Text: Text): Boolean
                var
                    CALTestSuite: Record 130400;
                begin
                    CALTestSuite.Name := CurrentSuiteName;
                    IF PAGE.RUNMODAL(0, CALTestSuite) <> ACTION::LookupOK THEN
                        EXIT(FALSE);
                    Text := CALTestSuite.Name;
                    EXIT(TRUE);
                end;

                trigger OnValidate()
                begin
                    CALTestSuite.GET(CurrentSuiteName);
                    CALTestSuite.CALCFIELDS("Tests to Execute");
                    CurrentSuiteNameOnAfterValidat;
                end;
            }
            repeater()
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowAsTree = true;
                field(LineType; "Line Type")
                {
                    ApplicationArea = All;
                    Caption = 'Line Type';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = LineTypeEmphasize;
                }
                field(TestCodeunit; "Test Codeunit")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Codeunit ID';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TestCodeunitEmphasize;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ToolTip = 'Specifies the name of the test tool.';
                }
                field("Hit Objects"; "Hit Objects")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = NameEmphasize;

                    trigger OnDrillDown()
                    var
                        CALTestCoverageMap: Record 130406;
                    begin
                        CALTestCoverageMap.ShowHitObjects("Test Codeunit");
                    end;
                }
                field(Run; Run)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                field(Result; Result)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = ResultEmphasize;
                }
                field("First Error"; "First Error")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        ShowTestResults
                    end;
                }
                field(Duration; "Finish Time" - "Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                }
            }
            group()
            {
                field(SuccessfulTests; Success)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Successful Tests';
                    Editable = false;
                }
                field(FailedTests; Failure)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Failed Tests';
                    Editable = false;
                }
                field(SkippedTests; Skipped)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Skipped Tests';
                    Editable = false;
                }
                field(NotExecutedTests; NotExecuted)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    Caption = 'Tests not Executed';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(DeleteLines)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Lines';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Delete the selected line.';

                    trigger OnAction()
                    var
                        CALTestLine: Record 130401;
                    begin
                        CurrPage.SETSELECTIONFILTER(CALTestLine);
                        CALTestLine.DELETEALL(TRUE);
                        CalcTestResults(Success, Failure, Skipped, NotExecuted);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(GetTestCodeunits)
                {
                    ApplicationArea = All;
                    Caption = 'Get Test Codeunits';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CALTestMgt: Codeunit 130401;
                    begin
                        CALTestSuite.GET(CurrentSuiteName);
                        CALTestMgt.GetTestCodeunitsSelection(CALTestSuite);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(Run)
                {
                    ApplicationArea = All;
                    Caption = '&Run';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+L';

                    trigger OnAction()
                    var
                        CALTestLine: Record 130401;
                        CALTestMgt: Codeunit 130401;
                    begin
                        WarnNonEnglishLanguage;

                        CALTestLine := Rec;
                        CALTestMgt.RunSuiteYesNo(Rec);
                        Rec := CALTestLine;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RunSelected)
                {
                    ApplicationArea = All;
                    Caption = 'Run &Selected';
                    Image = TestFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelectedCALTestLine: Record 130401;
                        CALTestMgt: Codeunit 130401;
                    begin
                        WarnNonEnglishLanguage;

                        CurrPage.SETSELECTIONFILTER(SelectedCALTestLine);
                        SelectedCALTestLine.SETRANGE("Test Suite", "Test Suite");
                        CALTestMgt.RunSelected(SelectedCALTestLine);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(ClearResults)
                {
                    ApplicationArea = All;
                    Caption = 'Clear &Results';
                    Image = ClearLog;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    var
                        CALTestLine: Record 130401;
                    begin
                        CALTestLine := Rec;
                        ClearResults(CALTestSuite);
                        Rec := CALTestLine;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(GetTestMethods)
                {
                    ApplicationArea = All;
                    Caption = 'Get Test Methods';
                    Image = RefreshText;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        CALTestMgt: Codeunit 130401;
                    begin
                        CALTestMgt.RunSuite(Rec, FALSE);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group(TCM)
            {
                Caption = 'TCM';
                action(TestCoverageMap)
                {
                    ApplicationArea = All;
                    Caption = 'Test Coverage Map';
                    Image = Workdays;

                    trigger OnAction()
                    var
                        CALTestCoverageMap: Record 130406;
                    begin
                        CALTestCoverageMap.Show;
                    end;
                }
            }
            group("P&rojects")
            {
                Caption = 'P&rojects';
                action(ExportProject)
                {
                    ApplicationArea = All;
                    Caption = 'Export';
                    Image = Export;
                    ToolTip = 'Export the picture to a file.';

                    trigger OnAction()
                    var
                        CALTestProjectMgt: Codeunit 130404;
                    begin
                        CALTestProjectMgt.Export(CurrentSuiteName);
                    end;
                }
                action(ImportProject)
                {
                    ApplicationArea = All;
                    Caption = 'Import';
                    Image = Import;

                    trigger OnAction()
                    var
                        CALTestProjectMgt: Codeunit 130404;
                    begin
                        CALTestProjectMgt.Import;
                    end;
                }
            }
            action(NextError)
            {
                ApplicationArea = All;
                Caption = 'Next Error';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Go to the next error.';

                trigger OnAction()
                begin
                    FindError('>=');
                end;
            }
            action(PreviousError)
            {
                ApplicationArea = All;
                Caption = 'Previous Error';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Go to the previous error.';

                trigger OnAction()
                begin
                    FindError('<=');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcTestResults(Success, Failure, Skipped, NotExecuted);
        NameIndent := "Line Type";
        LineTypeEmphasize := "Line Type" IN ["Line Type"::Group, "Line Type"::Codeunit];
        TestCodeunitEmphasize := "Line Type" = "Line Type"::Codeunit;
        NameEmphasize := "Line Type" = "Line Type"::Group;
        ResultEmphasize := Result = Result::Success;
        IF "Line Type" <> "Line Type"::Codeunit THEN
            "Hit Objects" := 0;
    end;

    trigger OnOpenPage()
    begin
        IF NOT CALTestSuite.GET(CurrentSuiteName) THEN
            IF CALTestSuite.FINDFIRST THEN
                CurrentSuiteName := CALTestSuite.Name
            ELSE BEGIN
                CreateTestSuite(CurrentSuiteName);
                COMMIT;
            END;

        FILTERGROUP(2);
        SETRANGE("Test Suite", CurrentSuiteName);
        FILTERGROUP(0);

        IF FIND('-') THEN;
        CurrPage.UPDATE(FALSE);

        CALTestSuite.GET(CurrentSuiteName);
        CALTestSuite.CALCFIELDS("Tests to Execute");
    end;

    var
        CALTestSuite: Record 130400;
        LanguageWarningNotification: Notification;
        CurrentSuiteName: Code[10];
        Skipped: Integer;
        Success: Integer;
        Failure: Integer;
        NotExecuted: Integer;
        [InDataSet]
        NameIndent: Integer;
        [InDataSet]
        LineTypeEmphasize: Boolean;
        NameEmphasize: Boolean;
        [InDataSet]
        TestCodeunitEmphasize: Boolean;
        [InDataSet]
        ResultEmphasize: Boolean;
        LanguageWarningShown: Boolean;
        LanguageWarningMsg: Label 'Warning: The current language is not set to English (US). The tests may only contain captions in English (US), which will cause the tests to fail. Resolve the issue by switching the language or introducing translations in the test.';

    local procedure ClearResults(CALTestSuite: Record 130400)
    var
        CALTestLine: Record 130401;
    begin
        IF CALTestSuite.Name <> '' THEN
            CALTestLine.SETRANGE("Test Suite", CALTestSuite.Name);

        CALTestLine.MODIFYALL(Result, Result::" ");
        CALTestLine.MODIFYALL("First Error", '');
        CALTestLine.MODIFYALL("Start Time", 0DT);
        CALTestLine.MODIFYALL("Finish Time", 0DT);
    end;

    local procedure FindError(Which: Code[10])
    var
        CALTestLine: Record 130401;
    begin
        CALTestLine.COPY(Rec);
        CALTestLine.SETRANGE(Result, Result::Failure);
        IF CALTestLine.FIND(Which) THEN
            Rec := CALTestLine;
    end;

    local procedure CreateTestSuite(var NewSuiteName: Code[10])
    var
        CALTestSuite: Record 130400;
        CALTestMgt: Codeunit 130401;
    begin
        CALTestMgt.CreateNewSuite(NewSuiteName);
        CALTestSuite.GET(NewSuiteName);
    end;

    local procedure CurrentSuiteNameOnAfterValidat()
    begin
        CurrPage.SAVERECORD;

        FILTERGROUP(2);
        SETRANGE("Test Suite", CurrentSuiteName);
        FILTERGROUP(0);

        CurrPage.UPDATE(FALSE);
    end;

    local procedure WarnNonEnglishLanguage()
    begin
        IF LanguageWarningShown THEN
            EXIT;

        IF GLOBALLANGUAGE <> 1033 THEN BEGIN
            LanguageWarningNotification.MESSAGE := LanguageWarningMsg;
            LanguageWarningNotification.SEND;
        END;

        LanguageWarningShown := TRUE;
    end;
}

