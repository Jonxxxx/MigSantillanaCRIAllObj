pageextension 50136 EXCCRIPostedReturnRcptSub extends "Posted Return Receipt Subform"
{
    layout
    {
        addafter("Item Reference No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the posted return receipt line.';
            }
        }
    }
}
