table 70513 "Grupo Precio Cliente"
{

    fields
    {
        field(1;Codigo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;Descripcion;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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

