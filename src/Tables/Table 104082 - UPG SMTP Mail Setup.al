table 55732 "UPG SMTP Mail Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(5; Password; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

