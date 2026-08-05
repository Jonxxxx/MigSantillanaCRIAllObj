table 55733 "UPG Job"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(1035; "Over Budget"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Over Budget';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

