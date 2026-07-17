pageextension 50012 EXCCRIVendorLedgerEntries extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                Caption = 'Fiscal Receipt No.';
                ToolTip = 'Specifies the fiscal receipt number associated with the vendor ledger entry.';
            }
            field(EXCCRIVendorPostingGroup; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Vendor Posting Group';
                ToolTip = 'Specifies the vendor posting group used for the entry.';
            }
            field(EXCCRIBuyFromVendorNo; Rec."Buy-from Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Buy-from Vendor No.';
                ToolTip = 'Specifies the vendor from which the purchase originated.';
            }
        }
    }
}
