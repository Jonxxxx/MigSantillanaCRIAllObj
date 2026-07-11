page 130400 "CAL Test Suites"
{
    Caption = 'CAL Test Suites';
    PageType = List;
    SaveValues = true;
    SourceTable = 130400;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the test suite.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Update Test Coverage Map"; "Update Test Coverage Map")
                {
                    ApplicationArea = All;
                }
                field("Tests to Execute"; "Tests to Execute")
                {
                    ApplicationArea = All;
                }
                field(Failures; Failures)
                {
                    ApplicationArea = All;
                }
                field("Tests not Executed"; "Tests not Executed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Test &Suite")
            {
                Caption = 'Test &Suite';
                action("&Run All")
                {
                    ApplicationArea = All;
                    Caption = '&Run All';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+L';

                    trigger OnAction()
                    var
                        CALTestSuite: Record 130400;
                        CALTestLine: Record 130401;
                    begin
                        IF CALTestSuite.FINDSET THEN
                            REPEAT
                                CALTestLine.SETRANGE("Test Suite", CALTestSuite.Name);
                                IF CALTestLine.FINDFIRST THEN
                                    CODEUNIT.RUN(CODEUNIT::"CAL Test Runner", CALTestLine);
                            UNTIL CALTestSuite.NEXT = 0;
                        COMMIT;
                    end;
                }
                group(Setup)
                {
                    Caption = 'Setup';
                    Image = Setup;
                    action("E&xport")
                    {
                        ApplicationArea = All;
                        Caption = 'E&xport';
                        Promoted = true;
                        PromotedCategory = Process;

                        trigger OnAction()
                        begin
                            ExportTestSuiteSetup;
                        end;
                    }
                    action("I&mport")
                    {
                        ApplicationArea = All;
                        Caption = 'I&mport';

                        trigger OnAction()
                        begin
                            ImportTestSuiteSetup;
                        end;
                    }
                }
                separator(Separator)
                {
                    Caption = 'Separator';
                }
                group(Results)
                {
                    Caption = 'Results';
                    Image = Log;
                    action("E&xport")
                    {
                        ApplicationArea = All;
                        Caption = 'E&xport';

                        trigger OnAction()
                        begin
                            ExportTestSuiteResult;
                        end;
                    }
                    action("I&mport")
                    {
                        ApplicationArea = All;
                        Caption = 'I&mport';

                        trigger OnAction()
                        begin
                            ImportTestSuiteResult;
                        end;
                    }
                }
            }
        }
    }
}

