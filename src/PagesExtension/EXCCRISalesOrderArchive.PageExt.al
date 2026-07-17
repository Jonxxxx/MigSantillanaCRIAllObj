pageextension 50096 EXCCRISalesOrderArchive extends "Sales Order Archive"
{
    layout
    {
        addafter("Order Date")
        {
            field(EXCCRIDocumentType; Rec."Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Document Type value for the archived sales order.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIOrderTracking)
            {
                ApplicationArea = All;
                Caption = 'Order Tracking';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Opens the custom order tracking page for the archived sales order.';

                trigger OnAction()
                var
                    EXCCRIOrderTrackingPage: Page 56081;
                begin
                    EXCCRIOrderTrackingPage.SetDoc(1, Rec."No.");
                    EXCCRIOrderTrackingPage.Run();
                end;
            }
        }
    }
}
