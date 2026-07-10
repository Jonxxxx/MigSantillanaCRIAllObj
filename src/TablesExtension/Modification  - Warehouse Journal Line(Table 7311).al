tableextension 70000101 tableextension70000101 extends "Warehouse Journal Line" 
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

        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 5)".


        //Unsupported feature: Property Deletion (Description) on ""Item No."(Field 9)".


        //Unsupported feature: Deletion (FieldCollection) on "Barcode(Field 34002500)".

    }

    //Unsupported feature: Property Modification (Attributes) on "GetItem(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpAdjustmentBin(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "EmptyLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "TemplateSelection(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "TemplateSelectionFromBatch(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "OpenJnl(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CheckName(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "SetName(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "LookupName(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Modification (Attributes) on "ItemTrackingReclass(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "IsReclass(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "SetProposal(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "SetSource(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "SetTracking(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "SetWhseDoc(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBin(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckName(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckTemplateName(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetLocation(PROCEDURE 31)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeOpenItemTrackingLines(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "OnOpenItemTrackingLinesOnBeforeSetSource(PROCEDURE 28)".

}

