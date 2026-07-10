tableextension 70000119 tableextension70000119 extends "Vendor Posting Group" 
{
    fields
    {
        modify("Payment Disc. Debit Acc.")
        {
            Caption = 'Payment Disc. Debit Acc.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Permite Emitir NCF"(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""NCF Obligatorio"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Factura Compra"(Field 34003005)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos Compra"(Field 34003006)".


        //Unsupported feature: Deletion (FieldCollection) on "Internacional(Field 34003007)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetPayablesAccount(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtDiscountAccount(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "GetPmtToleranceAccount(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetRoundingAccount(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetApplRoundingAccount(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: GLAccount) (VariableCollection) on "GetInvRoundingAccount(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "GetInvRoundingAccount(PROCEDURE 9)".


    //Unsupported feature: Code Modification on "GetInvRoundingAccount(PROCEDURE 9)".

    //procedure GetInvRoundingAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Invoice Rounding Account" = '' THEN
          PostingSetupMgt.SendVendPostingGroupNotification(Rec,FIELDCAPTION("Invoice Rounding Account"));
        TESTFIELD("Invoice Rounding Account");
        EXIT("Invoice Rounding Account");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Invoice Rounding Account" <> '' THEN BEGIN
          GLAccount.GET("Invoice Rounding Account");
          GLAccount.CheckGenProdPostingGroup;
        END ELSE
        #2..4
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetServiceChargeAccount(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountVisibility(PROCEDURE 10)".

}

