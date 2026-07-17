pageextension 50115 EXCCRITransferOrderSubform extends "Transfer Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            Editable = false;
        }
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN2)
            {
                ApplicationArea = All;
                Caption = 'ISBN';
                ToolTip = 'Specifies the ISBN of the item on the transfer line.';
            }
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the transfer line.';
            }
        }
        addafter(Description)
        {
            field(EXCCRIQtyInTransit; Rec."Qty. in Transit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity that is currently in transit.';
            }
            field(EXCCRIConsignmentOrderNo; Rec."No. Pedido Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment order number associated with the transfer line.';
            }
            field(EXCCRIRequestedQuantity; Rec."Cantidad Solicitada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity requested on the transfer line.';
            }
            field(EXCCRIApprovedPercent; Rec."Porcentaje Cant. Aprobada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the percentage of the requested quantity that was approved.';
            }
            field(EXCCRIApprovedQuantity; Rec."Cantidad Aprobada")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the approved quantity on the transfer line.';
            }
            field(EXCCRIPendingBOQuantity; Rec."Cantidad pendiente BO")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the backorder quantity that is still pending.';
            }
            field(EXCCRICancelQuantity; Rec."Cantidad a Anular")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the pending backorder quantity to cancel.';
            }
            //TODO: Ver 
            /*
            field(EXCCRIAvailability; EXCCRIAvailabilityManagement.CalcAvailabilityTL_BackOrder(Rec))
            {
                ApplicationArea = All;
                Caption = 'Availability';
                Editable = false;
                ToolTip = 'Specifies the calculated item availability for backorder processing.';
            }*/
            field(EXCCRIAdjustQuantity; Rec."Cantidad a Ajustar")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the pending backorder quantity to add to the transfer line.';
            }
            field(EXCCRIVATProdPostingGroup; Rec."Grupo registro IVA prod.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT product posting group stored on the transfer line.';
            }
            field(EXCCRIVATBusPostingGroup; Rec."Grupo registro IVA neg.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT business posting group stored on the transfer line.';
            }
            field(EXCCRIVATPercent; Rec."% IVA")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the VAT percentage stored on the transfer line.';
            }
            field(EXCCRIQtyToShip; Rec."Qty. to Ship")
            {
                ApplicationArea = All;
                BlankZero = true;
                ToolTip = 'Specifies the quantity to ship for the transfer line.';
            }
            field(EXCCRIConsignmentPrice; Rec."Precio Venta Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consignment sales price of the transfer line.';
            }
            field(EXCCRIConsignmentDiscount; Rec."Descuento % Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consignment discount percentage of the transfer line.';
            }
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consignment amount of the transfer line.';
            }
            field(EXCCRIOriginalConsignAmount; Rec."Importe Consignacion Original")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the original consignment amount of the transfer line.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIUpdateBackOrder)
            {
                ApplicationArea = All;
                Caption = 'Update BO';
                Image = UpdateDescription;
                ToolTip = 'Updates the transfer line with the pending backorder adjustment or cancellation quantities.';

                trigger OnAction()
                begin
                    Rec.ActLinBO();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    procedure DeshacerEnvio()
    begin
        //TODO: Ver  Rec.DeshacerEnvio();
    end;

    var
        EXCCRIAvailabilityManagement: Codeunit 7171;
}
