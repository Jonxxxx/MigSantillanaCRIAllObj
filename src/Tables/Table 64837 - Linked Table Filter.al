table 64837 "Linked Table Filter"
{

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification No.';
            Editable = false;
            TableRelation = Specification."No.";
        }
        field(4; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionMembers = CONSTANT,"FIELD";
        }
        field(5; "Linked Field No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Linked Field No.';
        }
        field(6; "Linked Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Linked Field Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(7; "Main Table Field No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Main Table Field No.';
        }
        field(8; Value; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
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
        DbFields: Record 64829;
        "Fields": Record 2000000041;
        Specification: Record 64822;
        MainSpecification: Record 64822;
        xInteger: Integer;
}

