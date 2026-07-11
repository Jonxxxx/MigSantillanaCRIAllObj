table 64822 Specification
{
    DataCaptionFields = "No.", Description;
    DrillDownPageID = 64832;
    LookupPageID = 64832;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(5; "Replicator Group Code"; Code[20])
        {
            TableRelation = "Replicator Group".Code;
        }
        field(6; "Seq. No."; Integer)
        {
        }
        field(7; Enabled; Boolean)
        {
            InitValue = true;
        }
        field(10; Description; Text[80])
        {
        }
        field(14; "Transfer Type"; Option)
        {
            InitValue = Normal;
            OptionMembers = ,Normal,,,"ToDo Table","By Actions",Objects,Backup,BackupCompare,CompanyExport,CompanyImport;
        }
        field(15; WhatToDo; Option)
        {
            InitValue = "Update-Add";
            OptionMembers = ,Update,Add,"Update-Add",Delete,"Update-Delete","Add-Delete","Update-Add-Delete";
        }
        field(16; "Field List Type"; Option)
        {
            InitValue = "All Fields";
            OptionMembers = "Exclude List","Include List","All Fields";
        }
        field(17; "Sequential Read"; Option)
        {
            InitValue = "Source+Dest";
            OptionMembers = "Source+Dest","Source only","Dest only";
        }
        field(19; "Source Design"; Code[20])
        {
            //TODO: Ver TableRelation = Database.Code;
        }
        field(20; "Source Database"; Code[20])
        {
            NotBlank = true;
            //TODO: Ver TableRelation = Database.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(28; "Source Table No"; Integer)
        {
            TableRelation = IF ("Source Design" = FILTER('')) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE IF ("Source Design" = FILTER(<> '')) "Database Table"."Table No." WHERE("Database Code" = FIELD("Source Design"));
        }
        field(29; "Source Table Name"; Text[30])
        {
            Editable = false;
        }
        field(30; "Source Key"; Text[80])
        {
        }
        field(31; "Source Key Fields"; Text[250])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(33; "Source Filter"; Boolean)
        {
            CalcFormula = Exist("Field Filter" WHERE("Specification No." = FIELD("No."),
                                                      Type = CONST(Source Filter)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Source Flag Field"; Integer)
        {
        }
        field(36; "Source Flag Field Name"; Text[30])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(37; "Source Counter Field"; Integer)
        {
        }
        field(38; "Source Counter Name"; Text[30])
        {
            Editable = false;
        }
        field(39; "Dest. Design"; Code[20])
        {
            //TODO: Ver TableRelation = Database.Code;
        }
        field(40; "Dest. Database"; Code[20])
        {
            //TODO: Ver TableRelation = Database.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48; "Dest. Table No."; Integer)
        {
            TableRelation = IF (Dest.Design=FILTER('')) AllObj."Object ID" WHERE ("Object Type"=CONST(Table))
                            ELSE IF (Dest. Design=FILTER(<>'')) "Database Table"."Table No." WHERE ("Database Code"=FIELD("Dest. Design"));
        }
        field(49;"Dest. Table Name";Text[30])
        {
            Editable = false;
        }
        field(50;"Dest. Key";Text[80])
        {
        }
        field(51;"Dest. Key Fields";Text[250])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(53;"Dest. Filter";Boolean)
        {
            CalcFormula = Exist("Field Filter" WHERE ("Specification No."=FIELD("No."),
                                                      Type=CONST(Dest. Filter)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(54;"Main Spec.";Code[20])
        {
            TableRelation = Specification;
        }
        field(55;"Dest. Update SC.";Code[20])
        {
            TableRelation = Specification."No.";
        }
        field(56;"Dest. Return Changes";Boolean)
        {
        }
        field(57;"Log Changes";Boolean)
        {
        }
        field(58;"Source UserID Field";Integer)
        {
        }
        field(59;"Source UserID Name";Text[30])
        {
            Editable = false;
        }
        field(60;"Commit per";Integer)
        {
        }
        field(61;"Buffer Size (Records)";Integer)
        {
        }
        field(62;"Action Table No.";Integer)
        {
            TableRelation = IF ("Source Design"=FILTER('')) AllObj."Object ID" WHERE ("Object Type"=CONST(Table))
                            ELSE IF ("Source Design"=FILTER(<>'')) "Database Table"."Table No." WHERE ("Database Code"=FIELD("Source Design"));
        }
        field(63;"Action Table Name";Text[30])
        {
        }
        field(64;"Move Actions";Boolean)
        {
        }
        field(65;"Dest. Check SC. No.";Integer)
        {
        }
        field(66;"Dest. Check SC. Name";Text[30])
        {
        }
        field(67;"Sub Specifications";Boolean)
        {
            CalcFormula = Exist(Specification WHERE ("Main Spec."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68;"Field List";Boolean)
        {
            CalcFormula = Exist("Field List" WHERE ("Specification No."=FIELD("No."),
                                                    List Type=CONST(Field Transfer List)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69;"Table-Linking";Boolean)
        {
            CalcFormula = Exist("Field List" WHERE ("Specification No."=FIELD("No."),
                                                    List Type=CONST(Key Field Links)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70;"No. Series";Code[10])
        {
        }
        field(71;"Changes Only (from SQL)";Boolean)
        {
        }
        field(80;Text;Text[50])
        {
        }
        field(81;"Code";Code[50])
        {
        }
        field(82;"Integer";Integer)
        {
        }
        field(83;Decimal;Decimal)
        {
        }
        field(84;Date;Date)
        {
        }
        field(85;Time;Time)
        {
        }
        field(86;Option;Option)
        {
            OptionMembers = '';
        }
        field(87;Boolean;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
        key(Key2;"Replicator Group Code","Seq. No.",Enabled)
        {
        }
    }

    fieldgroups
    {
    }

    var
        FieldList: Record 64825;
        FieldFilter: Record 64836;
        LinkedTableFilter: Record 64837;
        DB: Record 64823;
        Spec: Record 64822;
        ReplicatorSetup: Record 64835;
        DatabaseTables: Record 64828;
        AllObj: Record 2000000038;
        NoSeriesMgt: Codeunit 396;
}

