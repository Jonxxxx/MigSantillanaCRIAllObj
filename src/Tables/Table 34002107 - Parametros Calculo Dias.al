table 34002107 "Parametros Calculo Dias"
{
    Caption = 'Days Calculation Parameter';
    DataPerCompany = false;
    //IGNORAR: Page no existe DrillDownPageID = 34002149;
    //IGNORAR: Page no existe LookupPageID = 34002149;

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
        field(3; Valor; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
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

