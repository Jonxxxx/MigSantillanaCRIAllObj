table 55969 "Temp carta retenciones"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; Description; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Amount including vat"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount including vat';
        }
        field(4; "Amount 10"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount 10';
        }
        field(5; "Amount 30"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount 30';
        }
        field(6; "Amount 100"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount 100';
        }
        field(7; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(8; "Document date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document date';
        }
        field(9; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

