table 34002131 "Tabla retencion ISR"
{
    DataPerCompany = false;
    //TODO: Ver LookupPageID = 34002159;

    fields
    {
        field(1; Ano; Code[4])
        {
        }
        field(2; "No. orden"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Importe Máximo"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(4; "Importe retencion"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(5; "% Retencion"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; Ano, "No. orden")
        {
        }
        key(Key2; Ano, "Importe Máximo")
        {
        }
    }

    fieldgroups
    {
    }
}

