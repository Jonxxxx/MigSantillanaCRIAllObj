pageextension 50125 EXCCRIWhsePickSubform extends "Whse. Pick Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the warehouse pick line.';
            }
        }
    }
}
