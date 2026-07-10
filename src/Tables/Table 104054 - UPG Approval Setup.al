table 104054 "UPG Approval Setup"
{

    fields
    {
        field(1;"Primary Key";Code[20])
        {
        }
        field(2;"Due Date Formula";DateFormula)
        {
        }
        field(3;"Approval Administrator";Code[50])
        {
            TableRelation = "User Setup";
        }
        field(5;"Request Rejection Comment";Boolean)
        {
        }
        field(6;Approvals;Boolean)
        {
        }
        field(7;Cancellations;Boolean)
        {
        }
        field(8;Rejections;Boolean)
        {
        }
        field(9;Delegations;Boolean)
        {
        }
        field(10;"Last Run Time";Time)
        {
        }
        field(11;"Last Run Date";Date)
        {
        }
        field(12;"Overdue Template";BLOB)
        {
            SubType = UserDefined;
        }
        field(13;"Approval Template";BLOB)
        {
            SubType = UserDefined;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

