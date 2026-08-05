table 55456 "Database Key"
{
    //IGNORAR: Page no existe DrillDownPageID = 55456;
    //IGNORAR: Page no existe LookupPageID = 55456;

    fields
    {
        field(1; "Database Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Database Code';
        }
        field(2; "Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table No.';
        }
        field(3; "Key Sequence No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Key Sequence No.';
        }
        field(10; "Key Field No."; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Key Field No.';
        }
        field(11; "Key Field Names"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Key Field Names';
        }
    }

    keys
    {
        key(Key1; "Database Code", "Table No.", "Key Sequence No.", "Key Field No.")
        {
        }
    }

    fieldgroups
    {
    }
}

