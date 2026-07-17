pageextension 50067 EXCCRIPhysInventoryJournal extends "Phys. Inventory Journal"
{
    actions
    {
        addafter(CalculateCountingPeriod)
        {
            action(EXCCRIPhysicalInvAdjustment)
            {
                ApplicationArea = All;
                Caption = 'Physical Inventory Adjustment List';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                //TODO: Ver RunObject = Report 56031;
                ToolTip = 'Runs the custom physical inventory adjustment list report.';
            }
        }
    }
}
