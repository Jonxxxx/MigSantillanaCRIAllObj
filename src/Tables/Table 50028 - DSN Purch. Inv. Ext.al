table 50028 "DSN Purch. Inv. Ext"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'No.';
        }
        field(2;"Buy-from Vendor No.";Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(79;"Buy-from Vendor Name";Text[100])
        {
            Caption = 'Buy-from Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(52500;Clave;Text[60])
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
        }
        field(52501;Consecutivo;Text[20])
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
        }
        field(52502;Estado;Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
        }
        field(52503;Mensaje;Text[150])
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
        }
        field(52504;"Fecha Doc Electronico";DateTime)
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
        }
        field(52505;"E-Mail-FE";Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
            ExtendedDatatype = EMail;
        }
        field(52506;"Tipo Doc Electronico";Option)
        {
            Caption = 'Tipo Documento Electronico';
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
            OptionMembers = Factura,Tiquete;
        }
        field(52507;"QR Code FE";BLOB)
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
            SubType = UserDefined;
        }
        field(52508;"Tipo Doc. Ref.";Option)
        {
            Caption = 'Tipo Doc. Ref.';
            DataClassification = ToBeClassified;
            Description = '#FE-CR1.02';
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante,Comprobante de Proveedor No Domiciliado';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante","Comprobante de Proveedor No Domiciliado";
        }
        field(52509;"Numero Referencia FE";Code[25])
        {
            Caption = 'Numero Referencia FE';
            DataClassification = ToBeClassified;
            Description = '#FE-CR1.02';
        }
        field(52510;"Tipo Doc. Ref NC";Option)
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR1.02';
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }
        field(52511;"Codigo Referencia";Option)
        {
            DataClassification = ToBeClassified;
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

