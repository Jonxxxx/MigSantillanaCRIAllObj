pageextension 50137 EXCCRIPostedReturnReceipts extends "Posted Return Receipts"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRIAppliesToDocNo; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document number that the posted return receipt applies to.';
            }
            field(EXCCRIUserId; Rec."User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the user who posted the return receipt.';
            }
            field(EXCCRIReturnOrderNo; Rec."Return Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales return order number related to the posted return receipt.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the external document number of the posted return receipt.';
            }
        }
    }
}
