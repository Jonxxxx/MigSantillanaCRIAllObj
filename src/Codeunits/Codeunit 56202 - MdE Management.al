codeunit 56202 "MdE Management"
{
    // #101415 17/11/2017 PLB: Se ha separado la función SendAsyncPostRequest en dos:
    //                       CreateAsyncPostRequest
    //                       SendAsyncPostRequest
    // MdM JPT 25/09/17 Añadonueva función SendPostRequest2


    trigger OnRun()
    begin
    end;

    var
        ConfSant Record: 56001;
        ErrorInsert: Label 'Sólo se puede crear "%1" desde el MdE.';
        ErrorModify: Label 'Sólo se puede modificar "%1" de la tabla "%2" desde el MdE.';
        ErrorDelete: Label 'Sólo se puede borrar "%1" desde el MdE.';
        AsyncProcQueue Record: 56200;

    procedure CreateAsyncPostRequest(ProcessCode: Code[50]; Url: Text[150]; SoapAction: Text[250]; Content: Text): Text
    var
        AsyncWS: Codeunit 56203;
        IsError: Boolean;
        ResponseMessage: Text;
        QueueId: Integer;
    begin
        //+#101415
        IF NOT AsyncWS.StartNewQueue(ProcessCode, Url, SoapAction, Content, QueueId, ResponseMessage) THEN
            ERROR(ResponseMessage);

        AsyncProcQueue.GET(QueueId);
    end;

    procedure SendAsyncPostRequest(): Text
    var
        AsyncProcStarter: Codeunit 56204;
    begin
        //+#101415
        AsyncProcQueue.MODIFY;
        AsyncProcStarter.RUN(AsyncProcQueue);
    end;

    procedure SendPostRequest(Url: Text[150]; SoapAction: Text[250]; Content: Text): Text
    var
        IsError: Boolean;
    begin
        EXIT(SendPostRequestLocal(Url, SoapAction, Content, FALSE, IsError));
    end;

    procedure SendPostRequest2(Url: Text[150]; SoapAction: Text[250]; Content: Text; ShowError: Boolean; var IsError: Boolean): Text
    begin
        // MdM
        EXIT(SendPostRequestLocal(Url, SoapAction, Content, ShowError, IsError));
    end;

    procedure SendPostRequestNoError(Url: Text[150]; SoapAction: Text[250]; Content: Text; var IsError: Boolean): Text
    begin
        EXIT(SendPostRequestLocal(Url, SoapAction, Content, TRUE, IsError));
    end;

    local procedure SendPostRequestLocal(Url: Text[150]; SoapAction: Text[250]; Content: Text; ShowError: Boolean; var IsError: Boolean) Response: Text
    var
        HttpClient: DotNet HttpClient;
        Uri: DotNet Uri;
        HttpResponseMessage: DotNet HttpResponseMessage;
        StringContent: DotNet StringContent;
        TextEncoding: DotNet Encoding;
        Status: Integer;
    begin
        HttpClient := HttpClient.HttpClient();
        Uri := Uri.Uri(Url);
        HttpClient.BaseAddress(Uri);

        // Header
        //HttpClient.DefaultRequestHeaders.Add('Content-type', 'application/soap+xml; charset=utf-8'); // esta da error
        HttpClient.DefaultRequestHeaders.Add('SOAPAction', SoapAction);
        HttpClient.DefaultRequestHeaders.Add('Host', Uri.Host);


        StringContent := StringContent.StringContent(Content, TextEncoding.UTF8, 'application/soap+xml');

        //HttpClient.Timeout

        // Get response
        HttpResponseMessage := HttpClient.PostAsync(Uri, StringContent).Result;

        // Save data
        Status := HttpResponseMessage.StatusCode;
        Response := HttpResponseMessage.Content.ReadAsStringAsync().Result;

        // Check reponse status
        IF (Status < 200) OR (Status > 299) THEN BEGIN
            IF ShowError THEN
                ERROR(Response)
            ELSE
                IsError := TRUE;
        END;
    end;

    procedure AddElement(var XMLNode: DotNet XmlNode; NodeName: Text[250]; NodeText: Text[250]; Prefix: Text[250]; NSUri: Text[250]; var CreatedXMLNode: DotNet XmlNode) ExitStatus: Integer
    var
        NewChildNode: DotNet XmlNode;
        XmlNodeType: DotNet XmlNodeType;
    begin
        NewChildNode := XMLNode.OwnerDocument.CreateNode(XmlNodeType.Element, Prefix, NodeName, NSUri);

        IF ISNULL(NewChildNode) THEN BEGIN
            ExitStatus := 50;
            EXIT;
        END;

        IF NodeText <> '' THEN
            NewChildNode.InnerText := NodeText;

        XMLNode.AppendChild(NewChildNode);
        CreatedXMLNode := NewChildNode;

        ExitStatus := 0;
    end;

    procedure FormatDateTime(Fecha: Date; Hora: Time) TxtFecha: Text[50]
    var
        DT: DateTime;
    begin
        DT := CREATEDATETIME(Fecha, Hora);
        TxtFecha := FORMAT(DT, 0, 9);
        TxtFecha := COPYSTR(TxtFecha, 1, 19); // eliminamos el último carácter (Z): 2016-06-30T22:00:00Z --> 2016-06-30T22:00:00
    end;

    procedure FormatDate(Fecha: Date) TxtFecha: Text[50]
    begin
        TxtFecha := FORMAT(Fecha, 0, '<Year4>-<Month,2>-<Day,2>T00:00:00'); //2016-06-30T00:00:00
    end;

    procedure Employee_Insert(var Employee Record: 5200")
    begin
        ConfSant.GET;
        IF ConfSant."MdE Activo" THEN
            ERROR(ErrorInsert, Employee.TABLECAPTION);
    end;

    procedure Employee_Modify(var Rec Record: 5200; var xRec Record: 5200")
    var
        ConfCont Record: 98;
    begin
        ConfSant.GET;

        IF ConfSant."MdE Activo" THEN BEGIN

            IF Rec."First Name" <> xRec."First Name" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("First Name"), Rec.TABLECAPTION);

            IF Rec."Last Name" <> xRec."Last Name" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Last Name"), Rec.TABLECAPTION);

            IF Rec."Second Last Name" <> xRec."Second Last Name" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Second Last Name"), Rec.TABLECAPTION);

            IF Rec."Employment Date" <> xRec."Employment Date" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Employment Date"), Rec.TABLECAPTION);

            IF Rec."Document Type" <> xRec."Document Type" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Document Type"), Rec.TABLECAPTION);

            IF Rec."Document ID" <> xRec."Document ID" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Document ID"), Rec.TABLECAPTION);

            IF Rec.Gender <> xRec.Gender THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION(Gender), Rec.TABLECAPTION);

            IF Rec."Estado civil" <> xRec."Estado civil" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Estado civil"), Rec.TABLECAPTION);

            IF Rec."Birth Date" <> xRec."Birth Date" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Birth Date"), Rec.TABLECAPTION);

            IF Rec.Nacionalidad <> xRec.Nacionalidad THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION(Nacionalidad), Rec.TABLECAPTION);

            IF Rec."Country/Region Code" <> xRec."Country/Region Code" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Country/Region Code"), Rec.TABLECAPTION);

            IF Rec.Address <> xRec.Address THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION(Address), Rec.TABLECAPTION);

            IF Rec.City <> xRec.City THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION(City), Rec.TABLECAPTION);

            IF Rec."Post Code" <> xRec."Post Code" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Post Code"), Rec.TABLECAPTION);

            IF Rec.County <> xRec.County THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION(County), Rec.TABLECAPTION);

            IF Rec."E-Mail" <> xRec."E-Mail" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("E-Mail"), Rec.TABLECAPTION);

            IF Rec."Phone No." <> xRec."Phone No." THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Phone No."), Rec.TABLECAPTION);

            IF ConfSant."Posicion MdE" = ConfSant."Posicion MdE"::"Puesto laboral" THEN
                IF Rec."Job Type Code" <> xRec."Job Type Code" THEN
                    ERROR(ErrorModify, Rec.FIELDCAPTION("Job Type Code"), Rec.TABLECAPTION);

            IF Rec."Working Center" <> xRec."Working Center" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Working Center"), Rec.TABLECAPTION);

            IF Rec."Categoria old" <> xRec."Categoria old" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Categoria old"), Rec.TABLECAPTION);

            IF Rec."Emplymt. Contract Code" <> xRec."Emplymt. Contract Code" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Emplymt. Contract Code"), Rec.TABLECAPTION);

            IF ConfSant."Departamento MdE"::Division IN [ConfSant."Departamento MdE", ConfSant."Division MdE", ConfSant."Area funcional MdE"] THEN
                IF Rec.Departamento <> xRec.Departamento THEN
                    ERROR(ErrorModify, Rec.FIELDCAPTION(Departamento), Rec.TABLECAPTION);

            ConfCont.GET;

            IF ConfCont."Global Dimension 1 Code" IN [ConfSant."Dimension Departamento", ConfSant."Dimension Division", ConfSant."Dimension Area funcional"] THEN
                IF Rec."Global Dimension 1 Code" <> xRec."Global Dimension 1 Code" THEN
                    ERROR(ErrorModify, Rec.FIELDCAPTION("Global Dimension 1 Code"), Rec.TABLECAPTION);

            IF ConfCont."Global Dimension 2 Code" IN [ConfSant."Dimension Departamento", ConfSant."Dimension Division", ConfSant."Dimension Area funcional"] THEN
                IF Rec."Global Dimension 2 Code" <> xRec."Global Dimension 2 Code" THEN
                    ERROR(ErrorModify, Rec.FIELDCAPTION("Global Dimension 2 Code"), Rec.TABLECAPTION);

        END;
    end;

    procedure Employee_Delete(var Employee Record: 5200")
    begin
        ConfSant.GET;
        IF ConfSant."MdE Activo" THEN
            ERROR(ErrorDelete, Employee.TABLECAPTION);
    end;

    procedure Contrato_Insert(var Contrato Record: 34002109")
    begin
        ConfSant.GET;
        IF ConfSant."MdE Activo" THEN
            ERROR(ErrorDelete, Contrato.TABLECAPTION);
    end;

    procedure Contrato_Modify(var Rec Record: 34002109; var xRec Record: 34002109")
    begin
        ConfSant.GET;
        IF ConfSant."MdE Activo" THEN BEGIN

            IF Rec."Cód. contrato" <> xRec."Cód. contrato" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Cód. contrato"), Rec.TABLECAPTION);

            IF ConfSant."Posicion MdE" = ConfSant."Posicion MdE"::"Puesto laboral" THEN
                IF Rec.Cargo <> xRec.Cargo THEN
                    ERROR(ErrorModify, Rec.FIELDCAPTION(Cargo), Rec.TABLECAPTION);

            IF Rec."Cód. contrato" <> xRec."Cód. contrato" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Cód. contrato"), Rec.TABLECAPTION);

            IF Rec."Fecha inicio" <> xRec."Fecha inicio" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Fecha inicio"), Rec.TABLECAPTION);

            IF Rec."Fecha finalización" <> xRec."Fecha finalización" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Fecha finalización"), Rec.TABLECAPTION);

            // Activo no puede gestionarse por el MdE, el usuario lo hará manualmente
            //IF Rec.Activo <> xRec.Activo THEN
            //  ERROR(ErrorModify, Rec.FIELDCAPTION(Activo), Rec.TABLECAPTION);

            IF Rec."Centro trabajo" <> xRec."Centro trabajo" THEN
                ERROR(ErrorModify, Rec.FIELDCAPTION("Centro trabajo"), Rec.TABLECAPTION);

        END;
    end;

    procedure Contrato_Delete(var Contrato Record: 34002109")
    begin
        ConfSant.GET;
        IF ConfSant."MdE Activo" THEN
            ERROR(ErrorDelete, Contrato.TABLECAPTION);
    end;

    procedure GetOutStrm(var OutStrm: OutStream)
    begin
        //+#101415
        AsyncProcQueue."Received Data".CREATEOUTSTREAM(OutStrm);
    end;
}

