pageextension 50135 EXCCRIPurchReturnOrderSub extends "Purchase Return Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the purchase return order line.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRISplitItemCharges)
            {
                ApplicationArea = All;
                Caption = 'Distribute Item Charges';
                Image = ItemCosts;
                ToolTip = 'Distributes the selected purchase item charges among the related item lines.';

                trigger OnAction()
                begin
                    SplitIC();
                end;
            }
        }
    }

    procedure SplitIC()
    var
        EXCCRIPurchaseLine: Record "Purchase Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRIPurchaseLine);
        //TODO: Ver 
        /*
        Report.Run(
            Report::"Split Item Charge",
            false,
            false,
            EXCCRIPurchaseLine);*/
    end;

    procedure Distribucion()
    var
        EXCCRIPurchaseLine: Record "Purchase Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRIPurchaseLine);
        //TODO: Ver 
        /*
        Report.Run(
            Report::"Split CC Distribution",
            false,
            false,
            EXCCRIPurchaseLine);*/
    end;
}
