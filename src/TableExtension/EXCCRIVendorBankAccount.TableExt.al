tableextension 55044 EXCCRIVendorBankAccount extends "Vendor Bank Account"
{
    fields
    {
        field(55955; "Tipo Cuenta"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'CC= Current Account,CA=Savings Account,TJ= Card,PR= Loan', Comment = 'ESP=CC= Cuenta Corriente,CA=Cuenta de Ahorro,TJ= Tarjeta,PR= Prestamo';
            OptionMembers = "CC= Cuenta Corriente","CA=Cuenta de Ahorro","TJ= Tarjeta","PR= Prestamo";
        }
    }
}
