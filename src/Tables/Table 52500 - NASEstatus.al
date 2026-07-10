table 52500 NASEstatus
{

    fields
    {
        field(1;Status;Text[200])
        {
        }
        field(2;Codigo;Code[20])
        {
        }
        field(3;Error;Text[200])
        {
        }
    }

    keys
    {
        key(Key1;Status,Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

