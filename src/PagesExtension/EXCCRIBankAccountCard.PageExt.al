pageextension 50063 EXCCRIBankAccountCard extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRICheckReportName; Rec."Check Report Name")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the name of the check report assigned to the bank account.';
            }
            field(EXCCRICheckReportId; Rec."Check Report ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the object ID of the check report assigned to the bank account.';
            }
        }
    }
}
