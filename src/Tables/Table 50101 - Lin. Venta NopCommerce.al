table 50101 "Lin. Venta NopCommerce"
{

    fields
    {
        field(1;"No. documento";Code[20])
        {
        }
        field(2;"Cod. producto";Code[20])
        {
        }
        field(3;"No. Linea";Integer)
        {
        }
        field(4;Cantidad;Decimal)
        {
        }
        field(5;"Precio de venta";Decimal)
        {
        }
        field(6;"Importe descuento";Decimal)
        {
        }
        field(7;"Unidad de medida";Code[20])
        {
        }
        field(100;Oferta;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No. documento","No. Linea")
        {
        }
    }

    fieldgroups
    {
    }
}

