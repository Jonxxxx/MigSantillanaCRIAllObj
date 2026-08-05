table 55560 "Atenciones -Dis. Centros Costo"
{

    fields
    {
        field(1; "No. Atencion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Atencion';
        }
        field(2; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            Editable = false;
        }
        field(3; "Descripcion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Editable = false;
        }
        field(4; Porcentaje; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porcentaje';
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

