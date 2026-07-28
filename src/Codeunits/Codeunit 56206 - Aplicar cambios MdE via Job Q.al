codeunit 56206 "Aplicar cambios MdE via Job Q"
{
    // #81969  27/01/2018 PLB: Tarea programada para aplicar los cambios en los empleados que vienen del MdE según la fecha efectiva
    // #269159 21.01.2020 RRT: Se descartarán los registros que ya hanb sido ejecutados con error detectado. No tiene sentido que vuelvan a ejecutarse.

    Permissions = TableData 56202 = rimd;
    TableNo = 472;

    trigger OnRun()
    var
        MdEHistory: Record 56202;
        MdEHistory2: Record 56202;
        IsOk: Boolean;
        DescErrorArray: array[10] of Text;
        TipoErrorArray: array[10] of Text;
    begin
        IsOk := TRUE;

        MdEHistory.SETCURRENTKEY(Aplicado, "Fecha efectiva");
        MdEHistory.SETRANGE(Aplicado, FALSE);

        //+#269159
        //... Para que no se ejecute cada vez, si ya se ha detectado un error.
        MdEHistory.SETRANGE("Error proceso", FALSE);
        //-#269159

        MdEHistory.SETRANGE("Fecha efectiva", 0D, TODAY);
        IF MdEHistory.FINDSET THEN
            REPEAT
                MdEHistory2 := MdEHistory;
                MdEHistory2.ApplyToEmployee;
                IF NOT MdEHistory2.GetErrors(DescErrorArray, TipoErrorArray) THEN BEGIN
                    IsOk := FALSE;
                    MdEHistory2."Error proceso" := TRUE;
                    MdEHistory2."Descripcion error" := COPYSTR(DescErrorArray[1], 1, MAXSTRLEN(MdEHistory2."Descripcion error"));
                    MdEHistory2.MODIFY;

                    SendNotification(MdEHistory2);  //+#269159

                END;
            UNTIL MdEHistory.NEXT = 0;

        //+#269159
        //... El SendNotificacion() anterior no cubre todos los errores que se hubieran detectado.
        /*
        IF NOT IsOk THEN BEGIN
          MdEHistory.FINDLAST;
          SendNotification(MdEHistory);
        END;
        */
        //-#269159

    end;

    var
        ErrorText: Label 'Error message:';

    procedure SendNotification(var MdEHistory: Record 56202)
    var
        ConfEmp: Record 56001;
        RecordLink: Record 2000000068;
        RecRef: RecordRef;
    begin
        ConfEmp.GET;
        IF ConfEmp."Usuario notificaciones MdE" = '' THEN
            EXIT;

        RecRef.GETTABLE(MdEHistory);

        RecordLink."Link ID" := 0;
        RecordLink."Record ID" := RecRef.RECORDID;
        RecordLink.Description := MdEHistory.TABLECAPTION;
        SetURL(MdEHistory, RecordLink);
        RecordLink.Type := RecordLink.Type::Note;
        RecordLink.Created := CURRENTDATETIME;
        RecordLink."User ID" := USERID;
        RecordLink.Company := COMPANYNAME;
        RecordLink.Notify := TRUE;
        RecordLink."To User ID" := ConfEmp."Usuario notificaciones MdE";
        SetText(MdEHistory, RecordLink);
        RecordLink.INSERT;
    end;

    local procedure SetURL(var MdEHistory: Record 56202; var RecordLink: Record 2000000068)
    var
        Link: Text;
    begin
        WITH MdEHistory DO BEGIN
            // Generates a URL such as dynamicsnav://host:port/instance/company/runpage?page=672&$filter=
            // The intent is to open up the Job Queue Entries page and show the list of "my errors".
            // TODO: Leverage parameters ",JobQueueEntry,TRUE)" to take into account the filters, which will add the
            // following to the Url: &$filter=JobQueueEntry.Status IS 2 AND JobQueueEntry."User ID" IS <UserID>.
            // This will also require setting the filters on the record, such as:
            // SETFILTER(Status,'=3');
            // SETFILTER("Posting User ID",'=%1',"Posting User ID");
            Link := GETURL(CLIENTTYPE::Default, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Lista Historial MdE") +
              STRSUBSTNO('&$filter=''%1''.''%2''%20IS%20''TRUE''%20AND%20''%1''.''%3''%20IS%20''FALSE''&mode=View',
                HtmlEncode(TABLENAME), HtmlEncode(FIELDNAME("Error proceso")), HtmlEncode(FIELDNAME(Aplicado)));

            RecordLink.URL1 := COPYSTR(Link, 1, MAXSTRLEN(RecordLink.URL1));
        END;
    end;

    local procedure SetText(var MdEHistory: Record 56202; var RecordLink: Record 2000000068)
    var
        RecordLinkManagement: Codeunit "Record Link Management";
        NoteText: Text;
    begin
        NoteText := STRSUBSTNO(ErrorText, MdEHistory."Descripcion error");
        RecordLinkManagement.WriteNote(RecordLink, NoteText);
    end;

    local procedure HtmlEncode(InText: Text[1024]): Text[1024]
    var
        TypeHelper: Codeunit "Type Helper";
        Value: Text;
    begin
        Value := InText;
        exit(CopyStr(TypeHelper.HtmlEncode(Value), 1, MaxStrLen(InText)));
    end;
}

