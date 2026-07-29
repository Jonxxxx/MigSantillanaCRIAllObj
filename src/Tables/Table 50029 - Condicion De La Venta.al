table 50029 "Condicion De La Venta"
{

    fields
    {
        field(1;Codigo;Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;"Condicion de la Venta";Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Condicion de la Venta';
        }
        field(3;Inactivo;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inactivo';
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

