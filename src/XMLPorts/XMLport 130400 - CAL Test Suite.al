xmlport 130400 "CAL Test Suite"
{
    Caption = 'CAL Test Suite';
    Encoding = UTF8;

    schema
    {
        textelement("<caltestsuites>")
        {
            XmlName = 'CALTestSuites';
            tableelement("cal test suite"; Table130400)
            {
                MinOccurs = Zero;
                XmlName = 'CALTestSuite';
                fieldelement(Name; "CAL Test Suite".Name)
                {
                }
                fieldelement(Description; "CAL Test Suite".Description)
                {
                }
                fieldelement(Export; "CAL Test Suite".Export)
                {
                }
                textelement(CALTestLines)
                {
                    tableelement("<cal test line>"; Table130401)
                    {
                        LinkFields = Field1 = FIELD(Field1);
                        LinkTable = "CAL Test Suite";
                        MinOccurs = Zero;
                        XmlName = 'CALTestLine';
                        fieldelement(TestTestSuite; "<CAL Test Line>"."Test Suite")
                        {
                        }
                        fieldelement(LineType; "<CAL Test Line>"."Line Type")
                        {
                        }
                        fieldelement(Name; "<CAL Test Line>".Name)
                        {
                            FieldValidate = No;
                        }
                        fieldelement(TestCodeunit; "<CAL Test Line>"."Test Codeunit")
                        {
                        }
                        fieldelement(Function; "<CAL Test Line>".Function)
                        {
                        }
                        fieldelement(Run; "<CAL Test Line>".Run)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "<CAL Test Line>"."Function" = '' THEN BEGIN
                                IF "<CAL Test Line>"."Test Codeunit" <> 0 THEN
                                    CALTestLine := "<CAL Test Line>";
                            END ELSE BEGIN
                                IF "<CAL Test Line>".Run THEN
                                    currXMLport.SKIP;
                                IF NOT CALTestLine.Run AND (CALTestLine."Test Codeunit" = "<CAL Test Line>"."Test Codeunit") THEN
                                    currXMLport.SKIP;
                            END;
                        end;

                        trigger OnAfterInsertRecord()
                        var
                            CopyOfCALTestLine Record: 130401;
                        begin
                            IF ("<CAL Test Line>"."Test Codeunit" <> 0) AND
                               ("<CAL Test Line>"."Function" = '')
                            THEN BEGIN
                                CopyOfCALTestLine.COPY("<CAL Test Line>");
                                "<CAL Test Line>".SETRECFILTER;

                                CALTestMgt.SETPUBLISHMODE;
                                CODEUNIT.RUN(CODEUNIT::"CAL Test Runner", "<CAL Test Line>");

                                "<CAL Test Line>".COPY(CopyOfCALTestLine);
                            END;
                        end;

                        trigger OnBeforeInsertRecord()
                        begin
                            IF "<CAL Test Line>"."Function" = '' THEN BEGIN
                                CALTestLine.SETRANGE("Test Suite", "<CAL Test Line>"."Test Suite");
                                CALTestLine.SETRANGE("Function", '');
                                "<CAL Test Line>"."Line No." := 10000;
                                IF CALTestLine.FINDLAST THEN
                                    "<CAL Test Line>"."Line No." := CALTestLine."Line No." + 10000;
                                CALTestLine.SETFILTER("Line No.", '>=%1', "<CAL Test Line>"."Line No.");
                            END ELSE BEGIN
                                CALTestLine.SETRANGE("Function", "<CAL Test Line>"."Function");
                                IF NOT CALTestLine.FINDFIRST THEN
                                    currXMLport.SKIP;
                                CALTestLine.DELETE;
                                "<CAL Test Line>"."Line No." := CALTestLine."Line No.";

                                CALTestLine.SETRANGE("Function", '');
                                CALTestLine.FINDLAST;
                            END;
                        end;
                    }
                }
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
        CALTestLine Record: 130401;
        CALTestMgt: Codeunit 130401;
}

