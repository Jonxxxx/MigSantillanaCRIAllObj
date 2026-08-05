table 55716 "Tmp facturas a liquidar"
{

    fields
    {
        field(10; "No. factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. factura';
        }
        field(20; "No. producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. producto';
        }
        field(30; "Cantidad liquidable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad liquidable';
        }
        field(40; "No. linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. linea';
        }
        field(50; "No. mov. producto"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. mov. producto';
        }
        field(60; Pendiente; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pendiente';
        }
    }

    keys
    {
        key(Key1; "No. factura", "No. linea", "No. producto")
        {
        }
    }

    fieldgroups
    {
    }
}

