table 67031 "Carga Horaria"
{
    DrillDownPageID = 67031;
    LookupPageID = 67031;

    fields
    {
        field(1;Codigo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;Descripcion;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3;"Cantidad horas";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad horas';
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

