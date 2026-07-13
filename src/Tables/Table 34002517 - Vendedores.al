table 34002517 Vendedores
{

    fields
    {
        field(34002500;Tienda;Code[20])
        {
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(34002501;Codigo;Code[10])
        {
            Description = 'DsPOS Standar';
        }
        field(34002502;Nombre;Text[50])
        {
            Description = 'DsPOS Standar';
        }
    }

    keys
    {
        key(Key1;Tienda,Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;Tienda,Codigo,Nombre)
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

