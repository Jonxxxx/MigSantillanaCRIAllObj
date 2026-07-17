pageextension 50154 EXCCRIRegisteredWhsePicks extends "Registered Whse. Picks"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIRegisteringDate; Rec."Registering Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the warehouse pick was registered.';
            }
        }
    }
}
