table 70508 MCliente03
{

    fields
    {
        field(1;Cliente;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente';
        }
        field(2;Descuento;Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento';
        }
        field(3;Sello;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sello';
        }
        field(4;"Cod. Descuento Producto";Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Descuento Producto';
        }
        field(5;Coleccion;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Coleccion';
        }
        field(6;"Fecha Ini Validez";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ini Validez';
        }
        field(7;"Fecha Fin Validez";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Fin Validez';
        }
        field(13;"Tipo Venta";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Venta';
            OptionCaption = 'Customer,Customer Disc. Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Disc. Group","All Customers",Campaign;
        }
    }

    keys
    {
        key(Key1;Cliente)
        {
        }
    }

    fieldgroups
    {
    }
}

