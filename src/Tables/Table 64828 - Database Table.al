table 55453 "Database Table"
{
    //IGNORAR: Page no existe DrillDownPageID = 55453;
    //IGNORAR: Page no existe LookupPageID = 55453;

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
        field(10; "Table Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Table Name';
        }
    }

    keys
    {
        key(Key1; "Database Code", "Table No.")
        {
        }
    }

    fieldgroups
    {
    }
}

