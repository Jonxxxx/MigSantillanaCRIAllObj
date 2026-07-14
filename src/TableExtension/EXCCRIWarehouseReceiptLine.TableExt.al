tableextension 50108 EXCCRIWarehouseReceiptLine extends "Warehouse Receipt Line"
{
    fields
    {
        field(50000; ISBN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("Item No.")));
        }
    }
}
