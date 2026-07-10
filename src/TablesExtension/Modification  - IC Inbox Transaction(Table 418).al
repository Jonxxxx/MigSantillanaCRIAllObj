tableextension 70000052 tableextension70000052 extends "IC Inbox Transaction" 
{
    fields
    {
        modify("IC Partner G/L Acc. No.")
        {
            Caption = 'IC Partner G/L Acc. No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003002)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDetails(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "InboxCheckAccept(PROCEDURE 40)".

    //procedure InboxCheckAccept();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeInboxCheckAccept(Rec,IsHandled);
        IF IsHandled THEN
        #4..7
        HandledICInboxTrans.SETRANGE("Source Type","Source Type");
        HandledICInboxTrans.SETRANGE("Document No.","Document No.");
        IF HandledICInboxTrans.FINDFIRST THEN
          IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text002,"Transaction No."),TRUE) THEN
            ERROR('');

        ICInboxTransaction2.SETRANGE("IC Partner Code","IC Partner Code");
        #15..45
        END;

        OnAfterInboxCheckAccept(Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
          IF NOT ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(
                 TransactionAlreadyExistsInInboxHandledQst,HandledICInboxTrans."Document Type",
                 HandledICInboxTrans."Document No.",HandledICInboxTrans."IC Partner Code"),
               TRUE)
          THEN
        #12..48
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnAfterInboxCheckAccept(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInboxCheckAccept(PROCEDURE 2)".


    //Unsupported feature: Deletion (VariableCollection) on "InboxCheckAccept(PROCEDURE 40).Text002(Variable 1000)".


    var
        TransactionAlreadyExistsInInboxHandledQst: Label '%1 %2 has already been received from intercompany partner %3. Accepting it again will create a duplicate %1. Do you want to accept the %1?', Comment='%1 - Document Type, %2 - Document No, %3 - IC parthner code';
}

