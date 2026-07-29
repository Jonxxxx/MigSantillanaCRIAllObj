table 70005 "Idiomas GL100"
{

    fields
    {
        field(1; "Codigo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Codigo")
        {
        }
    }

    fieldgroups
    {
    }
}

