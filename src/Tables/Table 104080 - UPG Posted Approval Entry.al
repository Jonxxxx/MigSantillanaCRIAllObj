table 104080 "UPG Posted Approval Entry"
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Sequence No."; Integer)
        {
        }
        field(5; "Approval Code"; Code[20])
        {
        }
        field(6; "Sender ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(7; "Salespers./Purch. Code"; Code[10])
        {
        }
        field(8; "Approver ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(9; Status; Option)
        {
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Posted Approval Comment Line" WHERE("Table ID" = FIELD("Table ID"),
                                                                      "Document No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Due Date"; Date)
        {
        }
        field(15; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(17; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20; "Available Credit Limit (LCY)"; Decimal)
        {
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

