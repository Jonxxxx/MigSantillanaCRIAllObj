pageextension 50028 EXCCRIPurchaseCreditMemo extends "Purchase Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the purchase credit memo.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number associated with the purchase credit memo.';
                }
                field(EXCCRIRelatedFiscalReceiptNo; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number related to the purchase credit memo.';
                }
                field(EXCCRINCFCorrection; Rec."Correccion Doc. NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the purchase credit memo corrects a fiscal receipt document.';
                }
                field(EXCCRINCFExpirationDate; Rec."Fecha vencimiento NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
                }
                field(EXCCRIExpenseClassificationCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expense classification code assigned to the purchase credit memo.';
                }
                field(EXCCRIProportionality; Rec.Proporcionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the proportionality treatment assigned to the purchase credit memo.';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRILocalizationActions)
            {
                Caption = 'Localization';

                action(EXCCRIConsultRNC)
                {
                    ApplicationArea = All;
                    Caption = 'Consult RNC';
                    ToolTip = 'Opens the configured DGII website to consult a tax registration number.';

                    trigger OnAction()
                    var
                        EXCCRILocalizationSetup: Record 34003008;
                    begin
                        EXCCRILocalizationSetup.Get();
                        EXCCRILocalizationSetup.TestField("URL DGII consulta RNC");
                        Hyperlink(EXCCRILocalizationSetup."URL DGII consulta RNC");
                    end;
                }
                action(EXCCRIRetention)
                {
                    ApplicationArea = All;
                    Caption = 'Retention';
                    RunObject = page 34003002;
                    RunPageLink = "Tipo documento" = field("Document Type"),
                                  "No. documento" = field("No.");
                    ToolTip = 'Opens the retention entries associated with the purchase credit memo.';
                }
                action(EXCCRIDistributeItemCharge)
                {
                    ApplicationArea = All;
                    Caption = 'Distribute Item Charge';
                    ToolTip = 'Distributes item charges among the purchase credit memo lines.';

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.Page.SplitIC();
                    end;
                }
            }
        }
    }
}
