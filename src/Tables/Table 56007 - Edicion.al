table 56007 Edicion
{
    // #6357  PLB   05/11/2014  Se ha configurado correctamente el LookUpPageId y DrillDownPageID

    DrillDownPageID = 56029;
    LookupPageID = 56029;

    fields
    {
        field(1;Codigo;Code[20])
        {
            Caption = 'Codigo';
        }
        field(2;Descripcion;Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

