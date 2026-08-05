table 55015 "Razones anulacion factura"
{
    //IGNORAR: Page no existe DrillDownPageID = 55015;
    //IGNORAR: Page no existe LookupPageID = 55015;

    fields
    {
        field(1; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            NotBlank = true;
        }
        field(2; Descripcion; Text[250])
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
    }
}

