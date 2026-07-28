table 34002166 AFP
{
    //IGNORAR: Page no existe DrillDownPageID = 34002174;
    //IGNORAR: Page no existe LookupPageID = 34002174;

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
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
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

