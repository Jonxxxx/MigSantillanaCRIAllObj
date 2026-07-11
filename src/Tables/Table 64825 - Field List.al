table 64825 "Field List"
{

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            TableRelation = Specification."No.";
        }
        field(2; "List Type"; Option)
        {
            OptionMembers = "Field Transfer List","Key Field Links";
        }
        field(10; "Field No. Source"; Integer)
        {
            NotBlank = true;
        }
        field(11; "Field Name Source"; Text[30])
        {
            Editable = false;
        }
        field(20; "Field No. Dest."; Integer)
        {
        }
        field(21; "Field Name Dest."; Text[30])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Specification No.", "List Type", "Field No. Source")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Specification: Record 64822;
        "Fields"Record 2000000041;
        DBFields: Record 64829;
}

