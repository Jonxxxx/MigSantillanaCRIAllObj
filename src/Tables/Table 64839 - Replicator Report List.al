table 64839 "Replicator Report List"
{
    DataPerCompany = false;

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Replicator;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Text; Text[30])
        {
        }
        field(4; "Report ID"; Integer)
        {
            TableRelation = AllObjWithCaption."Object ID"
    where("Object Type" = const(Report));

            trigger OnValidate()
            begin
                CALCFIELDS("Report Name");
                Text := "Report Name";
            end;
        }
        field(5; "Report Name"; Text[30])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report), "Object ID" = field("Report ID")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Type, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

