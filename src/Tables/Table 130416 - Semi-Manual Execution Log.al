table 130416 "Semi-Manual Execution Log"
{
    Caption = 'Semi-Manual Execution Log';
    ReplicateData = false;

    fields
    {
        field(1; "Time stamp"; DateTime)
        {
            Caption = 'Time stamp';
        }
        field(2; "Step description 1"; Text[250])
        {
            Caption = 'Step description 1';
        }
        field(3; "Step description 2"; Text[250])
        {
            Caption = 'Step description 2';
        }
        field(4; "Step description 3"; Text[250])
        {
            Caption = 'Step description 3';
        }
        field(5; "Step description 4"; Text[250])
        {
            Caption = 'Step description 4';
        }
        field(6; Id; Integer)
        {
            AutoIncrement = true;
            Caption = 'Id';
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    procedure Log(Message: Text[1000])
    begin
        INIT;
        Id := 0;
        "Time stamp" := CURRENTDATETIME;
        "Step description 1" := COPYSTR(Message, 1, 250);
        "Step description 2" := COPYSTR(Message, 251, 250);
        "Step description 3" := COPYSTR(Message, 501, 250);
        "Step description 4" := COPYSTR(Message, 751, 250);
        INSERT;
        COMMIT;
    end;

    procedure GetMessage(): Text[1000]
    begin
        EXIT("Step description 1" + "Step description 2" + "Step description 3" + "Step description 4");
    end;
}

