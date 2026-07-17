pageextension 50045 EXCCRIPostedPurchInvSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIUnitCost; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the unit cost recorded on the posted purchase invoice line.';
            }
            field(EXCCRIJobCurrencyCode; Rec."Job Currency Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the job currency code associated with the posted purchase invoice line.';
            }
        }
    }
}
