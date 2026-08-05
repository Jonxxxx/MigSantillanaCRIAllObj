table 55964 "Clasificacion Gastos"
{
    Caption = 'Expenses Clasification';
    DataPerCompany = false;
    DrillDownPageID = 55964;
    LookupPageID = 55964;

    fields
    {
        field(1; Codigo; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            NotBlank = true;
        }
        field(2; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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

