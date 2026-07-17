pageextension 50146 EXCCRIMovementWorksheet extends "Movement Worksheet"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN of the item on the warehouse movement worksheet line.';
            }
        }
    }
}
