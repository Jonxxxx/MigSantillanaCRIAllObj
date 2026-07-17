pageextension 50123 EXCCRIWhsePutAwaySubform extends "Whse. Put-away Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the warehouse put-away line.';
            }
        }
    }
}
