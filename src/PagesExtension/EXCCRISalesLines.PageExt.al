pageextension 50078 EXCCRISalesLines extends "Sales Lines"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIOriginCode; Rec."Cod. Procedencia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the origin code associated with the sales line.';
            }
        }
    }
}
