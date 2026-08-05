table 55692 "Precios Futuro"
{

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
            AutoIncrement = true;
            Editable = false;
        }
        field(10; Producto; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Producto';
            TableRelation = Item;
        }
        field(11; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(12; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = Inicio,Fin;
        }
        field(20; PricePos; RecordID)
        {
            DataClassification = CustomerContent;
            Caption = 'PricePos';
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
        key(Key2; Fecha, Producto)
        {
        }
        key(Key3; Producto, Fecha)
        {
        }
    }

    fieldgroups
    {
    }
}

