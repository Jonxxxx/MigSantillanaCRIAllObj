tableextension 70000047 tableextension70000047 extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        modify("Cust. Ledger Entry No.")
        {
            Caption = 'Cust. Ledger Entry No.';
        }
        modify("Initial Entry Due Date")
        {
            Caption = 'Initial Entry Due Date';
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
        modify("Applied Cust. Ledger Entry No.")
        {
            Caption = 'Applied Cust. Ledger Entry No.';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Caption = 'Remaining Pmt. Disc. Possible';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Grupo Contable"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Act. Ledger Entry Amount"(Field 50001)".

    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "SetZeroTransNo(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnrealizedGainLossAmount(PROCEDURE 2)".

    procedure GetLastEntryNo(): Integer
    var
        [SecurityFiltering(SecurityFilter::Ignored)]
        DetailedCustLedgEntryLocal: Record 379;
    begin
        IF DetailedCustLedgEntryLocal.FINDLAST THEN;
        EXIT(DetailedCustLedgEntryLocal."Entry No.");
    end;
}

