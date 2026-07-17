pageextension 50082 EXCCRIDimensionList extends "Dimension List"
{
    layout
    {
        addafter(Code)
        {
            field(EXCCRIConsolidationCode; Rec."Consolidation Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consolidation code assigned to the dimension.';
            }
        }
    }
}
