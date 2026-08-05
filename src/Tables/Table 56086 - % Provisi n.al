table 55306 "% Provision"
{
    // 001 CAT 20/02/14  #144 Configuraci n de los porcentajes de insolvencias


    fields
    {
        field(1; "Desde dia"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Desde dia';
        }
        field(2; "Descripcion"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "% Provision"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Provision';
        }
        field(4; "Importe Provision"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Provision';
        }
    }

    keys
    {
        key(Key1; "Desde dia")
        {
        }
    }

    fieldgroups
    {
    }
}

