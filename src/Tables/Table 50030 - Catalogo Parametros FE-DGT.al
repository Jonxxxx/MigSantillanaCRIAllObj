table 50030 "Catalogo Parametros FE-DGT"
{

    fields
    {
        field(1;"Tipo Parametro";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Descuentos,Condicion Venta,Tipo Medio Pago,Tipo Impuesto';
            OptionMembers = " ",Descuentos,"Condicion Venta","Tipo Medio Pago","Tipo Impuesto";
        }
        field(2;Codigo;Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Descripcion;Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Inactivo;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Descuento Asumido Fabrica";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Tipo Parametro",Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

