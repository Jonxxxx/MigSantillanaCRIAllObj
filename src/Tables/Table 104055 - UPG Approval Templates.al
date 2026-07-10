table 104055 "UPG Approval Templates"
{

    fields
    {
        field(1;"Table ID";Integer)
        {
            Editable = false;
        }
        field(2;"Approval Code";Code[20])
        {
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
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(6;"Additional Approvers";Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(7;Enabled;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Approval Code","Approval Type","Document Type","Limit Type")
        {
        }
        key(Key2;"Table ID","Approval Type",Enabled)
        {
        }
        key(Key3;"Approval Code","Approval Type",Enabled)
        {
        }
        key(Key4;Enabled)
        {
        }
        key(Key5;"Limit Type","Document Type","Approval Type",Enabled)
        {
        }
        key(Key6;"Table ID","Document Type",Enabled)
        {
        }
    }

    fieldgroups
    {
    }
}

