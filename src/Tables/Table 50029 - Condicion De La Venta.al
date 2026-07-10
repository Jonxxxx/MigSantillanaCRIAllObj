table 50029 "Condicion De La Venta"
{

    fields
    {
        field(1;Codigo;Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Condicion de la Venta";Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Inactivo;Boolean)
        {
            DataClassification = ToBeClassified;
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

