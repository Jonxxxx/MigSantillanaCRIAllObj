xmlport 130401 "CAL Test Results"
{
    Caption = 'CAL Test Results';
    Encoding = UTF8;

    schema
    {
        textelement(TestSuites)
        {
            tableelement("test suite";Table130400)
            {
                CalcFields = Field3;
                MinOccurs = Zero;
                XmlName = 'TestSuite';
                fieldelement(Name;"Test Suite".Name)
                {
                }
                fieldelement(Description;"Test Suite".Description)
                {
                }
                textelement(TestLines)
                {
                    tableelement("test line";Table130401)
                    {
                        LinkFields = Field1=FIELD(Field1);
                        LinkTable = "Test Suite";
                        MinOccurs = Zero;
                        XmlName = 'TestLine';
                        fieldelement(TestSuite;"Test Line"."Test Suite")
                        {
                        }
                        fieldelement(LineNo;"Test Line"."Line No.")
                        {
                        }
                        fieldelement(LineType;"Test Line"."Line Type")
                        {
                        }
                        fieldelement(Name;"Test Line".Name)
                        {
                            FieldValidate = No;
                        }
                        fieldelement(TestCodeunit;"Test Line"."Test Codeunit")
                        {
                        }
                        fieldelement(Function;"Test Line".Function)
                        {
                        }
                        fieldelement(Run;"Test Line".Run)
                        {
                            FieldValidate = No;
                        }
                        fieldelement(Result;"Test Line".Result)
                        {
                            FieldValidate = No;
                        }
                        fieldelement(FirstError;"Test Line"."First Error")
                        {
                            FieldValidate = No;
                        }
                        fieldelement(StartTime;"Test Line"."Start Time")
                        {
                            FieldValidate = No;
                        }
                        fieldelement(FinishTime;"Test Line"."Finish Time")
                        {
                            FieldValidate = No;
                        }
                        fieldelement(Level;"Test Line".Level)
                        {
                            FieldValidate = No;
                        }
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
}

