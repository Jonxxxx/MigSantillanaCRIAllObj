table 50500 "Ubicaciones que no existen"
{

    fields
    {
        field(1;"Cod. Ubicacion";Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Ubicacion';
        }
        field(2;"Cod. Almacen";Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Almacen';
        }
    }

    keys
    {
        key(Key1;"Cod. Ubicacion","Cod. Almacen")
        {
        }
    }

    fieldgroups
    {
    }
}

