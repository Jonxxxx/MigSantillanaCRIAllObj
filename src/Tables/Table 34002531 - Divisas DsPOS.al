table 34002531 "Divisas DsPOS"
{

    fields
    {
        field(1;Tienda;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas;
        }
        field(2;TPV;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TPV';
            Description = 'DsPOS Standar';
            TableRelation = "Configuracion TPV";
        }
        field(10;Divisa;Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Divisa';
            Description = 'DsPOS Standar';
            TableRelation = Currency;
        }
        field(20;Descripcion;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
        }
        field(30;"Tipo Cambio";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cambio';
            Description = 'DsPOS Standar';
        }
        field(40;"Fecha Valor";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Valor';
            Description = 'DsPOS Standar';
        }
    }

    keys
    {
        key(Key1;Tienda,TPV,Divisa)
        {
        }
    }

    fieldgroups
    {
    }
}

