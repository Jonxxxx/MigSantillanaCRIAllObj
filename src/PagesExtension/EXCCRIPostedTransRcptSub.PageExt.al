pageextension 50120 EXCCRIPostedTransRcptSub extends "Posted Transfer Rcpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(EXCCRIConsignmentOrderNo; Rec."No. Pedido Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment order number associated with the posted transfer receipt line.';
            }
            field(EXCCRIConsignmentPrice; Rec."Precio Venta Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment sales price of the posted transfer receipt line.';
            }
            field(EXCCRIConsignmentDiscount; Rec."Descuento % Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment discount percentage of the posted transfer receipt line.';
            }
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consignment amount of the posted transfer receipt line.';
            }
            field(EXCCRIVATProdPostingGroup; Rec."Grupo registro IVA prod.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the VAT product posting group stored on the posted transfer receipt line.';
            }
            field(EXCCRIVATBusPostingGroup; Rec."Grupo registro IVA neg.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the VAT business posting group stored on the posted transfer receipt line.';
            }
            field(EXCCRIVATPercent; Rec."% IVA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the VAT percentage stored on the posted transfer receipt line.';
            }
            field(EXCCRIVATAmount; Rec."Importe IVA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the VAT amount stored on the posted transfer receipt line.';
            }
        }
    }
}
