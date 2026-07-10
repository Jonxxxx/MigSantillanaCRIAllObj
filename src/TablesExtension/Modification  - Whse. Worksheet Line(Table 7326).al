tableextension 70000105 tableextension70000105 extends "Whse. Worksheet Line" 
{
    fields
    {
        modify("Location Code")
        {
            TableRelation = Location;
        }
        modify("Item No.")
        {
            TableRelation = Item WHERE (Type=CONST(Inventory));
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 33)".


        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 10)".


        //Unsupported feature: Property Deletion (Description) on ""Item No."(Field 16)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50000)".

    }

    //Unsupported feature: Property Modification (Attributes) on "CalcBaseQty(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "CalcQty(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "AutofillQtyToHandle(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteQtyToHandle(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CalcAvailableQtyBase(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "CalcReservedNotFromILEQty(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "CheckAvailQtytoMove(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "SortWhseWkshLines(PROCEDURE 3)".


    //Unsupported feature: Code Modification on "SortWhseWkshLines(PROCEDURE 3)".

    //procedure SortWhseWkshLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseWkshLine.SETRANGE("Worksheet Template Name",WhseWkshTemplate);
        WhseWkshLine.SETRANGE(Name,WhseWkshName);
        WhseWkshLine.SETRANGE("Location Code",LocationCode);
        #4..12
              GetLocation(LocationCode);
              IF Location."Bin Mandatory" THEN
                WhseWkshLine.SETCURRENTKEY(
                  "Worksheet Template Name",Name,"Location Code","To Bin Code")
              ELSE
                WhseWkshLine.SETCURRENTKEY(
                  "Worksheet Template Name",Name,"Location Code","Shelf No.");
        #20..33
            SequenceNo := SequenceNo + 10000;
          UNTIL WhseWkshLine.NEXT = 0;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..15
                  "Worksheet Template Name",Name,"Location Code","To Bin Code","Shelf No.")
        #17..36
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetItem(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBin(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "PutAwayCreate(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "MovementCreate(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "TemplateSelection(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "TemplateSelectionFromBatch(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "OpenWhseWksh(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OpenWhseWkshBatch(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "CheckWhseWkshName(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "SetWhseWkshName(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "LookupWhseWkshName(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidationDialog(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "AvailableQtyToPick(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "AvailableQtyToPickExcludingQCBins(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "InitLineWithItem(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "GetSortSeqNo(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "SetItemTrackingLines(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "SetCurrentFieldNo(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "SetSourceFilter(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAutofillQtyToHandle(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBin(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckTemplateName(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckWhseEmployee(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckWhseWkshName(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnCalcAvailQtyToMoveOnAfterSetFilters(PROCEDURE 6)".



    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1009)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text007 : ENU=You must first set up user %1 as a warehouse employee.;ESM=Primero debe configurar usuario %1 como empleado almacén.;FRC=Vous devez d'abord établir l'utilisateur %1 à titre de magasinier.;ENC=You must first set up user %1 as a warehouse employee.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text007 : ENU=You must first set up user %1 as a warehouse employee.;ESM=Primero debe configurar usuario %1 como empleado almacén.;FRC=Vous devez d'abord configurer l'utilisateur %1 en tant qu'employé d'entreptôt.;ENC=You must first set up user %1 as a warehouse employee.;
        //Variable type has not been exported.
}

