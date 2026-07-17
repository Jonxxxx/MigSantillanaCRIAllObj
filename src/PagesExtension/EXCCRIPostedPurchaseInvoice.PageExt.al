pageextension 50044 EXCCRIPostedPurchaseInvoice extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the posted purchase invoice.';
                }
                field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the expense classification code assigned to the posted purchase invoice.';
                }
                field(EXCCRIProportionality; Rec.Proporcionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the proportionality treatment assigned to the posted purchase invoice.';
                }
            }
            group(EXCCRIElectronicPurchase)
            {
                Caption = 'Electronic Purchase Invoice';

                field(EXCCRIElectronicDocType; Rec."Tipo Doc Electronico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic document type assigned to the posted purchase invoice.';
                }
                field(EXCCRIReferencedDocType; Rec."Tipo Doc. Ref.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the electronic document referenced by the posted purchase invoice.';
                }
                field(EXCCRIElectronicReference; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the electronic invoicing reference number associated with the posted purchase invoice.';
                }
                field(EXCCRIElectronicEmail; Rec."E-Mail-FE")
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
            group(EXCCRIRetentionActions)
            {
                Caption = 'Retentions';

                action(EXCCRIRetentions)
                {
                    ApplicationArea = All;
                    Caption = 'Retentions';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page 34003003;
                    RunPageView = sorting("Tipo documento", "No. documento", "Codigo Retencion") order(ascending);
                    RunPageLink = "Cod. Proveedor" = field("Pay-to Vendor No."),
                                  "Tipo documento" = filter(Invoice),
                                  "No. documento" = field("No.");
                    ToolTip = 'Opens the retention records associated with the posted purchase invoice and vendor.';
                }
                action(EXCCRIRetention)
                {
                    ApplicationArea = All;
                    Caption = 'Retention';
                    RunObject = page 34003003;
                    RunPageLink = "No. documento" = field("No.");
                    ToolTip = 'Opens the retention records associated with the posted purchase invoice.';
                }
            }
        }
    }
}
