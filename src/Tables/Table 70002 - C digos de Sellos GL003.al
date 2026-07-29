table 70002 "Codigos de Sellos GL003"
{

    fields
    {
        field(1; "Codigo Sello"; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Sello';
        }
        field(2; "Descripcion Sello"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Sello';
        }
    }

    keys
    {
        key(Key1; "Codigo Sello")
        {
        }
    }

    fieldgroups
    {
    }
}

