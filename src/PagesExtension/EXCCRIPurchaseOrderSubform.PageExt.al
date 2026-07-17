pageextension 50030 EXCCRIPurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIGenBusPostingGroup; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the general business posting group assigned to the purchase order line.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIDistributeItemCharge)
            {
                ApplicationArea = All;
                Caption = 'Distribute Item Charge';
                ToolTip = 'Distributes item charges among the selected purchase order lines.';

                trigger OnAction()
                begin
                    SplitIC();
                end;
            }
        }
    }

    procedure SplitIC()
    var
        EXCCRIPurchaseLine: Record "Purchase Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRIPurchaseLine);
        //TODO: Ver 
        /*
        Report.Run(
            Report::"Split Item Charge",
            false,
            false,
            EXCCRIPurchaseLine);*/
    end;

    procedure Distribucion()
    var
        EXCCRIPurchaseLine: Record "Purchase Line";
    begin
        CurrPage.SetSelectionFilter(EXCCRIPurchaseLine);
        //TODO: Ver 
        /*
        Report.Run(
            Report::"Split CC Distribution",
            false,
            false,
            EXCCRIPurchaseLine);*/
    end;
}
