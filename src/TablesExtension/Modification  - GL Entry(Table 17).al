tableextension 70000015 tableextension70000015 extends "G/L Entry" 
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No. Mov. cliente provisionado"(Field 56045)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on "RNC(Field 34003008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003011)".

    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""No. Mov. cliente provisionado,Document Date"(Key)".


        //Unsupported feature: Deletion (KeyCollection) on ""Source No.,Document Date,No. Mov. cliente provisionado,Source Type"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ShowValueEntries(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 4)".


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        "Document Type" := GenJnlLine."Document Type";
        #4..32
        "User ID" := USERID;
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";

        OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..35
        "Prod. Order No." := GenJnlLine."Prod. Order No.";

        OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromGLEntry(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromVATEntry(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromGenJnlLine(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "CopyPostingGroupsFromDtldCVBuf(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGLEntryFromGenJnlLine(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromDeferralPostBuffer(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAccountID(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromDeferralPostBuffer(PROCEDURE 7)".

}

