table 55828 "Parametros vacaciones"
{
    Caption = 'Vacation parameters';
    DataPerCompany = false;

    fields
    {
        field(1; Desde; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Desde';
        }
        field(2; "Cantidad de dias"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de dias';
        }
    }

    keys
    {
        key(Key1; Desde)
        {
        }
    }

    fieldgroups
    {
    }
}

