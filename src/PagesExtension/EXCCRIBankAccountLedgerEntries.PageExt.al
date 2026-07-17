pageextension 50065 EXCCRIBankAccountLedgerEntries extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the external document number associated with the bank account ledger entry.';
            }
        }
        addafter("Bal. Account No.")
        {
            field(EXCCRIStatementNo; Rec."Statement No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the bank statement number associated with the bank account ledger entry.';
            }
        }
        addafter("Entry No.")
        {
            field(EXCCRIFinanceProcessed; Rec."Realizado Financ.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the finance processing information stored on the bank account ledger entry.';
            }
            field(EXCCRICollectorCode; Rec."Collector Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the collector associated with the bank account ledger entry.';
            }
        }
    }
}
