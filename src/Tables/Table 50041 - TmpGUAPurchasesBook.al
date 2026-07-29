table 50041 TmpGUAPurchasesBook
{
    // YYYYMMDD Version        Sign Proj.Ref. Description
    // -------------------------------------------------------------------------
    // 20090709 COL5.0.001     JPA  950       Temporary table to be loaded with the information for the purchases book


    fields
    {
        field(1; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
            Description = 'COL5.0.001';
        }
        field(2; Vendedor; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendedor';
            Description = 'COL5.0.001';
            TableRelation = "Sales Header"."No.";
        }
        field(3; Identification; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Identification';
            Description = 'COL5.0.001';
            TableRelation = "Sales Header"."No.";
        }
        field(4; "Total purchase"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total purchase';
            Description = 'COL5.0.001';
        }
        field(6; "Total service"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total service';
            Description = 'COL5.0.001';
        }
        field(8; VAT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT';
            Description = 'COL5.0.001';
        }
        field(9; "Total invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total invoice';
            Description = 'COL5.0.001';
        }
        field(10; Import; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Import';
            Description = 'COL5.0.001';
        }
        field(11; Reference; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference';
            Description = 'COL5.0.001';
        }
        field(13; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            Description = 'COL5.0.001';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(14; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Bus. Posting Group';
            Description = 'COL5.0.001';
        }
        field(15; No; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No';
            Description = 'COL5.0.001';
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

