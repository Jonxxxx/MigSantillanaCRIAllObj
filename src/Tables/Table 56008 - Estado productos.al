table 56008 "Estado productos"
{
    // #6357  PLB   05/11/2014  Se ha configurado correctamente el LookUpPageId y DrillDownPageID

    DrillDownPageID = 56033;
    LookupPageID = 56033;

    fields
    {
        field(1; "Codigo"; Code[20])
        {
        }
        field(2; "Descripcion"; Text[30])
        {
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

