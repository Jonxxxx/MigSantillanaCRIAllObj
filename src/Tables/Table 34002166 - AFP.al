table 55807 AFP
{
    //IGNORAR: Page no existe DrillDownPageID = 55815;
    //IGNORAR: Page no existe LookupPageID = 55815;

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

