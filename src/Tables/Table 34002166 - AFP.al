table 34002166 AFP
{
    //IGNORAR: Page no existe DrillDownPageID = 34002174;
    //IGNORAR: Page no existe LookupPageID = 34002174;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Reporte Planilla"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte Planilla';
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

