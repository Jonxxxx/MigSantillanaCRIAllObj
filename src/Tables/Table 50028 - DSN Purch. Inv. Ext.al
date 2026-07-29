table 50028 "DSN Purch. Inv. Ext"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Description = 'No.';
        }
        field(2;"Buy-from Vendor No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Buy-from Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(79;"Buy-from Vendor Name";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Buy-from Vendor Name';
        }
        field(52500;Clave;Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Clave';
            Description = '#FE-CR';
        }
        field(52501;Consecutivo;Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Consecutivo';
            Description = '#FE-CR';
        }
        field(52502;Estado;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            Description = '#FE-CR';
        }
        field(52503;Mensaje;Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Mensaje';
            Description = '#FE-CR';
        }
        field(52504;"Fecha Doc Electronico";DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Doc Electronico';
            Description = '#FE-CR';
        }
        field(52505;"E-Mail-FE";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail-FE';
            Description = '#FE-CR';
            ExtendedDatatype = EMail;
        }
        field(52506;"Tipo Doc Electronico";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Doc Electronico';
            Description = '#FE-CR';
            OptionMembers = Factura,Tiquete;
        }
        field(52507;"QR Code FE";BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'QR Code FE';
            Description = '#FE-CR';
            SubType = UserDefined;
        }
        field(52508;"Tipo Doc. Ref.";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Doc. Ref.';
            Description = '#FE-CR1.02';
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante,Comprobante de Proveedor No Domiciliado';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante","Comprobante de Proveedor No Domiciliado";
        }
        field(52509;"Numero Referencia FE";Code[25])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Referencia FE';
            Description = '#FE-CR1.02';
        }
        field(52510;"Tipo Doc. Ref NC";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Doc. Ref NC';
            Description = '#FE-CR1.02';
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }
        field(52511;"Codigo Referencia";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Referencia';
            Description = '#FE-CR1.02';
            OptionCaption = ' ,Devolucion Total,Devolucion Parcial';
            OptionMembers = " ","Devolucion Total","Devolucion Parcial";
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

