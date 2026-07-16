codeunit 56205 "Async SendPostRequest"
{
    // Dynamics.is - Gunnar Þor Gestsson

    TableNo = 56200;

    trigger OnRun()
    var
        MdeMgnt: Codeunit 56202;
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

