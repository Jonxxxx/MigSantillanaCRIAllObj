page 55577 "Inventarios Colegios ListPart"
{
    Caption = 'Sample Inventory';
    PageType = CardPart;
    SourceTable = 5050;

    layout
    {
        area(content)
        {
            field(FuncAPSColCalcInvMuestrasNo; FuncAPS.ColCalcInvMuestras(Rec."No."))
            {
                ApplicationArea = All;
                Caption = 'Sample Inventory';

                trigger OnLookup(var Text: Text): Boolean
                var
                    BC: Record 7302;
                    BCPage: Page 7304;
                begin
                    BC.RESET;
                    BC.SETRANGE("Location Code", Rec."Samples Location Code");
                    BC.SETRANGE("Bin Code", Rec."No.");
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
        FuncAPS: Codeunit 55467;
}

