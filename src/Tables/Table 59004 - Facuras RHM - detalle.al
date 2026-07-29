table 59004 "Facuras RHM - detalle"
{

    fields
    {
        field(1;Documento;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Documento';
        }
        field(2;"Fecha registro";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(3;"No. Linea";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(4;"Cod. Producto";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
        }
        field(5;Descripcion;Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(6;Cliente;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente';
        }
        field(7;Nombre;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(8;Cantidad;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(9;"Importe bruto";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe bruto';
        }
    }

    keys
    {
        key(Key1;Documento,"No. Linea")
        {
        }
    }

    fieldgroups
    {
    }
}

