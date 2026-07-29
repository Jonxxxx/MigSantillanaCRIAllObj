table 64830 "Database Company"
{
    //IGNORAR: Page no existe DrillDownPageID = 64830;
    //IGNORAR: Page no existe LookupPageID = 64830;

    fields
    {
        field(1; "Database Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Database Code';
        }
        field(2; "Company Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
        }
    }

    keys
    {
        key(Key1; "Database Code", "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

