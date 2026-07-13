table 64830 "Database Company"
{
    //TODO: Ver DrillDownPageID = 64830;
    //TODO: Ver LookupPageID = 64830;

    fields
    {
        field(1; "Database Code"; Code[20])
        {
        }
        field(2; "Company Name"; Text[30])
        {
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

