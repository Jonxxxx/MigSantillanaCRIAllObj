table 50016 "Abonos - Facturas afectadas"
{

    fields
    {
        field(1;"No. Abono";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Abono';
        }
        field(2;"Fecha Abono";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Abono';
        }
        field(3;"No factura";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No factura';
        }
        field(4;"Fecha Factura";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Factura';
        }
        field(5;"No. Doc. Ext Abono";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Doc. Ext Abono';
        }
        field(6;"Importe Abono";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Abono';
        }
        field(7;"Importe Factura";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Factura';
        }
    }

    keys
    {
        key(Key1;"No. Abono","No factura")
        {
        }
    }

    fieldgroups
    {
    }
}

