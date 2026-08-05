table 55785 "Conceptos formula"
{
    Caption = 'Wedge formulation';

    fields
    {
        field(1; Concepto; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto';
        }
        field(2; Formula; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula';
        }
        field(3; Valor; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; Concepto)
        {
        }
    }

    fieldgroups
    {
    }
}

