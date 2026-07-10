tableextension 70000074 tableextension70000074 extends "Item Cross Reference" 
{

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Cross-Reference Type No." <> '') AND
           ("Cross-Reference Type" = "Cross-Reference Type"::" ")
        THEN
        #4..6
        IF "Unit of Measure" = '' THEN
          VALIDATE("Unit of Measure",Item."Base Unit of Measure");
        CreateItemVendor;

        //001
        ValidaCodBarra;
        //001
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ("Cross-Reference Type No." <> '') AND
           ("Cross-Reference Type" = "Cross-Reference Type"::" ")
        THEN
        #4..10
          IF "Cross-Reference Type" = "Cross-Reference Type"::Vendor THEN
            CreateItemVendor;
        END;

        //001
        ValidaCodBarra;
        //001
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateItemVendorNo(PROCEDURE 3)".

    //procedure UpdateItemVendorNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT MultipleCrossReferencesExist(ItemCrossReference) THEN
          IF ItemVend.GET(ItemCrossReference."Cross-Reference Type No.",ItemCrossReference."Item No.",ItemCrossReference."Variant Code") THEN BEGIN
            ItemVend.VALIDATE("Vendor Item No.",NewCrossRefNo);
            ItemVend.MODIFY;
          END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT MultipleCrossReferencesExist(ItemCrossReference) THEN
          IF ItemVend.GET(ItemCrossReference."Cross-Reference Type No.",ItemCrossReference."Item No.",ItemCrossReference."Variant Code") THEN BEGIN
            ItemVend."Vendor Item No." := NewCrossRefNo;
            ItemVend.MODIFY;
          END;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetItemDescription(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "HasValidUnitOfMeasure(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateItemVendor(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeItemVendorDelete(PROCEDURE 7)".

}

