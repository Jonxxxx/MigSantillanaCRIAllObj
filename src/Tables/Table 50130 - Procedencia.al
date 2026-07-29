table 50130 Procedencia
{
    //IGNORAR: Page no existe DrillDownPageID = 50031;
    //IGNORAR: Page no existe LookupPageID = 50031;

    fields
    {
        field(1; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Text[30])
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

