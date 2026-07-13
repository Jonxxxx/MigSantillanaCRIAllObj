table 34002166 AFP
{
    //TODO: Ver DrillDownPageID = 34002174;
    //TODO: Ver LookupPageID = 34002174;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Reporte Planilla"; Integer)
        {
            TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

