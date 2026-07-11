page 67118 "Inventarios Colegios ListPart"
{
    Caption = 'Sample Inventory';
    PageType = CardPart;
    SourceTable = Table5050;

    layout
    {
        area(content)
        {
            field(FuncAPS.ColCalcInvMuestras("No.");
                FuncAPS.ColCalcInvMuestras("No."))
            {
                Caption = 'Sample Inventory';

                trigger OnLookup(var Text: Text): Boolean
                var
                    BC: Record 7302;
                    BCPage: Page7304;
                begin
                    BC.RESET;
                    BC.SETRANGE("Location Code", "Samples Location Code");
                    BC.SETRANGE("Bin Code", "No.");
                    IF BC.FINDSET THEN BEGIN
                        BCPage.SETTABLEVIEW(BC);
                        BCPage.RUNMODAL;
                        CLEAR(BCPage);
                    END;
                end;
            }
        }
    }

    actions
    {
    }

    var
        FuncAPS: Codeunit 67000;
}

