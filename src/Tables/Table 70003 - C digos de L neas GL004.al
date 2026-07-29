table 70003 "Codigos de L neas GL004"
{

    fields
    {
        field(1; "Codigo L nea"; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo L nea';
            Description = '(3 Primeros d gitos, corresponden al Sello)';
        }
        field(2; "Descripcion L nea"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion L nea';
        }
    }

    keys
    {
        key(Key1; "Codigo L nea")
        {
        }
    }

    fieldgroups
    {
    }
}

