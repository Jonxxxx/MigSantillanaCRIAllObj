table 55010 "Valores dimension TMP"
{

    fields
    {
        field(1; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; nombre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'nombre';
        }
        field(3; identar; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'identar';
        }
        field(4; "Tipo Valor Dimension"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Valor Dimension';
        }
        field(5; sumatorio; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'sumatorio';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

