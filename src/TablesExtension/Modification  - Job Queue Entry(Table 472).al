tableextension 70000058 tableextension70000058 extends "Job Queue Entry" 
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Hold On Finish"(Field 75000)".

    }

    //Unsupported feature: Property Modification (Attributes) on "DoesExistLocked(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "RefreshLocked(PROCEDURE 37)".


    //Unsupported feature: Property Modification (Attributes) on "IsExpired(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "IsReadyToStart(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "GetErrorMessage(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "SetErrorMessage(PROCEDURE 2)".


    //Unsupported feature: Code Modification on "SetErrorMessage(PROCEDURE 2)".

    //procedure SetErrorMessage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TextMgt.SetRecordErrorMessage("Error Message","Error Message 2","Error Message 3","Error Message 4",ErrorText);

        // ++ 001-YFC
        //IF rec.Status = rec.Status::Error THEN
         NotificarError.RUN(Rec);
        // -- 001-YFC
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TextMgt.SetRecordErrorMessage("Error Message","Error Message 2","Error Message 3","Error Message 4",ErrorText);
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "ShowErrorMessage(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "SetError(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "SetResult(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "SetResultDeletedEntry(PROCEDURE 46)".


    //Unsupported feature: Property Modification (Attributes) on "FinalizeRun(PROCEDURE 44)".


    //Unsupported feature: Property Modification (Attributes) on "GetLastLogEntryNo(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "InsertLogEntry(PROCEDURE 45)".


    //Unsupported feature: Property Modification (Attributes) on "FinalizeLogEntry(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "SetStatus(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "Cancel(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteTask(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "DeleteTasks(PROCEDURE 48)".


    //Unsupported feature: Property Modification (Attributes) on "Restart(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CancelTask(PROCEDURE 32)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleTask(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "ReuseExistingJobFromID(PROCEDURE 34)".


    //Unsupported feature: Property Modification (Attributes) on "ReuseExistingJobFromCatagory(PROCEDURE 35)".



    //Unsupported feature: Code Modification on "CleanupAfterExecution(PROCEDURE 11)".

    //procedure CleanupAfterExecution();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "Notify On Success" THEN
          CODEUNIT.RUN(CODEUNIT::"Job Queue - Send Notification",Rec);
        //fes
        IF "Recurring Job" THEN BEGIN
          // + MdM
          IF "Hold On Finish" THEN
            SetStatusValue(Status::"On Hold")
          ELSE
          // - MdM
          ClearServiceValues;
          IF Status = Status::"On Hold with Inactivity Timeout" THEN
            "Earliest Start Date/Time" := JobQueueDispatcher.CalcNextRunTimeHoldDuetoInactivityJob(Rec,CURRENTDATETIME)
          ELSE
            "Earliest Start Date/Time" := JobQueueDispatcher.CalcNextRunTimeForRecurringJob(Rec,CURRENTDATETIME);
          EnqueueTask;
          // + MdM
          "Hold On Finish" := FALSE;
          MODIFY;
          // - MdM
        END ELSE
          DELETE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Notify On Success" THEN
          CODEUNIT.RUN(CODEUNIT::"Job Queue - Send Notification",Rec);

        IF "Recurring Job" THEN BEGIN
        #10..15
        END ELSE
          DELETE;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetTimeout(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ShowStatusMsg(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "LookupRecordToProcess(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "LookupObjectID(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "GetXmlContent(PROCEDURE 66)".


    //Unsupported feature: Property Modification (Attributes) on "SetXmlContent(PROCEDURE 69)".


    //Unsupported feature: Property Modification (Attributes) on "GetReportParameters(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "SetReportParameters(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "RunReportRequestPage(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleJobQueueEntry(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleJobQueueEntryWithParameters(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleJobQueueEntryForLater(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "GetStartingDateTime(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "GetEndingDateTime(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleRecurrentJobQueueEntry(PROCEDURE 25)".


    //Unsupported feature: Property Modification (Attributes) on "ScheduleRecurrentJobQueueEntryWtihFrequency(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "InitRecurringJob(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "FindJobQueueEntry(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "GetDefaultDescription(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "IsToReportInbox(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "FilterInactiveOnHoldEntries(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "DoesJobNeedToBeRun(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterReschedule(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeClearServiceValues(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeInsertLogEntry(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeModifyLogEntry(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeScheduleTask(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetStatusValue(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "OnFindingIfJobNeedsToBeRun(PROCEDURE 50)".



    //Unsupported feature: Property Modification (TextConstString) on "ExpiresBeforeStartErr(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //ExpiresBeforeStartErr : @@@="%1 = Expiration Date, %2=Start date";ENU=%1 must be later than %2.;ESM=%1 debe ser posterior a %2.;FRC=%1 doit être ultérieur à %2.;ENC=%1 must be later than %2.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ExpiresBeforeStartErr : @@@="%1 = Expiration Date, %2=Start date";ENU=%1 must be later than %2.;ESM=%1 debe ser posterior que %2.;FRC=%1 doit être ultérieur à %2.;ENC=%1 must be later than %2.;
        //Variable type has not been exported.
}

