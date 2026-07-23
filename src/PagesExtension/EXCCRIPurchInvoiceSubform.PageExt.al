pageextension 50031 EXCCRIPurchInvoiceSubform extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIGenBusPostingGroup; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the general business posting group assigned to the purchase invoice line.';
            }
            field(EXCCRIGenProdPostingGroup; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the general product posting group assigned to the purchase invoice line.';
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
                ToolTip = 'Distributes item charges among the selected purchase invoice lines.';

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
        // 
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
        // 
        /*
        Report.Run(
            Report::"Split CC Distribution",
            false,
            false,
            EXCCRIPurchaseLine);*/
    end;
}
