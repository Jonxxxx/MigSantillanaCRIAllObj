table 104069 "UPG Phys. Invt. Item Selection"
{

    fields
    {
        field(1;"Item No.";Code[20])
        {
            Editable = false;
        }
        field(2;"Variant Code";Code[10])
        {
            Editable = false;
        }
        field(3;"Location Code";Code[10])
        {
            Editable = false;
        }
        field(5;"Shelf No.";Code[10])
        {
            Editable = false;
        }
        field(6;"Phys Invt Counting Period Code";Code[10])
        {
            Editable = false;
        }
        field(7;"Last Counting Date";Date)
        {
            Editable = false;
        }
        field(8;"Next Counting Period";Text[250])
        {
            Editable = false;
        }
        field(9;"Count Frequency per Year";Integer)
        {
            BlankZero = true;
            Editable = false;
            MinValue = 0;
        }
        field(10;Selected;Boolean)
        {
        }
        field(11;"Phys Invt Counting Period Type";Option)
        {
            OptionMembers = " ",Item,SKU;
        }
    }

    keys
    {
        key(Key1;"Item No.","Variant Code","Location Code","Phys Invt Counting Period Code")
        {
        }
    }

    fieldgroups
    {
    }
}

