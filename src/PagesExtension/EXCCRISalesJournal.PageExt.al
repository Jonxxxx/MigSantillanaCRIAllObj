pageextension 50058 EXCCRISalesJournal extends "Sales Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field(EXCCRIQuantity; Rec.Quantity)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity associated with the sales journal line.';
            }
        }
    }
}
