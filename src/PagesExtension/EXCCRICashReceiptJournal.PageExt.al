pageextension 50059 EXCCRICashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field(EXCCRICollectorCode; Rec."Collector Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the collector assigned to the cash receipt journal line.';
            }
        }
    }
}
