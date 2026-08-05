table 55243 "Cab. Ident. Devoluci n Reg."
{

    fields
    {
        field(1; "No. Ident. Devolucion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Ident. Devolucion';
        }
        field(2; "Id. Usuario"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id. Usuario';
        }
        field(3; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;
        }
        field(4; "Nombre Cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(5; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Bultos';
        }
        field(6; Comentarios; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
        }
        field(7; "Fecha Recepcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Recepcion';
        }
        field(8; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(9; "Agencia Transporte"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Agencia Transporte';
        }
        field(10; "Tipo de Producto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Producto';
            OptionCaption = ' ,Text,Not Text,Mixed';
            OptionMembers = " ",Texto,"No Texto",Mixta;
        }
        field(11; Ubicacion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion';
        }
        field(12; Almacen; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen';
        }
        field(13; Procesada; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesada';
        }
    }

    keys
    {
        key(Key1; "No. Ident. Devolucion")
        {
        }
    }

    fieldgroups
    {
    }
}

