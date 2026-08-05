table 55748 "Parametros Calculo Dias"
{
    Caption = 'Days Calculation Parameter';
    DataPerCompany = false;
    //IGNORAR: Page no existe DrillDownPageID = 55790;
    //IGNORAR: Page no existe LookupPageID = 55790;

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

