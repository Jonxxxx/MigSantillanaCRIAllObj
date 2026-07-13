table 34003009 "Clasificacion Gastos"
{
    Caption = 'Expenses Clasification';
    DataPerCompany = false;
    //TODO: Ver DrillDownPageID = 34003009;
    //TODO: Ver LookupPageID = 34003009;

    fields
    {
        field(1; Codigo; Code[2])
        {
            NotBlank = true;
        }
        field(2; Descripcion; Text[50])
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

