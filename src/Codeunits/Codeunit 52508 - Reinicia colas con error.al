codeunit 52508 "Reinicia colas con error"
{

    trigger OnRun()
    begin
        JobQueueEntry.RESET;
        JobQueueEntry.SETRANGE(Status, JobQueueEntry.Status::Error);
        IF JobQueueEntry.FINDSET THEN
            REPEAT
                JobQueueEntry.Restart;
            UNTIL JobQueueEntry.NEXT = 0;
    end;

    var
        JobQueueEntry Record: 472;
}

