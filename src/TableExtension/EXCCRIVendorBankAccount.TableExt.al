tableextension 50044 EXCCRIVendorBankAccount extends "Vendor Bank Account"
{
    fields
    {
        field(34003000; "Tipo Cuenta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'CC= Current Account,CA=Savings Account,TJ= Card,PR= Loan', Comment = 'ESP=CC= Cuenta Corriente,CA=Cuenta de Ahorro,TJ= Tarjeta,PR= Préstamo';
            OptionMembers = "CC= Cuenta Corriente","CA=Cuenta de Ahorro","TJ= Tarjeta","PR= Préstamo";
        }
    }
}
