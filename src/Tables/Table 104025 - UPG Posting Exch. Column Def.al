table 104025 "UPG Posting Exch. Column Def"
{
    Caption = 'Posting Exch. Column Def';

    fields
    {
        field(1;"Posting Exch. Def Code";Code[20])
        {
        }
        field(2;"Column No.";Integer)
        {
        }
        field(9;Multiplier;Decimal)
        {
        }
        field(10;"Posting Exch. Line Def Code";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Posting Exch. Def Code","Posting Exch. Line Def Code","Column No.")
        {
        }
    }

    fieldgroups
    {
    }
}

