pageextension 50118 EXCCRIPostedTransShptSub extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(EXCCRIConsignmentPrice; Rec."Precio Venta Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment sales price of the posted transfer shipment line.';
            }
            field(EXCCRIConsignmentDiscount; Rec."Descuento % Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment discount percentage of the posted transfer shipment line.';
            }
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment amount of the posted transfer shipment line.';
            }
        }
    }
}
