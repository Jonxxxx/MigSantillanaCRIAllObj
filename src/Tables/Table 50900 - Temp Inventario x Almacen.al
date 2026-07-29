table 50900 "Temp Inventario x Almacen"
{

    fields
    {
        field(1;Producto;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Producto';
        }
        field(2;Almacen;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen';
        }
        field(3;Existencias;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Existencias';
        }
        field(4;Consignacion;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consignacion';
        }
        field(5;"Coste unitario";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Coste unitario';
        }
    }

    keys
    {
        key(Key1;Producto,Almacen)
        {
        }
    }

    fieldgroups
    {
    }
}

