table 55772 "Tabla retencion ISR"
{
    DataPerCompany = false;
    LookupPageID = 55800;

    fields
    {
        field(1; Ano; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
        }
        field(2; "No. orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. orden';
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Importe Maximo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Maximo';
            DecimalPlaces = 2 : 2;
        }
        field(4; "Importe retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe retencion';
            DecimalPlaces = 2 : 2;
        }
        field(5; "% Retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Retencion';
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; Ano, "No. orden")
        {
        }
        key(Key2; Ano, "Importe Maximo")
        {
        }
    }

    fieldgroups
    {
    }
}

