table 56000 "Config. Usuarios Empresa"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(2; "Allow to mod. Sales Price Docs"; Boolean)
        {
            Caption = 'Allow to mod. Sales Price in Documents';
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

