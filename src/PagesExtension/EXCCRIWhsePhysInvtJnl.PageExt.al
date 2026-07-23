pageextension 50142 EXCCRIWhsePhysInvtJnl extends "Whse. Phys. Invt. Journal"
{
    actions
    {
        addlast(Processing)
        {
            action(EXCCRIPhysInvtAdjustList)
            {
                ApplicationArea = All;
                Caption = 'Physical Inventory Adjustment List';
                Image = Print;
                ToolTip = 'Runs the custom physical inventory adjustment list for the current warehouse journal batch and location.';

                trigger OnAction()
                var
                // EXCCRIPhysicalInvtReport: Report 56032;
                begin
                    // 
                    /*
                    EXCCRIPhysicalInvtReport.RecibeParametros(
                        Rec."Journal Template Name",
                        Rec."Journal Batch Name",
                        Rec."Location Code");
                    EXCCRIPhysicalInvtReport.RunModal();
                    Clear(EXCCRIPhysicalInvtReport);*/
                end;
            }
        }
    }
}
