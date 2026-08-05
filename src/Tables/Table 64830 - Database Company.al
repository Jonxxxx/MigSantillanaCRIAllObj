table 55455 "Database Company"
{
    //IGNORAR: Page no existe DrillDownPageID = 55455;
    //IGNORAR: Page no existe LookupPageID = 55455;

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

