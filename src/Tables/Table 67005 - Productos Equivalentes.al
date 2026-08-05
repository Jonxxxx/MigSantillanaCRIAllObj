table 55472 "Productos Equivalentes"
{

    fields
    {
        field(1; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            TableRelation = Item;
        }
        field(2; "Cod. Producto Anterior"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto Anterior';
            TableRelation = Item;
        }
        field(3; "Nombre Producto"; Text[100])
        {
            Caption = 'Nombre Producto';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Nombre Producto Anterior"; Text[100])
        {
            Caption = 'Nombre Producto Anterior';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto Anterior")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Cod. Producto Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto Docente';
            TableRelation = Item;
        }
        field(6; "Nombre Producto Docenter"; Text[100])
        {
            Caption = 'Nombre Producto Docenter';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto Docente")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }
}

