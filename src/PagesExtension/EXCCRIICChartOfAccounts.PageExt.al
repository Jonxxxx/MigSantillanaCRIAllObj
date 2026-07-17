pageextension 50086 EXCCRIICChartOfAccounts extends "IC Chart of Accounts"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIIndentation; Rec.Indentation)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the indentation level of the intercompany general ledger account.';
            }
        }
    }
}
