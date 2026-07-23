pageextension 50049 EXCCRIPostedSalesCreditMemos extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales order category associated with the posted sales credit memo.';
            }
            field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos2")
            {
                ApplicationArea = All;
                Caption = 'Credit Memo NCF Series No.';
                ToolTip = 'Specifies the fiscal receipt number series used for the posted sales credit memo.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                Caption = 'Fiscal Document No.';
                ToolTip = 'Specifies the fiscal receipt number assigned to the posted sales credit memo.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external document number of the posted sales credit memo.';
            }
            field(EXCCRIRelatedFiscalReceipt; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                Caption = 'Related Fiscal Document';
                ToolTip = 'Specifies the fiscal receipt number related to the posted sales credit memo.';
            }
            field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
            }
            field(EXCCRIReturnOrderNo; Rec."Return Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the return order number associated with the posted sales credit memo.';
            }
            field(EXCCRIIncomeType; Rec."Tipo de ingreso")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the income type assigned to the posted sales credit memo.';
            }
            field(EXCCRINCFVoidReason; Rec."Razon anulacion NCF")
            {
                ApplicationArea = All;
                Caption = 'Void NCF Reason';
                ToolTip = 'Specifies the reason for voiding the fiscal receipt number.';
            }
            field(EXCCRIElectronicKey; Rec.Clave)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic document key assigned to the posted sales credit memo.';
            }
            field(EXCCRIConsecutiveNo; Rec.Consecutivo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the consecutive number assigned to the electronic document.';
            }
            field(EXCCRIElectronicStatus; Rec.Estado)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the current electronic invoicing status of the posted sales credit memo.';
            }
            field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document number to which the posted sales credit memo is applied.';
            }
            field(EXCCRIElectronicMessage; Rec.Mensaje)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the message returned by the electronic invoicing process.';
            }
            field(EXCCRIElectronicDocDate; Rec."Fecha Doc Electronico")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date and time associated with the electronic document.';
            }
            field(EXCCRICAe; Rec.CAE)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic authorization indicator stored on the posted sales credit memo.';
            }
            field(EXCCRICAeC; Rec.CAEC)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the contingency electronic authorization indicator stored on the posted sales credit memo.';
            }
            field(EXCCRISICDocumentNo; Rec."No. Documento SIC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the SIC document number associated with the posted sales credit memo.';
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

                action(EXCCRISendElectronicCrMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Send Electronic Credit Memo';
                    Image = ElectronicNumber;
                    ToolTip = 'Sends the selected posted sales credit memo through the custom electronic invoicing process.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                    begin
                        //if Rec."Venta TPV" then
                        //    EXCCRIElectronicInvoicing.TiqueteElectronicoNCR_vCentral(Rec."No.")
                        //else
                        //    EXCCRIElectronicInvoicing.NotaCreditoElectronica(Rec."No.");
                    end;
                }
                action(EXCCRICheckElectronicCrMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Check Electronic Credit Memo';
                    Image = ElectronicNumber;
                    ToolTip = 'Checks the electronic invoicing status of the selected posted sales credit memo.';

                    trigger OnAction()
                    var
                        EXCCRIElectronicInvoicing: Codeunit 52504;
                        EXCCRIElectronicLog: Record 52502;
                    begin
                        if not EXCCRIElectronicLog.Get(1, Rec."No.") then
                            Error(EXCCRIElectronicLogMissingErr, Rec."No.");

                        //if Rec."Venta TPV" then
                        //    EXCCRIElectronicInvoicing.Parametros(true, Rec.Tienda);

                        //EXCCRIElectronicInvoicing.ComprobarDocumentoElectronicoLOG(EXCCRIElectronicLog);
                    end;
                }
                action(EXCCRIElectronicDocumentLog)
                {
                    ApplicationArea = All;
                    Caption = 'Electronic Document Log';
                    Image = Log;
                    RunObject = page 52500;
                    RunPageLink = NoDocumento = field("No.");
                    ToolTip = 'Opens the electronic document log related to the posted sales credit memo.';
                }
            }
        }
    }

    var
        EXCCRIElectronicLogMissingErr: Label 'No electronic invoicing log information was found for document %1.';
}
