table 104056 "UPG Additional Approvers"
{

    fields
    {
        field(1;"Approval Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Code';
        }
        field(2;"Approver ID";Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approver ID';
            TableRelation = "User Setup"."User ID";
        }
        field(3;"Approval Type";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Type';
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(4;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None";
        }
        field(5;"Limit Type";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Limit Type';
            Editable = false;
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(6;"Sequence No.";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sequence No.';
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

