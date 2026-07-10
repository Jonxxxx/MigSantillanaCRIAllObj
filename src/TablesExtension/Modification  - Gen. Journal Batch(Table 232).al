tableextension 70000021 tableextension70000021 extends "Gen. Journal Batch" 
{
    fields
    {
        modify("Copy VAT Setup to Jnl. Lines")
        {
            Caption = 'Copy Tax Setup to Jnl. Lines';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Seccion POS"(Field 50000)".

        field(28;"Pending Approval";Boolean)
        {
            Caption = 'Pending Approval';
            Editable = false;
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "SetupNewBatch(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "LinesExist(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetBalance(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBalance(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "OnGeneralJournalBatchBalanced(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "OnGeneralJournalBatchNotBalanced(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLineExportRestrictions(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OnMoveGenJournalBatch(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateBalAccountId(PROCEDURE 9)".



    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text001 : ENU=must not be %1;ESM=No puede ser %1.;FRC=ne doit pas être %1;ENC=must not be %1;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text001 : ENU=must not be %1;ESM=no puede ser %1;FRC=ne doit pas être %1;ENC=must not be %1;
        //Variable type has not been exported.
}

