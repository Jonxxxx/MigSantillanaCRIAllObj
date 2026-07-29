table 34002137 "Distribucion Importes TSS"
{

    fields
    {
        field(1; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
        }
        field(2; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales";
        }
        field(3; "No. orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. orden';
            AutoIncrement = true;
            Editable = false;
        }
        field(4; "Importe Maximo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Maximo';
            DecimalPlaces = 2 : 2;
        }
        field(5; "Importe retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe retencion';
            DecimalPlaces = 2 : 2;
        }
        field(6; "% Retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Retencion';
            DecimalPlaces = 2 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; Ano, "Concepto Salarial", "No. orden")
        {
        }
    }

    fieldgroups
    {
    }
}

