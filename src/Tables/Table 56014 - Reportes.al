table 55239 Reportes
{

    fields
    {
        field(1; "No. Mov."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov.';
        }
        field(2; "Tipo Mov."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Mov.';
        }
        field(3; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(4; PVP; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP';
        }
        field(5; "Precio Liquido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio Liquido';
        }
        field(6; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(7; "No. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Producto';
            TableRelation = Item;
        }
        field(8; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
    }

    keys
    {
        key(Key1; "No. Mov.")
        {
        }
        key(Key2; "No. Producto", "Tipo Mov.", "Fecha Registro", PVP, "Precio Liquido")
        {
        }
        key(Key3; "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

