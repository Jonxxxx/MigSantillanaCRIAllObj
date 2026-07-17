pageextension 50062 EXCCRIPostCodes extends "Post Codes"
{
    layout
    {
        addafter(City)
        {
            field(EXCCRIColony; Rec.Colonia)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the neighborhood or colony associated with the postal code.';
            }
        }
    }
}
