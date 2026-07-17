pageextension 50060 EXCCRIPaymentJournal extends "Payment Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field(EXCCRIBeneficiary; Rec.Beneficiario)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the beneficiary associated with the payment journal line.';
            }
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the payment journal line.';
            }
        }
    }
}
