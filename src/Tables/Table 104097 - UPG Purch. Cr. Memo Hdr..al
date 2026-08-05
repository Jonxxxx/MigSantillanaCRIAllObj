table 55737 "UPG Purch. Cr. Memo Hdr."
{

    fields
    {
        field(3; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(1300; Canceled; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Canceled';
            FieldClass = Normal;
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

