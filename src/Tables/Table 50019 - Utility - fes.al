table 50019 "Utility - fes"
{

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3;Description;Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4;"Def. Gen. Prod. Posting Group";Code[10])
        {
            Caption = 'Def. Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(5;"Def. Inventory Posting Group";Code[10])
        {
            Caption = 'Def. Inventory Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }
        field(6;"Def. Tax Group Code";Code[10])
        {
            Caption = 'Def. Tax Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "Tax Group".Code;
        }
        field(7;"Def. Costing Method";Option)
        {
            Caption = 'Def. Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8;"Def. VAT Prod. Posting Group";Code[10])
        {
            Caption = 'Def. Tax Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(75000;Bloqueado;Boolean)
        {
            Caption = 'Bloqueado';
            DataClassification = ToBeClassified;
            Description = 'MdM';
        }
        field(75001;MdM;Boolean)
        {
            DataClassification = ToBeClassified;
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

