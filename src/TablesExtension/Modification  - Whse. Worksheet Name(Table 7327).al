tableextension 70000106 tableextension70000106 extends "Whse. Worksheet Name" 
{
    fields
    {
        modify("Location Code")
        {
            TableRelation = Location;
        }

        //Unsupported feature: Property Deletion (Description) on ""Location Code"(Field 3)".

    }

    //Unsupported feature: Property Modification (Attributes) on "SetupNewName(PROCEDURE 3)".

}

