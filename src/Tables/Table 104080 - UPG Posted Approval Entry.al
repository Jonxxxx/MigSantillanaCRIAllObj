table 55731 "UPG Posted Approval Entry"
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table ID';
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(4; "Sequence No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sequence No.';
        }
        field(5; "Approval Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Code';
        }
        field(6; "Sender ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sender ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(7; "Salespers./Purch. Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salespers./Purch. Code';
        }
        field(8; "Approver ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approver ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(9; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Modified By ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(13; Comment; Boolean)
        {
            Caption = 'Comment';
            CalcFormula = Exist("Posted Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                                      "Document No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(15; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount (LCY)';
            AutoFormatType = 1;
        }
        field(17; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Type';
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Limit Type';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20; "Available Credit Limit (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Available Credit Limit (LCY)';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document No.", "Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }
}

