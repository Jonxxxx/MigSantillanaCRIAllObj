table 59001 "tmp ctas"
{

    fields
    {
        field(1;Codigo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;Entrada;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entrada';
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

