pageextension 50052 EXCCRIPostedPurchCreditMemos extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number assigned to the posted purchase credit memo.';
            }
            field(EXCCRIRelatedFiscalReceipt; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number related to the posted purchase credit memo.';
            }
        }
    }
}
