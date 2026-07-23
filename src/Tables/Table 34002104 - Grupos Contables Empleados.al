table 34002104 "Grupos Contables Empleados"
{
    DataCaptionFields = "Codigo";
    DrillDownPageID = 34002140;
    //TODO: Ver LookupPageID = 34002140;

    fields
    {
        field(1; "Codigo"; Code[10])
        {
        }
        field(2; "Descripcion"; Text[50])
        {
        }
        field(3; "Excluir contabilizacion"; Boolean)
        {
            Caption = 'Exclude from G/L Post';
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
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }
}

