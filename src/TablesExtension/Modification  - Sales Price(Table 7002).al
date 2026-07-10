tableextension 70000099 tableextension70000099 extends "Sales Price" 
{
    fields
    {
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'Tax Bus. Posting Gr. (Price)';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Source counter"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Item description"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "IdJobQueueEntry(Field 75000)".


        //Unsupported feature: Deletion (FieldCollection) on "Location(Field 34002504)".


        //Unsupported feature: Deletion (FieldCollection) on ""Precio manual"(Field 34002505)".

    }

    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Sales Type" = "Sales Type"::"All Customers" THEN
          "Sales Code" := ''
        ELSE
          TESTFIELD("Sales Code");
        TESTFIELD("Item No.");

        // MdM 18/09/17
        IF NOT wModificadoMdM THEN
          cGestMdm.GestNotityPrec(lwXRec2,Rec, FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        */
    //end;


    //Unsupported feature: Code Modification on "OnRename".

    //trigger OnRename()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Sales Type" <> "Sales Type"::"All Customers" THEN
          TESTFIELD("Sales Code");
        TESTFIELD("Item No.");

        // MdM 18/09/17
        IF NOT wModificadoMdM THEN
          cGestMdm.GestNotityPrec(xRec,Rec, FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CopySalesPriceToCustomersSalesPrice(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeNewSalesPriceInsert(PROCEDURE 2)".

}

