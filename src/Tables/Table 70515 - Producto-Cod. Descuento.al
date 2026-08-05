table 55680 "Producto-Cod. Descuento"
{

    fields
    {
        field(1; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
        }
        field(2; "Cod. Descuento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Descuento';
        }
    }

    keys
    {
        key(Key1; "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }
}

