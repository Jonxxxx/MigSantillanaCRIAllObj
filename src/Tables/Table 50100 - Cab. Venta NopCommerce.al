table 50100 "Cab. Venta NopCommerce"
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
        }
        field(2; "Cod. Cliente"; Code[20])
        {
            TableRelation = Customer;
        }
        field(3; "Fecha registro"; Date)
        {
        }
        field(4; "Cod. Vendedor"; Code[20])
        {
        }
        field(5; "Cod. Divisa"; Code[20])
        {
        }
        field(6; "Tasa de cambio"; Decimal)
        {
        }
        field(7; Procesado; Boolean)
        {
        }
        field(8; "Tipo Documento"; Integer)
        {
        }
        field(9; "C d. Direcci n de env o"; Code[20])
        {
        }
        field(10; "No. Factura NCr"; Code[20])
        {
        }
        field(11; "Location Code"; Code[20])
        {
        }
        field(12; Ship_date; Date)
        {
        }
        field(13; "Comentario Svr Cte"; Text[80])
        {
        }
        field(14; "Comentario CC"; Text[120])
        {
        }
        field(15; "Comentario Alm"; Text[250])
        {
        }
        field(16; "No. documento NAV"; Code[20])
        {
        }
        field(17; "Pedido v a telef nica"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56004; "Cod. Cupon"; Code[20])
        {
            Caption = 'Coupon Code';
        }
        field(56005; "Tipo Comprobante"; Option)
        {
            OptionMembers = Consumidor,"Credito Fiscal",Gubernamental;
        }
        field(56006; Nombre; Text[200])
        {
        }
        field(56007; "RNC/Cedula"; Text[30])
        {
        }
        field(56008; Delivery; Boolean)
        {
        }
        field(56009; "Importe Delivery"; Decimal)
        {
        }
        field(56010; "No. Telefono"; Text[70])
        {
        }
        field(56011; "E-Mail"; Text[80])
        {
        }
        field(56012; "Metodo de Envio Ecommerce"; Code[80])
        {
            Caption = 'Metodo de Envio Ecommerce';
            Description = 'SANTINAV-1940';
        }
        field(56013; "Direccion 1"; Text[250])
        {
            Caption = 'Direccion 1';
            Description = 'SANTINAV-2130';
        }
        field(56014; "Direccion 2"; Text[250])
        {
            Caption = 'Direccion 2';
            Description = 'SANTINAV-2130';
        }
        field(56015; Error; Boolean)
        {
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

