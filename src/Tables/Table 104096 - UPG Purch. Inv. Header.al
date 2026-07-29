table 104096 "UPG Purch. Inv. Header"
{

    fields
    {
        field(3;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(1300;"Canceled By";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Canceled By';
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }
}

