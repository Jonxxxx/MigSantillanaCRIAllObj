pageextension 50047 EXCCRIPostedSalesShipments extends "Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIInvoiceNo; Rec."No. Factura")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the invoice number associated with the posted sales shipment.';
            }
            field(EXCCRIBillToCity; Rec."Bill-to City")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bill-to city associated with the posted sales shipment.';
            }
            field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document number to which the posted sales shipment is applied.';
            }
        }
    }
}
