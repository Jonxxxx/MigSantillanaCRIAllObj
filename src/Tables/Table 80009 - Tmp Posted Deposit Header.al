table 80009 "Tmp Posted Deposit Header"
{
    Caption = 'Posted Deposit Header';
    DataCaptionFields = "No.";
    //IGNORAR: Page no existe LookupPageID = 10147;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Bank Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(3; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(4; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(6; "Total Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Deposit Amount';
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(7; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Bank Acc. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Acc. Posting Group';
            TableRelation = "Bank Account Posting Group";
        }
        field(11; "Language Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(12; "No. Printed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Printed';
            Editable = false;
        }
        field(13; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(14; Correction; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correction';
        }
        field(15; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; "Posting Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Description';
        }
        field(21; Comment; Boolean)
        {
            CalcFormula = Exist("Bank Comment Line" WHERE("Table Name" = CONST("Posted Deposit"),
            "Bank Account No." = FIELD("Bank Account No."),
            "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Total Deposit Lines"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Posted Deposit Line".Amount WHERE("Deposit No." = FIELD("No.")));
            Caption = 'Total Deposit Lines';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Bank Account No.")
        {
        }
    }

    fieldgroups
    {
    }
}

