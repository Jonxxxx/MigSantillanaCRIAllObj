table 56006 Tipos
{
    // #6357  PLB   05/11/2014  Se ha configurado correctamente el LookUpPageId y DrillDownPageID

    Caption = 'Types';
    DrillDownPageID = 56032;
    LookupPageID = 56032;

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
        }
        field(2;Description;Text[60])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

