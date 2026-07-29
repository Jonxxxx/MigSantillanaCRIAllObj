table 64840 "Last SourceCounter Numbers"
{

    fields
    {
        field(1;TableNumber;Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'TableNumber';
        }
        field(2;"Last SourceCounter";BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Last SourceCounter';
        }
    }

    keys
    {
        key(Key1;TableNumber)
        {
        }
    }

    fieldgroups
    {
    }
}

