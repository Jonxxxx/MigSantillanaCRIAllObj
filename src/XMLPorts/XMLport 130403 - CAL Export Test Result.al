xmlport 130403 "CAL Export Test Result"
{
    Caption = 'CAL Export Test Result';
    Direction = Export;

    schema
    {
        textelement(TestResults)
        {
            tableelement(Table130405;Table130405)
            {
                XmlName = 'TestResult';
                fieldelement(No;"CAL Test Result"."No.")
                {
                }
                fieldelement(TestRunNo;"CAL Test Result"."Test Run No.")
                {
                }
                fieldelement(CUId;"CAL Test Result"."Codeunit ID")
                {
                }
                fieldelement(CUName;"CAL Test Result"."Codeunit Name")
                {
                }
                fieldelement(FName;"CAL Test Result"."Function Name")
                {
                }
                fieldelement(Platform;"CAL Test Result".Platform)
                {
                }
                fieldelement(Result;"CAL Test Result".Result)
                {
                }
                fieldelement(Restore;"CAL Test Result".Restore)
                {
                }
                fieldelement(ExecutionTime;"CAL Test Result"."Execution Time")
                {
                }
                fieldelement(ErrorCode;"CAL Test Result"."Error Code")
                {
                }
                fieldelement(ErrorMessage;"CAL Test Result"."Error Message")
                {
                }
                fieldelement(File;"CAL Test Result".File)
                {
                }
                textelement(callstacktext)
                {
                    XmlName = 'CallStack';
                }

                trigger OnAfterGetRecord()
                var
                    InStr: InStream;
                begin
                    "CAL Test Result".CALCFIELDS("Call Stack");
                    "CAL Test Result"."Call Stack".CREATEINSTREAM(InStr);
                    InStr.READTEXT(CallStackText);
                end;

                trigger OnPreXmlItem()
                var
                    TestRunNo: Integer;
                begin
                    IF SkipPassed THEN
                      "CAL Test Result".SETFILTER(Result,'<>%1',"CAL Test Result".Result::Passed);

                    IF LastTestRun THEN BEGIN
                      TestRunNo := "CAL Test Result".LastTestRunNo;
                      "CAL Test Result".SETRANGE("Test Run No.",TestRunNo);
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        SkipPassed: Boolean;
        LastTestRun: Boolean;

    [Scope('Personalization')]
    procedure SetParam(NewSkipPassed: Boolean;NewLastTestRun: Boolean)
    begin
        SkipPassed := NewSkipPassed;
        LastTestRun := NewLastTestRun;
    end;
}

