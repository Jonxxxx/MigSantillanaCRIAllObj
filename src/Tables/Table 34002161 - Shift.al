table 34002161 Shift
{
    //TODO: Ver DrillDownPageID = 34002177;
    //TODO: Ver LookupPageID = 34002177;

    fields
    {
        field(1; Codigo; Code[10])
        {
        }
        field(2; Descripcion; Text[30])
        {
        }
        field(3; "Hora Inicio"; Time)
        {
        }
        field(4; "Hora Fin"; Time)
        {
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

