table 104026 "UPG Sales Header"
{
    DataCaptionFields = "No.";

    fields
    {
        field(1;"Document Type";Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"No.";Code[20])
        {
        }
        field(825;"Authorization Required";Boolean)
        {
        }
        field(827;"Credit Card No.";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Document Type","No.")
        {
        }
    }

    fieldgroups
    {
    }
}

