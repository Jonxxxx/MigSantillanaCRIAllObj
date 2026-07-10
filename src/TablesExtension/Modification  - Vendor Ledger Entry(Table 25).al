tableextension 70000023 tableextension70000023 extends "Vendor Ledger Entry" 
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
        modify("Closed by Entry No.")
        {
            Caption = 'Closed by Entry No.';
        }
        modify("Closed by Amount (LCY)")
        {
            Caption = 'Closed by Amount ($)';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Caption = 'Remaining Pmt. Disc. Possible';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003001)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDoc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPostedDocAttachment(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "HasPostedDocAttachment(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnEntries(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnOverdueEntries(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "GetOriginalCurrencyFactor(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetAdjustedCurrencyFactor(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCVLedgEntryBuffer(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateAmounts(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyVendLedgerEntryFromGenJnlLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyVendLedgerEntryFromCVLedgEntryBuffer(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowDoc(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownEntries(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownOnOverdueEntries(PROCEDURE 12)".

}

