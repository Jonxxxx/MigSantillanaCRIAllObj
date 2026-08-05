table 55458 Scheduler
{
    DataCaptionFields = "No.", Description;
    //IGNORAR: Page no existe DrillDownPageID = 64847;
    //IGNORAR: Page no existe LookupPageID = 64847;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            NotBlank = false;
        }
        field(5; Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; "Job Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Type';
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
            DataClassification = CustomerContent;
            Caption = 'Specfication No.';
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
            DataClassification = CustomerContent;
            Caption = 'Replicator Group Code';
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
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Ok,Processing,Error,Stopped;
        }
        field(16; "Error Handling"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Error Handling';
            OptionMembers = Skip,Retry,Stop;
        }
        field(17; Interval; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Interval';
            BlankZero = true;
        }
        field(18; Unit; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit';
            BlankZero = true;
            OptionMembers = ,"Minute(s)","Hour(s)","Day(s)","Week(s)","Month(s)";
        }
        field(20; Sunday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sunday';
            InitValue = true;
        }
        field(21; Monday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Monday';
            InitValue = true;
        }
        field(22; Tuesday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tuesday';
            InitValue = true;
        }
        field(23; Wednesday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Wednesday';
            InitValue = true;
        }
        field(24; Thursday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Thursday';
            InitValue = true;
        }
        field(25; Friday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Friday';
            InitValue = true;
        }
        field(26; Saturday; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Saturday';
            InitValue = true;
        }
        field(28; "Start Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Time';
        }
        field(29; "End Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'End Time';
        }
        field(30; "Last Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date';
        }
        field(31; "Last Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Time';
        }
        field(32; "Next Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Date';
        }
        field(33; "Next Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Time';
        }
        field(40; "Codeunit No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Codeunit No.';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Codeunit));

            trigger OnValidate()
            begin
                IF "Codeunit No." <> 0 THEN
                    TESTFIELD("Job Type", "Job Type"::Navision);
            end;
        }
        field(50; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
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
        "No. Series" := ReplicatorSetup."Scheduler Nos.";
        if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then "No. Series" := xRec."No. Series";
        "No." := NoSeriesMgt.GetNextNo("No. Series");
    end;

    var
        tags: Record 55459;
        ReplicatorSetup: Record 55460;
        Sched: Record 55458;
        NoSeriesMgt: Codeunit 310;

    procedure AssistEdit(OldSched: Record 55458): Boolean
    begin
        Sched := Rec;
        ReplicatorSetup.Get();
        ReplicatorSetup.TestField("Scheduler Nos.");

        if NoSeriesMgt.LookupRelatedNoSeries(
             ReplicatorSetup."Scheduler Nos.",
             OldSched."No. Series",
             Sched."No. Series")
        then begin
            Sched."No." := NoSeriesMgt.GetNextNo(Sched."No. Series");
            Rec := Sched;
            exit(true);
        end;

        exit(false);
    end;
}

