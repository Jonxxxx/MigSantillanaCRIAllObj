table 56029 "Zonas de cobro"
{
    DrillDownPageID = 56067;
    LookupPageID = 56067;

    fields
    {
        field(10; "Cod. zona"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. zona';
        }
        field(20; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Cod. zona")
        {
        }
    }

    fieldgroups
    {
    }
}

