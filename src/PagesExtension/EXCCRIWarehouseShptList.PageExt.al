pageextension 50145 EXCCRIWarehouseShptList extends "Warehouse Shipment List"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field(EXCCRIPackingCompleted; Rec."Packing Completo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether packing has been completed for the warehouse shipment.';
            }
        }
    }
}
