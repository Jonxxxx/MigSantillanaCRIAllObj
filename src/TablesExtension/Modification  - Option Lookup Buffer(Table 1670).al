tableextension 70000014 tableextension70000014 extends "Option Lookup Buffer" 
{

    //Unsupported feature: Property Modification (Attributes) on "ValidateOption(PROCEDURE 4)".


    //Unsupported feature: Code Modification on "FillBufferInternal(PROCEDURE 3)".

    //procedure FillBufferInternal();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RecRef.OPEN(TableNo);
        FieldRef := RecRef.FIELD(FieldNo);
        FOR OptionIndex := 0 TO TypeHelper.GetNumberOfOptions(FieldRef.OPTIONSTRING) DO BEGIN
        #4..8
              CreateNew(OptionIndex,FormatOption(FieldRef),LookupType)
            ELSE BEGIN
              RelatedRecRef.OPEN(RelatedTableNo);
              //RelatedRecRef.SETPERMISSIONFILTER;
              IF RelatedRecRef.READPERMISSION THEN
                CreateNew(OptionIndex,FormatOption(FieldRef),LookupType);
              RelatedRecRef.CLOSE;
            END;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
              RelatedRecRef.SETPERMISSIONFILTER;
        #13..18
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetCurrentType(PROCEDURE 5)".

}

