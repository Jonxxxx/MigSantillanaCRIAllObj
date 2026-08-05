table 55447 Specification
{
    DataCaptionFields = "No.", Description;
    //IGNORAR: Page no existe DrillDownPageID = 55457;
    //IGNORAR: Page no existe LookupPageID = 55457;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(5; "Replicator Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Replicator Group Code';
            TableRelation = "Replicator Group".Code;
        }
        field(6; "Seq. No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Seq. No.';
        }
        field(7; Enabled; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Enabled';
            InitValue = true;
        }
        field(10; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(14; "Transfer Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer Type';
            InitValue = Normal;
            OptionMembers = ,Normal,,,"ToDo Table","By Actions",Objects,Backup,BackupCompare,CompanyExport,CompanyImport;
        }
        field(15; WhatToDo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'WhatToDo';
            InitValue = "Update-Add";
            OptionMembers = ,Update,Add,"Update-Add",Delete,"Update-Delete","Add-Delete","Update-Add-Delete";
        }
        field(16; "Field List Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Field List Type';
            InitValue = "All Fields";
            OptionMembers = "Exclude List","Include List","All Fields";
        }
        field(17; "Sequential Read"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sequential Read';
            InitValue = "Source+Dest";
            OptionMembers = "Source+Dest","Source only","Dest only";
        }
        field(19; "Source Design"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Design';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(20; "Source Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Database';
            NotBlank = true;
            TableRelation = EXCCRIDatabase.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(28; "Source Table No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Table No';
            TableRelation = IF ("Source Design" = FILTER('')) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Source Design" = FILTER(<> '')) "Database Table"."Table No." WHERE("Database Code" = FIELD("Source Design"));
        }
        field(29; "Source Table Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Table Name';
            Editable = false;
        }
        field(30; "Source Key"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Key';
        }
        field(31; "Source Key Fields"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Key Fields';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(33; "Source Filter"; Boolean)
        {
            Caption = 'Source Filter';
            CalcFormula = Exist("Field Filter" WHERE("Specification No." = FIELD("No."),
                                                      "Type" = CONST("Source Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Source Flag Field"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Flag Field';
        }
        field(36; "Source Flag Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Flag Field Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(37; "Source Counter Field"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter Field';
        }
        field(38; "Source Counter Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter Name';
            Editable = false;
        }
        field(39; "Dest. Design"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Design';
            TableRelation = EXCCRIDatabase.Code;
        }
        field(40; "Dest. Database"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Database';
            TableRelation = EXCCRIDatabase.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(48; "Dest. Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Table No.';
            TableRelation = IF ("Dest. Design" = FILTER('')) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Dest. Design" = FILTER(<> '')) "Database Table"."Table No." WHERE("Database Code" = FIELD("Dest. Design"));
        }
        field(49; "Dest. Table Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Table Name';
            Editable = false;
        }
        field(50; "Dest. Key"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Key';
        }
        field(51; "Dest. Key Fields"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Key Fields';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(53; "Dest. Filter"; Boolean)
        {
            Caption = 'Dest. Filter';
            CalcFormula = Exist("Field Filter" WHERE("Specification No." = FIELD("No."),
                                                      "Type" = CONST("Dest. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Main Spec."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Main Spec.';
            TableRelation = Specification;
        }
        field(55; "Dest. Update SC."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Update SC.';
            TableRelation = Specification."No.";
        }
        field(56; "Dest. Return Changes"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Return Changes';
        }
        field(57; "Log Changes"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Log Changes';
        }
        field(58; "Source UserID Field"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source UserID Field';
        }
        field(59; "Source UserID Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source UserID Name';
            Editable = false;
        }
        field(60; "Commit per"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Commit per';
        }
        field(61; "Buffer Size (Records)"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Buffer Size (Records)';
        }
        field(62; "Action Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Table No.';
            TableRelation = IF ("Source Design" = FILTER('')) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Source Design" = FILTER(<> '')) "Database Table"."Table No." WHERE("Database Code" = FIELD("Source Design"));
        }
        field(63; "Action Table Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Action Table Name';
        }
        field(64; "Move Actions"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Move Actions';
        }
        field(65; "Dest. Check SC. No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Check SC. No.';
        }
        field(66; "Dest. Check SC. Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dest. Check SC. Name';
        }
        field(67; "Sub Specifications"; Boolean)
        {
            Caption = 'Sub Specifications';
            CalcFormula = Exist(Specification WHERE("Main Spec." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68; "Field List"; Boolean)
        {
            Caption = 'Field List';
            CalcFormula = Exist("Field List" WHERE("Specification No." = FIELD("No."),
                                                    "List Type" = CONST("Field Transfer List")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; "Table-Linking"; Boolean)
        {
            Caption = 'Table-Linking';
            CalcFormula = Exist("Field List" WHERE("Specification No." = FIELD("No."),
                                                    "List Type" = CONST("Key Field Links")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(71; "Changes Only (from SQL)"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Changes Only (from SQL)';
        }
        field(80; Text; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Text';
        }
        field(81; "Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(82; "Integer"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Integer';
        }
        field(83; Decimal; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Decimal';
        }
        field(84; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(85; Time; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time';
        }

        /*
        field(86;Option;Option)
        {
            OptionMembers =  '';
        }*/
        field(87; Boolean; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Boolean';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Replicator Group Code", "Seq. No.", Enabled)
        {
        }
    }

    fieldgroups
    {
    }

    var
        FieldList: Record 55450;
        FieldFilter: Record 55461;
        LinkedTableFilter: Record 55462;
        DB: Record 55448;
        Spec: Record 55447;
        ReplicatorSetup: Record 55460;
        DatabaseTables: Record 55453;
        AllObj: Record 2000000038;
}

