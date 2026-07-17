pageextension 50085 EXCCRIDtlVendorLedgEntries extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field(EXCCRIPostingGroup; Rec."Grupo Contable")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the posting group stored on the detailed vendor ledger entry.';
            }
        }
    }
}
