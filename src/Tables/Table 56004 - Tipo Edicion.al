table 56004 "Tipo Edicion"
{
    // #6357  PLB   05/11/2014  Se ha configurado correctamente el LookUpPageId y DrillDownPageID

    Caption = 'Edition Type';
    DrillDownPageID = 56030;
    LookupPageID = 56030;

    fields
    {
        field(1;"Cod. Tipo Edicion";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Tipo Edicion';
        }
        field(2;Descripcion;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1;"Cod. Tipo Edicion")
        {
        }
    }

    fieldgroups
    {
    }
}

