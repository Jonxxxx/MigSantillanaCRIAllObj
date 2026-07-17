pageextension 50039 EXCCRIPostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether copyright charges do not apply to the posted sales shipment.';
                }
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
                ToolTip = 'Opens the custom order tracking page for the posted sales shipment.';

                trigger OnAction()
                var
                    EXCCRIOrderTrackingPage: Page 56081;
                begin
                    EXCCRIOrderTrackingPage.SetDoc(2, Rec."No.");
                    EXCCRIOrderTrackingPage.Run();
                end;
            }
        }
    }
}
