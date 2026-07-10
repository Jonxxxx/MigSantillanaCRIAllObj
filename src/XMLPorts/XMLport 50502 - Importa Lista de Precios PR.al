xmlport 50502 "Importa Lista de Precios PR"
{
    Caption = 'Importa Lista de Precios';
    Format = VariableText;

    schema
    {
        textelement(Lista_de_Precios)
        {
            tableelement(Table7002; Table7002)
            {
                AutoUpdate = true;
                XmlName = 'recSalesPrice';
                SourceTableView = SORTING(Field1, Field13, Field2, Field4, Field3, Field5700, Field5400, Field14);
                fieldelement(SalesType; "Sales Price"."Sales Type")
                {
                }
                fieldelement(SalesCode; "Sales Price"."Sales Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ItemNo; "Sales Price"."Item No.")
                {
                }
                fieldelement(UniMedida; "Sales Price"."Unit of Measure Code")
                {
                }
                fieldelement(UnitPrice; "Sales Price"."Unit Price")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StartingDate; "Sales Price"."Starting Date")
                {

                    trigger OnAfterAssignField()
                    begin
                        SP2.RESET;
                        SP2.SETRANGE("Sales Type", SP2."Sales Type"::"Customer Price Group");
                        SP2.SETRANGE("Item No.", "Sales Price"."Item No.");
                        SP2.SETRANGE("Starting Date", 0D, CALCDATE('-1D', "Sales Price"."Starting Date"));
                        IF SP2.FINDSET(TRUE, FALSE) THEN
                            REPEAT
                                SP2."Ending Date" := CALCDATE('-1D', "Sales Price"."Starting Date");
                                SP2.MODIFY;
                            UNTIL SP2.NEXT = 0;
                    end;
                }
                fieldelement("AllowLineDisc."; "Sales Price"."Allow Line Disc.")
                {
                    MinOccurs = Zero;
                }
                fieldelement("AllowInvoiceDisc."; "Sales Price"."Allow Invoice Disc.")
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin
                    "Sales Price"."Sales Type" := "Sales Price"."Sales Type"::"Customer Price Group";
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
        SP Record: 7002;
        SP2Record 7002;
}

