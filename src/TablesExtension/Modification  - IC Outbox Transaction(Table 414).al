tableextension 70000051 tableextension70000051 extends "IC Outbox Transaction" 
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


    //Unsupported feature: Code Modification on "OutboxCheckSend(PROCEDURE 36)".

    //procedure OutboxCheckSend();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeOutboxCheckSend(Rec,IsHandled);
        IF IsHandled THEN
        #4..6
        HandledICOutboxTrans.SETRANGE("Document Type","Document Type");
        HandledICOutboxTrans.SETRANGE("Document No.","Document No.");
        IF HandledICOutboxTrans.FINDFIRST THEN
          IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text002,"Transaction No."),TRUE) THEN
            ERROR('');

        ICOutboxTransaction2.SETRANGE("Source Type","Source Type");
        #14..21
               STRSUBSTNO(Text001,ICOutboxTransaction2."Transaction No.","Transaction No."),TRUE)
          THEN
            ERROR('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
          IF NOT ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(
                 TransactionAlreadyExistsInOutboxHandledQst,HandledICOutboxTrans."Document Type",
                 HandledICOutboxTrans."Document No.",HandledICOutboxTrans."IC Partner Code"),
               TRUE)
          THEN
        #11..24
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOutboxCheckSend(PROCEDURE 2)".


    //Unsupported feature: Deletion (VariableCollection) on "OutboxCheckSend(PROCEDURE 36).Text002(Variable 1000)".


    var
        TransactionAlreadyExistsInOutboxHandledQst: Label '%1 %2 has already been sent to intercompany partner %3. Resending it will create a duplicate %1 for them. Do you want to send it again?', Comment='%1 - Document Type, %2 - Document No, %3 - IC parthner code';
}

