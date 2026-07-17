pageextension 50061 EXCCRIGenBusinessPostingGroups extends "Gen. Business Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRISamples; Rec.Muestras)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general business posting group is used for samples.';
            }
            field(EXCCRIDonations; Rec.Donaciones)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general business posting group is used for donations.';
            }
            field(EXCCRIDestructions; Rec.Destrucciones)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general business posting group is used for destructions.';
            }
        }
    }
}
