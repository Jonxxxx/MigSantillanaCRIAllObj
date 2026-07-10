tableextension 70000069 tableextension70000069 extends "Item Unit of Measure" 
{

    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TestItemUOM;
        CheckNoEntriesWithUoM;

        // MdM 18/09/17
        IF NOT wModificadoMdM THEN
          cGestMdm.GestNotityUnid(xRec, Rec, TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TestItemUOM;
        CheckNoEntriesWithUoM;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CalcWeight(PROCEDURE 7301)".


    //Unsupported feature: Property Modification (Attributes) on "TestItemSetup(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "CheckNoEntriesWithUoM(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcCubage(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCalcWeight(PROCEDURE 15)".

}

