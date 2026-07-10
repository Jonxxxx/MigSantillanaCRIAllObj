table 130401 "CAL Test Line"
{
    Caption = 'CAL Test Line';
    ReplicateData = false;

    fields
    {
        field(1; "Test Suite"; Code[10])
        {
            Caption = 'Test Suite';
            TableRelation = "CAL Test Suite".Name;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(3; "Line Type"; Option)
        {
            Caption = 'Line Type';
            Editable = false;
            InitValue = "Codeunit";
            OptionCaption = 'Group,Codeunit,Function';
            OptionMembers = Group,"Codeunit","Function";

            trigger OnValidate()
            begin
                CASE "Line Type" OF
                    "Line Type"::Group:
                        TESTFIELD("Test Codeunit", 0);
                    "Line Type"::Codeunit:
                        BEGIN
                            TESTFIELD("Function", '');
                            Name := '';
                        END;
                END;

                UpdateLevelNo;
            end;
        }
        field(4; "Test Codeunit"; Integer)
        {
            Caption = 'Test Codeunit';
            Editable = false;
            TableRelation = IF (Line Type=CONST(Codeunit)) AllObjWithCaption."Object ID" WHERE (Object Type=CONST(Codeunit),
                                                                                                Object Subtype=CONST(Test));

            trigger OnValidate()
            var
                AllObjWithCaption Record: 2000000058;
            begin
                IF "Test Codeunit" = 0 THEN
                    EXIT;
                TESTFIELD("Function", '');
                IF "Line Type" = "Line Type"::Group THEN
                    TESTFIELD("Test Codeunit", 0);
                IF AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Codeunit, "Test Codeunit") THEN
                    Name := AllObjWithCaption."Object Name";
                UpdateLevelNo;
            end;
        }
        field(5; Name; Text[128])
        {
            Caption = 'Name';
            Editable = false;

            trigger OnValidate()
            var
                TestUnitNo: Integer;
            begin
                CASE "Line Type" OF
                    "Line Type"::Group:
                        ;
                    "Line Type"::"Function":
                        TESTFIELD(Name, "Function");
                    "Line Type"::Codeunit:
                        BEGIN
                            TESTFIELD(Name);
                            EVALUATE(TestUnitNo, Name);
                            VALIDATE("Test Codeunit", TestUnitNo);
                        END;
                END;
            end;
        }
        field(6; "Function"; Text[128])
        {
            Caption = 'Function';
            Editable = false;

            trigger OnValidate()
            begin
                IF "Line Type" <> "Line Type"::"Function" THEN BEGIN
                    TESTFIELD("Function", '');
                    EXIT;
                END;
                UpdateLevelNo;
                Name := "Function";
            end;
        }
        field(7; Run; Boolean)
        {
            Caption = 'Run';

            trigger OnValidate()
            begin
                IF "Function" = 'OnRun' THEN
                    ERROR(CannotChangeValueErr);
                CALTestLine.COPY(Rec);
                UpdateGroup(CALTestLine);
                UpdateChildren(CALTestLine);
            end;
        }
        field(8; Result; Option)
        {
            Caption = 'Result';
            Editable = false;
            OptionCaption = ' ,Failure,Success,Skipped';
            OptionMembers = " ",Failure,Success,Skipped;

            trigger OnValidate()
            begin
                "First Error" := '';
            end;
        }
        field(9; "First Error"; Text[250])
        {
            Caption = 'First Error';
            Editable = false;
        }
        field(10; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            Editable = false;
        }
        field(11; "Finish Time"; DateTime)
        {
            Caption = 'Finish Time';
            Editable = false;
        }
        field(12; Level; Integer)
        {
            Caption = 'Level';
            Editable = false;
        }
        field(13; "Hit Objects"; Integer)
        {
            CalcFormula = Count("CAL Test Coverage Map" WHERE(Test Codeunit ID=FIELD(Test Codeunit)));
            Caption = 'Hit Objects';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Test Suite","Line No.")
        {
        }
        key(Key2;"Test Suite",Result,"Line Type",Run)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DeleteChildren;
    end;

    trigger OnInsert()
    begin
        IF "Line Type" = "Line Type"::Codeunit THEN
          CALTestMgt.RunSuite(Rec,FALSE);
    end;

    trigger OnModify()
    begin
        IF ("Line Type" = "Line Type"::Codeunit) AND
           ("Test Codeunit" <> xRec."Test Codeunit")
        THEN
          CALTestMgt.RunSuite(Rec,FALSE);
    end;

    var
        CALTestLine Record: 130401;
        CannotChangeValueErr: Label 'You cannot change the value of the OnRun.', Locked=true;
        CALTestMgt: Codeunit 130401;

    [Scope('Personalization')]
    procedure UpdateGroup(var CALTestLine Record: 130401")
    var
        CopyOfCALTestLine Record: 130401;
        OutOfGroup: Boolean;
    begin
        IF NOT CALTestLine.Run THEN
          EXIT;
        IF NOT ("Line Type" = "Line Type"::"Function") THEN
          EXIT;

        CopyOfCALTestLine.COPY(CALTestLine);
        WITH CALTestLine DO BEGIN
          RESET;
          SETRANGE("Test Suite","Test Suite");
          REPEAT
            OutOfGroup :=
              (NEXT(-1) = 0) OR
              ("Test Codeunit" <> CopyOfCALTestLine."Test Codeunit");

            IF (("Line Type" IN ["Line Type"::Group,"Line Type"::Codeunit]) OR ("Function" = 'OnRun')) AND
               NOT Run
            THEN BEGIN
              Run := TRUE;
              MODIFY;
            END;
          UNTIL OutOfGroup;
        END;
        CALTestLine.COPY(CopyOfCALTestLine);
    end;

    [Scope('Personalization')]
    procedure UpdateChildren(var CALTestLine Record: 130401")
    var
        CopyOfCALTestLine Record: 130401;
    begin
        IF CALTestLine."Line Type" = "Line Type"::"Function" THEN
          EXIT;

        CopyOfCALTestLine.COPY(CALTestLine);
        WITH CALTestLine DO BEGIN
          RESET;
          SETRANGE("Test Suite","Test Suite");
          WHILE (NEXT <> 0) AND NOT ("Line Type" IN ["Line Type"::Group,CopyOfCALTestLine."Line Type"]) DO BEGIN
            Run := CopyOfCALTestLine.Run;
            MODIFY;
          END;
        END;
        CALTestLine.COPY(CopyOfCALTestLine);
    end;

    [Scope('Personalization')]
    procedure GetMinCodeunitLineNo() MinLineNo: Integer
    var
        CALTestLine Record: 130401;
    begin
        WITH CALTestLine DO BEGIN
          COPY(Rec);
          RESET;
          SETRANGE("Test Suite","Test Suite");

          MinLineNo := "Line No.";
          REPEAT
            MinLineNo := "Line No.";
          UNTIL (Level < 2) OR (NEXT(-1) = 0);
        END;
    end;

    [Scope('Personalization')]
    procedure GetMaxGroupLineNo() MaxLineNo: Integer
    var
        CALTestLine Record: 130401;
    begin
        WITH CALTestLine DO BEGIN
          COPY(Rec);
          RESET;
          SETRANGE("Test Suite","Test Suite");

          MaxLineNo := "Line No.";
          WHILE (NEXT <> 0) AND (Level >= Rec.Level) DO
            MaxLineNo := "Line No.";
        END;
    end;

    [Scope('Personalization')]
    procedure GetMaxCodeunitLineNo(var NoOfFunctions: Integer) MaxLineNo: Integer
    var
        CALTestLine Record: 130401;
    begin
        TESTFIELD("Test Codeunit");
        NoOfFunctions := 0;

        WITH CALTestLine DO BEGIN
          COPY(Rec);
          RESET;
          SETRANGE("Test Suite","Test Suite");
          MaxLineNo := "Line No.";
          WHILE (NEXT <> 0) AND ("Line Type" = "Line Type"::"Function") DO BEGIN
            MaxLineNo := "Line No.";
            IF Run THEN
              NoOfFunctions += 1;
          END;
        END;
    end;

    [Scope('Personalization')]
    procedure DeleteChildren()
    var
        CopyOfCALTestLine Record: 130401;
    begin
        CopyOfCALTestLine.COPY(Rec);
        RESET;
        SETRANGE("Test Suite","Test Suite");
        WHILE (NEXT <> 0) AND (Level > CopyOfCALTestLine.Level) DO
          DELETE(TRUE);
        COPY(CopyOfCALTestLine);
    end;

    [Scope('Personalization')]
    procedure CalcTestResults(var Success: Integer;var Fail: Integer;var Skipped: Integer;var NotExecuted: Integer)
    var
        CALTestLine Record: 130401;
    begin
        CALTestLine.SETRANGE("Test Suite","Test Suite");
        CALTestLine.SETFILTER("Function",'<>%1','OnRun');
        CALTestLine.SETRANGE("Line Type","Line Type"::"Function");

        CALTestLine.SETRANGE(Result,Result::Success);
        Success := CALTestLine.COUNT;

        CALTestLine.SETRANGE(Result,Result::Failure);
        Fail := CALTestLine.COUNT;

        CALTestLine.SETRANGE(Result,Result::Skipped);
        Skipped := CALTestLine.COUNT;

        CALTestLine.SETRANGE(Result,Result::" ");
        NotExecuted := CALTestLine.COUNT;
    end;

    local procedure UpdateLevelNo()
    begin
        CASE "Line Type" OF
          "Line Type"::Group:
            Level := 0;
          "Line Type"::Codeunit:
            Level := 1;
          ELSE
            Level := 2;
        END;
    end;

    [Scope('Personalization')]
    procedure ShowTestResults()
    var
        CALTestResult Record: 130405;
    begin
        CALTestResult.SETRANGE("Codeunit ID","Test Codeunit");
        IF "Function" <> '' THEN
          CALTestResult.SETRANGE("Function Name","Function");
        IF CALTestResult.FINDLAST THEN;
        PAGE.RUN(PAGE::"CAL Test Results",CALTestResult);
    end;
}

