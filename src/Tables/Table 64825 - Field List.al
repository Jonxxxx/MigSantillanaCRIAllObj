table 64825 "Field List"
{

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification No.';
            TableRelation = Specification."No.";
        }
        field(2; "List Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'List Type';
            OptionMembers = "Field Transfer List","Key Field Links";
        }
        field(10; "Field No. Source"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No. Source';
            NotBlank = true;
        }
        field(11; "Field Name Source"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name Source';
            Editable = false;
        }
        field(20; "Field No. Dest."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No. Dest.';
        }
        field(21; "Field Name Dest."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name Dest.';
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
        "Fields": Record 2000000041;
        DBFields: Record 64829;
}

