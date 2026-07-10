pageextension 70000130 pageextension70000130 extends "Item Charge Assignment (Purch)" 
{
    actions
    {
        modify(GetReceiptLines)
        {
            ApplicationArea = ItemCharges;
        }
        modify(SuggestItemChargeAssignment)
        {
            ApplicationArea = ItemCharges;
        }

        //Unsupported feature: Property Deletion (PromotedIsBig) on "GetReceiptLines(Action 20)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "SuggestItemChargeAssignment(Action 41)".

    }

    //Unsupported feature: Property Modification (Attributes) on "Initialize(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitialize(PROCEDURE 4)".

}

