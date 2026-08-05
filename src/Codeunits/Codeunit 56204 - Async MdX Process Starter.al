codeunit 55357 "Async MdX Process Starter"
{
    // Dynamics.is - Gunnar Þor Gestsson

    TableNo = 55353;

    trigger OnRun()
    begin
        StartAsyncSendPostRequest(Rec);
    end;

    local procedure StartAsyncSendPostRequest(AsyncNAVProcessQueue: Record 55353)
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

