table 55101 "Lin. Venta NopCommerce"
{

    fields
    {
        field(1; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(2; "Cod. producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. producto';
        }
        field(3; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(4; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(5; "Precio de venta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de venta';
        }
        field(6; "Importe descuento"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe descuento';
        }
        field(7; "Unidad de medida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad de medida';
        }
        field(100; Oferta; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Oferta';
        }
    }

    keys
    {
        key(Key1; "No. documento", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }
}

