pageextension 50027 EXCCRIPurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIWithholdingType; Rec."Tipo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the withholding type assigned to the purchase invoice.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number associated with the purchase invoice.';
                }
                field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
                }
                field(EXCCRIExpenseClassificationCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expense classification code assigned to the purchase invoice.';
                }
                field(EXCCRIProportionality; Rec.Proporcionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the proportionality treatment assigned to the purchase invoice.';
                }
                field(EXCCRIAppliesToDocType; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the posted document that the purchase invoice will be applied to.';
                }
                field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the posted document that the purchase invoice will be applied to.';
                }
            }
            group(EXCCRIElectronicPurchaseInvoice)
            {
                Caption = 'Electronic Purchase Invoice';

                field(EXCCRIElectronicDocumentType; Rec."Tipo Doc Electronico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic document type assigned to the purchase invoice.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the electronic document referenced by the purchase invoice.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the electronic invoice reference number associated with the purchase invoice.';
                }
                field(EXCCRIElectronicInvoiceEmail; Rec."E-Mail-FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address used for the electronic purchase invoice.';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRILocalizationActions)
            {
                Caption = 'Localization';

                action(EXCCRIRetentions)
                {
                    ApplicationArea = All;
                    Caption = 'Retentions';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page 34003002;
                    RunPageView = sorting("Cod. Proveedor", "Codigo Retencion", "Tipo documento", "No. documento") order(ascending);
                    RunPageLink = "Cod. Proveedor" = field("Buy-from Vendor No."),
                                  "Tipo documento" = field("Document Type"),
                                  "No. documento" = field("No.");
                    ToolTip = 'Opens the retentions configured for the purchase invoice and vendor.';
                }
                action(EXCCRIRetention)
                {
                    ApplicationArea = All;
                    Caption = 'Retention';
                    RunObject = page 34003002;
                    RunPageLink = "Tipo documento" = field("Document Type"),
                                  "No. documento" = field("No.");
                    ToolTip = 'Opens the retention entries associated with the purchase invoice.';
                }
            }
        }
    }
}
