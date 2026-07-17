pageextension 50034 EXCCRIPurchCrMemoSubform extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIISBN; Rec.ISBN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ISBN associated with the purchase credit memo line.';
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
                Caption = 'Distribute Item Charges';
                ToolTip = 'Distributes item charges among the selected purchase credit memo lines.';

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
