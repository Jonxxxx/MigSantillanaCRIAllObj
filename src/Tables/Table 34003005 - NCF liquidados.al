table 34003005 "NCF liquidados"
{

    fields
    {
        field(1;NCF;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF';
        }
        field(2;Importe;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
    }

    keys
    {
        key(Key1;NCF)
        {
        }
        key(Key2;Importe)
        {
        }
    }

    fieldgroups
    {
    }
}

