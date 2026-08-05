table 55834 "Employee Value"
{
    Caption = 'Contact Value';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; Value; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
            AutoFormatType = 1;
        }
        field(3; "Last Date Updated"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Updated';
        }
        field(4; "Questions Answered (%)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Questions Answered (%)';
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
        key(Key2; Value)
        {
        }
    }

    fieldgroups
    {
    }
}

