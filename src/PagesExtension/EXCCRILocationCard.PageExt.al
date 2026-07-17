pageextension 50110 EXCCRILocationCard extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIInactive; Rec.Inactivo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the location is inactive.';
            }
            field(EXCCRISICInterfaceId; Rec."ID Interface SIC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the SIC interface identifier assigned to the location.';
            }
        }
        addlast(Content)
        {
            group(EXCCRIWarehouseSettings)
            {
                Caption = 'Custom Warehouse Settings';

                field(EXCCRIPackingRequired; Rec."Packing requerido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether packing is required for the location.';
                }
                field(EXCCRILinesPerDay; Rec."Cant. Lineas a Man. Por dia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of lines that can be handled per day at the location.';
                }
            }
            group(EXCCRIElectronicInvoicing)
            {
                Caption = 'Electronic Invoicing';

                field(EXCCRIBranchCode; Rec."Cod. Sucursal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic invoicing branch code assigned to the location.';
                }
            }
        }
    }
}
