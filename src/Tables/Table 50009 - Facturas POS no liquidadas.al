table 50009 "Facturas POS no liquidadas"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2;"Fecha registro";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(10;"Importe total";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe total';
        }
        field(11;"Importe Pendiente";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente';
        }
        field(12;Diferencia;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Diferencia';
        }
        field(13;"No. registrado antes";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. registrado antes';
        }
        field(14;Procesado;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesado';
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

