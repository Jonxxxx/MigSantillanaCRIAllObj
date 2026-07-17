pageextension 50122 EXCCRIWhseReceiptSubform extends "Whse. Receipt Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the warehouse receipt line.';
            }
        }
    }
}
