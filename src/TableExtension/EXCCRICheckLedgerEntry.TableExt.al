tableextension 55043 EXCCRICheckLedgerEntry extends "Check Ledger Entry"
{
    fields
    {
        field(34003001; Beneficiario; Text[100])
        {
            Caption = 'Beneficiary', Comment = 'ESP=Beneficiario';
            DataClassification = CustomerContent;
        }
    }
}
