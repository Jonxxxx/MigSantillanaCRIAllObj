tableextension 50024 EXCCRIGeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "ITBIS al costo activo"; Boolean)
        {
            Caption = 'VAT to cost active';
            DataClassification = ToBeClassified;
        }
        field(56000; "Nombre Divisa Local"; Text[30])
        {
            Caption = 'Local Currency Description';
            DataClassification = ToBeClassified;
        }
    }
}
