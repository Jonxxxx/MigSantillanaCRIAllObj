pageextension 50050 EXCCRIPostedPurchaseReceipts extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIOrderNo; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the purchase order number associated with the posted purchase receipt.';
            }
        }
    }
}
