table 34002165 ARS
{
    Caption = 'ARS';
    //TODO: Page no existe DrillDownPageID = 34002173;
    //TODO: Page no existe LookupPageID = 34002173;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

