table 104067 "UPG Item"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(92; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(5702; "Item Category Code"; Code[10])
        {
        }
        field(5704; "Product Group Code"; Code[10])
        {
        }
        field(7382; "Next Counting Period"; Text[250])
        {
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

