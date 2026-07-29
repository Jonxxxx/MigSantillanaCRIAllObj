table 70514 "Clientes Ofisys"
{

    fields
    {
        field(1;"Cod. Cliente";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
        }
        field(2;"Nombre Cliente";Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(3;"Fecha Ingreso";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ingreso';
        }
        field(4;"Tipo Cliente";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cliente';
        }
        field(5;"Tipo Persona";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Persona';
        }
        field(6;"Tipo Documento Ident.";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento Ident.';
        }
        field(7;"Numero Documento Identidad";Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Documento Identidad';
        }
        field(8;"Numero RUC";Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero RUC';
        }
        field(9;"Condicion Pago";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Condicion Pago';
        }
        field(10;"Porcentaje descuento";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porcentaje descuento';
        }
        field(11;"Codigo Colegio";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Colegio';
        }
        field(12;"Tipo Vendedor";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Vendedor';
        }
        field(13;"Codigo Vendedor";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Vendedor';
        }
        field(14;Situacion;Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Situacion';
        }
        field(15;"Codigo Documento Sunat";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Documento Sunat';
        }
        field(16;"Numero Documento Sunat";Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Documento Sunat';
        }
    }

    keys
    {
        key(Key1;"Cod. Cliente")
        {
        }
    }

    fieldgroups
    {
    }
}

