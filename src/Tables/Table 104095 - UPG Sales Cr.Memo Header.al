table 104095 "UPG Sales Cr.Memo Header"
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
        field(1300;Canceled;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Canceled';
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

