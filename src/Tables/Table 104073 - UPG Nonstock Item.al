table 104073 "UPG Nonstock Item"
{
    DrillDownPageID = 5726;
    LookupPageID = 5726;

    fields
    {
        field(1;"Entry No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = true;
        }
        field(12;"Item Category Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(13;"Product Group Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

