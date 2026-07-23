pageextension 50033 EXCCRISalesCrMemoSubform extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIQtyToInvoice; Rec."Qty. to Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity that will be invoiced on the sales credit memo line.';
            }
            field(EXCCRIQtyToShip; Rec."Qty. to Ship")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity that will be shipped on the sales credit memo line.';
            }
        }
    }

    procedure SplitIC()
    var
        EXCCRISalesLine: Record "Sales Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRISalesLine);
        // 
        /*
        Report.Run(
            Report::"Split Sales Item Charge.",
            false,
            false,
            EXCCRISalesLine);*/
    end;
}
