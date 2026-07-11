tableextension 70000049 tableextension70000049 extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        modify("Vendor Ledger Entry No.")
        {
            Caption = 'Vendor Ledger Entry No.';
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
        modify("Applied Vend. Ledger Entry No.")
        {
            Caption = 'Applied Vend. Ledger Entry No.';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Caption = 'Remaining Pmt. Disc. Possible';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Grupo Contable"(Field 50000)".

    }

    //Unsupported feature: Property Modification (Attributes) on "UpdateDebitCredit(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "SetZeroTransNo(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "GetUnrealizedGainLossAmount(PROCEDURE 2)".

    procedure GetLastEntryNo(): Integer
    var
        [SecurityFiltering(SecurityFilter::Ignored)]
        DetailedVendorLedgEntryLocal: Record 380;
    begin
        IF DetailedVendorLedgEntryLocal.FINDLAST THEN;
        EXIT(DetailedVendorLedgEntryLocal."Entry No.");
    end;
}

