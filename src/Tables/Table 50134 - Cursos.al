table 50134 Cursos
{
    DrillDownPageID = 50030;
    LookupPageID = 50030;

    fields
    {
        field(1; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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

