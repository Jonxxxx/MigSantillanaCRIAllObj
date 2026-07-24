codeunit 34003003 "Consultas DGII"
{
    trigger OnRun()
    begin
        DescargarListadoRNC();
    end;

    var
        Err001: Label 'Se debe especificar un número de NCF';
        Err002: Label 'Fiscal Document No. invalid or not authorized for this vendor';
        RncNotFoundMsg: Label 'No se ha encontrado el RNC %1';
        HttpRequestFailedErr: Label 'The request to DGII could not be completed.';
        HttpStatusErr: Label 'DGII returned HTTP status %1.';
        FormTokenErr: Label 'The DGII form could not be initialized because the required security tokens were not found.';
        RncFileNotFoundErr: Label 'The DGII ZIP file does not contain DGII_RNC.TXT.';
        RncUrlLbl: Label 'https://dgii.gov.do/app/WebApps/ConsultasWeb2/ConsultasWeb/consultas/rnc.aspx', Locked = true;
        NcfUrlLbl: Label 'https://dgii.gov.do/app/WebApps/ConsultasWeb2/ConsultasWeb/consultas/ncf.aspx', Locked = true;
        RncZipUrlLbl: Label 'https://dgii.gov.do/app/WebApps/Consultas/RNC/DGII_RNC.zip', Locked = true;
        RncEntryNameLbl: Label 'DGII_RNC.TXT', Locked = true;
        DownloadingRncLbl: Label 'Downloading and extracting the DGII RNC file. @1@@@@@@@@@@';

    procedure BuscarRNC(NumeroDocumento: Text[30]; var Datos: array[6] of Text[250])
    var
        Client: HttpClient;
        ResponseHtml: Text;
        FormData: Text;
        ViewState: Text;
        ViewStateGenerator: Text;
        EventValidation: Text;
    begin
        Clear(Datos);
        NumeroDocumento := DelChr(NumeroDocumento, '=', '-. /_');

        Client.UseResponseCookies(true);
        GetFormTokens(Client, RncUrlLbl, ViewState, ViewStateGenerator, EventValidation);

        AddFormField(FormData, 'ctl00$smMain', 'ctl00$cphMain$upBusqueda|ctl00$cphMain$btnBuscarPorRNC');
        AddFormField(FormData, 'ctl00$cphMain$txtRNCCedula', NumeroDocumento);
        AddFormField(FormData, 'ctl00$cphMain$txtRazonSocial', '');
        AddFormField(FormData, 'ctl00$cphMain$hidActiveTab', '');
        AddFormField(FormData, '__EVENTTARGET', 'ctl00$cphMain$btnBuscarPorRNC');
        AddFormField(FormData, '__EVENTARGUMENT', '');
        AddFormField(FormData, '__VIEWSTATE', ViewState);
        AddFormField(FormData, '__VIEWSTATEGENERATOR', ViewStateGenerator);
        AddFormField(FormData, '__EVENTVALIDATION', EventValidation);
        AddFormField(FormData, '__ASYNCPOST', 'true');

        ResponseHtml := PostForm(Client, RncUrlLbl, FormData);

        Datos[1] := CopyStr(
            GetValueByLabels(ResponseHtml, 'RNC/Cédula', 'RNC/Cedula', 'RNC/Céd.'),
            1,
            250);
        Datos[2] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Nombre/Razón Social', 'Nombre / Razón Social', 'Razón Social'),
            1,
            250);
        Datos[3] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Nombre Comercial', 'Nombre comercial', ''),
            1,
            250);
        Datos[4] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Categoría', 'Categoria', ''),
            1,
            250);
        Datos[5] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Régimen de Pagos', 'Régimen de Pago', 'Regimen de Pagos'),
            1,
            250);
        Datos[6] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Estado', 'Estatus', ''),
            1,
            250);

        if AreResultValuesEmpty(Datos) then begin
            if GuiAllowed() then
                Message(RncNotFoundMsg, NumeroDocumento);

            Clear(Datos);
        end;
    end;

    procedure ValidaNCF(RNC: Text[19]; NCF: Code[30]; var Datos: array[6] of Text[250])
    begin
        QueryNcf(RNC, NCF, Datos);
    end;

    procedure ValidarRNC_NCF(RNC: Text[19]; NCF: Code[30]; var Datos: array[6] of Text[250])
    begin
        QueryNcf(RNC, NCF, Datos);
    end;

    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        NewString := CopyStr(ReplaceText(String, FindWhat, ReplaceWith), 1, MaxStrLen(NewString));
    end;

    procedure GuardarXML(codPrmDoc: Code[20]; StringXMLTXT: BigText)
    var
        TempBlob: Codeunit "Temp Blob";
        XmlInStream: InStream;
        XmlOutStream: OutStream;
        FileName: Text;
    begin
        TempBlob.CreateOutStream(XmlOutStream, TextEncoding::UTF8);
        StringXMLTXT.Write(XmlOutStream);
        Clear(XmlOutStream);

        if not GuiAllowed() then
            exit;

        TempBlob.CreateInStream(XmlInStream, TextEncoding::UTF8);
        FileName := codPrmDoc + '.txt';
        DownloadFromStream(XmlInStream, '', '', 'Text files (*.txt)|*.txt', FileName);
    end;

    procedure DescargarListadoRNC()
    var
        RNCDGII: Record 34003024;
        RNCDGIIImport: XmlPort 34003025;
        DownloadedZipTempBlob: Codeunit "Temp Blob";
        ExtractedTextTempBlob: Codeunit "Temp Blob";
        CleanTextTempBlob: Codeunit "Temp Blob";
        DataCompression: Codeunit "Data Compression";
        Client: HttpClient;
        Response: HttpResponseMessage;
        ZipInStream: InStream;
        SourceInStream: InStream;
        CleanInStream: InStream;
        TempOutStream: OutStream;
        CleanOutStream: OutStream;
        EntryList: List of [Text];
        EntryName: Text;
        RncEntryName: Text;
        LineText: Text;
        Window: Dialog;
        SOH: Char;
        US: Char;
    begin
        if GuiAllowed() then begin
            Window.Open(DownloadingRncLbl);
            Window.Update(1, 1000);
        end;

        Client.UseResponseCookies(true);

        if not Client.Get(RncZipUrlLbl, Response) then
            Error(HttpRequestFailedErr);

        EnsureSuccessfulResponse(Response);

        Response.Content.ReadAs(ZipInStream);
        DownloadedZipTempBlob.CreateOutStream(TempOutStream);
        CopyStream(TempOutStream, ZipInStream);
        Clear(TempOutStream);

        if GuiAllowed() then
            Window.Update(1, 3000);

        DownloadedZipTempBlob.CreateInStream(ZipInStream);
        DataCompression.OpenZipArchive(ZipInStream, false);
        DataCompression.GetEntryList(EntryList);

        foreach EntryName in EntryList do
            if IsRncFileEntry(EntryName) then begin
                RncEntryName := EntryName;
                break;
            end;

        if RncEntryName = '' then begin
            DataCompression.CloseZipArchive();
            Error(RncFileNotFoundErr);
        end;

        DataCompression.ExtractEntry(RncEntryName, ExtractedTextTempBlob);
        DataCompression.CloseZipArchive();

        if GuiAllowed() then
            Window.Update(1, 5000);

        ExtractedTextTempBlob.CreateInStream(SourceInStream, TextEncoding::Windows);
        CleanTextTempBlob.CreateOutStream(CleanOutStream, TextEncoding::Windows);

        SOH := 1;
        US := 31;

        while not SourceInStream.EOS do begin
            Clear(LineText);
            SourceInStream.ReadText(LineText);
            LineText := DelChr(LineText, '=', Format(SOH) + Format(US));
            CleanOutStream.WriteText(LineText);
            CleanOutStream.WriteText();
        end;

        Clear(CleanOutStream);

        if GuiAllowed() then
            Window.Update(1, 7000);

        CleanTextTempBlob.CreateInStream(CleanInStream, TextEncoding::Windows);

        // Delete the existing list only after the new file has been downloaded and extracted successfully.
        RNCDGII.DeleteAll();

        RNCDGIIImport.SetSource(CleanInStream);
        RNCDGIIImport.Import();

        if GuiAllowed() then begin
            Window.Update(1, 10000);
            Window.Close();
        end;
    end;

    local procedure QueryNcf(RNC: Text[19]; NCF: Code[30]; var Datos: array[6] of Text[250])
    var
        Client: HttpClient;
        ResponseHtml: Text;
        FormData: Text;
        ViewState: Text;
        ViewStateGenerator: Text;
        EventValidation: Text;
    begin
        Clear(Datos);
        RNC := DelChr(RNC, '=', '-. /_');

        if NCF = '' then
            Error(Err001);

        Client.UseResponseCookies(true);
        GetFormTokens(Client, NcfUrlLbl, ViewState, ViewStateGenerator, EventValidation);

        AddFormField(FormData, 'ctl00$smMain', 'ctl00$upMainMaster|ctl00$cphMain$btnConsultar');
        AddFormField(FormData, 'ctl00$cphMain$txtRNC', RNC);
        AddFormField(FormData, 'ctl00$cphMain$txtNCF', NCF);
        AddFormField(FormData, 'ctl00$cphMain$txtRNCComprador', '');
        AddFormField(FormData, 'ctl00$cphMain$txtCodigoSeguridad', '');
        AddFormField(FormData, 'ctl00$cphMain$btnConsultar', 'Buscar');
        AddFormField(FormData, '__EVENTTARGET', '');
        AddFormField(FormData, '__EVENTARGUMENT', '');
        AddFormField(FormData, '__VIEWSTATE', ViewState);
        AddFormField(FormData, '__VIEWSTATEGENERATOR', ViewStateGenerator);
        AddFormField(FormData, '__EVENTVALIDATION', EventValidation);
        AddFormField(FormData, '__ASYNCPOST', 'true');

        ResponseHtml := PostForm(Client, NcfUrlLbl, FormData);

        Datos[1] := CopyStr(
            GetValueByLabels(ResponseHtml, 'RNC/Cédula', 'RNC/Cedula', 'Registro Nacional del Contribuyente'),
            1,
            250);
        Datos[2] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Nombre/Razón Social', 'Nombre / Razón Social', 'Razón Social'),
            1,
            250);
        Datos[3] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Tipo de comprobante', 'Tipo Comprobante', 'Tipo de Comprobante'),
            1,
            250);
        Datos[4] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Número de Comprobante Fiscal', 'NCF', 'Número Comprobante Fiscal'),
            1,
            250);
        Datos[5] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Estado', 'Estatus', ''),
            1,
            250);
        Datos[6] := CopyStr(
            GetValueByLabels(ResponseHtml, 'Válido hasta', 'Vigencia', 'Fecha de vencimiento'),
            1,
            250);

        if AreResultValuesEmpty(Datos) then
            Error(Err002);
    end;

    local procedure GetFormTokens(var Client: HttpClient; Url: Text; var ViewState: Text; var ViewStateGenerator: Text; var EventValidation: Text)
    var
        Response: HttpResponseMessage;
        Html: Text;
    begin
        if not Client.Get(Url, Response) then
            Error(HttpRequestFailedErr);

        EnsureSuccessfulResponse(Response);
        Response.Content.ReadAs(Html);

        ViewState := ExtractInputValue(Html, '__VIEWSTATE');
        ViewStateGenerator := ExtractInputValue(Html, '__VIEWSTATEGENERATOR');
        EventValidation := ExtractInputValue(Html, '__EVENTVALIDATION');

        if ViewState = '' then
            Error(FormTokenErr);
    end;

    local procedure PostForm(var Client: HttpClient; Url: Text; FormData: Text): Text
    var
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        RequestHeaders: HttpHeaders;
        ResponseText: Text;
    begin
        Content.WriteFrom(FormData);
        Content.GetHeaders(ContentHeaders);

        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');

        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        Request.SetRequestUri(Url);
        Request.Method('POST');
        Request.Content(Content);
        Request.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Accept', 'text/html,application/xhtml+xml,application/xml');
        RequestHeaders.Add('X-MicrosoftAjax', 'Delta=true');
        RequestHeaders.Add('X-Requested-With', 'XMLHttpRequest');

        if not Client.Send(Request, Response) then
            Error(HttpRequestFailedErr);

        EnsureSuccessfulResponse(Response);
        Response.Content.ReadAs(ResponseText);
        exit(ResponseText);
    end;

    local procedure EnsureSuccessfulResponse(Response: HttpResponseMessage)
    begin
        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode());
    end;

    local procedure AddFormField(var FormData: Text; FieldName: Text; FieldValue: Text)
    var
        Uri: Codeunit Uri;
    begin
        if FormData <> '' then
            FormData += '&';

        FormData += Uri.EscapeDataString(FieldName) + '=' + Uri.EscapeDataString(FieldValue);
    end;

    local procedure ExtractInputValue(Html: Text; InputName: Text): Text
    var
        LowerHtml: Text;
        InputTag: Text;
        Marker: Text;
        MarkerPosition: Integer;
        InputStartPosition: Integer;
        InputEndPosition: Integer;
        RelativeEndPosition: Integer;
    begin
        LowerHtml := LowerCase(Html);

        Marker := 'name="' + LowerCase(InputName) + '"';
        MarkerPosition := StrPos(LowerHtml, Marker);

        if MarkerPosition = 0 then begin
            Marker := 'id="' + LowerCase(InputName) + '"';
            MarkerPosition := StrPos(LowerHtml, Marker);
        end;

        if MarkerPosition = 0 then
            exit('');

        InputStartPosition := FindLastOccurrenceBefore(LowerHtml, '<input', MarkerPosition);
        if InputStartPosition = 0 then
            InputStartPosition := MarkerPosition;

        RelativeEndPosition := StrPos(CopyStr(LowerHtml, MarkerPosition), '>');
        if RelativeEndPosition = 0 then
            exit('');

        InputEndPosition := MarkerPosition + RelativeEndPosition - 1;
        InputTag := CopyStr(Html, InputStartPosition, InputEndPosition - InputStartPosition + 1);

        exit(HtmlDecode(ExtractAttributeValue(InputTag, 'value')));
    end;

    local procedure ExtractAttributeValue(TagText: Text; AttributeName: Text): Text
    var
        LowerTagText: Text;
        Marker: Text;
        ValueStartPosition: Integer;
        ValueEndPosition: Integer;
    begin
        LowerTagText := LowerCase(TagText);
        Marker := LowerCase(AttributeName) + '="';
        ValueStartPosition := StrPos(LowerTagText, Marker);

        if ValueStartPosition = 0 then
            exit('');

        ValueStartPosition += StrLen(Marker);
        ValueEndPosition := StrPos(CopyStr(TagText, ValueStartPosition), '"');

        if ValueEndPosition = 0 then
            exit('');

        exit(CopyStr(TagText, ValueStartPosition, ValueEndPosition - 1));
    end;

    local procedure FindLastOccurrenceBefore(SourceText: Text; SearchText: Text; EndPosition: Integer): Integer
    var
        SearchOffset: Integer;
        RelativePosition: Integer;
        FoundPosition: Integer;
    begin
        SearchOffset := 1;

        while SearchOffset <= EndPosition do begin
            RelativePosition := StrPos(
                CopyStr(SourceText, SearchOffset, EndPosition - SearchOffset + 1),
                SearchText);

            if RelativePosition = 0 then
                break;

            FoundPosition := SearchOffset + RelativePosition - 1;
            SearchOffset := FoundPosition + 1;
        end;

        exit(FoundPosition);
    end;

    local procedure GetValueByLabels(Html: Text; Label1: Text; Label2: Text; Label3: Text): Text
    var
        ResultValue: Text;
    begin
        ResultValue := GetValueByLabel(Html, Label1);

        if (ResultValue = '') and (Label2 <> '') then
            ResultValue := GetValueByLabel(Html, Label2);

        if (ResultValue = '') and (Label3 <> '') then
            ResultValue := GetValueByLabel(Html, Label3);

        exit(ResultValue);
    end;

    local procedure GetValueByLabel(Html: Text; LabelText: Text): Text
    var
        LowerHtml: Text;
        LowerLabelText: Text;
        LabelPosition: Integer;
        FirstCellEndPosition: Integer;
        SecondCellStartPosition: Integer;
        SecondCellTagEndPosition: Integer;
        SecondCellEndPosition: Integer;
        RelativePosition: Integer;
        CellText: Text;
    begin
        if LabelText = '' then
            exit('');

        LowerHtml := LowerCase(Html);
        LowerLabelText := LowerCase(LabelText);
        LabelPosition := StrPos(LowerHtml, LowerLabelText);

        if LabelPosition = 0 then
            exit('');

        RelativePosition := StrPos(CopyStr(LowerHtml, LabelPosition), '</td>');
        if RelativePosition = 0 then
            exit('');

        FirstCellEndPosition := LabelPosition + RelativePosition - 1;

        RelativePosition := StrPos(CopyStr(LowerHtml, FirstCellEndPosition + StrLen('</td>')), '<td');
        if RelativePosition = 0 then
            exit('');

        SecondCellStartPosition :=
            FirstCellEndPosition + StrLen('</td>') + RelativePosition - 1;

        RelativePosition := StrPos(CopyStr(LowerHtml, SecondCellStartPosition), '>');
        if RelativePosition = 0 then
            exit('');

        SecondCellTagEndPosition := SecondCellStartPosition + RelativePosition - 1;

        RelativePosition := StrPos(CopyStr(LowerHtml, SecondCellTagEndPosition + 1), '</td>');
        if RelativePosition = 0 then
            exit('');

        SecondCellEndPosition := SecondCellTagEndPosition + RelativePosition;
        CellText := CopyStr(
            Html,
            SecondCellTagEndPosition + 1,
            SecondCellEndPosition - SecondCellTagEndPosition - 1);

        exit(CleanHtmlValue(CellText));
    end;

    local procedure CleanHtmlValue(HtmlValue: Text): Text
    var
        TagStartPosition: Integer;
        TagEndPosition: Integer;
    begin
        HtmlValue := ReplaceText(HtmlValue, '<br>', ' ');
        HtmlValue := ReplaceText(HtmlValue, '<br/>', ' ');
        HtmlValue := ReplaceText(HtmlValue, '<br />', ' ');

        TagStartPosition := StrPos(HtmlValue, '<');

        while TagStartPosition > 0 do begin
            TagEndPosition := StrPos(CopyStr(HtmlValue, TagStartPosition), '>');

            if TagEndPosition = 0 then
                break;

            HtmlValue := DelStr(HtmlValue, TagStartPosition, TagEndPosition);
            TagStartPosition := StrPos(HtmlValue, '<');
        end;

        HtmlValue := HtmlDecode(HtmlValue);
        exit(DelChr(HtmlValue, '<>', ' '));
    end;

    local procedure HtmlDecode(Value: Text): Text
    begin
        Value := ReplaceText(Value, '&nbsp;', ' ');
        Value := ReplaceText(Value, '&amp;', '&');
        Value := ReplaceText(Value, '&quot;', '"');
        Value := ReplaceText(Value, '&#39;', '''');
        Value := ReplaceText(Value, '&apos;', '''');
        Value := ReplaceText(Value, '&lt;', '<');
        Value := ReplaceText(Value, '&gt;', '>');
        Value := ReplaceText(Value, '&#225;', 'á');
        Value := ReplaceText(Value, '&#233;', 'é');
        Value := ReplaceText(Value, '&#237;', 'í');
        Value := ReplaceText(Value, '&#243;', 'ó');
        Value := ReplaceText(Value, '&#250;', 'ú');
        Value := ReplaceText(Value, '&#241;', 'ñ');
        Value := ReplaceText(Value, '&#252;', 'ü');
        Value := ReplaceText(Value, '&#193;', 'Á');
        Value := ReplaceText(Value, '&#201;', 'É');
        Value := ReplaceText(Value, '&#205;', 'Í');
        Value := ReplaceText(Value, '&#211;', 'Ó');
        Value := ReplaceText(Value, '&#218;', 'Ú');
        Value := ReplaceText(Value, '&#209;', 'Ñ');
        Value := ReplaceText(Value, '&#220;', 'Ü');
        exit(Value);
    end;

    local procedure ReplaceText(SourceText: Text; FindWhat: Text; ReplaceWith: Text): Text
    var
        Position: Integer;
    begin
        if FindWhat = '' then
            exit(SourceText);

        Position := StrPos(SourceText, FindWhat);

        while Position > 0 do begin
            SourceText :=
                CopyStr(SourceText, 1, Position - 1) +
                ReplaceWith +
                CopyStr(SourceText, Position + StrLen(FindWhat));

            Position := StrPos(SourceText, FindWhat);
        end;

        exit(SourceText);
    end;

    local procedure AreResultValuesEmpty(Datos: array[6] of Text[250]): Boolean
    var
        Index: Integer;
    begin
        for Index := 1 to ArrayLen(Datos) do
            if Datos[Index] <> '' then
                exit(false);

        exit(true);
    end;

    local procedure IsRncFileEntry(EntryName: Text): Boolean
    var
        UpperEntryName: Text;
        UpperExpectedName: Text;
    begin
        UpperEntryName := UpperCase(ReplaceText(EntryName, '\', '/'));
        UpperExpectedName := UpperCase(RncEntryNameLbl);

        if StrLen(UpperEntryName) < StrLen(UpperExpectedName) then
            exit(false);

        exit(
            CopyStr(
                UpperEntryName,
                StrLen(UpperEntryName) - StrLen(UpperExpectedName) + 1) =
            UpperExpectedName);
    end;
}
