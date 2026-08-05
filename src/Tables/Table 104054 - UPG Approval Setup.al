table 55721 "UPG Approval Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Due Date Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date Formula';
        }
        field(3; "Approval Administrator"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Administrator';
            TableRelation = "User Setup";
        }
        field(5; "Request Rejection Comment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Rejection Comment';
        }
        field(6; Approvals; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approvals';
        }
        field(7; Cancellations; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellations';
        }
        field(8; Rejections; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejections';
        }
        field(9; Delegations; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Delegations';
        }
        field(10; "Last Run Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Run Time';
        }
        field(11; "Last Run Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Run Date';
        }
        field(12; "Overdue Template"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Overdue Template';
            SubType = UserDefined;
        }
        field(13; "Approval Template"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Template';
            SubType = UserDefined;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

