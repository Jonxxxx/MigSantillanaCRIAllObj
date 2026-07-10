xmlport 130402 "CAL Import Enabled Codeunit"
{
    Caption = 'CAL Import Enabled Codeunit';
    Direction = Import;
    Encoding = UTF16;

    schema
    {
        textelement(CALTests)
        {
            textattribute(Name)
            {
            }
            textattribute(Description)
            {
            }
            tableelement(Table130403; Table130403)
            {
                XmlName = 'Codeunit';
                fieldattribute(ID; "CAL Test Enabled Codeunit"."Test Codeunit ID")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    CALTestMgt: Codeunit 130401;
                begin
                    IF NOT CALTestMgt.DoesTestCodeunitExist("CAL Test Enabled Codeunit"."Test Codeunit ID") OR
                       CodeunitIsEnabled("CAL Test Enabled Codeunit"."Test Codeunit ID")
                    THEN
                        currXMLport.SKIP;
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

    local procedure CodeunitIsEnabled(CodeunitId: Integer): Boolean
    var
        CALTestEnabledCodeunit Record: 130403;
    begin
        CALTestEnabledCodeunit.SETRANGE("Test Codeunit ID", CodeunitId);
        EXIT(NOT CALTestEnabledCodeunit.ISEMPTY);
    end;
}

