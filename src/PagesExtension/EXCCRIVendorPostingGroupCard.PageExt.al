pageextension 50054 EXCCRIVendorPostingGroupCard extends "Vendor Posting Group Card"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRINCFRequired; Rec."NCF Obligatorio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether a fiscal receipt number is required for this vendor posting group.';
            }
            field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Factura Compra")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for purchase invoices.';
            }
            field(EXCCRINCFCreditMemoSeries; Rec."No. Serie NCF Abonos Compra")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number series used for purchase credit memos.';
            }
            field(EXCCRIInternational; Rec.Internacional)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether this vendor posting group is used for international vendors.';
            }
        }
    }
}
