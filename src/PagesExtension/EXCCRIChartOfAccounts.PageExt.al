pageextension 50003 EXCCRIChartOfAccounts extends "Chart of Accounts"
{
    layout
    {
        addafter(Name)
        {
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
            field(EXCCRITotaling; Rec.Totaling)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the account interval or formula used to calculate totals for the general ledger account.';
            }
            field(EXCCRINetChange; Rec."Net Change")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the net change posted to the general ledger account within the active filters.';
            }
            field(EXCCRICreditAmount; Rec."Credit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total credit amount posted to the general ledger account within the active filters.';
            }
            field(EXCCRIExchangeRateAdjustment; Rec."Exchange Rate Adjustment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how exchange rate adjustments are handled for the general ledger account.';
            }
            field(EXCCRIBlocked; Rec.Blocked)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether posting to the general ledger account is blocked.';
            }
        }
    }
}
