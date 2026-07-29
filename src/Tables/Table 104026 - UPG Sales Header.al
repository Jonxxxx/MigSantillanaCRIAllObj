table 104026 "UPG Sales Header"
{
    DataCaptionFields = "No.";

    fields
    {
        field(1;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(825;"Authorization Required";Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Authorization Required';
        }
        field(827;"Credit Card No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Card No.';
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

