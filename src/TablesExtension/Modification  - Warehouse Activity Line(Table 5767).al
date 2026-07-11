tableextension 70000084 tableextension70000084 extends "Warehouse Activity Line"
{
    fields
    {
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 19)".


        //Unsupported feature: Code Modification on ""Qty. to Handle"(Field 26).OnValidate".

        //trigger  to Handle"(Field 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IsHandled := FALSE;
        OnBeforeValidateQtyToHandle(Rec,IsHandled);
        IF NOT IsHandled THEN
        #4..34
           ("Action Type" <> "Action Type"::Place) AND ("Lot No." <> '') AND (CurrFieldNo <> 0)
        THEN
          CheckReservedItemTrkg(1,"Lot No.");

        IF ("Qty. to Handle" = 0) AND RegisteredWhseActLineIsEmpty THEN
          UpdateReservation(Rec,FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..37
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50000)".

    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Source Document,Source No."(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "CalcQty(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "AutofillQtyToHandle(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteQtyToHandle(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteRelatedWhseActivLines(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CheckWhseDocLine(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBinInSourceDoc(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetBin(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "SplitLine(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "ShowWhseDoc(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "ShowActivityDoc(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "ChangeUOMCode(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateRelatedItemTrkg(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpTrackingSummary(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteBinContent(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromPickWkshLine(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromShptLine(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromATOShptLine(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromIntPickLine(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromCompLine(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromAssemblyLine(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "TransferFromMovWkshLine(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemAvailabilityByPeriod(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemAvailabilityByVariant(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemAvailabilityByLocation(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "ShowItemAvailabilityByEvent(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "ActivityExists(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "TrackingExists(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "SetSource(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetSourceFilter(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "ClearSourceFilter(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "ClearTracking(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "ClearTrackingFilter(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "CopyTrackingFromSpec(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "SetTrackingFilter(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutofillQtyToHandle(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutofillQtyToHandleLine(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearTracking(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearTrackingFilter(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyTrackingFromSpec(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteQtyToHandle(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitTrackingSpecFromWhseActivLine(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterLookupTrackingSummary(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetTrackingFilter(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSplitLines(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromShptLine(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromIntPickLine(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromCompLine(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromAssemblyLine(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromMovWkshLine(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterTransferFromPickWkshLine(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateQtyToHandleWhseActivLine(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeAutofillQtyToHandle(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBinInSourceDoc(PROCEDURE 84)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckReservedItemTrkg(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckWhseDocLine(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmWhseActivLinesDeletionRecreate(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeConfirmWhseActivLinesDeletionOutOfBalance(PROCEDURE 94)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSplitLines(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDeleteRelatedWhseActivLines(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDeleteQtyToHandle(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDeleteWhseActivLine2(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertNewWhseActivLine(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeModifyOldWhseActivLine(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowDeletedMessage(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeShowWhseDoc(PROCEDURE 82)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateQtyToHandle(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnCreateNewUOMLineOnBeforeNewWhseActivLineInsert(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpTrackingSummaryOnAfterAssistEditTrackingNo(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpTrackingSummaryOnAfterCheckDataSet(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBinCodeOnAfterGetBin(PROCEDURE 91)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateItemNoOnAfterValidateUoMCode(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnAfterGetItemVariant(PROCEDURE 92)".


    procedure ResetQtyToHandleOnReservation()
    begin
        IF ("Qty. to Handle" = 0) AND TrackingExists AND RegisteredWhseActLineIsEmpty THEN
            UpdateReservation(Rec, FALSE)
    end;

    procedure TestNonSpecificItemTracking()
    var
        ItemJournalLine: Record 83;
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
        SNRequired: Boolean;
        LNRequired: Boolean;
        SNInfoRequired: Boolean;
        LNInfoRequired: Boolean;
    begin
        CASE "Source Document" OF
            "Source Document"::"Sales Order":
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Sale;
            "Source Document"::"Purchase Return Order":
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Purchase;
            "Source Document"::"Outbound Transfer":
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
            "Source Document"::"Prod. Consumption":
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Consumption;
            "Source Document"::"Assembly Consumption":
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Assembly Consumption";
            ELSE
                EXIT;
        END;

        GetItem;
        ItemTrackingMgt.CheckWhseItemTrkgSetup("Item No.", WhseSNRequired, WhseLNRequired, TRUE);
        ItemTrackingMgt.GetItemTrackingSettings(
          ItemTrackingCode, ItemJournalLine."Entry Type", FALSE, SNRequired, LNRequired, SNInfoRequired, LNInfoRequired);

        IF SNRequired AND NOT WhseSNRequired AND WhseLNRequired THEN
            TESTFIELD("Serial No.");
        IF LNRequired AND NOT WhseLNRequired AND WhseSNRequired THEN
            TESTFIELD("Lot No.");
    end;


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must not be %1;ESM=No puede ser %1.;FRC=ne doit pas être %1;ENC=must not be %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must not be %1;ESM=no puede ser %1;FRC=ne doit pas être %1;ENC=must not be %1;
    //Variable type has not been exported.
}

