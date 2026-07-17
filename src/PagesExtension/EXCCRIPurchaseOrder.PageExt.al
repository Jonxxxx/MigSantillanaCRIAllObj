pageextension 50026 EXCCRIPurchaseOrder extends "Purchase Order"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the purchase order.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number associated with the purchase order.';
                }
                field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
                }
                field(EXCCRIExpenseClassificationCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expense classification code assigned to the purchase order.';
                }
                field(EXCCRIWithholdingType; Rec."Tipo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the withholding type assigned to the purchase order.';
                }
                field(EXCCRIPaymentMethodCode; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment method assigned to the purchase order.';
                }
                field(EXCCRIProportionality; Rec.Proporcionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the proportionality treatment assigned to the purchase order.';
                }
                field(EXCCRIAppliesToDocType; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the posted document that the purchase order will be applied to.';
                }
                field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the posted document that the purchase order will be applied to.';
                }
            }
            group(EXCCRIElectronicPurchaseInvoice)
            {
                Caption = 'Electronic Purchase Invoice';

                field(EXCCRIElectronicDocumentType; Rec."Tipo Doc Electronico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic document type assigned to the purchase order.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the electronic document referenced by the purchase order.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the electronic invoice reference number associated with the purchase order.';
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
                    ToolTip = 'Opens the retentions configured for the purchase order and vendor.';
                }
                action(EXCCRIConsultNCF)
                {
                    ApplicationArea = All;
                    Caption = 'Consult NCF';
                    ToolTip = 'Opens the configured DGII website to consult a fiscal receipt number.';

                    trigger OnAction()
                    var
                        EXCCRILocalizationSetup: Record 34003008;
                    begin
                        EXCCRILocalizationSetup.Get();
                        EXCCRILocalizationSetup.TestField("URL DGII consulta NCF");
                        Hyperlink(EXCCRILocalizationSetup."URL DGII consulta NCF");
                    end;
                }
                action(EXCCRIConsultRNC)
                {
                    ApplicationArea = All;
                    Caption = 'Consult RNC';
                    ToolTip = 'Opens the configured DGII website to consult a tax registration number.';

                    trigger OnAction()
                    var
                        EXCCRILocalizationSetup: Record 34003008;
                    begin
                        EXCCRILocalizationSetup.Get();
                        EXCCRILocalizationSetup.TestField("URL DGII consulta RNC");
                        Hyperlink(EXCCRILocalizationSetup."URL DGII consulta RNC");
                    end;
                }
                action(EXCCRIRetention)
                {
                    ApplicationArea = All;
                    Caption = 'Retention';
                    RunObject = page 34003002;
                    RunPageLink = "Tipo documento" = field("Document Type"),
                                  "No. documento" = field("No.");
                    ToolTip = 'Opens the retention entries associated with the purchase order.';
                }
            }
        }
    }
}
