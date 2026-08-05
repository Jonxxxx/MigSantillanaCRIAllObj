tableextension 55094 EXCCRIWarehouseActivityLine extends "Warehouse Activity Line"
{
    fields
    {
        field(55000; ISBN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ISBN where("No." = field("Item No.")));
        }
    }
}
