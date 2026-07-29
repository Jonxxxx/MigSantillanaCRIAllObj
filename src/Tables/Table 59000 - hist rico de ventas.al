table 59000 "hist rico de ventas"
{

    fields
    {
        field(1; "Tipo Factura"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Factura';
        }
        field(2; "Cliente Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente Santillana';
        }
        field(3; "Destinatario Santillana"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Destinatario Santillana';
        }
        field(4; "Orden de compra del cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Orden de compra del cliente';
        }
        field(5; "Fecha Factura"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Factura';
        }
        field(6; "N  legal comprobante"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N  legal comprobante';
        }
        field(7; Moneda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Moneda';
        }
        field(8; "Codigo Material Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Material Santillana';
        }
        field(9; ISBN; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ISBN';
        }
        field(10; "P.V.P."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'P.V.P.';
        }
        field(11; Descuento; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento';
        }
        field(12; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(13; NoDoc; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NoDoc';
        }
        field(14; NoLin; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'NoLin';
        }
    }

    keys
    {
        key(Key1; NoDoc, NoLin)
        {
        }
    }

    fieldgroups
    {
    }
}

