pageextension 50006 EXCCRIGeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRISystemCreatedEntry; Rec."System-Created Entry")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general ledger entry was created automatically by the system.';
            }
            field(EXCCRITransactionNo; Rec."Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the transaction number assigned to the general ledger entry.';
            }
            field(EXCCRISourceType; Rec."Source Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of source record that generated the general ledger entry.';
            }
            field(EXCCRISourceNo; Rec."Source No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the source number that generated the general ledger entry.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external document number associated with the general ledger entry.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number associated with the general ledger entry.';
            }
            field(EXCCRIExpenseClassification; Rec."Cod. Clasificacion Gasto")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expense classification code associated with the general ledger entry.';
            }
            field(EXCCRIRNC; Rec.RNC)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the tax registration number associated with the general ledger entry.';
            }
            field(EXCCRIQuantity; Rec.Quantity)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity associated with the general ledger entry.';
            }
        }
    }
}
