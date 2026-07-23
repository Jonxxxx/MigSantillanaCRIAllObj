table 50114 "Config. Caja Electronica"
{

    fields
    {
        field(1; Sucursal; Code[4])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Caja ID"; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(4; Pais; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Situacion; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cod. Seguridad"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Serie Factura"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Serie Nota de credito"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Primer Factura"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Referencia Factura"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Referencia Nota de credito"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Tienda POS"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Emisor; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; LenRandonSeguridad; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Primer Nota de credito"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Referencia Sucursal"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Cliente Defecto"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "mac address"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Tienda ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(20; TPV; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Configuracion TPV"."Id TPV";
        }
        field(21; "Secuencia electronica"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Secuencia electronica CR"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Cliente SIC"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LDP:SIC-JERM';
            TableRelation = Customer."No_ Cliente SIC";
        }
        field(25; "No. Serie Pedido"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LDP:SIC-JERM';
            TableRelation = "No. Series".Code;
        }
        field(26; "No. Serie Registro Nota C."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LDP:SIC-JERM';
            TableRelation = "No. Series".Code;
        }
        field(27; "No. Serie Registro Factura Pos"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LDP:SIC-JERM';
        }
        field(28; "No. Serie Nota Credito Pos"; Code[20])
        {
            DataClassification = ToBeClassified;
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

