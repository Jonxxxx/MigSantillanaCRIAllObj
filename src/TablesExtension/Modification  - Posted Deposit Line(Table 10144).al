tableextension 70000001 tableextension70000001 extends "Posted Deposit Line" 
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Bank Account Ledger Entry No.")
        {
            Caption = 'Bank Account Ledger Entry No.';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""No. Documento Externo"(Field 481)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAccountCard(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAccountLedgerEntries(PROCEDURE 1020001)".

}

