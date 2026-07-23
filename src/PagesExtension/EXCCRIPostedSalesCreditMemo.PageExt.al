pageextension 50042 EXCCRIPostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the sales order category associated with the posted sales credit memo.';
                }
                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the tax registration number associated with the posted sales credit memo.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the posted sales credit memo.';
                }
                field(EXCCRIRelatedFiscalReceiptNo; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the related fiscal receipt number assigned to the posted sales credit memo.';
                }
                field(EXCCRIIncomeType; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the income type assigned to the posted sales credit memo.';
                }
                field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
                }
                field(EXCCRINCFVoidReason; Rec."Razon anulacion NCF")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the reason for voiding the fiscal receipt number.';
                }
                field(EXCCRICorrection; Rec.Correction)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether the posted sales credit memo is a corrective document.';
                }
                field(EXCCRICollectorCode; Rec."Collector Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the collector associated with the posted sales credit memo.';
                }
                field(EXCCRIPostingDescription; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the posting description of the posted sales credit memo.';
                }
                field(EXCCRICAe; Rec.CAE)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the electronic authorization indicator stored on the posted sales credit memo.';
                }
                field(EXCCRICAeC; Rec.CAEC)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the contingency electronic authorization indicator stored on the posted sales credit memo.';
                }
                field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number series used for the posted sales credit memo.';
                }
                field(EXCCRIFolioVoidedInIFacere; Rec."Folio Anulado en Ifacere")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether the folio was voided in IFacere.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref NC")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the type of document referenced by the posted sales credit memo.';
                }
                field(EXCCRIReferenceCode; Rec."Codigo Referencia")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the reference code assigned to the posted sales credit memo.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the electronic invoicing reference number.';
                }
                field(EXCCRIElectronicInvoiceEmail; Rec."E-Mail-FE")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the email address used for the electronic credit memo.';
                }
                field(EXCCRIHistoricalDocumentNo; Rec."No. Doc Historico")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the historical document number associated with the posted sales credit memo.';
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
                ToolTip = 'Prints the posted sales credit memo using the custom electronic or fiscal printer configuration.';

                trigger OnAction()
                var
                    EXCCRISalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    EXCCRISantillanaSetup: Record 56001;
                    EXCCRIResolutionDate: Date;
                begin
                    EXCCRISalesCreditMemoHeader := Rec;
                    EXCCRISantillanaSetup.Get();
                    CurrPage.SetSelectionFilter(EXCCRISalesCreditMemoHeader);

                    if not EXCCRISantillanaSetup."Funcionalidad FE Activa" then begin
                        if not EXCCRISantillanaSetup."Funcionalidad Imp. Fiscal Act." then
                            EXCCRISalesCreditMemoHeader.PrintRecords(true)
                        else begin
                            EXCCRISantillanaSetup.TestField("Copia NDC Imp. Fiscal Panama");
                            Report.RunModal(
                                EXCCRISantillanaSetup."Copia NDC Imp. Fiscal Panama",
                                true,
                                false,
                                EXCCRISalesCreditMemoHeader);
                        end;
                        exit;
                    end;

                    EXCCRIResolutionDate := Dmy2Date(1, 3, 2012);
                    if Rec.CAE <> '' then
                        Report.Run(
                            EXCCRISantillanaSetup."Reporte NC Elect.",
                            true,
                            false,
                            EXCCRISalesCreditMemoHeader);
                    if Rec.CAEC <> '' then
                        Report.Run(
                            EXCCRISantillanaSetup."Reporte NC Resguardo",
                            true,
                            false,
                            EXCCRISalesCreditMemoHeader);
                    if (Rec.CAE = '') and
                       (Rec.CAEC = '') and
                       (Rec."Posting Date" < EXCCRIResolutionDate)
                    then
                        Report.Run(
                            EXCCRISantillanaSetup."Reporte NC Resguardo",
                            true,
                            false,
                            EXCCRISalesCreditMemoHeader);
                    if (Rec.CAE = '') and
                       (Rec.CAEC = '') and
                       (Rec."Posting Date" > EXCCRIResolutionDate)
                    then
                        Report.Run(
                            EXCCRISantillanaSetup."Reporte NC Elect.",
                            true,
                            false,
                            EXCCRISalesCreditMemoHeader);
                end;
            }
        }
        addlast(Processing)
        {
            group(EXCCRICustomActions)
            {
                Caption = 'Custom Actions';

                action(EXCCRIElectronicDocumentLog)
                {
                    ApplicationArea = All;
                    Caption = 'Electronic Document Log';
                    Image = Log;
                    RunObject = page 52500;
                    RunPageLink = NoDocumento = field("No.");
                    ToolTip = 'Opens the electronic document log related to the posted sales credit memo.';
                }
                action(EXCCRIVoidedNCF)
                {
                    ApplicationArea = All;
                    Caption = 'Voided NCF';
                    RunObject = page 34003010;
                    RunPageLink = "No. documento" = field("No.");
                    ToolTip = 'Opens the voided fiscal receipt records related to the posted sales credit memo.';
                }
                action(EXCCRIGenerateDigitalCert)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Digital Certificate';
                    Image = ElectronicNumber;
                    ToolTip = 'Generates the digital certificate for the posted sales credit memo.';

                    trigger OnAction()
                    var
                        EXCCRISalesCreditMemoHeader: Record "Sales Cr.Memo Header";
                    begin
                        if Rec.CAE <> '' then
                            Error(EXCCRIDigitalCertificateExistsErr);
                        if Rec.CAEC <> '' then
                            Error(EXCCRIDigitalCertificateExistsErr);

                        CurrPage.SetSelectionFilter(EXCCRISalesCreditMemoHeader);
                        Report.RunModal(
                            56010,
                            true,
                            true,
                            EXCCRISalesCreditMemoHeader);
                    end;
                }
                action(EXCCRIUpdateTaxId)
                {
                    ApplicationArea = All;
                    Caption = 'Update Tax ID';
                    Image = UpdateDescription;
                    ToolTip = 'Updates the tax identification number on the posted sales credit memo when the user has permission.';

                    trigger OnAction()
                    var
                        EXCCRIUserSetup: Record "User Setup";
                        EXCCRIUpdateTaxIdPage: Page 56031;
                    begin
                        if EXCCRIUserSetup.Get(UserId()) then
                            if EXCCRIUserSetup."Permite Modificar NIT en Hist." then begin
                                EXCCRIUpdateTaxIdPage.RecibeNoFac(Rec."No.", 2);
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
                    ToolTip = 'Voids the IFacere folio of the posted sales credit memo when the user has permission.';

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

                        if (Rec.CAE <> '') and (Rec.CAEC <> '') then
                            Error(EXCCRIInvalidDigitalSealErr);

                        Rec.TestField("Folio Anulado en Ifacere", false);
                        // if Confirm(EXCCRIVoidFolioQst, false) then
                        //     EXCCRIElectronicInvoicing.AnulaNotaCR(Rec);
                    end;
                }
            }
        }
    }

    var
        EXCCRIDigitalCertificateExistsErr: Label 'This credit memo already has a digital certificate.';
        EXCCRIInvalidDigitalSealErr: Label 'This credit memo cannot have both digital authorization indicators.';
        EXCCRIUpdateTaxIdNotAllowedMsg: Label 'The user is not allowed to modify the tax identification number on posted documents.';
        EXCCRIVoidFolioNotAllowedMsg: Label 'The user is not allowed to void IFacere folios.';
        EXCCRIVoidFolioQst: Label 'Do you want to void the IFacere folio?';
}
