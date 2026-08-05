table 55228 "Sello/Marca"
{
    // #6357  PLB   05/11/2014  Se ha configurado correctamente el LookUpPageId y DrillDownPageID

    Caption = 'Seal/Brand';
    DrillDownPageID = 55259;
    LookupPageID = 55259;

    fields
    {
        field(1; "Cod. Sello/Marca"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Sello/Marca';
        }
        field(2; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Cod. Sello/Marca")
        {
        }
    }

    fieldgroups
    {
    }
}

