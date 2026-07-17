pageextension 50084 EXCCRIDtlCustLedgEntries extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field(EXCCRIPostingGroup; Rec."Grupo Contable")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the posting group stored on the detailed customer ledger entry.';
            }
        }
    }
}
