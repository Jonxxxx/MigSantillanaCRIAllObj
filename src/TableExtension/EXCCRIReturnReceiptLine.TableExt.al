tableextension 50103 EXCCRIReturnReceiptLine extends "Return Receipt Line"
{
    fields
    {
        field(50000; ISBN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("No.")));
        }
    }
}
