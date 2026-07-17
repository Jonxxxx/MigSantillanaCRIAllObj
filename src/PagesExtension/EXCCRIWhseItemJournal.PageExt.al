pageextension 50141 EXCCRIWhseItemJournal extends "Whse. Item Journal"
{
    layout
    {
        addafter("Registering Date")
        {
            field(EXCCRIEntryType; Rec."Entry Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the entry type of the warehouse journal line.';
            }
            field(EXCCRIBarcode; Rec.Barcode)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the barcode entered for the warehouse journal line.';
            }
        }
    }
}
