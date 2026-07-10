tableextension 70000072 tableextension70000072 extends "FA Journal Line"
{
    fields
    {
        modify("FA No.")
        {
            TableRelation = "Fixed Asset";
        }
        modify("No. of Depreciation Days")
        {
            Caption = 'No. of Depreciation Days';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("FA Error Entry No.")
        {
            Caption = 'FA Error Entry No.';
        }

        //Unsupported feature: Property Deletion (Description) on ""FA No."(Field 6)".


        //Unsupported feature: Code Insertion (VariableCollection) on "Amount(Field 14).OnValidate".

        //trigger (Variable: Currency)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 14).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ((Amount > 0) AND (NOT Correction)) OR
           ((Amount < 0) AND Correction)
        THEN BEGIN
        #4..6
          "Debit Amount" := 0;
          "Credit Amount" := -Amount;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(Currency);
        Currency.InitRoundingPrecision;
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        #1..9
        */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "ConvertToLedgEntry(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnConvertToLedgEntryCase(PROCEDURE 3)".


    var
        Currency Record: 4;
}

