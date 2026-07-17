pageextension 50053 EXCCRICustomerPostingGroupCard extends "Customer Posting Group Card"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIAllowNCF; Rec."Permite emitir NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether fiscal receipt numbers can be issued for this customer posting group.';
            }
            field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Factura Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for sales invoices.';
            }
            field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for sales credit memos.';
            }
        }
    }
}
