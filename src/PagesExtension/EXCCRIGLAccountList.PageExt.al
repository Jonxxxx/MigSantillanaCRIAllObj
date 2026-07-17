pageextension 50005 EXCCRIGLAccountList extends "G/L Account List"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIConsolDebitAccount; Rec."Consol. Debit Acc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consolidation account to which debit balances are transferred.';
            }
            field(EXCCRIConsolCreditAccount; Rec."Consol. Credit Acc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consolidation account to which credit balances are transferred.';
            }
            field(EXCCRIIndentation; Rec.Indentation)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the indentation level of the general ledger account.';
            }
            field(EXCCRIDebitCredit; Rec."Debit/Credit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general ledger account normally contains debit or credit amounts.';
            }
            field(EXCCRILastDateModified; Rec."Last Date Modified")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the general ledger account was last modified.';
            }
            field(EXCCRIBlocked; Rec.Blocked)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether posting to the general ledger account is blocked.';
            }
        }
    }
}
