table 55100 "Cab. Venta NopCommerce"
{
    //  Proyecto: Implementacion Microsoft Dynamics Nav
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.        Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001     02-10-2023      LDP      SANTINAV-4272, se agrandala longitud del campo "No. Telefono"


    fields
    {
        field(1; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(2; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;
        }
        field(3; "Fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(4; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
        }
        field(5; "Cod. Divisa"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Divisa';
        }
        field(6; "Tasa de cambio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tasa de cambio';
        }
        field(7; Procesado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesado';
        }
        field(8; "Tipo Documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
        }
        field(9; "Cod. Direccion de envio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Direccion de envio';
        }
        field(10; "No. Factura NCr"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Factura NCr';
        }
        field(11; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(12; Ship_date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ship_date';
        }
        field(13; "Comentario Svr Cte"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario Svr Cte';
        }
        field(14; "Comentario CC"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario CC';
        }
        field(15; "Comentario Alm"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario Alm';
        }
        field(16; "No. documento NAV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento NAV';
        }
        field(17; "Pedido via telefonica"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pedido via telefonica';
        }
        field(55229; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cupon';
        }
        field(55230; "Tipo Comprobante"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Comprobante';
            OptionMembers = Consumidor,"Credito Fiscal",Gubernamental;
        }
        field(55231; Nombre; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(55232; "RNC/Cedula"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC/Cedula';
        }
        field(55233; Delivery; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery';
        }
        field(55234; "Importe Delivery"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Delivery';
        }
        field(55235; "No. Telefono"; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Telefono';
        }
        field(55236; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
        }
        field(55237; "Metodo de Envio Ecommerce"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Metodo de Envio Ecommerce';
            Description = 'SANTINAV-1940';
        }
        field(55238; "Direccion 1"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion 1';
            Description = 'SANTINAV-2130';
        }
        field(55239; "Direccion 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion 2';
            Description = 'SANTINAV-2130';
        }
        field(55240; Error; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Error';
            Description = 'SANTINAV-2130';
        }
    }

    keys
    {
        key(Key1; "No. documento", "Cod. Cliente")
        {
        }
    }

    fieldgroups
    {
    }
}

