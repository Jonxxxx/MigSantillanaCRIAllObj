pageextension 55123 EXCCRIWarehousePick extends "Warehouse Pick"
{
    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addlast(Processing)
        {
            action(EXCCRIPrintPicking)
            {
                ApplicationArea = All;
                Caption = 'Print Picking';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prints the custom picking report for the selected warehouse pick.';

                trigger OnAction()
                var
                    EXCCRIWhseActivityHeader: Record "Warehouse Activity Header";
                begin
                    CurrPage.SetSelectionFilter(EXCCRIWhseActivityHeader);
                    Report.RunModal(
                        55432,
                        true,
                        true,
                        EXCCRIWhseActivityHeader);
                end;
            }
            action(EXCCRIGlobalPickingList)
            {
                ApplicationArea = All;
                Caption = 'Global Picking List';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prints the custom global picking list for the selected warehouse picks.';

                trigger OnAction()
                var
                    EXCCRIWhseActivityHeader: Record "Warehouse Activity Header";
                begin
                    CurrPage.SetSelectionFilter(EXCCRIWhseActivityHeader);
                    Report.RunModal(
                        55433,
                        true,
                        true,
                        EXCCRIWhseActivityHeader);
                end;
            }
        }
    }
}
