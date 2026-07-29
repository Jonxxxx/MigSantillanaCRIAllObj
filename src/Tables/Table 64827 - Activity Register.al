table 64827 "Activity Register"
{
    //IGNORAR: Page no existe DrillDownPageID = 64827;
    //IGNORAR: Page no existe LookupPageID = 64827;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(3; "Scheduler No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduler No.';
            TableRelation = Scheduler."No.";
        }
        field(4; "Specification No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification No.';
            TableRelation = Specification."No.";
        }
        field(5; "Replicator Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Replicator Group Code';
            TableRelation = "Replicator Group".Code;
        }
        field(6; "Source Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Database';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(7; "Dest. Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Database';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(8; "Source Counter"; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter';
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
        field(12; Error; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Error';
        }
        field(15; Text; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Text';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Specification No.", "Source Database", "Dest. Database", "Source Counter", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

