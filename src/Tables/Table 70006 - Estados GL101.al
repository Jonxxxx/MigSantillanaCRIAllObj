table 55659 "Estados GL101"
{

    fields
    {
        field(1; "Codigo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Text[40])
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

