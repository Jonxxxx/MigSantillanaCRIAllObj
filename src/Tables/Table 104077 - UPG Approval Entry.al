table 104077 "UPG Approval Entry"
{

    fields
    {
        field(1;"Table ID";Integer)
        {
        }
        field(2;"Document Type";Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"Document No.";Code[20])
        {
        }
        field(4;"Sequence No.";Integer)
        {
        }
        field(5;"Approval Code";Code[20])
        {
        }
        field(6;"Sender ID";Code[50])
        {
        }
        field(7;"Salespers./Purch. Code";Code[10])
        {
        }
        field(8;"Approver ID";Code[50])
        {
        }
        field(9;Status;Option)
        {
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(10;"Date-Time Sent for Approval";DateTime)
        {
        }
        field(11;"Last Date-Time Modified";DateTime)
        {
        }
        field(12;"Last Modified By ID";Code[50])
        {
        }
        field(13;Comment;Boolean)
        {
            CalcFormula = Exist("Approval Comment Line" WHERE (Table ID=FIELD(Table ID),
                                                               Document Type=FIELD(Document Type),
                                                               Document No.=FIELD(Document No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Due Date";Date)
        {
        }
        field(15;Amount;Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(16;"Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
        }
        field(17;"Currency Code";Code[10])
        {
            TableRelation = Currency;
        }
        field(18;"Approval Type";Option)
        {
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19;"Limit Type";Option)
        {
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20;"Available Credit Limit (LCY)";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Table ID","Document Type","Document No.","Sequence No.")
        {
        }
        key(Key2;"Approver ID",Status)
        {
        }
        key(Key3;"Sender ID")
        {
        }
    }

    fieldgroups
    {
    }
}

