table 34002189 "Relacion Evaluacion"
{
    Caption = 'Business Relation';
    DataCaptionFields = "Code", Description;
    LookupPageID = 5060;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "No. of Contacts"; Integer)
        {
            CalcFormula = Count("Contact Business Relation" WHERE("Business Relation Code" = FIELD("Code")));
            Caption = 'No. of Contacts';
            Editable = false;
            FieldClass = FlowField;
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
    }
}

