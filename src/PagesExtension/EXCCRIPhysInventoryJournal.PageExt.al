pageextension 55067 EXCCRIPhysInventoryJournal extends "Phys. Inventory Journal"
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
                // RunObject = Report 55256;
                ToolTip = 'Runs the custom physical inventory adjustment list report.';
            }
        }
    }
}
