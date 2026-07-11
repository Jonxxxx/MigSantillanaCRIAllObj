codeunit 75006 "MdM Async Sender"
{
    TableNo = 75003;

    trigger OnRun()
    begin

        cAsingMng.TraspasaCab(Rec);
    end;

    var
        rConfMdM: Record 75000;
        txtRet: Label 'http://retornoAsincrono.santillanaBus';
        XmlDoc: DotNet XmlDocument;
        XmlNode: array[10] of DotNet XmlNode;
        NSUri: Label 'http://schemas.xmlsoap.org/soap/envelope/';
        Notif: Label 'http://NotificacionDatosalMDM.santillanaBus';
        NS: Label '';
        XmlNType: DotNet XmlNodeType;
        XmlAtrbt: DotNet XmlAttribute;
        XmlAtrrbts: DotNet XmlAttributeCollection;
        MdEMgnt: Codeunit 56202;
        cFileMng: Codeunit 419;
        NS2: Label 'inf';
        TClave: Label 'CLAVE';
        cAsingMng: Codeunit 75005;
        wErrorCode: Code[20];
        wErrorDescription: Text;
        TOrigen: Label 'NAV_BOL';

    procedure BuildXML(pwCab: Record 75003; pwTipo: Option Insert,Update,Delete,Error)
    var
        lwNodeName: Text[30];
        lwTxt: Text[30];
        XmlNsMgr: DotNet XmlNamespaceManager;
        lwsoapEnvelope: DotNet XmlElement;
        MyDT: DateTime;
        lwInt: Integer;
        lwInt2: Integer;
        lwNumInt: Integer;
    begin
        // BuildXML

        XmlDoc := XmlDoc.XmlDocument;

        CASE pwTipo OF
            pwTipo::Insert:
                lwTxt := 'retornoInsert';
            pwTipo::Update:
                lwTxt := 'retornoUpdate';
            pwTipo::Delete:
                lwTxt := 'retornoDelete';
            pwTipo::Error:
                lwTxt := 'retornoError';
        END;
        //lwNodeName := 'ret:' + lwTxt;
        lwNodeName := lwTxt;

        lwsoapEnvelope := XmlDoc.CreateElement('soapenv', 'Envelope', NSUri);
        //lwsoapEnvelope := XmlDoc.CreateElement('soapenv:Envelope');
        lwsoapEnvelope.SetAttribute('xmlns:ret', txtRet);
        //lwsoapEnvelope.SetAttribute('xmlns:soapenv', NSUri);

        XmlDoc.AppendChild(lwsoapEnvelope);
        //XmlNode[1] := XmlDoc.CreateNode('element', 'soapenv:Header', '');

        XmlNode[1] := XmlDoc.CreateNode(XmlNType.Element, 'soapenv', 'Header', NSUri);

        lwsoapEnvelope.AppendChild(XmlNode[1]);
        //XmlNode[1] := XmlDoc.CreateNode('element', 'soapenv:Body', '');
        XmlNode[1] := XmlDoc.CreateNode(XmlNType.Element, 'soapenv', 'Body', NSUri);
        lwsoapEnvelope.AppendChild(XmlNode[1]);
        AddElement2(1, lwNodeName, '', 'ret', txtRet);

        AddElement2(2, 'mensaje', '', '', '');
        AddElement2(3, 'head', '', '', '');

        AddElement2(4, 'id_mensaje', pwCab.id_mensaje, '', ''); //de la cabecera recibida
        //AddElement2(4,'sistema_origen',  pwCab.sistema_origen, '','');
        //AddElement2(4,'sistema_origen',  TOrigen, '',''); // Valor fijo: NAV
        AddElement2(4, 'sistema_origen', cAsingMng.GetSistemaOrigen, '', ''); // Valor fijo: NAV

        AddElement2(4, 'pais_origen', pwCab.pais_origen, '', '');
        AddElement2(4, 'fecha_origen', FORMAT(pwCab.fecha_origen), '', '');//de la cabecera recibida
        AddElement2(4, 'fecha', FORMAT(CURRENTDATETIME), '', '');
        AddElement2(4, 'tipo', pwCab.tipo, '', ''); //de la cabecera recibida

        IF pwTipo = pwTipo::Error THEN BEGIN
            AddElement2(4, 'error', '', '', '');
            AddElement2(5, 'code', wErrorCode, '', '');
            AddElement2(5, 'level', '', '', '');
            AddElement2(5, 'description', wErrorDescription, '', '');
        END;

        // Reintentos
        /*
        pwCab.GetIntDates(lwInt2, lwInt, lwNumInt);
        lwNumInt:= pwCab.Attempt;
        
        
        AddElement2(4 ,'num_reintentos'            , FORMAT(lwNumInt),'','');
        AddElement2(4 ,'datetime_ultimo_reintento' , FORMAT(pwCab."Last Attempt"),'','');
        AddElement2(4 ,'nivel_reintento'           , FORMAT(lwInt2) ,'','');
        AddElement2(4 ,'estado_reintento'          , FORMAT(lwInt),'','');
        */

        AddElement2(3, 'body', '', '', '');

    end;

    procedure BuildXMLError(pwCab: Record 75003; pwCode: Code[20]; pwDescription: Text)
    begin
        // BuildXMLError

        // JPT 28/01/2019
        // Controlamos que la longitud no supere los 250 caracteres
        pwDescription := COPYSTR(pwDescription, 1, 250);
        wErrorCode := pwCode;
        wErrorDescription := pwDescription;

        BuildXML(pwCab, 3);

        /*
        AddElement2(4,'error','','','');
        AddElement2(5,'code' , pwCode,'','');
        AddElement2(5,'level', '','','');
        AddElement2(5,'description',pwDescription,'','');
        */

    end;

    procedure BuildXMLRequest(pwCab: Record 75003)
    var
        lrLinImp: Record 75004;
        lrLinImpTmp Record: 75004" temporary;
        lrLinField: Record 75005;
        lwCod: Text;
        lwCodMdM: Text;
        lcText001: Label 'Tablas_Referencia';
        lcText002: Label 'articulo';
        lwFieldName: Text;
        lwElemento: Text;
        lcText003: Label 'id';
        lwTipo: Option Insert,Update,Delete,Error;
        lwOK: Boolean;
        lwEsArticulo: Boolean;
        lwDevolver: Boolean;
    begin
        // BuildXMLRequest

        lwTipo := pwCab.Operacion;
        BuildXML(pwCab, lwTipo);

        IF lwTipo = lwTipo::Error THEN BEGIN
            AddElement(XmlNode[4], 'newCodes', '', '', '', XmlNode[6]);
        END
        ELSE BEGIN
            AddElement(XmlNode[4], 'ok', '', '', '', XmlNode[5]);
            AddElement(XmlNode[5], 'newCodes', '', '', '', XmlNode[6]);
        END;

        CLEAR(lrLinImp);
        lrLinImp.SETCURRENTKEY("Id Cab.");
        lrLinImp.SETRANGE("Id Cab.", pwCab.Id);
        //lrLinImp.SETFILTER("Id Tabla", '<>%1', 90); // subtabla de 90, no se procesa
        //IF lrLinImp.FINDSET(FALSE) THEN BEGIN
        IF lrLinImp.FINDFIRST THEN BEGIN
            CLEAR(lrLinImpTmp);
            //REPEAT
            // No queremos que se devuelvan dos lineas de producto (GENERAL/ESPECIFICO)
            //lwOK := (lrLinImp."Id Tabla" <> lrLinImpTmp."Id Tabla") OR (lrLinImp.Code <> lrLinImpTmp.Code) OR (lrLinImpTmp."Code MdM" <> lrLinImpTmp."Code MdM");
            lwOK := TRUE;
            lrLinImpTmp := lrLinImp;

            IF lwOK THEN BEGIN
                CLEAR(lwCod);
                CLEAR(lwCodMdM);

                AddElement(XmlNode[6], 'newCodeForElement', '', '', '', XmlNode[7]);
                /*
                IF lrLinImp."Id Tabla" IN [27, 90] THEN
                  AddElement(XmlNode[7],'element',lrLinImp."Nombre Elemento",'','','',XmlNode[8])
                ELSE
                  AddElement(XmlNode[7],'element','Tablas_Referencia','','','',XmlNode[8]);
                */

                lwEsArticulo := FALSE;
                CASE lrLinImp."Id Tabla" OF
                    27, 90:
                        lwEsArticulo := TRUE;
                    -1:
                        BEGIN // No Aplica
                            lwEsArticulo := lrLinImp.Tipo >= 30;
                        END;
                END;

                IF lwEsArticulo THEN
                    lwElemento := lcText002
                ELSE
                    lwElemento := lcText001;

                AddElement2(7, 'element', lwElemento, '', '');
                AddElement2(7, 'pk_fields', '', '', '');

                /*
                CLEAR(lrLinField);
                lrLinField.SETRANGE("Id Rel", lrLinImp.Id);
                lrLinField.SETRANGE(PK, TRUE);
                IF lrLinField.FINDSET THEN BEGIN
                  REPEAT
                    AddElement2(8,'pk_field','','','');
                    AddElement2(,'field_name'     , lrLinField."Nombre Elemento",'','');
                    lwCodMdM := lrLinField."MdM Value";
                    IF lwCodMdM = '' THEN
                      lwCodMdM := lrLinField.Value;
                    AddElement2(9,'received_value', lwCodMdM,'','');
                    AddElement2(9,'new_value'      , lrLinField.Value,'','');
                    AddElement2(9,'description'      , '','','');
                  UNTIL lrLinField.NEXT=0;
                END
                ELSE BEGIN
                  AddElement2(8,'pk_field','','','', XmlNode[9]);
                  AddElement2(9,'field_name'     , TClave,'');
                  lwCodMdM := lrLinImp."Code MdM";
                  IF lwCodMdM = '' THEN
                    lwCodMdM := lrLinImp.Code;
                  AddElement2(9,'received_value', lwCodMdM,'');
                  AddElement2(9,'new_value'      , lrLinImp.Code,'');
                  AddElement2(9,'description'      , '','');
                END;
                */

                IF lwEsArticulo THEN
                    lwFieldName := lcText003
                ELSE
                    lwFieldName := lrLinImp."Nombre Elemento";

                AddElement2(8, 'pk_field', '', '', '');
                AddElement2(9, 'field_name', lwFieldName, '', '');


                lwDevolver := lrLinImp."Id Tabla" <> -1;
                IF (lrLinImp."Id Tabla" = 27) AND (lrLinImp.Tipo = 3) THEN
                    lwDevolver := FALSE;
                IF lwEsArticulo AND (lrLinImp."Id Tabla" <> 27) THEN
                    lwDevolver := FALSE;
                //lwDevolver := lwDevolver AND (NOT(lrLinImp."Id Tabla" = 27) AND (lrLinImp.Tipo =3)); // Autores

                lwDevolver := lwDevolver AND (pwCab.Operacion = pwCab.Operacion::Insert);
                IF lwDevolver THEN BEGIN // -1 = No Aplica
                    lwCodMdM := lrLinImp."Code MdM";
                    IF lwCodMdM = '' THEN
                        lwCodMdM := lrLinImp.Code;
                    lwCod := lrLinImp.Code;
                END;

                AddElement2(9, 'received_value', lwCodMdM, '', '');
                AddElement2(9, 'new_value', lwCod, '', '');
                //AddElement2(9,'description'      , '','','');
            END;
            //UNTIL lrLinImp.NEXT=0;
        END;

    end;

    procedure Send(var prCab Record: 75003")
    var
        lwIsError: Boolean;
        lwFileName: Text[1024];
        lwResp: Text;
        lwURL: Text;
        lwXML: Text;
    begin
        // Send
        // pwError refiere a un error a la hora de procesar los datos
        // lwIsError refiere a un error en el envio de la respuesta asincrona
        // En ambos casos marcamos el registro con estado Error


        //lwFileName := TEMPORARYPATH + 'TempAsinc.XML';
        lwFileName := cFileMng.ServerTempFileName('XML');

        lwXML := '';
        // Ahora no sacamos lo guardado sino que lo generamos cada vez
        /*
        prCab.CALCFIELDS("Send XML");
        IF (prCab."Send XML".HASVALUE) AND (prCab.Estado <> prCab.Estado::Pendiente) THEN BEGIN
          prCab."Send XML".EXPORT(lwFileName);
          //lwXML := AddEnvlp(GestFileText(lwFileName));
          lwXML := GestFileText(lwFileName);
          IF prCab.Entrada = prCab.Entrada::NOTIFICA THEN
               lwXML := AddEnvlp(lwXML);
        END
        ELSE BEGIN
        */
        BEGIN
            CASE prCab.Entrada OF
                prCab.Entrada::INT_WS:
                    BEGIN
                        XmlDoc.Save(lwFileName);
                        lwXML := XmlDoc.OuterXml;
                    END;
                prCab.Entrada::NOTIFICA:
                    BEGIN
                        SaveNotification(prCab);
                        lwXML := XmlDoc.OuterXml;
                        XmlDoc.Save(lwFileName);
                    END;
            END;

            prCab."Send XML".IMPORT(lwFileName);
        END;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF NOT rConfMdM.Pruebas THEN BEGIN
            CLEAR(lwURL);
            CASE prCab.Entrada OF
                prCab.Entrada::INT_WS:
                    BEGIN
                        rConfMdM.TESTFIELD("URL Async Reply");
                        lwURL := rConfMdM."URL Async Reply";
                    END;
                prCab.Entrada::NOTIFICA:
                    BEGIN
                        rConfMdM.TESTFIELD("URL Notif.MdM");
                        lwURL := rConfMdM."URL Notif.MdM";
                    END;
            END;

            //lwResp := MdEMgnt.SendPostRequestNoError(lwURL, '', lwXML, lwIsError);
            lwResp := MdEMgnt.SendPostRequest2(lwURL, '', lwXML, FALSE, lwIsError);

            // JPT 24/01/2019 No hace falta insertar registro
            //MdEMgnt.CreateAsyncPostRequest('WS_RESPUESTA_MdM',lwURL, '', lwXML);

            IF lwIsError THEN
                prCab."Estado Envio" := prCab."Estado Envio"::Error
            ELSE
                prCab."Estado Envio" := prCab."Estado Envio"::Finalizado;

            SaveAsincResp(prCab, lwResp);
        END
        ELSE BEGIN
            IF GUIALLOWED THEN
                cFileMng.DownloadToFile(lwFileName, 'D:\TEMP\TEMP.XML');
        END;

        //prCab.MODIFY;

    end;

    procedure AddElement(var pwXmlNode: DotNet XmlNode; NodeName: Text[250];
                                            NodeText: Text[250];
                                            Prefix: Text; NameSpace: Text[250]; var pwCreatedXMLNode: DotNet XmlNode) ExitStatus: Integer
    begin
        //AddElement

        ExitStatus := MdEMgnt.AddElement(pwXmlNode, NodeName, NodeText, Prefix, NameSpace, pwCreatedXMLNode);
    end;

    procedure AddElement2(pwIdNode: Integer; NodeName: Text[250]; NodeText: Text[250]; Prefix: Text; NameSpace: Text[250]) ExitStatus: Integer
    begin
        //AddElement2

        ExitStatus := AddElement(XmlNode[pwIdNode], NodeName, NodeText, Prefix, NameSpace, XmlNode[pwIdNode + 1]);
    end;

    procedure SaveNotification(prCab: Record 75003) wTxt: Text
    var
        lrCab2Record: Record 75003;
        lwOutStrm: OutStream;
        lwFile: File;
        lwsoapEnvelope: DotNet XmlElement;
        lrLinImp: Record 75004;
        lwOk: Boolean;
        lwValues: array[10] of Text;
        lwHavValues: array[10] of Boolean;
    begin
        // SaveNotification

        wTxt := '';

        IF prCab.Entrada <> prCab.Entrada::NOTIFICA THEN
            EXIT;

        XmlDoc := XmlDoc.XmlDocument;
        lwsoapEnvelope := XmlDoc.CreateElement('soapenv', 'Envelope', NSUri);
        lwsoapEnvelope.SetAttribute('xmlns:not', Notif);

        XmlDoc.AppendChild(lwsoapEnvelope);
        XmlNode[1] := XmlDoc.CreateNode(XmlNType.Element, 'soapenv', 'Header', NSUri);

        lwsoapEnvelope.AppendChild(XmlNode[1]);
        XmlNode[1] := XmlDoc.CreateNode(XmlNType.Element, 'soapenv', 'Body', NSUri);
        lwsoapEnvelope.AppendChild(XmlNode[1]);
        AddElement2(1, 'update', '', 'not', Notif);

        AddElement2(2, 'mensaje', '', '', '');
        AddElement2(3, 'head', '', '', '');

        AddElement2(4, 'id_mensaje', prCab.id_mensaje, '', ''); //de la cabecera recibida
        AddElement2(4, 'sistema_origen', cAsingMng.GetSistemaOrigen, '', ''); // Valor fijo: NAV

        AddElement2(4, 'pais_origen', prCab.pais_origen, '', '');
        AddElement2(4, 'fecha_origen', FORMAT(prCab.fecha_origen, 0, 9), '', '');//de la cabecera recibida

        AddElement2(4, 'fecha', FORMAT(CURRENTDATETIME, 0, 9), '', '');
        AddElement2(4, 'tipo', prCab.tipo, '', ''); //de la cabecera recibida

        // Reintentos
        /*
        pwCab.GetIntDates(lwInt2, lwInt, lwNumInt);
        lwNumInt:= pwCab.Attempt;
        
        
        AddElement2(4 ,'num_reintentos'            , FORMAT(lwNumInt),'','');
        AddElement2(4 ,'datetime_ultimo_reintento' , FORMAT(pwCab."Last Attempt"),'','');
        AddElement2(4 ,'nivel_reintento'           , FORMAT(lwInt2) ,'','');
        AddElement2(4 ,'estado_reintento'          , FORMAT(lwInt),'','');
        */

        AddElement2(3, 'body', '', '', '');

        CLEAR(lrLinImp);
        lrLinImp.SETCURRENTKEY("Id Cab.");
        lrLinImp.SETRANGE("Id Cab.", prCab.Id);
        IF lrLinImp.FINDFIRST THEN BEGIN

            CLEAR(lwValues);
            CLEAR(lwHavValues);

            lwHavValues[1] := GetFieldValue(lrLinImp, -103, lwValues[1]); // Peso
            lwHavValues[2] := GetFieldValue(lrLinImp, 75008, lwValues[2]); // Fecha Almacen
            lwHavValues[3] := GetFieldValue(lrLinImp, 75009, lwValues[3]); // Fecha Comercializacion
            lwHavValues[4] := GetFieldValue(lrLinImp, -300, lwValues[4]); // Precio sin impuestos
            lwHavValues[5] := GetFieldValue(lrLinImp, -325, lwValues[5]); // Precio con impuestos
            lwHavValues[8] := GetFieldValue(lrLinImp, -501, lwValues[8]); // Moneda
            // Valores Auxiliares
            lwHavValues[6] := GetFieldValue(lrLinImp, 49, lwValues[6]); // Pais
            lwHavValues[7] := GetFieldValue(lrLinImp, 75005, lwValues[7]); // Sociedad


            IF lwHavValues[1] THEN BEGIN
                AddElement2(4, 'Articulos_GENERAL', '', '', '');
                AddElement2(5, 'Articulo_GENERAL', '', '', '');
                AddElement2(6, 'pk', '', '', '');
                // Informamos del valor Navision y no el MdM
                //AddElement2(7,'ID_Articulo', lrLinImp."Code MdM",'','');
                AddElement2(7, 'ID_Articulo', lrLinImp.Code, '', '');
                IF lwHavValues[1] THEN // Peso
                    AddElement2(6, 'Peso', lwValues[1], '', '');
            END;

            lwOk := lwHavValues[2] OR lwHavValues[3] OR lwHavValues[4] OR lwHavValues[5] OR lwHavValues[6] OR lwHavValues[7];
            IF lwOk THEN BEGIN
                AddElement2(4, 'Articulos_ESPEC', '', '', '');
                AddElement2(5, 'Articulo_ESPEC', '', '', '');
                AddElement2(6, 'pk', '', '', '');
                // Informamos del valor Navision y no el MdM
                //AddElement2(7,'ID_Articulo',lrLinImp."Code MdM",'','');
                AddElement2(7, 'ID_Articulo', lrLinImp.Code, '', '');
                IF lwHavValues[6] THEN
                    AddElement2(7, 'COD_Pais', lwValues[6], '', '');
                IF lwHavValues[7] THEN
                    AddElement2(7, 'COD_Sociedad', lwValues[7], '', '');
                IF lwHavValues[2] THEN
                    AddElement2(6, 'Fecha_Almacen', lwValues[2], '', '');
                IF lwHavValues[3] THEN
                    AddElement2(6, 'Fecha_Comercializacion', lwValues[3], '', '');
                IF lwHavValues[4] OR lwHavValues[5] THEN BEGIN
                    AddElement2(6, 'Precio', '', '', '');
                    AddElement2(7, 'Precio_sin_Impuestos', lwValues[4], '', '');
                    AddElement2(7, 'Precio_con_Impuestos', lwValues[5], '', '');
                    AddElement2(7, 'COD_Moneda', lwValues[8], '', '');
                END;
            END;
        END;

        wTxt := XmlDoc.OuterXml;

    end;

    procedure GestFileText(pwFilename: Text) wTxt: Text
    var
        lrCab2Record: Record 75003;
        lwInStrm: InStream;
        lwFile: File;
        lwBuffer: Text[1024];
    begin
        // GestFileText

        // Pasamos el fichero a texto
        lwFile.OPEN(pwFilename);
        lwFile.CREATEINSTREAM(lwInStrm);
        WHILE NOT lwInStrm.EOS DO BEGIN
            lwInStrm.READTEXT(lwBuffer);
            wTxt += lwBuffer;
        END;
        lwFile.CLOSE;
    end;

    procedure AddEnvlp(pwText: Text) wReturn: Text
    var
        TxEnv1: Label '<soapenv:Envelope>

     <soapenv: Header/>

    <soapenv: Body>';
        TxEnv2: Label '</soapenv:Body>

     </soapenv: Envelope>';
    begin
        // AddEnvlp

        wReturn := TxEnv1 + pwText + Tx44
    end;

    procedure SaveAsincResp(var prCab: Record "75003;pwText: Text)
    var
        lwOutStrm: OutStream;
    begin
        // SaveAsincResp
        // Guarda la respuesta Asincrona

        prCab."Send XML Reply".CREATEOUTSTREAM(lwOutStrm);
        lwOutStrm.WRITETEXT(pwText);44
    end;
44
    procedure GetFieldValue(prLinField: Record "75004; pwIdField: Integer; var pwValue: Text) wRet: Boolean
    var
        lrField: Record "75005;
    begin
        // GetFieldValue

        pwValue := '';

        CLEAR(lrField);
        wRet := lrField.GET(prLinField.Id, pwIdField);
        IF wRet THEN
            pwValue := lrField.Value;
    end;

    trigger XmlDoc::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;
}

