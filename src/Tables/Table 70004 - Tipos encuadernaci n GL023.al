table 70004 "Tipos Encuadernacion GL023"
{

    fields
    {
        field(1; "Codigo"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            Description = 'Ojo en SAP son 2 posiciones.';
        }
        field(2; "Descripcion"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Codigo")
        {
        }
    }

    fieldgroups
    {
    }
}

