tableextension 50037 EXCCRIPostCode extends "Post Code"
{
    fields
    {
        field(52500; Colonia; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    fieldgroups
    {
        addlast(DropDown; Colonia)
        {
        }
    }
}
