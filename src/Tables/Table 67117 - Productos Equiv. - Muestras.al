table 67117 "Productos Equiv. - Muestras"
{

    fields
    {
        field(1;"Cod. Producto";Code[20])
        {
            TableRelation = Item;
        }
        field(2;"Cod. Producto Docente";Code[20])
        {
            TableRelation = Item;
        }
        field(3;"Nombre Producto";Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE (No.=FIELD(Cod. Producto)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4;"Nombre Producto Docente";Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE (No.=FIELD(Cod. Producto Docente)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cod. Producto","Cod. Producto Docente")
        {
        }
    }

    fieldgroups
    {
    }
}

