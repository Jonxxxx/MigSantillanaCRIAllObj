table 104094 "UPG Sales Invoice Header"
{

    fields
    {
        field(3;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(827;"Credit Card No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Card No.';
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

