table 70008 "Articulos Utilizar en Random"
{

    fields
    {
        field(1;Codigo;Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;ISBN;Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN';
        }
    }

    keys
    {
        key(Key1;Codigo,ISBN)
        {
        }
    }

    fieldgroups
    {
    }
}

