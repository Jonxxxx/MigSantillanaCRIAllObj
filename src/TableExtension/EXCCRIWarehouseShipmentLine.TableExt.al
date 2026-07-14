tableextension 50110 EXCCRIWarehouseShipmentLine extends "Warehouse Shipment Line"
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
