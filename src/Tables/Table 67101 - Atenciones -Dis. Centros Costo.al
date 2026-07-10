table 67101 "Atenciones -Dis. Centros Costo"
{

    fields
    {
        field(1;"No. Atenci n";Code[20])
        {
        }
        field(2;"C digo";Code[20])
        {
            Editable = false;
        }
        field(3;"Descripci n";Text[60])
        {
            Editable = false;
        }
        field(4;Porcentaje;Decimal)
        {
            Caption = '%';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;"No. Atenci n","C digo")
        {
        }
    }

    fieldgroups
    {
    }
}

