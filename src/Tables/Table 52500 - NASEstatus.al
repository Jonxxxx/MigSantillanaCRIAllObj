table 55199 NASEstatus
{

    fields
    {
        field(1; Status; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Error; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Error';
        }
    }

    keys
    {
        key(Key1; Status, Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

