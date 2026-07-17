pageextension 50021 EXCCRISalesInvoice extends "Sales Invoice"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIDistributionRoute; Rec."Ruta de Distribucion")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the distribution route associated with the sales invoice.';
                }
                field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Facturas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number series used for the sales invoice.';
                }
                field(EXCCRIConsignmentOrder; Rec."Pedido Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the sales invoice is related to a consignment order.';
                }
                field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether copyright charges do not apply to the sales invoice.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the sales invoice.';
                }
                field(EXCCRIIncomeType; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the income type assigned to the sales invoice.';
                }
                field(EXCCRINCFVoidReason; Rec."Razon anulacion NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for voiding the fiscal receipt number.';
                }
                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the sales invoice.';
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
                ToolTip = 'Distributes item charges among the sales invoice lines.';

                trigger OnAction()
                begin
                    CurrPage.SalesLines.Page.SplitIC();
                end;
            }
        }
    }
}
