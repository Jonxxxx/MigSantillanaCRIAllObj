table 56053 "Order Tracking buffer"
{
    // --------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // --------------------------------------------------------------------------
    // #117    21-10-2013      PLB           Tabla para el seguimiento de pedidos
    // #50366  13-05-2016      JMB           Se a ade el campo "Reference"

    Caption = 'Order Tracking buffer';

    fields
    {
        field(1;"Entry no.";Integer)
        {
            Caption = 'Entry no.';
        }
        field(2;"Table ID";Integer)
        {
            Caption = 'Table ID';
        }
        field(3;"Table Name";Text[80])
        {
            Caption = 'Table Name';
        }
        field(4;Indentation;Integer)
        {
            Caption = 'Ident';
        }
        field(5;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(6;Reference;Code[20])
        {
            Caption = 'Referencia';
            Description = '#50366';
        }
    }

    keys
    {
        key(Key1;"Entry no.")
        {
        }
    }

    fieldgroups
    {
    }
}

