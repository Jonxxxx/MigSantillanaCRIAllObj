pageextension 50023 EXCCRISalesList extends "Sales List"
{
    layout
    {
        addbefore("No.")
        {
            field(EXCCRIPostingDate; Rec."Posting Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the date when the sales document will be posted.';
            }
            field(EXCCRIOrderDate; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the sales document was created.';
            }
        }
        addafter("No.")
        {
            field(EXCCRIPostingNo; Rec."Posting No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting number assigned to the sales document.';
            }
            field(EXCCRIQuantityInLines; Rec."Cantidad en lineas")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total quantity contained in the sales document lines.';
            }
            field(EXCCRIWarehouseShipmentNo; Rec."No. Envio de Almacen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the warehouse shipment number associated with the sales document.';
            }
            field(EXCCRIPickNo; Rec."No. Picking")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the inventory or warehouse pick number associated with the sales document.';
            }
            field(EXCCRIPostedPickNo; Rec."No. Picking Reg.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posted pick number associated with the sales document.';
            }
            field(EXCCRIPackingNo; Rec."No. Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing document number associated with the sales document.';
            }
            field(EXCCRIPostedPackingNo; Rec."No. Packing Reg.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posted packing document number associated with the sales document.';
            }
            field(EXCCRIInvoiceNo; Rec."No. Factura")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the invoice number generated from the sales document.';
            }
            field(EXCCRIShipmentNo; Rec."No. Envio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posted shipment number generated from the sales document.';
            }
            field(EXCCRIInRouteSheet; Rec."En Hoja de Ruta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the sales document is included in a route sheet.';
            }
            //TODO: Ver 
            /*
            field(EXCCRIOutstandingAmountUSD; Rec."Outstanding Amount ($)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding amount of the sales document in the configured dollar currency.';
            }*/
            field(EXCCRIOrderType; Rec."Tipo pedido")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the custom order type assigned to the sales document.';
            }
            field(EXCCRIShippingNo; Rec."Shipping No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the shipping number assigned to the sales document.';
            }
            field(EXCCRIAmount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the amount of the sales document.';
            }
            field(EXCCRIComment; Rec.Comment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether comments exist for the sales document.';
            }
            field(EXCCRIStatus; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current status of the sales document.';
            }
            field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Facturas")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series assigned to the sales document.';
            }
            field(EXCCRIPromisedDeliveryDate; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when delivery was promised to the customer.';
            }
            field(EXCCRIRequestedDeliveryDate; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the customer requested delivery.';
            }
        }
    }
}
