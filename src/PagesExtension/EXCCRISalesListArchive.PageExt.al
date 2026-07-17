pageextension 50097 EXCCRISalesListArchive extends "Sales List Archive"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIInvoice; Rec.Invoice)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Invoice value for the archived sales document.';
            }
            field(EXCCRINoFactura; Rec."No. Factura")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the No. Factura value for the archived sales document.';
            }
            field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Applies-to Doc. No. value for the archived sales document.';
            }
            field(EXCCRIDocumentType; Rec."Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Document Type value for the archived sales document.';
            }
            field(EXCCRIPromisedDeliveryDate; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Promised Delivery Date value for the archived sales document.';
            }
            field(EXCCRIPostingDate; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Posting Date value for the archived sales document.';
            }
            field(EXCCRIRequestedDeliveryDate; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Requested Delivery Date value for the archived sales document.';
            }
        }
    }
}
