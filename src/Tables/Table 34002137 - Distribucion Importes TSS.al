table 34002137 "Distribucion Importes TSS"
{

    fields
    {
        field(1;Ano;Integer)
        {
        }
        field(2;"Concepto Salarial";Code[20])
        {
            TableRelation = "Conceptos salariales";
        }
        field(3;"No. orden";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(4;"Importe Máximo";Decimal)
        {
            DecimalPlaces = 2:2;
        }
        field(5;"Importe retención";Decimal)
        {
            DecimalPlaces = 2:2;
        }
        field(6;"% Retención";Decimal)
        {
            DecimalPlaces = 2:2;
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;Ano,"Concepto Salarial","No. orden")
        {
        }
    }

    fieldgroups
    {
    }
}

