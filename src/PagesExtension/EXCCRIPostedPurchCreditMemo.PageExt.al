pageextension 50046 EXCCRIPostedPurchCreditMemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the posted purchase credit memo.';
                }
                field(EXCCRIRelatedFiscalReceipt; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the fiscal receipt number related to the posted purchase credit memo.';
                }
                field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the expense classification code assigned to the posted purchase credit memo.';
                }
                field(EXCCRIProportionality; Rec.Proporcionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the proportionality treatment assigned to the posted purchase credit memo.';
                }
            }
        }
    }
}
