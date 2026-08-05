table 55729 "UPG Product Group"
{

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(2; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7300; "Warehouse Class Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Warehouse Class Code';
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

