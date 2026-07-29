table 50019 "Utility - fes"
{

    fields
    {
        field(1;"Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(3;Description;Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4;"Def. Gen. Prod. Posting Group";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(5;"Def. Inventory Posting Group";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Inventory Posting Group';
            TableRelation = "Inventory Posting Group".Code;
        }
        field(6;"Def. Tax Group Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Tax Group Code';
            TableRelation = "Tax Group".Code;
        }
        field(7;"Def. Costing Method";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Def. Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8;"Def. VAT Prod. Posting Group";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Def. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(75000;Bloqueado;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bloqueado';
            Description = 'MdM';
        }
        field(75001;MdM;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'MdM';
            Description = 'MdM, Bloquea los productos relacioandos con esta marca';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

