table 50114 "Config. Caja Electronica"
{

    fields
    {
        field(1; Sucursal; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Sucursal';
        }
        field(2; "Caja ID"; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Caja ID';
        }
        field(3; Location; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location';
            TableRelation = Location;
        }
        field(4; Pais; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Pais';
        }
        field(5; Situacion; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Situacion';
        }
        field(6; "Cod. Seguridad"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Seguridad';
        }
        field(7; "Serie Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Factura';
        }
        field(8; "Serie Nota de credito"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Nota de credito';
        }
        field(9; "Primer Factura"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primer Factura';
        }
        field(10; "Referencia Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Referencia Factura';
        }
        field(11; "Referencia Nota de credito"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Referencia Nota de credito';
        }
        field(12; "Tienda POS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda POS';
        }
        field(13; Emisor; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Emisor';
        }
        field(14; LenRandonSeguridad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'LenRandonSeguridad';
        }
        field(15; "Primer Nota de credito"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primer Nota de credito';
        }
        field(16; "Referencia Sucursal"; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Referencia Sucursal';
        }
        field(17; "Cliente Defecto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente Defecto';
        }
        field(18; "mac address"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'mac address';
        }
        field(19; "Tienda ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda ID';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(20; TPV; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TPV';
            TableRelation = "Configuracion TPV"."Id TPV";
        }
        field(21; "Secuencia electronica"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia electronica';
        }
        field(22; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
        }
        field(23; "Secuencia electronica CR"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia electronica CR';
        }
        field(24; "Cliente SIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente SIC';
            Description = 'LDP:SIC-JERM';
            TableRelation = Customer."No_ Cliente SIC";
        }
        field(25; "No. Serie Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Pedido';
            Description = 'LDP:SIC-JERM';
            TableRelation = "No. Series".Code;
        }
        field(26; "No. Serie Registro Nota C."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Registro Nota C.';
            Description = 'LDP:SIC-JERM';
            TableRelation = "No. Series".Code;
        }
        field(27; "No. Serie Registro Factura Pos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Registro Factura Pos';
            Description = 'LDP:SIC-JERM';
        }
        field(28; "No. Serie Nota Credito Pos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Nota Credito Pos';
            Description = 'LDP:SIC-JERM';
        }
    }

    keys
    {
        key(Key1; "Tienda ID", "Caja ID")
        {
        }
    }

    fieldgroups
    {
    }
}

