pageextension 50022 EXCCRISalesCreditMemo extends "Sales Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRINCFCreditMemoNoSeries; Rec."No. Serie NCF Abonos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number series used for sales credit memos.';
                }
                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the sales credit memo.';
                }
                field(EXCCRIPostingNo; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting number assigned to the sales credit memo.';
                }
                field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether copyright charges do not apply to the sales credit memo.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the sales credit memo.';
                }
                field(EXCCRIRelatedFiscalReceiptNo; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related fiscal receipt number assigned to the sales credit memo.';
                }
                field(EXCCRIIncomeType; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the income type assigned to the sales credit memo.';
                }
                field(EXCCRINCFVoidReason; Rec."Razon anulacion NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for voiding the fiscal receipt number.';
                }
                field(EXCCRICorrection; Rec.Correction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the sales credit memo is a corrective document.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref NC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of document referenced by the sales credit memo.';
                }
                field(EXCCRIHistoricalDocumentNo; Rec."No. Doc Historico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the historical document number associated with the sales credit memo.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic invoicing reference number.';
                }
                field(EXCCRIReferenceCode; Rec."Codigo Referencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reference code assigned to the sales credit memo.';
                }
                field(EXCCRIReturnReceiptNo; Rec."Return Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted return receipt related to the sales credit memo.';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIDistributeItemCharge)
            {
                ApplicationArea = All;
                Caption = 'Distribute Item Charge';
                ToolTip = 'Distributes item charges among the sales credit memo lines.';

                trigger OnAction()
                begin
                    CurrPage.SalesLines.Page.SplitIC();
                end;
            }
        }
    }
}
