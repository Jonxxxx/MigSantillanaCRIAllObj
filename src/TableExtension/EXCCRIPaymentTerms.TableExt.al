tableextension 50000 EXCCRIPaymentTerms extends "Payment Terms"
{
    fields
    {
        field(50000; "Condicion Venta DGT"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Plazo de tiempo"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}
