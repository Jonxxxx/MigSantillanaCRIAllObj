table 55457 "Action"
{

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(5; "Source Counter"; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter';
        }
        field(10; WhatToDo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'WhatToDo';
            OptionMembers = Update,Add,Delete,UpdateAdd;
        }
        field(11; "Move Action"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Move Action';
        }
        field(12; "Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table No.';
        }
        field(14; "Key"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Key';
        }
        field(20; "Change Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Change Date';
        }
        field(21; "Change Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Change Time';
        }
        field(22; "Changed by User"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Changed by User';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Source Counter")
        {
        }
    }

    fieldgroups
    {
    }
}

