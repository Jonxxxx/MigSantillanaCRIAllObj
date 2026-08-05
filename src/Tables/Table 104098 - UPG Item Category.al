table 55738 "UPG Item Category"
{
    LookupPageID = 5730;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "Def. Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Gen. Prod. Posting Group';
        }
        field(5; "Def. Inventory Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Inventory Posting Group';
        }
        field(6; "Def. Tax Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Tax Group Code';
        }
        field(7; "Def. Costing Method"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Costing Method';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8; "Def. VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. VAT Prod. Posting Group';
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

