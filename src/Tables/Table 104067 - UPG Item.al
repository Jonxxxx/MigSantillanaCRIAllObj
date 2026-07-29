table 104067 "UPG Item"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(92; Picture; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(5702; "Item Category Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(5704; "Product Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
        field(7382; "Next Counting Period"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Next Counting Period';
            Editable = false;
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

