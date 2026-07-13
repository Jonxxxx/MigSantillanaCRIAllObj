table 67101 "Atenciones -Dis. Centros Costo"
{

    fields
    {
        field(1; "No. Atencion"; Code[20])
        {
        }
        field(2; "Codigo"; Code[20])
        {
            Editable = false;
        }
        field(3; "Descripcion"; Text[60])
        {
            Editable = false;
        }
        field(4; Porcentaje; Decimal)
        {
            Caption = '%';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "No. Atencion", "Codigo")
        {
        }
    }

    fieldgroups
    {
    }
}

