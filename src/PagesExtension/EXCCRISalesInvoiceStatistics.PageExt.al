pageextension 50068 EXCCRISalesInvoiceStatistics extends "Sales Invoice Statistics"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRILineDiscountAmount; Rec."Line Discount Amount")
            {
                ApplicationArea = All;
                Caption = 'Line Discount Amount';
                Editable = false;
                ToolTip = 'Specifies the total line discount amount of the posted sales invoice.';
            }
        }
    }
}
