tableextension 70000073 tableextension70000073 extends "FA Reclass. Journal Line" 
{
    fields
    {
        modify("FA No.")
        {
            TableRelation = "Fixed Asset";
        }
        modify("New FA No.")
        {
            TableRelation = "Fixed Asset";
        }

        //Unsupported feature: Property Deletion (Description) on ""FA No."(Field 4)".


        //Unsupported feature: Property Deletion (Description) on ""New FA No."(Field 5)".

    }

    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetUpNewLine(PROCEDURE 1)".

}

