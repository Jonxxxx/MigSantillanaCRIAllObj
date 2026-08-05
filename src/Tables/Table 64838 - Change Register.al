table 55463 "Change Register"
{

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Specification No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification No.';
            TableRelation = Specification."No.";
        }
        field(3; "Source Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Database';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(4; "Dest. Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Database';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(5; "Changes Made"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Changes Made';
            OptionMembers = ,update,add,delete;
        }
        field(6; "Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table No.';
        }
        field(7; "Table Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Table Name';
        }
        field(8; "Key Fields Values"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Key Fields Values';
        }
        field(9; Company; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Company';
        }
        field(10; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(11; Time; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time';
        }
        field(12; "Scheduler No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduler No.';
        }
        field(13; "User ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(15; "Field No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No.';
        }
        field(16; "Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name';
        }
        field(20; "Old Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Value';
        }
        field(21; "New Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'New Value';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Specification No.")
        {
        }
    }

    fieldgroups
    {
    }
}

