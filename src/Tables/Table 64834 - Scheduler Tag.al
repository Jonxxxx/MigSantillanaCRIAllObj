table 55459 "Scheduler Tag"
{

    fields
    {
        field(1; "Scheduler No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduler No.';
            TableRelation = Scheduler."No.";
        }
        field(2; "No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(5; Value; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; "Scheduler No.", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

