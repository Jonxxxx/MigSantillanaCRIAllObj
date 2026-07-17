pageextension 50128 EXCCRIGLItemLedgerRelation extends "G/L - Item Ledger Relation"
{
    layout
    {
        addafter("ValueEntry.""Posting Date""")
        {
            field(EXCCRIValuationDate; EXCCRIValueEntry."Valuation Date")
            {
                ApplicationArea = All;
                Caption = 'Valuation Date';
                Editable = false;
                ToolTip = 'Specifies the valuation date of the related value entry.';
            }
            field(EXCCRIDocumentDate; EXCCRIValueEntry."Document Date")
            {
                ApplicationArea = All;
                Caption = 'Document Date';
                Editable = false;
                ToolTip = 'Specifies the document date of the related value entry.';
            }
        }
        addafter("G/L Register No.")
        {
            field(EXCCRIGLAccountNo; EXCCRIGLEntry."G/L Account No.")
            {
                ApplicationArea = All;
                Caption = 'G/L Account No.';
                Editable = false;
                ToolTip = 'Specifies the general ledger account of the related general ledger entry.';
            }
            field(EXCCRIDebitAmount; EXCCRIGLEntry."Debit Amount")
            {
                ApplicationArea = All;
                Caption = 'Debit Amount';
                Editable = false;
                ToolTip = 'Specifies the debit amount of the related general ledger entry.';
            }
            field(EXCCRICreditAmount; EXCCRIGLEntry."Credit Amount")
            {
                ApplicationArea = All;
                Caption = 'Credit Amount';
                Editable = false;
                ToolTip = 'Specifies the credit amount of the related general ledger entry.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not EXCCRIValueEntry.Get(Rec."Value Entry No.") then
            Clear(EXCCRIValueEntry);

        if not EXCCRIGLEntry.Get(Rec."G/L Entry No.") then
            Clear(EXCCRIGLEntry);
    end;

    var
        EXCCRIValueEntry: Record "Value Entry";
        EXCCRIGLEntry: Record "G/L Entry";
}
