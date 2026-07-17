pageextension 50016 EXCCRIItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRISourceNo; Rec."Source No.")
            {
                ApplicationArea = All;
                Caption = 'Source No.';
                ToolTip = 'Specifies the source number associated with the item ledger entry.';
            }
            field(EXCCRIItemDescription; Rec."Descripcion Producto")
            {
                ApplicationArea = All;
                Caption = 'Item Description';
                ToolTip = 'Specifies the item description stored on the item ledger entry.';
            }
            field(EXCCRIInitialConsUnitPrice; Rec."Precio Unitario Cons. Inicial")
            {
                ApplicationArea = All;
                Caption = 'Initial Consignment Unit Price';
                ToolTip = 'Specifies the initial consignment unit price.';
            }
            field(EXCCRIUpdatedConsDiscount; Rec."Descuento % Cons. Actualizado")
            {
                ApplicationArea = All;
                Caption = 'Updated Consignment Discount %';
                ToolTip = 'Specifies the updated consignment discount percentage.';
            }
            field(EXCCRIUpdatedGrossConsAmount; Rec."Importe Cons. bruto Act.")
            {
                ApplicationArea = All;
                Caption = 'Updated Gross Consignment Amount';
                ToolTip = 'Specifies the updated gross consignment amount.';
            }
            field(EXCCRIUpdatedNetConsAmount; Rec."Importe Cons. Neto Act.")
            {
                ApplicationArea = All;
                Caption = 'Updated Net Consignment Amount';
                ToolTip = 'Specifies the updated net consignment amount.';
            }
        }
    }
}
