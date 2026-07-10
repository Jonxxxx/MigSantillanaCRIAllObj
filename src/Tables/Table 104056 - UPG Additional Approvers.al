table 104056 "UPG Additional Approvers"
{

    fields
    {
        field(1;"Approval Code";Code[20])
        {
        }
        field(2;"Approver ID";Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3;"Approval Type";Option)
        {
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(4;"Document Type";Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None";
        }
        field(5;"Limit Type";Option)
        {
            Editable = false;
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(6;"Sequence No.";Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Approver ID","Approval Code","Approval Type","Document Type","Limit Type","Sequence No.")
        {
        }
        key(Key2;"Sequence No.")
        {
        }
    }

    fieldgroups
    {
    }
}

