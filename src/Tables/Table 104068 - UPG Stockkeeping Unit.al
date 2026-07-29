table 104068 "UPG Stockkeeping Unit"
{

    fields
    {
        field(1;"Item No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            NotBlank = true;
        }
        field(2;"Variant Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(3;"Location Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(7382;"Next Counting Period";Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Next Counting Period';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Location Code","Item No.","Variant Code")
        {
        }
    }

    fieldgroups
    {
    }
}

