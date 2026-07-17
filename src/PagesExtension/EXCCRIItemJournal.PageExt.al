pageextension 50018 EXCCRIItemJournal extends "Item Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the item journal line.';
            }
            field(EXCCRIPromotion; Rec.Promocion)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the item journal line corresponds to a promotion.';
            }
            field(EXCCRIBarcode; Rec.Barcode)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the barcode associated with the item journal line.';
            }
        }
    }
}
