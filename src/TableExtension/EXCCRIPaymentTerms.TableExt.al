tableextension 55225 EXCCRIPaymentTerms extends "Payment Terms"
{
    fields
    {
        field(55225; "Condicion Venta DGT"; Code[2])
        {
            DataClassification = CustomerContent;
        }
        field(55226; "Plazo de tiempo"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}
