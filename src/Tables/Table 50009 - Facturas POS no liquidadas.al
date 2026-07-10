table 50009 "Facturas POS no liquidadas"
{

    fields
    {
        field(1;"No.";Code[20])
        {
        }
        field(2;"Fecha registro";Date)
        {
        }
        field(10;"Importe total";Decimal)
        {
        }
        field(11;"Importe Pendiente";Decimal)
        {
        }
        field(12;Diferencia;Decimal)
        {
        }
        field(13;"No. registrado antes";Code[20])
        {
        }
        field(14;Procesado;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }
}

