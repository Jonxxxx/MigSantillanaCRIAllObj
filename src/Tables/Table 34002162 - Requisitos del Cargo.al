table 55803 "Requisitos del Cargo"
{
    Caption = 'Job requisites';
    DrillDownPageID = 55854;
    LookupPageID = 55854;

    fields
    {
        field(1; "Cod. Cargo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cargo';
        }
        field(2; "Cod. requisito"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. requisito';
        }
        field(3; "Cualificacion requerida"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cualificacion requerida';
        }
        field(4; Requerido; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requerido';
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

