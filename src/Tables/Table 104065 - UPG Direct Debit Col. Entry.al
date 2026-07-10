table 104065 "UPG Direct Debit Col. Entry"
{

    fields
    {
        field(1;"Direct Debit Collection No.";Integer)
        {
            TableRelation = "Direct Debit Collection";
        }
        field(2;"Entry No.";Integer)
        {
        }
        field(11;"Mandate ID";Text[35])
        {
        }
    }

    keys
    {
        key(Key1;"Direct Debit Collection No.","Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

