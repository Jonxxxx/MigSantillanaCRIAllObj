page 130415 "Semi-Manual Test Wizard"
{
    Caption = 'Semi-Manual Test Wizard';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = NavigatePage;
    SourceTable = Table130415;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(StepCodeunit)
            {
                Caption = '';
                Visible = NOT TestExecuting;
                group(Para1)
                {
                    Caption = 'Codeunit';
                    InstructionalText = 'Choose the codeunit, and then load it. The wizard will do the actions that could be automated, and list actions for each step that you need to do manually.';
                    field(CodeunitId; CodeunitId)
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        ColumnSpan = 2;

                        trigger OnDrillDown()
                        var
                            AllObjWithCaption Record: 2000000058;
                            GetSemiManualTestCodeunits: Page130416;
                        begin
                            GetSemiManualTestCodeunits.LOOKUPMODE := TRUE;
                            IF GetSemiManualTestCodeunits.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GetSemiManualTestCodeunits.SETSELECTIONFILTER(AllObjWithCaption);
                                IF AllObjWithCaption.FINDFIRST THEN
                                    CodeunitId := AllObjWithCaption."Object ID";
                                LoadTest;
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            LoadTest;
                        end;
                    }
                }
            }
            group(StepManualSteps)
            {
                Caption = '';
                Visible = TestExecuting;
                group(Para3)
                {
                    Caption = '';
                    field(CodeunitIdentifier; CodeunitIdentifier)
                    {
                        ApplicationArea = All;
                        Caption = '';
                        Editable = false;
                        Style = Strong;
                        StyleExpr = TRUE;
                    }
                }
                group(Para2)
                {
                    Caption = 'Manual steps';
                    InstructionalText = 'These are the actions that cannot be automated. Manually perform each of the actions listed for each step. If an error message displays, you''ve found a bug! Copy information about the error after clicking on the Download log button, and provide that when you report the bug.';
                    field(StepHeading; StepHeading)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies title of this set of manual actions';
                    }
                    field(ManualSteps; ManualSteps)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        MultiLine = true;
                        ToolTip = 'Specifies the manual actions for this step in the test.';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GetExecutionLog)
            {
                ApplicationArea = All;
                Caption = 'Download log';
                Enabled = TestExecuting;
                InFooterBar = true;
                ToolTip = 'Displays a list of actions executed so far ';

                trigger OnAction()
                var
                    SemiManualExecutionLog Record: 130416;
                    FileManagement: Codeunit 419;
                    File: File;
                    OutStream: OutStream;
                    ServerFileName: Text;
                begin
                    ServerFileName := FileManagement.ServerTempFileName('txt');
                    File.CREATE(ServerFileName);
                    File.CREATEOUTSTREAM(OutStream);
                    IF SemiManualExecutionLog.FINDSET THEN
                        REPEAT
                            OutStream.WRITE('[' + FORMAT(SemiManualExecutionLog."Time stamp") + '] ');
                            OutStream.WRITETEXT(SemiManualExecutionLog.GetMessage);
                            OutStream.WRITETEXT;
                        UNTIL SemiManualExecutionLog.NEXT = 0;
                    File.CLOSE;
                    FileManagement.DownloadTempFile(ServerFileName);
                end;
            }
            action(ClearExecutionLog)
            {
                ApplicationArea = All;
                Caption = 'Clear log';
                InFooterBar = true;
                ToolTip = 'Delete all entries in the execution log.';

                trigger OnAction()
                begin
                    SemiManualExecutionLog.DELETEALL;
                end;
            }
            action(LoadTest)
            {
                ApplicationArea = All;
                Caption = 'Load';
                Enabled = NOT TestExecuting;
                InFooterBar = true;
                ToolTip = 'Load the selected codeunit.';

                trigger OnAction()
                begin
                    LoadTest;
                end;
            }
            action(SkipStep)
            {
                ApplicationArea = All;
                Caption = 'Skip step';
                Enabled = TestExecuting;
                InFooterBar = true;
                ToolTip = 'Specifies that the automated actions are complete, and displays the manual actions for the next step.';

                trigger OnAction()
                begin
                    "Skip current step" := TRUE;
                    OnNextStep;
                end;
            }
            action(NextStep)
            {
                ApplicationArea = All;
                Caption = 'Next step';
                Enabled = TestExecuting;
                InFooterBar = true;
                ToolTip = 'Specifies that the manual actions for this step are complete, and displays the actions for the next step.';

                trigger OnAction()
                begin
                    "Skip current step" := FALSE;
                    OnNextStep;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "Step number" > "Total steps" THEN
            StepHeading := 'TEST COMPLETE'
        ELSE
            StepHeading := STRSUBSTNO('Step %1 of %2. %3', "Step number", "Total steps", "Step heading");
    end;

    var
        SemiManualExecutionLog Record: 130416;
        StepHeading: Text;
        ManualSteps: Text;
        CodeunitId: Integer;
        CodeunitIdentifier: Text;
        TestExecuting: Boolean;
        ErrorOccuredErr: Label 'The following error occured: %1', Locked = true;
        TestSuccessfulMsg: Label 'Test successfully completed.';

    local procedure LoadTest()
    var
        AllObjWithCaption Record: 2000000058;
    begin
        TestExecuting := FALSE;
        IF CodeunitId <= 0 THEN
            EXIT;

        SemiManualExecutionLog.Log(STRSUBSTNO('Attempting to load codeunit %1.', CodeunitId));
        AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Codeunit);
        AllObjWithCaption.SETRANGE("Object ID", CodeunitId);
        IF NOT AllObjWithCaption.FINDFIRST THEN
            EXIT;

        CodeunitIdentifier := STRSUBSTNO('%1: %2', CodeunitId, AllObjWithCaption."Object Name");
        Initialize(AllObjWithCaption."Object ID", AllObjWithCaption."Object Name");
        ManualSteps := GetManualSteps;
        TestExecuting := TRUE;
        SemiManualExecutionLog.Log(STRSUBSTNO('Loaded codeunit %1. Total steps = %2.',
            CodeunitId, "Total steps"));
        CurrPage.UPDATE;
    end;

    local procedure OnNextStep()
    begin
        CLEARLASTERROR;
        SemiManualExecutionLog.Log(STRSUBSTNO('Manual step %1- %2 executed. Attempting to execute the automation post process.',
            "Step number", "Step heading"));
        IF CODEUNIT.RUN("Codeunit number", Rec) THEN BEGIN
            ManualSteps := GetManualSteps;
            IF "Step number" > "Total steps" THEN BEGIN
                TestExecuting := FALSE;
                MESSAGE(TestSuccessfulMsg);
            END;
            CurrPage.UPDATE;
            IF "Skip current step" THEN
                SemiManualExecutionLog.Log('The automation post process step skipped.')
            ELSE
                SemiManualExecutionLog.Log('The automation post process executed without errors.');
        END ELSE BEGIN
            SemiManualExecutionLog.Log(STRSUBSTNO(ErrorOccuredErr, GETLASTERRORTEXT));
            ERROR(ErrorOccuredErr, GETLASTERRORTEXT);
        END;
    end;
}

