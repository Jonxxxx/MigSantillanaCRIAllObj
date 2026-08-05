table 55802 Shift
{
    DrillDownPageID = 55818;
    LookupPageID = 55818;

    fields
    {
        field(1; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Hora Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio';
        }
        field(4; "Hora Fin"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }
}

