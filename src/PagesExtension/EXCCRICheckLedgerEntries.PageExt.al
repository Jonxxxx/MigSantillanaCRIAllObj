pageextension 50066 EXCCRICheckLedgerEntries extends "Check Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIBeneficiary; Rec.Beneficiario)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the beneficiary associated with the check ledger entry.';
            }
        }
        addafter("Document No.")
        {
            field(EXCCRIStatementStatus; Rec."Statement Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the bank statement reconciliation status of the check ledger entry.';
            }
        }
    }
}
