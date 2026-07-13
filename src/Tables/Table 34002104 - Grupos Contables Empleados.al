table 34002104 "Grupos Contables Empleados"
{
    DataCaptionFields = "Código";
    //TODO: Ver DrillDownPageID = 34002140;
    //TODO: Ver LookupPageID = 34002140;

    fields
    {
        field(1; "Código"; Code[10])
        {
        }
        field(2; "Descripción"; Text[50])
        {
        }
        field(3; "Excluir contabilizacion"; Boolean)
        {
            Caption = 'Exclude from G/L Post';
        }
    }

    keys
    {
        key(Key1; "Código")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descripción")
        {
        }
    }
}

