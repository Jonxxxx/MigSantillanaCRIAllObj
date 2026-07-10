table 130405 "CAL Test Result"
{
    Caption = 'CAL Test Result';
    ReplicateData = false;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; "Test Run No."; Integer)
        {
            Caption = 'Test Run No.';
        }
        field(3; "Codeunit ID"; Integer)
        {
            Caption = 'Codeunit ID';

            trigger OnValidate()
            begin
                SetCodeunitName;
            end;
        }
        field(4; "Codeunit Name"; Text[30])
        {
            Caption = 'Codeunit Name';
        }
        field(5; "Function Name"; Text[128])
        {
            Caption = 'Function Name';
        }
        field(6; Platform; Option)
        {
            Caption = 'Platform';
            OptionCaption = 'Classic,ServiceTier';
            OptionMembers = Classic,ServiceTier;
        }
        field(7; Result; Option)
        {
            Caption = 'Result';
            InitValue = Incomplete;
            OptionCaption = 'Passed,Failed,Inconclusive,Incomplete';
            OptionMembers = Passed,Failed,Inconclusive,Incomplete;
        }
        field(8; Restore; Boolean)
        {
            Caption = 'Restore';
        }
        field(9; "Execution Time"; Duration)
        {
            Caption = 'Execution Time';
        }
        field(10; "Error Code"; Text[250])
        {
            Caption = 'Error Code';
        }
        field(11; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(12; File; Text[250])
        {
            Caption = 'File';
        }
        field(14; "Call Stack"; BLOB)
        {
            Caption = 'Call Stack';
            Compressed = false;
        }
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit 418;
            begin
                UserMgt.LookupUserID("User ID");
            end;
        }
        field(16; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            Editable = false;
        }
        field(17; "Finish Time"; DateTime)
        {
            Caption = 'Finish Time';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Test Run No.", "Codeunit ID", "Function Name", Platform)
        {
        }
    }

    fieldgroups
    {
    }

    procedure Add(SourceCALTestLine Record: 130401; TestRunNo: Integer)
    begin
        Initialize(TestRunNo, SourceCALTestLine."Test Codeunit", SourceCALTestLine."Function", SourceCALTestLine."Start Time");
        Update(SourceCALTestLine.Result = SourceCALTestLine.Result::Success, SourceCALTestLine."Finish Time");
    end;

    [Scope('Personalization')]
    procedure Initialize(TestRunNo: Integer; CodeunitId: Integer; FunctionName: Text[128]; StartTime: DateTime): Boolean
    begin
        INIT;
        "No." := GetNextNo;
        "Test Run No." := TestRunNo;
        VALIDATE("Codeunit ID", CodeunitId);
        "Function Name" := FunctionName;
        "Start Time" := StartTime;
        "User ID" := USERID;
        Result := Result::Incomplete;
        Platform := Platform::ServiceTier;
        INSERT;
    end;

    procedure Update(Success: Boolean; FinishTime: DateTime)
    var
        Out: OutStream;
    begin
        IF Success THEN BEGIN
            Result := Result::Passed;
            CLEARLASTERROR;
        END ELSE BEGIN
            "Error Code" := CropTo(GETLASTERRORCODE, 250);
            "Error Message" := CropTo(GETLASTERRORTEXT, 250);
            "Call Stack".CREATEOUTSTREAM(Out);
            Out.WRITETEXT(GETLASTERRORCALLSTACK);
            IF STRPOS("Error Message", 'Known failure:') = 1 THEN
                Result := Result::Inconclusive
            ELSE
                Result := Result::Failed;
        END;

        "Finish Time" := FinishTime;
        "Execution Time" := "Finish Time" - "Start Time";
        MODIFY;
    end;

    local procedure GetNextNo(): Integer
    var
        CALTestResult Record: 130405;
    begin
        IF CALTestResult.FINDLAST THEN
            EXIT(CALTestResult."No." + 1);
        EXIT(1);
    end;

    local procedure CropTo(String: Text; Length: Integer): Text[250]
    begin
        IF STRLEN(String) > Length THEN
            EXIT(PADSTR(String, Length));
        EXIT(String);
    end;

    [Scope('Personalization')]
    procedure LastTestRunNo(): Integer
    begin
        SETCURRENTKEY("Test Run No.", "Codeunit ID", "Function Name", Platform);
        IF FINDLAST THEN;
        EXIT("Test Run No.");
    end;

    local procedure SetCodeunitName()
    var
        AllObjWithCaption Record: 2000000058;
    begin
        AllObjWithCaption.SETRANGE("Object Type", AllObjWithCaption."Object Type"::Codeunit);
        AllObjWithCaption.SETRANGE("Object ID", "Codeunit ID");
        IF AllObjWithCaption.FINDFIRST THEN
            "Codeunit Name" := AllObjWithCaption."Object Name";
    end;
}

