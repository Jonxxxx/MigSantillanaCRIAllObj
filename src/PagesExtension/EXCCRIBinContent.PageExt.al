pageextension 50139 EXCCRIBinContent extends "Bin Content"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIItemDescription; Rec."Descripcion Producto")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the custom item description associated with the bin content.';
            }
            field(EXCCRICrossReferenceNo; Rec."No. Referencia Cruzada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the cross-reference number associated with the item in the bin.';
            }
        }
    }
}
