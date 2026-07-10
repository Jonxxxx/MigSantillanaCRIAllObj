table 104068 "UPG Stockkeeping Unit"
{

    fields
    {
        field(1;"Item No.";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Variant Code";Code[10])
        {
        }
        field(3;"Location Code";Code[10])
        {
        }
        field(7382;"Next Counting Period";Text[250])
        {
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

