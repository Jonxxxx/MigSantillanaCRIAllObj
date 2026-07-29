table 64835 "Replicator Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(10; "Date Shut Down"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Shut Down';
        }
        field(11; "Time Shut Down"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Shut Down';
        }
        field(12; "Repeat Interval (sec.)"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Repeat Interval (sec.)';
            InitValue = 5;
        }
        field(13; Running; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Running';

            trigger OnValidate()
            begin
                IF (NOT Running) AND xRec.Running THEN
                    IF NOT CONFIRM(
                      'Please ensure that the Scheduler is not\' +
                      'running somewhere else - continue?', FALSE)
                    THEN
                        ERROR('Stop the scheduler from the workstation running it.');
                IF Running AND (NOT xRec.Running) THEN
                    ERROR('You can start the Automatic Scheduler from the main menu.');
            end;
        }
        field(14; "Register Scheduler actions"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Register Scheduler actions';
        }
        field(15; "Calcdate Day char"; Text[1])
        {
            DataClassification = CustomerContent;
            Caption = 'Calcdate Day char';
            InitValue = 'D';
        }
        field(16; "Calcdate Month char"; Text[1])
        {
            DataClassification = CustomerContent;
            Caption = 'Calcdate Month char';
            InitValue = 'M';
        }
        field(20; "Specification Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Specification Nos.';
            TableRelation = "No. Series";
        }
        field(21; "Scheduler Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduler Nos.';
            TableRelation = "No. Series";
        }
        field(30; "Local Database Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Database Code';
            TableRelation = EXCCRIDatabase.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Local Database Code" <> '' THEN
                    IF Database2.COUNT() > 0 THEN
                        Database2.GET("Local Database Code");
            end;
        }
        field(31; "Central Database Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Central Database Code';
            TableRelation = EXCCRIDatabase.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Central Database Code" <> '' THEN
                    IF Database2.COUNT() > 0 THEN
                        Database2.GET("Central Database Code");
            end;
        }
        field(40; "Shut Down Date (Sched)"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shut Down Date (Sched)';
        }
        field(41; "Shut Down Time (Sched)"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Shut Down Time (Sched)';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Database2: Record 64823;
}

