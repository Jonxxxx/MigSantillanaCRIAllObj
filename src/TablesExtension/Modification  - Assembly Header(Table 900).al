tableextension 70000113 tableextension70000113 extends "Assembly Header" 
{
    fields
    {
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Code Modification on "Quantity(Field 40).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CheckIsNotAsmToOrder;
            TestStatusOpen;

            #4..11
            InitQtyToAssemble;
            VALIDATE("Quantity to Assemble");

            //#36174:Inicio
            TESTFIELD("Location Code");
            //36174:Fin

            AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO(Quantity),ReplaceLinesFromBOM,CurrFieldNo,CurrentFieldNum);
            AssemblyHeaderReserve.VerifyQuantity(Rec,xRec);

            ClearCurrentFieldNum(FIELDNO(Quantity));
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..14
            #19..22
            */
        //end;
    }

    //Unsupported feature: Property Modification (Attributes) on "RefreshBOM(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecord(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "InitRemainingQty(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "InitQtyToAssemble(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteAssemblyLines(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservation(PROCEDURE 121)".


    //Unsupported feature: Property Modification (Attributes) on "ShowReservationEntries(PROCEDURE 122)".


    //Unsupported feature: Property Modification (Attributes) on "AutoReserveAsmLine(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "SetTestReservationDateConflict(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "FilterLinesWithItemToPlan(PROCEDURE 70)".


    //Unsupported feature: Property Modification (Attributes) on "FindLinesWithItemToPlan(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "LinesWithItemToPlanExist(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ShowStatistics(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "SetDim(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitCost(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "SetItemFilter(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAssemblyList(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "RoundQty(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "CalcActualCosts(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateDates(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "GetDefaultBin(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "GetFromAssemblyBin(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateBinCode(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CreatePick(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "CreateInvtMovement(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "CompletelyPicked(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "IsInbound(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "ItemExists(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "TestStatusOpen(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "SuspendStatusCheck(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Attributes) on "IsStatusCheckSuspended(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTracking(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAsmToOrder(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "IsAsmToOrder(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "IsStandardCostItem(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDueDateBeforeWorkDateMsg(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "AddBOMLine(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateWarningOnLines(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "SetWarningsOff(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "CalcTotalCost(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "RowID1(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitQtyToAssemble(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRecord(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitRemaining(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeReplaceLinesFromBOM(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateItemNoOnAfterGetDefaultBin(PROCEDURE 72)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateItemNoOnBeforeValidateDates(PROCEDURE 71)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnBeforeUpdateAssemblyLines(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVariantCodeOnBeforeValidateDates(PROCEDURE 74)".

}

