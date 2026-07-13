table 64833 Scheduler
{
    DataCaptionFields = "No.", Description;
    //TODO: Ver DrillDownPageID = 64847;
    //TODO: Ver LookupPageID = 64847;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(5; Description; Text[30])
        {
        }
        field(6; "Job Type"; Option)
        {
            OptionMembers = Replicator,Navision;

            trigger OnValidate()
            begin
                IF "Job Type" = "Job Type"::Replicator THEN
                    "Codeunit No." := 0
                ELSE BEGIN
                    "Specfication No." := '';
                    "Replicator Group Code" := '';
                END;
            end;
        }
        field(10; "Specfication No."; Code[20])
        {
            TableRelation = Specification."No.";

            trigger OnValidate()
            begin
                IF "Specfication No." <> '' THEN BEGIN
                    TESTFIELD("Job Type", "Job Type"::Replicator);
                    "Replicator Group Code" := '';
                END;
            end;
        }
        field(11; "Replicator Group Code"; Code[20])
        {
            TableRelation = "Replicator Group".Code;

            trigger OnValidate()
            begin
                IF "Replicator Group Code" <> '' THEN BEGIN
                    TESTFIELD("Job Type", "Job Type"::Replicator);
                    "Specfication No." := '';
                END;
            end;
        }
        field(15; Status; Option)
        {
            OptionMembers = Ok,Processing,Error,Stopped;
        }
        field(16; "Error Handling"; Option)
        {
            OptionMembers = Skip,Retry,Stop;
        }
        field(17; Interval; Integer)
        {
            BlankZero = true;
        }
        field(18; Unit; Option)
        {
            BlankZero = true;
            OptionMembers = ,"Minute(s)","Hour(s)","Day(s)","Week(s)","Month(s)";
        }
        field(20; Sunday; Boolean)
        {
            InitValue = true;
        }
        field(21; Monday; Boolean)
        {
            InitValue = true;
        }
        field(22; Tuesday; Boolean)
        {
            InitValue = true;
        }
        field(23; Wednesday; Boolean)
        {
            InitValue = true;
        }
        field(24; Thursday; Boolean)
        {
            InitValue = true;
        }
        field(25; Friday; Boolean)
        {
            InitValue = true;
        }
        field(26; Saturday; Boolean)
        {
            InitValue = true;
        }
        field(28; "Start Time"; Time)
        {
        }
        field(29; "End Time"; Time)
        {
        }
        field(30; "Last Date"; Date)
        {
        }
        field(31; "Last Time"; Time)
        {
        }
        field(32; "Next Date"; Date)
        {
        }
        field(33; "Next Time"; Time)
        {
        }
        field(40; "Codeunit No."; Integer)
        {
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Codeunit));

            trigger OnValidate()
            begin
                IF "Codeunit No." <> 0 THEN
                    TESTFIELD("Job Type", "Job Type"::Navision);
            end;
        }
        field(50; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Job Type", "Next Date", "Next Time")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        tags.SETRANGE("Scheduler No.", "No.");
        tags.DELETEALL;
    end;

    trigger OnInsert()
    begin
        ReplicatorSetup.GET;
        IF "No." = '' THEN
            ReplicatorSetup.TESTFIELD("Scheduler Nos.");
        //TODO: Ver NoSeriesMgt.InitSeries(ReplicatorSetup."Scheduler Nos.", xRec."No. Series", 0D, "No.", "No. Series");
    end;

    var
        tags: Record 64834;
        ReplicatorSetup: Record 64835;
        Sched: Record 64833;
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(OldSched: Record 64833): Boolean
    begin
        WITH Sched DO BEGIN
            Sched := Rec;
            ReplicatorSetup.GET;
            ReplicatorSetup.TESTFIELD("Scheduler Nos.");
            //TODO: Ver IF NoSeriesMgt.SelectSeries(ReplicatorSetup."Scheduler Nos.", OldSched."No. Series", "No. Series") THEN BEGIN
            ReplicatorSetup.GET;
            ReplicatorSetup.TESTFIELD("Scheduler Nos.");
            //TODO: Ver NoSeriesMgt.SetSeries("No.");
            Rec := Sched;
            EXIT(TRUE);
            //TODO: Ver END;
        END;
    end;
}

