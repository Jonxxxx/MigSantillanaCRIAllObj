table 34002536 "Dimensiones  POS"
{
    // #217374, RRT, 10.09.2019: Se aprovecha este desarrollo pra renumerar esta tabla en el rango DS-POS.

    Caption = 'Dimensiones POS';

    fields
    {
        field(10;Dimension;Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(20;"Valor dimension";Code[10])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=FIELD(Dimension));
        }
    }

    keys
    {
        key(Key1;Dimension)
        {
        }
    }

    fieldgroups
    {
    }
}

