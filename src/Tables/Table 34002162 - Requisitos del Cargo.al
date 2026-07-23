table 34002162 "Requisitos del Cargo"
{
    Caption = 'Job requisites';
    DrillDownPageID = 34002213;
    LookupPageID = 34002213;

    fields
    {
        field(1; "Cod. Cargo"; Code[10])
        {
            Caption = 'Position Code';
        }
        field(2; "Cod. requisito"; Code[10])
        {
            Caption = 'Skills code';
        }
        field(3; "Cualificacion requerida"; Code[10])
        {
            Caption = 'Qualification Required';
        }
        field(4; Requerido; Boolean)
        {
            Caption = 'Requested';
        }
    }

    keys
    {
        key(Key1; "Cod. Cargo", "Cod. requisito")
        {
        }
    }

    fieldgroups
    {
    }
}

