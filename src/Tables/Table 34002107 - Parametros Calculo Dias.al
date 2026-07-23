table 34002107 "Parametros Calculo Dias"
{
    Caption = 'Days Calculation Parameter';
    DataPerCompany = false;
    //TODO: Page no existe DrillDownPageID = 34002149;
    //TODO: Page no existe LookupPageID = 34002149;

    fields
    {
        field(1; Codigo; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Descripcion; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Valor; Decimal)
        {
            Caption = 'Value';
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
        fieldgroup(DropDown; Codigo, Descripcion, Valor)
        {
        }
    }
}

