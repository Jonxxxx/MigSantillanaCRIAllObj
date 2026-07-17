pageextension 50132 EXCCRISalesReturnOrder extends "Sales Return Order"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRISalesType; Rec."Tipo de Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales type of the sales return order.';
            }
            field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the NCF number series used for sales credit memos.';
            }
            field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the VAT registration number of the sales return order.';
            }
            field(EXCCRIPostingDescription; Rec."Posting Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting description of the sales return order.';
            }
            field(EXCCRIRelatedFiscalNo; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the related fiscal receipt number of the sales return order.';
            }
            field(EXCCRIExcludeCopyright; Rec."No aplica Derechos de Autor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether copyright charges do not apply to the sales return order.';
            }
            field(EXCCRIEmailFE; Rec."E-Mail-FE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic invoicing email address of the sales return order.';
            }
            field(EXCCRIReferenceDocType; Rec."Tipo Doc. Ref NC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the reference document type used for the credit memo.';
            }
            field(EXCCRIHistoricalDocNo; Rec."No. Doc Historico")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the historical document number referenced by the sales return order.';
            }
            field(EXCCRIFEReferenceNo; Rec."Numero Referencia FE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic invoicing reference number of the sales return order.';
            }
            field(EXCCRIReferenceCode; Rec."Codigo Referencia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the electronic invoicing reference code of the sales return order.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRISplitItemCharges)
            {
                ApplicationArea = All;
                Caption = 'Distribute Item Charges';
                Image = ItemCosts;
                ToolTip = 'Distributes the selected sales item charges among the related item lines.';

                trigger OnAction()
                begin
                    CurrPage.SalesLines.Page.SplitIC();
                end;
            }
        }
    }
}
