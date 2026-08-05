table 55724 "UPG Direct Debit Col. Entry"
{

    fields
    {
        field(1; "Direct Debit Collection No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Direct Debit Collection No.';
            TableRelation = "Direct Debit Collection";
        }
        field(2; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(11; "Mandate ID"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Mandate ID';
        }
    }

    keys
    {
        key(Key1; "Direct Debit Collection No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

