tableextension 55024 EXCCRIGeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(55000; "ITBIS al costo activo"; Boolean)
        {
            Caption = 'VAT to cost active';
            DataClassification = CustomerContent;
        }
        field(55225; "Nombre Divisa Local"; Text[30])
        {
            Caption = 'Local Currency Description';
            DataClassification = CustomerContent;
        }
    }
}
