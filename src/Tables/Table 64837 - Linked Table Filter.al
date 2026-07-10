table 64837 "Linked Table Filter"
{

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            Editable = false;
            TableRelation = Specification."No.";
        }
        field(4; Type; Option)
        {
            OptionMembers = CONSTANT,"FIELD";
        }
        field(5; "Linked Field No."; Integer)
        {
        }
        field(6; "Linked Field Name"; Text[30])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(7; "Main Table Field No."; Integer)
        {
        }
        field(8; Value; Text[100])
        {
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; "Specification No.", "Linked Field No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DbFields Record: 64829;
        "Fields"Record 2000000041;
        Specification Record: 64822;
        MainSpecification Record: 64822;
        xInteger: Integer;
}

