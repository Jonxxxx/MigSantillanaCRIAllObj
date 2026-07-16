codeunit 56204 "Async MdX Process Starter"
{
    // Dynamics.is - Gunnar Þor Gestsson

    TableNo = 56200;

    trigger OnRun()
    begin
        StartAsyncSendPostRequest(Rec);
    end;

    local procedure StartAsyncSendPostRequest(AsyncNAVProcessQueue: Record 56200)
    var
        NewSessionId: Integer;
    begin
        WITH AsyncNAVProcessQueue DO
            IF "Process Code" IN ['IRM', 'WS_RESPUESTA_MDE', 'HORARIOSCECO', 'CECO'] THEN BEGIN
                FIND;
                "Process Status" := "Process Status"::Pending;
                "Process Start Date & Time" := CURRENTDATETIME;
                MODIFY;
                COMMIT;
                STARTSESSION(NewSessionId, CODEUNIT::"Async SendPostRequest", COMPANYNAME, AsyncNAVProcessQueue);
            END;
    end;
}

