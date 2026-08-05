table 55576 "Productos Equiv. - Muestras"
{

    fields
    {
        field(1; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;
        }
        field(2; "Cod. Producto Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto Docente';
            TableRelation = Item;
        }
        field(3; "Nombre Producto"; Text[100])
        {
            Caption = 'Nombre Producto';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Nombre Producto Docente"; Text[100])
        {
            Caption = 'Nombre Producto Docente';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto Docente")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Producto", "Cod. Producto Docente")
        {
        }
    }

    fieldgroups
    {
    }
}

