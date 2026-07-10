table 56036 "Puestos de Pcking"
{
    Caption = 'Packing Position';
    LookupPageID = 56042;

    fields
    {
        field(1;Codigo;Code[20])
        {
            Caption = 'Code';
        }
        field(2;"Control Peso";Boolean)
        {
            Caption = 'Weight Control';
        }
        field(3;"Usuario Asignado";Code[20])
        {
            Caption = 'Assigned User';
            TableRelation = User;
        }
        field(4;Descripcion;Text[200])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

