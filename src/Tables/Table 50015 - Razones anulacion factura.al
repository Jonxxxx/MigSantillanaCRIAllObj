table 50015 "Razones anulacion factura"
{
    //IGNORAR: Page no existe DrillDownPageID = 50015;
    //IGNORAR: Page no existe LookupPageID = 50015;

    fields
    {
        field(1; Codigo; Code[10])
        {
            NotBlank = true;
        }
        field(2; Descripcion; Text[250])
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
    }
}

