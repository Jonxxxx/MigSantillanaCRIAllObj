table 55454 "Database Field"
{
    //IGNORAR: Page no existe DrillDownPageID = 55454;
    //IGNORAR: Page no existe LookupPageID = 55454;

    fields
    {
        field(1; "Database Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Database Code';
        }
        field(2; "Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table No.';
        }
        field(3; "Field No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No.';
        }
        field(10; "Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name';
        }
        field(11; "Field Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Field Type';
            OptionMembers = ,Option,Boolean,"Integer",ShortInteger,Text,"Code",Date,Time,Decimal,Blob,DateFormula,Binary,TableFilter,BigInteger,Datetime,Duration,GUID,RecordID;
        }
        field(12; "Field Length"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field Length';
        }
        field(13; "Field Option"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Option';
        }
        field(14; "Field Class"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Field Class';
            OptionMembers = ,Normal,FlowField,FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Database Code", "Table No.", "Field No.")
        {
        }
    }

    fieldgroups
    {
    }
}

