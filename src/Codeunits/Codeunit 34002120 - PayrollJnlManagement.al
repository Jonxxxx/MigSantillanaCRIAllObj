codeunit 34002120 PayrollJnlManagement
{
    Permissions = TableData 209 = imd,
                  TableData 237 = imd,
                  TableData 1015 = rimd;

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'JOB';
        Text001: Label 'Job Journal';
        Text004: Label 'DEFAULT';
        Text005: Label 'Default Journal';
        LastJobJnlLine: Record 34002172;
        OpenFromBatch: Boolean;

    procedure TemplateSelection(PageID: Integer; RecurringJnl: Boolean; var JobJnlLine: Record 34002172; var JnlSelected: Boolean)
    var
        JobJnlTemplate: Record 34002174;
    begin
        JnlSelected := TRUE;

        JobJnlTemplate.RESET;
        JobJnlTemplate.SETRANGE("Page ID", PageID);

        CASE JobJnlTemplate.COUNT OF
            0:
                BEGIN
                    JobJnlTemplate.INIT;
                    JobJnlTemplate.Name := Text000;
                    JobJnlTemplate.Description := Text001;
                    JobJnlTemplate.VALIDATE("Page ID", PageID);
                    JobJnlTemplate.INSERT;
                    COMMIT;
                END;
            1:
                JobJnlTemplate.FINDFIRST;
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, JobJnlTemplate) = ACTION::LookupOK;
        END;
        IF JnlSelected THEN BEGIN
            JobJnlLine.FILTERGROUP := 2;
            JobJnlLine.SETRANGE("Journal Template Name", JobJnlTemplate.Name);
            JobJnlLine.FILTERGROUP := 0;
            IF OpenFromBatch THEN BEGIN
                JobJnlLine."Journal Template Name" := '';
                PAGE.RUN(JobJnlTemplate."Page ID", JobJnlLine);
            END;
        END;
    end;

    procedure TemplateSelectionFromBatch(var JobJnlBatch: Record 34002173)
    var
        JobJnlLine: Record 34002172;
        JobJnlTemplate: Record 34002174;
    begin
        OpenFromBatch := TRUE;
        JobJnlTemplate.GET(JobJnlBatch."Journal Template Name");
        JobJnlTemplate.TESTFIELD("Page ID");
        JobJnlBatch.TESTFIELD(Name);

        JobJnlLine.FILTERGROUP := 2;
        JobJnlLine.SETRANGE("Journal Template Name", JobJnlTemplate.Name);
        JobJnlLine.FILTERGROUP := 0;

        JobJnlLine."Journal Template Name" := '';
        JobJnlLine."Journal Batch Name" := JobJnlBatch.Name;
        PAGE.RUN(JobJnlTemplate."Page ID", JobJnlLine);
    end;

    procedure OpenJnl(var CurrentJnlBatchName: Code[10]; var JobJnlLine: Record 34002172)
    begin
        CheckTemplateName(JobJnlLine.GETRANGEMAX("Journal Template Name"), CurrentJnlBatchName);
        JobJnlLine.FILTERGROUP := 2;
        JobJnlLine.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
        JobJnlLine.FILTERGROUP := 0;
    end;

    procedure OpenJnlBatch(var JobJnlBatch: Record 34002173)
    var
        JobJnlTemplate: Record 34002174;
        JobJnlLine: Record 34002172;
        JnlSelected: Boolean;
    begin
        IF JobJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            EXIT;
        JobJnlBatch.FILTERGROUP(2);
        IF JobJnlBatch.GETFILTER("Journal Template Name") <> '' THEN BEGIN
            JobJnlBatch.FILTERGROUP(0);
            EXIT;
        END;
        JobJnlBatch.FILTERGROUP(0);

        IF NOT JobJnlBatch.FIND('-') THEN BEGIN
            IF NOT JobJnlTemplate.FINDFIRST THEN
                TemplateSelection(0, FALSE, JobJnlLine, JnlSelected);
            IF JobJnlTemplate.FINDFIRST THEN
                CheckTemplateName(JobJnlTemplate.Name, JobJnlBatch.Name);
            IF NOT JobJnlTemplate.FINDFIRST THEN
                TemplateSelection(0, TRUE, JobJnlLine, JnlSelected);
            IF JobJnlTemplate.FINDFIRST THEN
                CheckTemplateName(JobJnlTemplate.Name, JobJnlBatch.Name);
        END;
        JobJnlBatch.FIND('-');
        JnlSelected := TRUE;
        IF JobJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            JobJnlTemplate.SETRANGE(Name, JobJnlBatch.GETFILTER("Journal Template Name"));
        CASE JobJnlTemplate.COUNT OF
            1:
                JobJnlTemplate.FINDFIRST;
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, JobJnlTemplate) = ACTION::LookupOK;
        END;
        IF NOT JnlSelected THEN
            ERROR('');

        JobJnlBatch.FILTERGROUP(2);
        JobJnlBatch.SETRANGE("Journal Template Name", JobJnlTemplate.Name);
        JobJnlBatch.FILTERGROUP(0);
    end;

    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10]; var CurrentJnlBatchName: Code[10])
    var
        JobJnlBatch: Record 34002173;
    begin
        JobJnlBatch.SETRANGE("Journal Template Name", CurrentJnlTemplateName);
        IF NOT JobJnlBatch.GET(CurrentJnlTemplateName, CurrentJnlBatchName) THEN BEGIN
            IF NOT JobJnlBatch.FINDFIRST THEN BEGIN
                JobJnlBatch.INIT;
                JobJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
                JobJnlBatch.SetupNewBatch;
                JobJnlBatch.Name := Text004;
                JobJnlBatch.Description := Text005;
                JobJnlBatch.INSERT(TRUE);
                COMMIT;
            END;
            CurrentJnlBatchName := JobJnlBatch.Name;
        END;
    end;

    procedure CheckName(CurrentJnlBatchName: Code[10]; var JobJnlLine: Record 34002172)
    var
        JobJnlBatch: Record 34002173;
    begin
        JobJnlBatch.GET(JobJnlLine.GETRANGEMAX("Journal Template Name"), CurrentJnlBatchName);
    end;

    procedure SetName(CurrentJnlBatchName: Code[10]; var JobJnlLine: Record 34002172)
    begin
        JobJnlLine.FILTERGROUP := 2;
        JobJnlLine.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
        JobJnlLine.FILTERGROUP := 0;
        IF JobJnlLine.FIND('-') THEN;
    end;

    procedure LookupName(var CurrentJnlBatchName: Code[10]; var JobJnlLine: Record 34002172): Boolean
    var
        JobJnlBatch: Record 34002173;
    begin
        COMMIT;
        JobJnlBatch."Journal Template Name" := JobJnlLine.GETRANGEMAX("Journal Template Name");
        JobJnlBatch.Name := JobJnlLine.GETRANGEMAX("Journal Batch Name");
        JobJnlBatch.FILTERGROUP(2);
        JobJnlBatch.SETRANGE("Journal Template Name", JobJnlBatch."Journal Template Name");
        JobJnlBatch.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, JobJnlBatch) = ACTION::LookupOK THEN BEGIN
            CurrentJnlBatchName := JobJnlBatch.Name;
            SetName(CurrentJnlBatchName, JobJnlLine);
        END;
    end;

    procedure GetNames(var JobJnlLine: Record 34002172; var JobDescription: Text[50]; var AccName: Text[50])
    var
        Job: Record 167;
        Res: Record 156;
        Item: Record 27;
        GLAcc: Record 15;
    begin
        IF (JobJnlLine."Job No." = '') OR
           (JobJnlLine."Job No." <> LastJobJnlLine."Job No.")
        THEN BEGIN
            JobDescription := '';
            IF Job.GET(JobJnlLine."Job No.") THEN
                JobDescription := Job.Description;
        END;
        /*GRN No va por el momento
        IF (JobJnlLine.Type <> LastJobJnlLine.Type) OR
           (JobJnlLine."No." <> LastJobJnlLine."No.")
        THEN BEGIN
          AccName := '';
          IF JobJnlLine."No." <> '' THEN
            CASE JobJnlLine.Type OF
              JobJnlLine.Type::Resource:
                IF Res.GET(JobJnlLine."No.") THEN
                  AccName := Res.Name;
              JobJnlLine.Type::Item:
                IF Item.GET(JobJnlLine."No.") THEN
                  AccName := Item.Description;
              JobJnlLine.Type::"G/L Account":
                IF GLAcc.GET(JobJnlLine."No.") THEN
                  AccName := GLAcc.Name;
            END;
        END;
        */
        LastJobJnlLine := JobJnlLine;

    end;
}

