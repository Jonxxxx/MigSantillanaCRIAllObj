tableextension 70000028 tableextension70000028 extends "Bank Account Ledger Entry"
{
    fields
    {
        modify("Bank Acc. Posting Group")
        {
            Caption = 'Bank Acc. Posting Group';
        }
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Closed by Entry No.")
        {
            Caption = 'Closed by Entry No.';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Forma de Pago"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on "Beneficiario(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Realizado Financ."(Field 34003002)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 3)".


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 3)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Bank Account No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    #4..16
    "Bal. Account Type" := GenJnlLine."Bal. Account Type";
    "Bal. Account No." := GenJnlLine."Bal. Account No.";

    // MDM
    "Collector Code"   := GenJnlLine."Collector Code";
    // MDM

    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "IsApplied(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetFilterBankAccNoOpen(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyFromGenJnlLine(PROCEDURE 7)".

}

