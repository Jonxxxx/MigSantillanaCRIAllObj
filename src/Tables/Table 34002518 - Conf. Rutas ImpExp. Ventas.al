table 34002518 "Conf. Rutas Imp/Exp. Ventas"
{
    Caption = 'Sales Import Path Setup';

    fields
    {
        field(1;"Cod. Tienda";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Tienda';
            NotBlank = true;
            TableRelation = "Bancos tienda";
        }
        field(2;"Ruta Importa Ventas";Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta Importa Ventas';
        }
        field(3;Direccion;Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion';
            OptionCaption = 'Export,Import';
            OptionMembers = Exporta,Importa;
        }
        field(4;"Cod. Tienda Destino";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Tienda Destino';
            TableRelation = "Bancos tienda";
        }
    }

    keys
    {
        key(Key1;"Cod. Tienda",Direccion)
        {
        }
    }

    fieldgroups
    {
    }
}

