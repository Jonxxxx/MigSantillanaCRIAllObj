pageextension 50140 EXCCRIBinContentsList extends "Bin Contents List"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIPickQuantityBase; Rec."Pick Quantity (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity in base units that has been assigned for picking from the bin.';
            }
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
