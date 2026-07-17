pageextension 50130 EXCCRIPostedServiceInvoice extends "Posted Service Invoice"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRINCFInvoiceSeries; Rec."No. Serie NCF Facturas")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the NCF number series used for the posted service invoice.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the fiscal receipt number of the posted service invoice.';
            }
            field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the expiration date of the NCF assigned to the posted service invoice.';
            }
            field(EXCCRIIncomeType; Rec."Tipo de ingreso")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the income type assigned to the posted service invoice.';
            }
        }
    }
}
