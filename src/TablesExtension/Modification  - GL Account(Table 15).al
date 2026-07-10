tableextension 70000013 tableextension70000013 extends "G/L Account"
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

        //Unsupported feature: Property Deletion (TableRelation) on "Totaling(Field 34)".


        //Unsupported feature: Code Modification on ""Gen. Prod. Posting Group"(Field 45).OnValidate".

        //trigger  Prod()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckOrdersPrepmtToDeduct(FIELDCAPTION("Gen. Prod. Posting Group"));
        #1..3
        */
        //end;


        //Unsupported feature: Code Insertion on ""VAT Prod. Posting Group"(Field 58)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        CheckOrdersPrepmtToDeduct(FIELDCAPTION("VAT Prod. Posting Group"));
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on "CABYS(Field 56035)".


        //Unsupported feature: Deletion (FieldCollection) on ""NCF Obligatorio"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo ingreso admitido"(Field 34003008)".

    }

    //Unsupported feature: Property Modification (Attributes) on "SetupNewGLAcc(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CheckGLAcc(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateAccountSubCategory(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "LookupAccountSubCategory(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "GetCurrencyCode(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "TranslationMethodConflict(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "IsTotaling(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckGLAcc(PROCEDURE 9)".


    procedure CheckGenProdPostingGroup()
    var
        GeneralLedgerSetup Record: 98;
        IsHandled: Boolean;
    begin
        IsHandled := FALSE;
        OnBeforeCheckGenProdPostingGroup(Rec, IsHandled);
        IF IsHandled THEN
            EXIT;

        GeneralLedgerSetup.GET;
        IF NOT GeneralLedgerSetup."VAT in Use" THEN
            EXIT;

        IF "Gen. Prod. Posting Group" = '' THEN
            ERROR(GenProdPostingGroupErr, FIELDCAPTION("Gen. Prod. Posting Group"), Name, "No.");
    end;

    local procedure CheckOrdersPrepmtToDeduct(FldCaption: Text)
    var
        GeneralPostingSetup Record: 252;
    begin
        GeneralPostingSetup.FILTERGROUP(-1);
        GeneralPostingSetup.SETRANGE("Sales Prepayments Account", "No.");
        GeneralPostingSetup.SETRANGE("Purch. Prepayments Account", "No.");
        IF GeneralPostingSetup.FIND('-') THEN
            REPEAT
                GeneralPostingSetup.CheckOrdersPrepmtToDeduct(
                  STRSUBSTNO(CannotChangeSetupOnPrepmtAccErr, '%1', FldCaption, "No."));
            UNTIL GeneralPostingSetup.NEXT = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckGenProdPostingGroup(var GLAccount Record: 15; var IsHandled: Boolean)
    begin
    end;

    var
        GenProdPostingGroupErr: Label '%1 is not set for the %2 G/L account with no. %3.', Comment = '%1 - caption Gen. Prod. Posting Group; %2 - G/L Account Description; %3 - G/L Account No.';
        CannotChangeSetupOnPrepmtAccErr: Label 'You cannot change %2 on account %3 while %1 is pending prepayment.', Comment = '%2 - field caption, %3 - account number, %1 - recordId - "Sales Header: Order, 1001".';
}

