pageextension 50134 EXCCRIPurchaseReturnOrder extends "Purchase Return Order"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number of the purchase return order.';
            }
            field(EXCCRIRelatedFiscalNo; Rec."No. Comprobante Fiscal Rel.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the related fiscal receipt number of the purchase return order.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIConsultRNC)
            {
                ApplicationArea = All;
                Caption = 'Consult RNC';
                Image = Web;
                ToolTip = 'Opens the configured DGII website used to consult the RNC.';

                trigger OnAction()
                var
                    EXCCRILocalizationSetup: Record 34003008;
                begin
                    EXCCRILocalizationSetup.Get();
                    EXCCRILocalizationSetup.TestField("URL DGII consulta RNC");
                    Hyperlink(EXCCRILocalizationSetup."URL DGII consulta RNC");
                end;
            }
            action(EXCCRISplitItemCharges)
            {
                ApplicationArea = All;
                Caption = 'Distribute Item Charges';
                Image = ItemCosts;
                ToolTip = 'Distributes the selected purchase item charges among the related item lines.';

                trigger OnAction()
                begin
                    CurrPage.PurchLines.Page.SplitIC();
                end;
            }
        }
    }
}
