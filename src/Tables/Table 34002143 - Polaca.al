table 34002143 Polaca
{

    fields
    {
        field(1;Formula;Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula';
        }
        field(2;Puntero;Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Puntero';
        }
        field(3;Token;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Token';
        }
    }

    keys
    {
        key(Key1;Formula,Puntero)
        {
        }
    }

    fieldgroups
    {
    }
}

