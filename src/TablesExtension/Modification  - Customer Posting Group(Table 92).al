tableextension 70000118 tableextension70000118 extends "Customer Posting Group" 
{
    fields
    {
        modify("Payment Disc. Debit Acc.")
        {
            Caption = 'Payment Disc. Debit Acc.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Cliente Interno"(Field 51000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Invoice Report ID"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Invoice Report Name"(Field 56001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Credit Memo Report ID"(Field 56002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Credit Memo Report Name"(Field 56003)".


        //Unsupported feature: Deletion (FieldCollection) on ""No aplica Derechos de Autor"(Field 56004)".


        //Unsupported feature: Deletion (FieldCollection) on "Promocion(Field 56005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cta. Dotacion Provision insolv"(Field 56010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Permite emitir NCF"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Factura Venta"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie NCF Abonos Venta"(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""RNC/Cedula no Requerido"(Field 34003004)".


        //Unsupported feature: Deletion (FieldCollection) on "Internacional(Field 34003007)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetReceivablesAccount(PROCEDURE 6)".


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
          PostingSetupMgt.SendCustPostingGroupNotification(Rec,FIELDCAPTION("Invoice Rounding Account"));
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


    //Unsupported feature: Property Modification (Attributes) on "GetAdditionalFeeAccount(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetAddFeePerLineAccount(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "GetInterestAccount(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "SetAccountVisibility(PROCEDURE 12)".

}

