table 55249 "Inventario Disp. Movil."
{

    fields
    {
        field(1; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;
        }
        field(2; Descripcion; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Cod. Almancen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Almancen';
            TableRelation = Location;
        }
        field(4; Inventario; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventario';
        }
        field(5; "Fecha Ult. Actualizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ult. Actualizacion';
        }
        field(6; "Linea de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de Negocio';
        }
        field(7; "Cod. Categoria Producto"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Categoria Producto';
        }
        field(8; "Nombre Categoria Producto"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Categoria Producto';
        }
    }

    keys
    {
        key(Key1; "Cod. Producto", "Cod. Almancen")
        {
        }
    }

    fieldgroups
    {
    }
}

