table 50800 Prueba
{

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Codigo 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo 2';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
        key(Key2; "Codigo 2")
        {
        }
    }

    fieldgroups
    {
    }
}

