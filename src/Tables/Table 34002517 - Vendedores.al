table 55911 Vendedores
{

    fields
    {
        field(55894; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(55895; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            Description = 'DsPOS Standar';
        }
        field(55896; Nombre; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
            Description = 'DsPOS Standar';
        }
    }

    keys
    {
        key(Key1; Tienda, Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Tienda, Codigo, Nombre)
        {
        }
    }

    trigger OnInsert()
    begin

        TESTFIELD(Tienda);
        TESTFIELD(Codigo);
        TESTFIELD(Nombre);
    end;
}

