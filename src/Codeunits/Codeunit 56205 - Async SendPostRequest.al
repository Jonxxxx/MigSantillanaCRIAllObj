codeunit 55358 "Async SendPostRequest"
{
    // Dynamics.is - Gunnar Þor Gestsson

    TableNo = 55353;

    trigger OnRun()
    var
        MdeMgnt: Codeunit 55355;
        IsError: Boolean;
    begin
        FIND;
        SetProcessResponse(MdeMgnt.SendPostRequestNoError("URL Web Service", "Soap Action", GetProcessData(), IsError));
        IF IsError THEN
            "Process Status" := "Process Status"::Error
        ELSE
            "Process Status" := "Process Status"::Completed;
        "Process End Date & Time" := CURRENTDATETIME;
        MODIFY;
    end;
}

