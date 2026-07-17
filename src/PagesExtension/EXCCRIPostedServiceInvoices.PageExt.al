pageextension 50129 EXCCRIPostedServiceInvoices extends "Posted Service Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRINCFInvoiceSeries; Rec."No. Serie NCF Facturas")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the NCF number series used for the posted service invoice.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number of the posted service invoice.';
            }
            field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the NCF assigned to the posted service invoice.';
            }
            field(EXCCRIIncomeType; Rec."Tipo de ingreso")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the income type assigned to the posted service invoice.';
            }
        }
    }
}
