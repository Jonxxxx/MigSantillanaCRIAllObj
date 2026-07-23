pageextension 50133 EXCCRISalesReturnOrderSub extends "Sales Return Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIISBN; Rec.EAN)
            {
                ApplicationArea = All;
                Caption = 'ISBN';
                ToolTip = 'Specifies the ISBN of the item on the sales return order line.';
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field(EXCCRIUnitCost; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the unit cost of the sales return order line.';
            }
        }
    }

    procedure SplitIC()
    var
        EXCCRISalesLine: Record "Sales Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRISalesLine);
        // 
        /*
        Report.Run(
            Report::"Split Sales Item Charge",
            false,
            false,
            EXCCRISalesLine);*/
    end;
}
