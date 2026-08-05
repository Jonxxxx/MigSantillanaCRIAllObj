tableextension 55000 EXCCRIPaymentTerms extends "Payment Terms"
{
    fields
    {
        field(55000; "Condicion Venta DGT"; Code[2])
        {
            DataClassification = CustomerContent;
        }
        field(55001; "Plazo de tiempo"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}
