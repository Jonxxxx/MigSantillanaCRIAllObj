tableextension 55249 EXCCRIGeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(55225; "ITBIS al costo activo"; Boolean)
        {
            Caption = 'VAT to cost active';
            DataClassification = CustomerContent;
        }
        field(56000; "Nombre Divisa Local"; Text[30])
        {
            Caption = 'Local Currency Description';
            DataClassification = CustomerContent;
        }
    }
}
