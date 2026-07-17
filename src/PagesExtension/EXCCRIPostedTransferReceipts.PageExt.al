pageextension 50121 EXCCRIPostedTransferReceipts extends "Posted Transfer Receipts"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRITransferOrderNo; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the transfer order number associated with the posted transfer receipt.';
            }
        }
    }
}
