pageextension 50040 EXCCRIPostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCRIAmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the total amount of the posted sales invoice including VAT.';
                }
                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the tax registration number associated with the posted sales invoice.';
                }
                field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether copyright charges do not apply to the posted sales invoice.';
                }
                field(EXCCRIDocumentReceiptDate; Rec."Fecha Recepcion Documento")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the document receipt date stored on the posted sales invoice.';
                }
                field(EXCCRITaxIdentificationType; Rec."Tax Identification Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the tax identification type associated with the posted sales invoice.';
                }
                field(EXCCRISaleType; Rec."Tipo de Venta")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the sale type assigned to the posted sales invoice.';
                }
                field(EXCCRIElectronicDocumentType; Rec."Tipo Doc Electronico")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the electronic document type assigned to the posted sales invoice.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the posted sales invoice.';
                }
                field(EXCCRIIncomeType; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the income type assigned to the posted sales invoice.';
                }
                field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
                }
                field(EXCCRICollectorCode; Rec."Collector Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the collector assigned to the posted sales invoice.';
                }
                field(EXCCRITotalDiscountAmount; EXCCRITotalDiscountAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Discount Amount';
                    Editable = false;
                    ToolTip = 'Specifies the combined invoice and line discount amount of the posted sales invoice.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the type of the electronic document referenced by the posted sales invoice.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the electronic invoicing reference number.';
                }
                field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the sales order category associated with the posted sales invoice.';
                }
                field(EXCCRIECommerceStatus; Rec."Estado E-Commerce")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the e-commerce status of the posted sales invoice.';
                }
                field(EXCCRIECommerceShippingMethod; Rec."Metodo de Envio E-Commerce")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the shipping method received from the e-commerce integration.';
                }
                field(EXCCRIElectronicInvoiceEmail; Rec."E-Mail-FE")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the email address used for the electronic invoice.';
                }
                field(EXCCRIEmail; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the email address stored on the posted sales invoice.';
                }
            }
            group(EXCCRIPOS)
            {
                Caption = 'POS';

                field(EXCRIStore; Rec.Tienda)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the store associated with the posted POS invoice.';
                }
                field(EXCRICouponCode; Rec."Cod. Cupon")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the coupon code associated with the posted POS invoice.';
                }
                field(EXCRISchoolCode; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the school code associated with the posted POS invoice.';
                }
                field(EXCRISchoolName; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the school name associated with the posted POS invoice.';
                }
                field(EXCRICashierId; Rec."ID Cajero")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the cashier identifier associated with the posted POS invoice.';
                }
                field(EXCRICreationTime; Rec."Hora creacion")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the creation time of the posted POS invoice.';
                }
                field(EXCRITerminalCode; Rec.TPV)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the POS terminal associated with the posted sales invoice.';
                }
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action(EXCCRIPrint)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Prints the posted sales invoice using the custom fiscal printer configuration when applicable.';

                trigger OnAction()
                var
                    EXCCRISalesInvoiceHeader: Record "Sales Invoice Header";
                    EXCCRISantillanaSetup: Record 56001;
                begin
                    EXCCRISalesInvoiceHeader := Rec;
                    EXCCRISantillanaSetup.Get();

                    CurrPage.SetSelectionFilter(EXCCRISalesInvoiceHeader);
                    if not EXCCRISantillanaSetup."Funcionalidad Imp. Fiscal Act." then
                        EXCCRISalesInvoiceHeader.PrintRecords(true)
                    else begin
                        EXCCRISantillanaSetup.TestField("Copia Fact. Imp. Fiscal Panama");
                        Report.RunModal(
                            EXCCRISantillanaSetup."Copia Fact. Imp. Fiscal Panama",
                            true,
                            false,
                            EXCCRISalesInvoiceHeader);
                    end;
                end;
            }
        }
        addlast(Processing)
        {
            group(EXCCRICustomActions)
            {
                Caption = 'Custom Actions';

                action(EXCCRIOrderTracking)
                {
                    ApplicationArea = All;
                    Caption = 'Order Tracking';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Opens the custom order tracking page for the posted sales invoice.';

                    trigger OnAction()
                    var
                        EXCCRIOrderTrackingPage: Page 56081;
                    begin
                        EXCCRIOrderTrackingPage.SetDoc(3, Rec."No.");
                        EXCCRIOrderTrackingPage.Run();
                    end;
                }
                action(EXCCRIVoidedNCF)
                {
                    ApplicationArea = All;
                    Caption = 'Voided NCF';
                    RunObject = page 34003010;
                    RunPageLink = "No. documento" = field("No.");
                    ToolTip = 'Opens the voided fiscal receipt records related to the posted sales invoice.';
                }
                group(EXCCRIECommerceActions)
                {
                    Caption = 'E-Commerce';

                    action(EXCCRISetInProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'Set In Process';
                        Image = Purchasing;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'Changes the e-commerce status of the posted sales invoice to In Process.';

                        trigger OnAction()
                        var
                            EXCCRIUpdateECommerceStatus: Codeunit 50011;
                        begin
                            EXCCRIUpdateECommerceStatus.EnProceso(Rec);
                        end;
                    }
                    action(EXCCRISetReadyForDelivery)
                    {
                        ApplicationArea = All;
                        Caption = 'Set Ready for Delivery';
                        Image = Track;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'Changes the e-commerce status of the posted sales invoice to Ready for Delivery.';

                        trigger OnAction()
                        var
                            EXCCRIUpdateECommerceStatus: Codeunit 50011;
                        begin
                            EXCCRIUpdateECommerceStatus.ListoParaEntrega(Rec);
                        end;
                    }
                    action(EXCCRISetDelivered)
                    {
                        ApplicationArea = All;
                        Caption = 'Set Delivered';
                        Image = Trace;
                        Promoted = true;
                        PromotedCategory = Process;
                        ToolTip = 'Changes the e-commerce status of the posted sales invoice to Delivered.';

                        trigger OnAction()
                        var
                            EXCCRIUpdateECommerceStatus: Codeunit 50011;
                        begin
                            EXCCRIUpdateECommerceStatus.Entregado(Rec);
                        end;
                    }
                }
                action(EXCCRIGenerateDigitalCert)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Digital Certificate';
                    Image = ElectronicNumber;
                    ToolTip = 'Runs the custom process that generates the digital certificate for the posted sales invoice.';

                    trigger OnAction()
                    var
                        EXCCRISalesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        CurrPage.SetSelectionFilter(EXCCRISalesInvoiceHeader);
                        Report.RunModal(56008, true, true, EXCCRISalesInvoiceHeader);
                    end;
                }
                action(EXCCRIUpdateTaxId)
                {
                    ApplicationArea = All;
                    Caption = 'Update Tax ID';
                    Image = UpdateDescription;
                    ToolTip = 'Updates the tax identification number on the posted sales invoice when the user has permission.';

                    trigger OnAction()
                    var
                        EXCCRIUserSetup: Record "User Setup";
                        EXCCRIUpdateTaxIdPage: Page 56031;
                    begin
                        if EXCCRIUserSetup.Get(UserId()) then
                            if EXCCRIUserSetup."Permite Modificar NIT en Hist." then begin
                                EXCCRIUpdateTaxIdPage.RecibeNoFac(Rec."No.", 1);
                                EXCCRIUpdateTaxIdPage.RunModal();
                                exit;
                            end;

                        Message(EXCCRIUpdateTaxIdNotAllowedMsg);
                    end;
                }
                action(EXCCRIVoidIFacereFolio)
                {
                    ApplicationArea = All;
                    Caption = 'Void IFacere Folio';
                    Image = UndoCategory;
                    ToolTip = 'Voids the IFacere folio of the posted sales invoice when the user has permission.';

                    trigger OnAction()
                    var
                        EXCCRIUserSetup: Record "User Setup";
                        EXCCRIElectronicInvoicing: Codeunit 56003;
                    begin
                        if not EXCCRIUserSetup.Get(UserId()) then begin
                            Message(EXCCRIVoidFolioNotAllowedMsg);
                            exit;
                        end;

                        if not EXCCRIUserSetup."Permite Anular Folios IFacere" then begin
                            Message(EXCCRIVoidFolioNotAllowedMsg);
                            exit;
                        end;

                        // if Confirm(EXCCRIVoidFolioQst, false) then
                        // EXCCRIElectronicInvoicing.AnulaFactura(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIUpdateTotalDiscountAmount();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRIUpdateTotalDiscountAmount();
    end;

    local procedure EXCCRIUpdateTotalDiscountAmount()
    begin
        Rec.CalcFields("Invoice Discount Amount", "Line Discount Amount");
        EXCCRITotalDiscountAmount :=
            Rec."Invoice Discount Amount" + Rec."Line Discount Amount";
    end;

    var
        EXCCRITotalDiscountAmount: Decimal;
        EXCCRIUpdateTaxIdNotAllowedMsg: Label 'The user is not allowed to modify the tax identification number on posted documents.';
        EXCCRIVoidFolioNotAllowedMsg: Label 'The user is not allowed to void IFacere folios.';
        EXCCRIVoidFolioQst: Label 'Do you want to void the IFacere folio?';
}
