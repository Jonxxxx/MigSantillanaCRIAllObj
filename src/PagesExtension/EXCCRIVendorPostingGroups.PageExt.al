pageextension 50036 EXCCRIVendorPostingGroups extends "Vendor Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIAllowNCF; Rec."Permite Emitir NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether fiscal receipt numbers can be issued for this vendor posting group.';
            }
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
                ToolTip = 'Specifies whether the vendor posting group is used for international vendors.';
            }
        }
    }
}
