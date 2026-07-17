pageextension 50116 EXCCRITransferOrders extends "Transfer Orders"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRITransferFromCity; Rec."Transfer-from City")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the city of the transfer-from location.';
            }
            field(EXCCRIPostingDate; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting date of the transfer order.';
            }
            field(EXCCRIShippingAgentCode; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shipping agent assigned to the transfer order.';
            }
            field(EXCCRIDistributionStatus; Rec."Estado distribucion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the custom distribution status of the transfer order.';
            }
            field(EXCCRITransferToName; Rec."Transfer-to Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the transfer-to location.';
            }
            field(EXCCRITransferToName2; Rec."Transfer-to Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the additional name of the transfer-to location.';
            }
            field(EXCCRITransferToAddress; Rec."Transfer-to Address")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the address of the transfer-to location.';
            }
            field(EXCCRITransferToAddress2; Rec."Transfer-to Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the additional address of the transfer-to location.';
            }
            field(EXCCRITransferFromName; Rec."Transfer-from Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the transfer-from location.';
            }
            field(EXCCRITransferFromName2; Rec."Transfer-from Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the additional name of the transfer-from location.';
            }
            field(EXCCRITransferFromAddress; Rec."Transfer-from Address")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the address of the transfer-from location.';
            }
            field(EXCCRITransferFromAddress2; Rec."Transfer-from Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the additional address of the transfer-from location.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external document number of the transfer order.';
            }
            field(EXCCRIDeliveryPriority; Rec."Prioridad entrega consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the delivery priority of the consignment transfer order.';
            }
            field(EXCCRIOriginalConsignAmount; Rec."Importe Consignacion Orginal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the original consignment amount of the transfer order.';
            }
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current consignment amount of the transfer order.';
            }
            field(EXCCRIInTransitCode; Rec."In-Transit Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the in-transit location used by the transfer order.';
            }
            field(EXCCRIStatus; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the transfer order is open or released.';
            }
            field(EXCCRIDirectTransfer; Rec."Direct Transfer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the transfer order is a direct transfer.';
            }
            field(EXCCRIShortcutDimension1; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shortcut dimension 1 code of the transfer order.';
            }
            field(EXCCRIShortcutDimension2; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shortcut dimension 2 code of the transfer order.';
            }
            field(EXCCRIAssignedUserId; Rec."Assigned User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the user assigned to the transfer order.';
            }
            field(EXCCRIShipmentDate; Rec."Shipment Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shipment date of the transfer order.';
            }
            field(EXCCRIShipmentMethodCode; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the shipment method of the transfer order.';
            }
            field(EXCCRIShippingAdvice; Rec."Shipping Advice")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies whether partial shipment is allowed for the transfer order.';
            }
            field(EXCCRIReceiptDate; Rec."Receipt Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the expected receipt date of the transfer order.';
            }
        }
    }
}
