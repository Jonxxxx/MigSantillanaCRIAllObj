table 67104 "Visitas A/C-Dis. Centros Costo"
{

    fields
    {
        field(1; "No. Visita Consultor/Asesor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Visita Consultor/Asesor';
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
        key(Key1; "No. Visita Consultor/Asesor", "Codigo")
        {
        }
    }

    fieldgroups
    {
    }
}

