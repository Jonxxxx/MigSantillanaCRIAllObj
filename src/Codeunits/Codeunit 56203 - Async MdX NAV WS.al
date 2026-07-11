codeunit 56203 "Async MdX NAV WS"
{
    TableNo = 56200;

    trigger OnRun()
    var
        MdeMgnt: Codeunit 56202;
        IsError: Boolean;
    begin
        SETRANGE("Process Status", "Process Status"::Error);
        IF FINDFIRST THEN
            REPEAT
                CLEARLASTERROR;
                IF NOT CODEUNIT.RUN(CODEUNIT::"Async SendPostRequest", Rec) THEN BEGIN
                    SetProcessResponse(GETLASTERRORTEXT);
                    "Process Status" := "Process Status"::Error;
                    MODIFY;
                END;
            UNTIL NEXT = 0;
    end;

    procedure StartNewQueue(ProcessCode: Code[50]; ProcessURLWS: Text[150]; ProcessSoapAction: Text[50]; ProcessData: Text; var QueueId: Integer; var ResponseMessage: Text) Success: Boolean
    begin
        Success := TryCreateNewQueue(ProcessCode, ProcessURLWS, ProcessSoapAction, ProcessData, QueueId);
        IF NOT Success THEN
            ResponseMessage := GETLASTERRORTEXT;
    end;

    procedure GetQueueStatus(QueueId: Integer; var Status: Text; var ResponseMessage: Text) Success: Boolean
    begin
        Success := TryGetQueueStatus(QueueId, Status);
        IF NOT Success THEN
            ResponseMessage := GETLASTERRORTEXT;
    end;

    local procedure TryCreateNewQueue(ProcessCode: Code[50]; ProcessURLWS: Text[150]; ProcessSoapAction: Text[50]; ProcessData: Text; var QueueId: Integer) Success: Boolean
    var
        AsyncNAVProcessQueue: Record 56200;
    begin
        WITH AsyncNAVProcessQueue DO BEGIN
            INIT;
            "Entry No." := 0;
            "Process Code" := ProcessCode;
            SetProcessData(ProcessData);
            "Process User Id" := USERID;
            "URL Web Service" := ProcessURLWS;
            "Soap Action" := ProcessSoapAction;
            IF NOT INSERT(TRUE) THEN
                EXIT(FALSE);
            QueueId := "Entry No.";
            COMMIT;
        END;

        EXIT(OnNewQueueInserted(AsyncNAVProcessQueue));
    end;

    local procedure TryGetQueueStatus(QueueId: Integer; var Status: Text) Success: Boolean
    var
        AsyncNAVProcessQueue: Record 56200;
    begin
        WITH AsyncNAVProcessQueue DO BEGIN
            IF GET(QueueId) THEN BEGIN
                Success := TRUE;
                Status := FORMAT("Process Status");
            END
            ELSE
                Success := FALSE;
        END;
    end;

    local procedure OnNewQueueInserted(AsyncNAVProcessQueue Record: 56200") Success: Boolean
    begin
        EXIT(TRUE);
    end;
}

