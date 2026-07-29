table 67108 "Log Importaci n"
{

    fields
    {
        field(1;Usuario;Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
        field(4;Secuencia;Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(5;Descripcion;Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1;Usuario,Secuencia)
        {
        }
    }

    fieldgroups
    {
    }
}

