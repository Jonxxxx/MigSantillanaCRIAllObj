pageextension 50144 EXCCRIWhseShipmentSub extends "Whse. Shipment Subform"
{
    layout
    {
        addafter("Source Line No.")
        {
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the warehouse shipment line.';
            }
        }
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the warehouse shipment line.';
            }
        }
    }
}
