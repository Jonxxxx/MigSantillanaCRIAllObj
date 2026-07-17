pageextension 50048 EXCCRIPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales order category associated with the posted sales invoice.';
            }
            field(EXCCRIPostingDescription; Rec."Posting Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting description of the posted sales invoice.';
            }
            field(EXCCRIElectronicDocType; Rec."Tipo Doc Electronico")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic document type assigned to the posted sales invoice.';
            }
            field(EXCCRIElectronicDocDate; Rec."Fecha Doc Electronico")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date and time associated with the electronic document.';
            }
            field(EXCCRIElectronicKey; Rec.Clave)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic document key assigned to the posted sales invoice.';
            }
            field(EXCCRIConsecutiveNo; Rec.Consecutivo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consecutive number assigned to the electronic document.';
            }
            field(EXCCRIElectronicStatus; Rec.Estado)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current electronic invoicing status of the posted sales invoice.';
            }
            field(EXCCRIElectronicMessage; Rec.Mensaje)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the message returned by the electronic invoicing process.';
            }
            field(EXCCRITotalDiscountAmount; EXCCRITotalDiscountAmount)
            {
                ApplicationArea = All;
                Caption = 'Invoice Discount Amount';
                Editable = false;
                ToolTip = 'Specifies the combined invoice and line discount amount of the posted sales invoice.';
            }
            field(EXCCRIECommerceStatus; Rec."Estado E-Commerce")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the e-commerce status of the posted sales invoice.';
            }
            field(EXCCRICurrencyFactor; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the currency factor used on the posted sales invoice.';
            }
            field(EXCCRINCFInvoiceSeries; Rec."No. Serie NCF Facturas")
            {
                ApplicationArea = All;
                Caption = 'Invoice NCF Series No.';
                ToolTip = 'Specifies the fiscal receipt number series used for the posted sales invoice.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                Caption = 'Fiscal Document No.';
                ToolTip = 'Specifies the fiscal receipt number assigned to the posted sales invoice.';
            }
            field(EXCCRIRelatedFiscalReceipt; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                Caption = 'Related Fiscal Document No.';
                ToolTip = 'Specifies the fiscal receipt number related to the posted sales invoice.';
            }
            field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
            }
            field(EXCCRICouponCode; Rec."Cod. Cupon")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the coupon code associated with the posted sales invoice.';
            }
            field(EXCCRISchoolCode; Rec."Cod. Colegio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the school code associated with the posted sales invoice.';
            }
            field(EXCCRISchoolName; Rec."Nombre Colegio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the school name associated with the posted sales invoice.';
            }
            field(EXCCRISaleType; Rec."Tipo de Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sale type assigned to the posted sales invoice.';
            }
            field(EXCCRIEmail; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address stored on the posted sales invoice.';
            }
            field(EXCCRIElectronicEmail; Rec."E-Mail-FE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address used for the electronic invoice.';
            }
            field(EXCCRIPOSSale; Rec."Venta TPV")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the posted sales invoice originated from the POS process.';
            }
            field(EXCCRISICDocumentNo; Rec."No. Documento SIC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the SIC document number associated with the posted sales invoice.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRIElectronicActions)
            {
                Caption = 'Electronic Document';

                action(EXCCRISendElectronicInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Send Electronic Invoice';
                    Image = ElectronicNumber;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Sends the selected posted sales invoice through the custom electronic invoicing process.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                        EXCCRILocalizationCR: Codeunit 34002511;
                    begin
                        //TODO: Ver
                        /*
                        if Rec."Tipo de Venta" = Rec."Tipo de Venta"::Exportacion then
                            EXCCRIElectronicInvoicing.FacturaElectronicaExportacion(Rec."No.")
                        else
                            if Rec."Venta TPV" then begin
                                EXCCRILocalizationCR.CambiarTipoDocumentoATiquete(Rec."No.");
                                EXCCRIElectronicInvoicing.TiqueteElectronico_vCentral(Rec."No.");
                            end else
                                if Rec."Tipo Doc Electronico" = Rec."Tipo Doc Electronico"::Factura then
                                    EXCCRIElectronicInvoicing.FacturaElectronica(Rec."No.")
                                else
                                    EXCCRIElectronicInvoicing.TiqueteElectronico_vCentral(Rec."No.");*/
                    end;
                }
                action(EXCCRICheckElectronicInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Check Electronic Invoice';
                    Image = ElectronicNumber;
                    ToolTip = 'Checks the electronic invoicing status of the selected posted sales invoice.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                        EXCCRIElectronicLog: Record 52502;
                    begin
                        if Rec."Venta TPV" then begin
                            if not EXCCRIElectronicLog.Get(3, Rec."No.") then
                                Error(EXCCRIElectronicLogMissingErr, Rec."No.");

                            //TODO: VerEXCCRIElectronicInvoicing.Parametros(true, Rec.Tienda);
                            //TODO: VerEXCCRIElectronicInvoicing.ComprobarDocumentoElectronicoLOG(EXCCRIElectronicLog);
                            exit;
                        end;

                        //TODO: Verif EXCCRIElectronicLog.Get(0, Rec."No.") then
                        //TODO: Ver    EXCCRIElectronicInvoicing.ComprobarDocumentoElectronicoLOG(EXCCRIElectronicLog);
                    end;
                }
                action(EXCCRICorrectDocumentText)
                {
                    ApplicationArea = All;
                    Caption = 'Correct Document Text';
                    Image = Edit;
                    ToolTip = 'Opens the custom page used to review the electronic document text.';

                    trigger OnAction()
                    var
                        EXCCRICorrectDocumentPage: Page 52504;
                    begin
                        EXCCRICorrectDocumentPage.TraerDatos(
                            Rec."No.",
                            Rec."Sell-to Customer Name",
                            Rec."VAT Registration No.",
                            Rec."E-Mail-FE");
                        EXCCRICorrectDocumentPage.RunModal();
                    end;
                }
                action(EXCCRIElectronicDocumentLog)
                {
                    ApplicationArea = All;
                    Caption = 'Electronic Document Log';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page 52500;
                    RunPageLink = NoDocumento = field("No.");
                    ToolTip = 'Opens the electronic document log related to the posted sales invoice.';
                }
            }
            action(EXCCRISettle)
            {
                ApplicationArea = All;
                Caption = 'Settle';
                Image = Register;
                ToolTip = 'Runs the custom settlement process for the posted sales invoice.';

                trigger OnAction()
                var
                    EXCCRISalesPost: Codeunit 80;
                begin
                    //TODO: VerEXCCRISalesPost.RegistrarCobrosSCR2(Rec."No.");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Invoice Discount Amount", "Line Discount Amount");
        EXCCRITotalDiscountAmount :=
            Rec."Invoice Discount Amount" + Rec."Line Discount Amount";
    end;

    var
        EXCCRITotalDiscountAmount: Decimal;
        EXCCRIElectronicLogMissingErr: Label 'No electronic invoicing log information was found for document %1.';
}
