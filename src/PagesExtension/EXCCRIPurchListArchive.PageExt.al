pageextension 50098 EXCCRIPurchListArchive extends "Purchase List Archive"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRICurrencyFactor; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Currency Factor value for the archived purchase document.';
            }
            field(EXCCRIAmount; Rec.Amount)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Amount value for the archived purchase document.';
            }
            field(EXCCRICurrencyCode; Rec."Currency Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Currency Code value for the archived purchase document.';
            }
            field(EXCCRIAmountIncludingVAT; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Amount Including VAT value for the archived purchase document.';
            }
        }
    }
}
