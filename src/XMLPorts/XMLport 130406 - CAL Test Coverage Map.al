xmlport 130406 "CAL Test Coverage Map"
{
    Caption = 'CAL Test Coverage Map';
    Direction = Both;
    Format = VariableText;

    schema
    {
        textelement("<coverage>")
        {
            XmlName = 'Coverage';
            tableelement(Table130406;Table130406)
            {
                AutoUpdate = true;
                XmlName = 'TestCoverageMap';
                fieldelement(TestCodeunitID;"CAL Test Coverage Map"."Test Codeunit ID")
                {
                }
                textelement(objtype)
                {
                    XmlName = 'ObjectType';

                    trigger OnBeforePassVariable()
                    var
                        "Integer": Integer;
                    begin
                        Integer := "CAL Test Coverage Map"."Object Type";
                        ObjType := FORMAT(Integer,0,9);
                    end;

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE("CAL Test Coverage Map"."Object Type",ObjType);
                    end;
                }
                fieldelement(ObjectID;"CAL Test Coverage Map"."Object ID")
                {
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

