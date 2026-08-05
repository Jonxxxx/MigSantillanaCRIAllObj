table 55451 ToDo
{

    fields
    {
        field(1; "Sender Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sender Database';
            NotBlank = true;
            TableRelation = EXCCRIDatabase.Code;
        }
        field(2; "Entry No."; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(5; "Receiver Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receiver Database';
            NotBlank = true;
            TableRelation = EXCCRIDatabase.Code;
        }
        field(6; Processed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Processed';
        }
        field(7; Private; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Private';
        }
        field(8; "Action"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Action';
            OptionMembers = Update,Add,Delete;
        }
        field(20; "ToDo Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ToDo Type';
        }
        field(21; Message; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Message';
        }
        field(30; "Remark Table Name"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Table Name';
            OptionMembers = "G/L Account",Customer,Vendor,Item,Resource,Job,,"Resource Group","Bank Account",Campaign;
        }
        field(31; "Remark No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark No.';
        }
        field(32; "Remark Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Line No.';
        }
        field(33; "Remark Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Date';
        }
        field(34; "Remark Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Code';
        }
        field(35; "Remark Comment"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Comment';
        }
        field(37; "Remark Comment No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Remark Comment No.';
        }
    }

    keys
    {
        key(Key1; "Sender Database", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

