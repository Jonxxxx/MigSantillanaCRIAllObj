pageextension 50064 EXCCRIBankAccountList extends "Bank Account List"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIBalanceLCY; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the current balance of the bank account in local currency.';
            }
            field(EXCCRIBalance; Rec.Balance)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the current balance of the bank account in its currency.';
            }
        }
    }
}
