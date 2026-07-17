pageextension 50094 EXCCRICampaignStatus extends "Campaign Status"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIFechaInicio; Rec."Fecha Inicio")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Fecha Inicio value for the campaign status.';
            }
            field(EXCCRIFechaFin; Rec."Fecha Fin")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Fecha Fin value for the campaign status.';
            }
        }
    }
}
