table 34003053 "_Dimensiones POS"
{
    // #217374, RRT, 10.09.19: Se aprovecha este desarrollo para renumerar esta tabla.

    Caption = 'Dimensiones POS';

    fields
    {
        field(10; Dimension; Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(20; "Valor dimension"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension"));
        }
    }

    keys
    {
        key(Key1; Dimension)
        {
        }
    }

    fieldgroups
    {
    }
}

