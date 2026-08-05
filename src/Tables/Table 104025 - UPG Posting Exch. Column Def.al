table 55718 "UPG Posting Exch. Column Def"
{
    Caption = 'Posting Exch. Column Def';

    fields
    {
        field(1; "Posting Exch. Def Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Exch. Def Code';
        }
        field(2; "Column No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Column No.';
        }
        field(9; Multiplier; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Multiplier';
        }
        field(10; "Posting Exch. Line Def Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Exch. Line Def Code';
        }
    }

    keys
    {
        key(Key1; "Posting Exch. Def Code", "Posting Exch. Line Def Code", "Column No.")
        {
        }
    }

    fieldgroups
    {
    }
}

