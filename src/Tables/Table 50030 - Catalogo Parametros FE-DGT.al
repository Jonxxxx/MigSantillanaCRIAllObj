table 55030 "Catalogo Parametros FE-DGT"
{

    fields
    {
        field(1; "Tipo Parametro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Parametro';
            OptionCaption = ' ,Descuentos,Condicion Venta,Tipo Medio Pago,Tipo Impuesto';
            OptionMembers = " ",Descuentos,"Condicion Venta","Tipo Medio Pago","Tipo Impuesto";
        }
        field(2; Codigo; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; Inactivo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inactivo';
        }
        field(5; "Descuento Asumido Fabrica"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento Asumido Fabrica';
        }
    }

    keys
    {
        key(Key1; "Tipo Parametro", Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

