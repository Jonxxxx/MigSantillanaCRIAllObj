page 55918 "Conf. ventas y cobros TPV"
{
    PageType = Card;
    SourceTable = 311;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Credit Memo Nos."; Rec."Credit Memo Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Credit Memo Nos.';
                }
                field("Posted Credit Memo Nos."; Rec."Posted Credit Memo Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posted Credit Memo Nos.';
                }
                field("Posted Shipment Nos."; Rec."Posted Shipment Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posted Shipment Nos.';
                }
            }
        }
    }

    actions
    {
    }
}

