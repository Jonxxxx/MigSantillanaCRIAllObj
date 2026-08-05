table 55663 "Relacion Material Ambito"
{

    fields
    {
        field(1; "Codigo Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Santillana';
        }
        field(2; "Codigo Ambito"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Ambito';
        }
    }

    keys
    {
        key(Key1; "Codigo Santillana")
        {
        }
    }

    fieldgroups
    {
    }
}

