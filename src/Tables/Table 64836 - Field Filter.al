table 64836 "Field Filter"
{

    fields
    {
        field(1; "Specification No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification No.';
            TableRelation = Specification."No.";
        }
        field(2; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            Editable = false;
            OptionMembers = "Source Filter","Dest. Filter";
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(5; "Field No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No.';
        }
        field(6; "Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(7; "Filter"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filter';
        }
    }

    keys
    {
        key(Key1; "Specification No.", Type, "Field No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Fields": Record 2000000041;
        DBFields: Record 64829;
        Specification: Record 64822;
        DbDesign: Code[20];
        TableNo: Integer;
}

