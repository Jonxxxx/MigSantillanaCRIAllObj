pageextension 50051 EXCCRIPostedPurchaseInvoices extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIVendorPostingGroup; Rec."Vendor Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor posting group assigned to the posted purchase invoice.';
            }
            field(EXCCRIElectronicMessage; EXCCRIDsnPurchInvExt.Mensaje)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the message returned by the electronic purchase invoicing process.';
            }
            field(EXCCRIElectronicStatus; EXCCRIDsnPurchInvExt.Estado)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current electronic invoicing status of the posted purchase invoice.';
            }
            field(EXCCRIElectronicEmail; EXCCRIDsnPurchInvExt."E-Mail-FE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the email address used for the electronic purchase invoice.';
            }
            field(EXCCRIElectronicDocType; Rec."Tipo Doc Electronico")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic document type assigned to the posted purchase invoice.';
            }
            field(EXCCRICurrencyFactor; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the currency factor used on the posted purchase invoice.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number assigned to the posted purchase invoice.';
            }
            field(EXCCRIRelatedFiscalReceipt; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number related to the posted purchase invoice.';
            }
            field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expense classification code assigned to the posted purchase invoice.';
            }
            field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
            }
            field(EXCCRIIncomeType; Rec."Tipo de ingreso")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the income type assigned to the posted purchase invoice.';
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

                action(EXCCRISendElectronicPurchInv)
                {
                    ApplicationArea = All;
                    Caption = 'Send Electronic Purchase Invoice';
                    Image = ElectronicNumber;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Sends the selected posted purchase invoice through the custom electronic invoicing process.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                        EXCCRIVendor: Record Vendor;
                    begin
                        EXCCRIVendor.Get(Rec."Buy-from Vendor No.");

                        //
                        /*
                        if EXCCRIVendor."Tax Identification Type" =
                           EXCCRIVendor."Tax Identification Type"::"Extranjero No Domiciliado"
                        then begin
                            EXCCRIElectronicInvoicing.FacturaElectronicaCompra(Rec."No.");
                            exit;
                        end;

                        Error(
                            EXCCRIInvalidVendorTaxIdErr,
                            EXCCRIVendor."Tax Identification Type");*/
                    end;
                }
                action(EXCCRICheckElectronicPurchInv)
                {
                    ApplicationArea = All;
                    Caption = 'Check Electronic Purchase Invoice';
                    Image = ElectronicNumber;
                    ToolTip = 'Checks the electronic invoicing status of the selected posted purchase invoice.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                        EXCCRIElectronicLog: Record 52502;
                    begin
                        if not EXCCRIElectronicLog.Get(7, Rec."No.") then
                            Error(EXCCRIElectronicLogMissingErr, Rec."No.");

                        // EXCCRIElectronicInvoicing.ComprobarDocumentoElectronicoLOG(EXCCRIElectronicLog);
                    end;
                }
                action(EXCCRICorrectDocumentText)
                {
                    ApplicationArea = All;
                    Caption = 'Correct Document Text';
                    Image = Edit;
                    ToolTip = 'Represents the legacy electronic document text correction action. The original C/AL action did not execute any active code.';
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
                    ToolTip = 'Opens the electronic document log related to the posted purchase invoice.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIDsnPurchInvExt.Reset();
        EXCCRIDsnPurchInvExt.SetRange("No.", Rec."No.");
        if not EXCCRIDsnPurchInvExt.FindFirst() then
            Clear(EXCCRIDsnPurchInvExt);
    end;

    var
        EXCCRIDsnPurchInvExt: Record 50028;
        EXCCRIElectronicLogMissingErr: Label 'No electronic invoicing log information was found for document %1.';
        EXCCRIInvalidVendorTaxIdErr: Label 'To issue the electronic purchase invoice, the vendor tax identification type must be Foreign Non-Resident. The current value is %1.';
}
