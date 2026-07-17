pageextension 50131 EXCCRIServiceZones extends "Service Zones"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRICollectorCode; Rec."Cod. Cobrador")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the collector code assigned to the service zone.';
            }
            field(EXCCRICollectorName; Rec."Nombre Cobrador")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the name of the collector assigned to the service zone.';
            }
        }
    }
}
