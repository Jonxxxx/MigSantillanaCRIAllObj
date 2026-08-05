table 55711 "Tmp Documentos cheques"
{
    Caption = 'Check Ledger Entry';
    DrillDownPageID = 374;
    LookupPageID = 374;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(3; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(5; Description; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            AutoFormatType = 1;
        }
        field(7; "Check Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Check Date';
        }
        field(8; "Check No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Check No.';
        }
        field(9; Beneficiario; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Beneficiario';
        }
        field(10; "Vendor Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Ledger Entry No.';
        }
    }

    keys
    {
        key(Key1; "Bank Account No.", "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

