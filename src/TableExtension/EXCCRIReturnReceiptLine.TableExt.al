tableextension 55103 EXCCRIReturnReceiptLine extends "Return Receipt Line"
{
    fields
    {
        field(55225; ISBN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("No.")));
        }
    }
}
