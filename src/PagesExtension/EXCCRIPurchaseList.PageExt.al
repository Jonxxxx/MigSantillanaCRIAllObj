pageextension 50029 EXCCRIPurchaseList extends "Purchase List"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIPostingNo; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting number assigned to the purchase document.';
            }
            field(EXCCRIVendorInvoiceNo; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the invoice number assigned by the vendor.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number associated with the purchase document.';
            }
        }
    }
}
