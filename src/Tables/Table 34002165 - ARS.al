table 55806 ARS
{
    Caption = 'ARS';
    //IGNORAR: Page no existe DrillDownPageID = 55814;
    //IGNORAR: Page no existe LookupPageID = 55814;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
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

