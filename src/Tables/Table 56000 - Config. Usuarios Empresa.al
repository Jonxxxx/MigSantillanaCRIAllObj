table 56000 "Config. Usuarios Empresa"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(2; "Allow to mod. Sales Price Docs"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow to mod. Sales Price Docs';
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

}

