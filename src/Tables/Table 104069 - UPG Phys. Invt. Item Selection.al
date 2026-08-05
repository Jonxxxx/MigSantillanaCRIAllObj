table 55727 "UPG Phys. Invt. Item Selection"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            Editable = false;
        }
        field(2; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            Editable = false;
        }
        field(3; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            Editable = false;
        }
        field(5; "Shelf No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shelf No.';
            Editable = false;
        }
        field(6; "Phys Invt Counting Period Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Phys Invt Counting Period Code';
            Editable = false;
        }
        field(7; "Last Counting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Counting Date';
            Editable = false;
        }
        field(8; "Next Counting Period"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Next Counting Period';
            Editable = false;
        }
        field(9; "Count Frequency per Year"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Count Frequency per Year';
            BlankZero = true;
            Editable = false;
            MinValue = 0;
        }
        field(10; Selected; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Selected';
        }
        field(11; "Phys Invt Counting Period Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Phys Invt Counting Period Type';
            OptionMembers = " ",Item,SKU;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Location Code", "Phys Invt Counting Period Code")
        {
        }
    }

    fieldgroups
    {
    }
}

