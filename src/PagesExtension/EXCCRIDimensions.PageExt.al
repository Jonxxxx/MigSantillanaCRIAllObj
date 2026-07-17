pageextension 50079 EXCCRIDimensions extends Dimensions
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIMdMType; Rec."Tipo MdM")
            {
                ApplicationArea = All;
                BlankZero = true;
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the MdM classification assigned to the dimension.';
            }
        }
    }
}
