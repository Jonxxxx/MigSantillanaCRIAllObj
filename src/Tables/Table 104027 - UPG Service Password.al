table 55720 "UPG Service Password"
{

    fields
    {
        field(1; "Key"; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Key';
        }
        field(2; Value; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; "Key")
        {
        }
    }

    fieldgroups
    {
    }
}

