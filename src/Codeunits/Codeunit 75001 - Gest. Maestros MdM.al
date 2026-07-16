codeunit 75001 "Gest. Maestros MdM"
{
    // Tengase en cuenta que tanto rImp como rCab y rField son registros TEMPORALES


    trigger OnRun()
    begin
        // Utilizamos el OnRun para lanzar la funcion de asegurar que esté activa la cola de proyecto
        // Asi si falla no detendrá nada
        ActColaProy;
    end;

    var
        cFuncMdm: Codeunit 75000;
        cFileMng: Codeunit 419;
        cAsynMng: Codeunit 75005;
        cTrasp: Codeunit 75007;
        cNotifPrec: Codeunit 75008;
        rConfMdM: Record 75000;
        rImp: Record 75004 temporary;
        rCab: Record 75003 temporary;
        rCabRl: Record 75003;
        rField: Record 75005 temporary;
        Text001: Label 'El tipo de dato %1 no está permitido en la importacion de datos. Campo %2';
        rConvNM: Record 75007;
        rConfSant: Record 56001;
        rConfCont: Record 98;
        wIds: array[3] of Integer;
        Text002: Label '%1 No es un valor permitido para %2.\ Los valores permitidos son %3';
        wDia: Dialog;
        wTotal: Integer;
        wCont: Integer;
        Text003: Label 'Traspasando';
        wStep: Integer;
        Text004: Label 'No Aplica';
        wAllowEmptyValues: Boolean;
        Text005: Label 'Se ha producido una referencia Circular en %1 %2. Producto %3';

    procedure SetValues(var prCab: Record 75003 temporary; var prImp: Record 75004 temporary; var prField: Record 75005 temporary)
    begin
        // Introduce los valores de las talas temporales
        // Para que funcione las tablas que se pasan por parametro tienen que ser temporales
        ResetAll;
        rCab.COPY(prCab);
        rImp.COPY(prImp);
        rField.COPY(prField);
    end;

    procedure GetValues(var prCab: Record 75003 temporary; var prImp: Record 75004 temporary; var prField: Record 75005 temporary)
    begin
        // Devueelve los valores de las tablas temporales
        // Para que funcione las tablas que se pasan por parametro tienen que ser temporales

        prCab.COPY(rCab);
        prImp.COPY(rImp);
        prField.COPY(rField);
    end;

    procedure ImpCabExcel()
    var
        lrCabR: Record 75003;
    begin
        // ImpCabExcel

        PasarAReal2(TRUE);
    end;

    procedure ResetAll()
    begin

        CLEAR(wIds);

        rImp.RESET;
        rImp.DELETEALL;

        rCab.RESET;
        rCab.DELETEALL;

        rField.RESET;
        rField.DELETEALL;
    end;

    procedure AddMstReg(pwOperacion: Option Insert,Update,Delete; pwIdTabla: Integer; pwTipo: Integer; pwCode: Code[30]; pwDescripcion: Text; pwNombreElemento: Text[50]; pwVisible: Text[10]) IDR: Integer
    begin
        // AddMstReg
        // Añade una linea en la tabla previa de maestros MdM
        // Devolvemos el valor Id del registro insertado

        IDR := AddMstReg2(pwOperacion, pwIdTabla, pwTipo, pwCode, pwDescripcion, pwNombreElemento, pwVisible, FALSE);
    end;

    procedure AddMstReg2(pwOperacion: Option Insert,Update,Delete; pwIdTabla: Integer; pwTipo: Integer; pwCode: Code[30]; pwDescripcion: Text; pwNombreElemento: Text[50]; pwVisible: Text[10]; pwValMdM: Boolean) IDR: Integer
    begin
        // AddMstReg2
        // Añade una linea en la tabla previa de maestros MdM
        // Devolvemos el valor Id del registro insertado

        wIds[2] += 1;
        wIds[3] := 0;
        CLEAR(rImp);
        rImp.Id := wIds[2];
        rImp."Id Cab." := rCab.Id;
        rImp.Operacion := pwOperacion;
        rImp."Id Tabla" := pwIdTabla;
        IF pwValMdM THEN
            rImp."Code MdM" := pwCode
        ELSE
            rImp.Code := pwCode;

        IF STRLEN(pwDescripcion) > MAXSTRLEN(rImp.Descripcion) THEN
            pwDescripcion := COPYSTR(pwDescripcion, 1, MAXSTRLEN(rImp.Descripcion));
        rImp.Descripcion := pwDescripcion;
        rImp.Tipo := pwTipo;
        rImp."Nombre Elemento" := pwNombreElemento;
        rImp.SetVisibleTx(pwVisible);
        RespNoAplica(rImp);
        rImp.INSERT;

        IDR := rImp.Id;

        cTrasp.ConvierteTabl(rImp, FALSE);
    end;

    procedure UpdtMstReg(pwTipo: Integer; pwCode: Code[30]; pwDescripcion: Text[100]; pwVisible: Text[10]) IDR: Integer
    begin
        // UpdtMstReg
        // Modifica linea en la tabla previa de maestros MdM
        // Devolvemos el valor Id del registro insertado

        rImp.Code := pwCode;
        rImp.Descripcion := pwDescripcion;
        rImp.Tipo := pwTipo;
        rImp.SetVisibleTx(pwVisible);
        RespNoAplica(rImp);
        rImp.MODIFY;

        IDR := rImp.Id;

        cTrasp.ConvierteTabl(rImp, FALSE);
    end;

    procedure GetMstReg(pwOperacion: Option Insert,Update,Delete; pwIdTabla: Integer; pwTipo: Integer; pwCode: Code[30]; pwDescripcion: Text[100]; pwNombreElemento: Text[50]; pwVisible: Text[10]; pwValMdM: Boolean) IDR: Integer
    begin
        // GetMstReg
        // Busca la última linea de la misma operacion/tabla/clave, si no la encuentra añade una linea en la tabla previa de maestros MdM
        // Devolvemos el valor Id del registro econtrado o insertado

        CLEAR(rImp);
        rImp.SETRANGE("Id Cab.", rCab.Id);
        rImp.SETRANGE(Operacion, pwOperacion);
        rImp.SETRANGE("Id Tabla", pwIdTabla);
        rImp.SETRANGE(Tipo, pwTipo);
        rImp.SETRANGE(Code, pwCode);
        IF rImp.FINDLAST THEN
            IDR := rImp.Id
        ELSE
            IDR := AddMstReg2(pwOperacion, pwIdTabla, pwTipo, pwCode, pwDescripcion, pwNombreElemento, pwVisible, pwValMdM);
        rImp.RESET;
    end;

    procedure AddMstRegField(pwIdField: Integer; pwValue: Text[250]; pwNombreElemento: Text[50])
    begin
        // AddMstRegField
        // Insertamos el valor del campo relacionado

        AddMstRegField2(pwIdField, pwValue, pwNombreElemento, FALSE);
    end;

    procedure AddMstRegField2(pwIdField: Integer; pwValue: Text[250]; pwNombreElemento: Text[50]; pwValMdM: Boolean)
    var
        lwExist: Boolean;
    begin
        // AddMstRegField2
        // Insertamos el valor del campo relacionado

        pwValue := DELCHR(pwValue, '<>'); // Trim
        IF (rImp.Id = 0) OR (pwIdField = 0) THEN
            EXIT;

        IF (NOT wAllowEmptyValues) AND (pwValue = '') THEN // Definimos si permitimos valors vacios
            EXIT;

        // Pueden llegar valores en blanco que anulen
        IF pwValue = '' THEN BEGIN
            pwValue := 'NULL';
        END;

        CLEAR(rField);
        lwExist := rField.GET(rImp.Id, pwIdField);
        IF lwExist THEN BEGIN
            IF pwValMdM THEN
                rField."MdM Value" := pwValue
            ELSE
                rField.Value := pwValue;
            rField.MODIFY;
        END
        ELSE BEGIN
            wIds[3] += 1;
            CLEAR(rField);
            rField."Id Cab." := rImp."Id Cab.";
            rField."Id Rel" := rImp.Id;
            rField."Table Id" := rImp."Id Tabla";
            rField."Id Field" := pwIdField;
            rField.Id := wIds[3]; // Viene a ser el orden de inserccion
            IF pwValMdM THEN
                rField."MdM Value" := pwValue
            ELSE
                rField.Value := pwValue;
            rField."Nombre Elemento" := pwNombreElemento;
            rField.INSERT(TRUE); // Establece el orden
        END;
    end;

    procedure AddRenameField(pwValue: Text[250])
    begin
        // AddRenameField
        // Renombra a

        rField."Renamed Val" := pwValue;
        rField.MODIFY;
    end;

    procedure AddMstRegHeader(pwOperacion: Option Insert,Update,Delete; pwEntrada: Option INT_WS,INT_Excel,NOTIFICA) IDC: Integer
    begin

        // AddMstRegHeader

        wIds[1] += 1;
        CLEAR(rCab);
        rCab.Id := wIds[1];
        rCab.Operacion := pwOperacion;
        rCab."Fecha Creacion" := CURRENTDATETIME;
        rCab.Entrada := pwEntrada;
        rCab.INSERT(TRUE);

        IDC := rCab.Id;
    end;

    procedure GetOutStrm(var pwOutStrm: OutStream)
    begin
        // GetOutStrm

        rCab.DOC.CREATEOUTSTREAM(pwOutStrm);
    end;

    procedure GestMessageXML(var pxResp: XMLport 75003)
    var
        lwError: Boolean;
        lwErrorText: Text;
        Text001: Label 'No hay nada que traspasar a Navision';
        NewSessionId: Integer;
    begin
        // GestMessageXML

        rCab.MODIFY;

        PasarAReal2(FALSE);

        CLEAR(lwErrorText);
        lwError := NOT rCabRl.FINDFIRST;
        IF lwError THEN
            lwErrorText := Text001;

        pxResp.SetCab(rCabRl, lwError, lwErrorText);
        pxResp.EXPORT;

        // Lo Traspasamos en otra sesion.
        // En realidad llamamos a cAsynMng.TraspasaCab pero en otra sesion
        //cAsynMng.TraspasaCab(rCabRl);
        COMMIT;
        STARTSESSION(NewSessionId, CODEUNIT::"MdM Async Sender", COMPANYNAME, rCabRl);

        ResetAll;

        //fes mig GestColaProy(0); // Nos aseguramos que la cola de proyecto está activada
    end;

    local procedure GetUnid(pwItemNo: Code[20]; pwCodUnidadBase: Code[10]; pwTipo: Option Ancho,Alto,Peso) wValor: Decimal
    var
        lrUnid: Record 5404;
    begin
        // GetUnid
        // Devuelve elementos de la unidad de medida

        IF pwItemNo = '' THEN
            EXIT;

        CLEAR(lrUnid);
        IF lrUnid.GET(pwItemNo, pwCodUnidadBase) THEN BEGIN
            CASE pwTipo OF
                pwTipo::Ancho:
                    wValor := lrUnid.Width;
                pwTipo::Alto:
                    wValor := lrUnid.Height;
                pwTipo::Peso:
                    wValor := lrUnid.Weight;
            END;
        END;
    end;

    procedure SetDatosCab(pwIdMensaje: Text[50]; pwSistemaOrigen: Text[50]; pwPaisOrigen: Text[50]; pwFechaOrigen: DateTime; pwFecha: DateTime; pwTipo: Text[50])
    begin
        // SetDatosCab

        rCab.id_mensaje := pwIdMensaje;
        rCab.sistema_origen := pwSistemaOrigen;
        rCab.pais_origen := pwPaisOrigen;
        rCab.fecha_origen := pwFechaOrigen;
        rCab.fecha := pwFecha;
        rCab.tipo := pwTipo;
        rCab.MODIFY;
    end;

    procedure PasarAReal(var prCab: Record 75003 temporary; var prImp: Record 75004 temporary; var prField: Record 75005 temporary; pwTraspasa: Boolean)
    var
        lrImpR: Record 75004;
        lrFieldR: Record 75005;
        lwDesde: Integer;
        lwHasta: Integer;
    begin
        // PasarAReal
        // Pasa los valores temporales a la tabla real;
        // Devuelve el Id de la cabecera real


        CLEAR(rCabRl);
        CLEAR(lwDesde);
        CLEAR(lwHasta);
        IF prCab.FINDSET THEN BEGIN
            REPEAT
                prCab.CALCFIELDS(DOC, prCab."Send XML", prCab."Send XML Reply");
                //rCabRl    := prCab;
                rCabRl.TRANSFERFIELDS(prCab);
                rCabRl.Id := 0;
                prImp.SETRANGE("Id Cab.", prCab.Id);
                IF prImp.FINDSET THEN BEGIN
                    rCabRl.INSERT; // Si no tiene lineas no insertamos la cabecera
                    IF lwDesde = 0 THEN
                        lwDesde := rCabRl.Id;
                    lwHasta := rCabRl.Id;
                    REPEAT
                        lrImpR := prImp;
                        lrImpR.Id := 0;
                        lrImpR."Id Cab." := rCabRl.Id;
                        lrImpR.INSERT;
                        prField.SETRANGE("Id Rel", prImp.Id);
                        IF prField.FINDSET THEN BEGIN
                            REPEAT
                                lrFieldR := prField;
                                lrFieldR."Id Rel" := lrImpR.Id;
                                lrFieldR."Id Cab." := rCabRl.Id;
                                lrFieldR.INSERT;
                            UNTIL prField.NEXT = 0;
                        END;
                    UNTIL prImp.NEXT = 0;
                    IF pwTraspasa THEN
                        cTrasp.RUN(rCabRl);
                END;

            UNTIL prCab.NEXT = 0;
        END;

        rCabRl.SETRANGE(Id, lwDesde, lwHasta);
    end;

    procedure PasarAReal2(pwTraspasa: Boolean)
    begin
        // PasarAReal2

        PasarAReal(rCab, rImp, rField, pwTraspasa);
    end;

    procedure GetTableCaption(pwId: Integer) wText: Text
    var
        //TODO: Ver lrObjects: Record 2000000001;
        lrObjects2: Record 2000000058;
    begin
        // GetTableCaption
        // Devuelve el caption de la tabla

        wText := '';
        /*
        CLEAR(lrObjects);
        lrObjects.SETRANGE(Type, lrObjects.Type::Table);
        lrObjects.SETRANGE(ID, pwId);
        IF lrObjects.FINDFIRST THEN BEGIN
          lrObjects.CALCFIELDS(Caption);
          wText := lrObjects.Caption;
        END;
        */

        CASE pwId OF
            -1:
                wText := Text004; // No aplica
            ELSE BEGIN
                CLEAR(lrObjects2);
                lrObjects2.SETRANGE("Object Type", lrObjects2."Object Type"::Table);
                lrObjects2.SETRANGE("Object ID", pwId);
                IF lrObjects2.FINDFIRST THEN BEGIN
                    //lrObjects2.CALCFIELDS("Object Caption");
                    wText := lrObjects2."Object Caption";
                END;
            END;
        END;

    end;

    procedure GetFieldCaption(pwTableId: Integer; pwFieldId: Integer) wText: Text
    var
        lrFields: Record 2000000041;
        LTEXT0001: Label 'Ancho';
        LTEXT0002: Label 'Alto';
        LTEXT0003: Label 'Peso';
        LTEXT0004: Label 'Dimensiones';
        LTEXT0005: Label 'Precio Venta';
        LTEXT0006: Label 'Cod. Barras';
        LTEXT0007: Label 'Observaciones';
        lwIdDim: Integer;
        LTEXT0008: Label 'Codigo Pack';
        LTEXT0009: Label 'Unidades Pack';
        LTEXT0010: Label 'Codigo Dimension';
        LTEXT0011: Label 'Valor Dimension';
        LTEXT0012: Label 'Moneda';
    begin
        // GetFieldCaption

        wText := '';

        IF pwFieldId > 0 THEN BEGIN // Campos Reales
            CLEAR(lrFields);
            lrFields.SETRANGE(TableNo, pwTableId);
            lrFields.SETRANGE("No.", pwFieldId);
            IF lrFields.FINDFIRST THEN BEGIN
                //lrFields.CALCFIELDS("Field Caption");
                wText := lrFields."Field Caption";
            END;
        END
        ELSE BEGIN // Campos virtuales
            CASE pwTableId OF
                27:
                    BEGIN
                        CASE pwFieldId OF
                            -101:
                                wText := LTEXT0001;
                            -102:
                                wText := LTEXT0002;
                            -103:
                                wText := LTEXT0003;
                            -110:
                                wText := LTEXT0008;
                            -111:
                                wText := LTEXT0009;
                            -120:
                                wText := LTEXT0010;
                            -121:
                                wText := LTEXT0011;

                            -299 .. -200:
                                BEGIN // Dimensiones
                                    lwIdDim := -(pwFieldId + 200);
                                    wText := cFuncMdm.GetDimCode(lwIdDim, FALSE);
                                END;
                            -349 .. -300:
                                wText := LTEXT0005;
                            -501:
                                wText := LTEXT0012;
                            -499 .. -400:
                                wText := LTEXT0006;
                            -500:
                                wText := LTEXT0007;
                        END;
                    END;
            END;
        END;
    end;

    procedure ExpMigracion(prProd: Record 27)
    var
        lwFileName: Text;
        lwFileName2: Text;
        lwFile: File;
        lwOutStr: OutStream;
        lText001: Label 'Guardar Archivo';
        lwXML: XMLport 75004;
    begin
        // ExpMigracion2
        //TODO: Ver 
        /*
        lwFileName := cFileMng.ServerTempFileName('xml');

        lwFile.CREATE(lwFileName);
        lwFile.CREATEOUTSTREAM(lwOutStr);
        XMLPORT.EXPORT(XMLPORT::"MDM-Migracion Inicial Art.", lwOutStr, prProd);
        lwFile.CLOSE;


        //lwFileName2 := cFileMng.SaveFileDialog(lText001,'','XML|*.XML');
        cFileMng.DownloadHandler(lwFileName, lText001, '', 'XML|*.XML', lwFileName2);*/
    end;

    procedure NotifyProd(prProd: Record 27; pwOperacion: Option Insert,Update,Delete; pwCambs: array[10] of Boolean)
    var
        lwPeso: Decimal;
        lwPrecConImpt: Decimal;
        lwPreSinImpt: Decimal;
        lwCodProd: Code[20];
        lwSysOrigen: Text;
        lwFecha: DateTime;
        lwDivisa: Code[10];
    begin
        // NotifyProd

        ResetAll;

        //SetAlowEmptyValues(TRUE); //Permitimos valores en blanco
        AddMstRegHeader(pwOperacion, rCab.Entrada::NOTIFICA);

        rConfSant.GET;
        lwSysOrigen := cAsynMng.GetSistemaOrigen;
        lwFecha := CURRENTDATETIME;
        // 28/09/2017 Defino el tipo '0008' a piñon por indicacion de Daniel Cibrian
        SetDatosCab('', lwSysOrigen, rConfSant."Cod. pais maestros Santill", lwFecha, lwFecha, '0008');

        // Informamos del valor Navision y no del MdM
        //AddMstReg2(pwOperacion, 27, 0, prProd."No. 2", prProd.Description, 'Articulos','', TRUE);
        AddMstReg2(pwOperacion, 27, 0, prProd."No.", prProd.Description, 'Articulos', '', FALSE);

        rImp.Code := prProd."No.";
        rImp.MODIFY;

        IF pwCambs[1] THEN BEGIN
            lwPeso := GetUnid(prProd."No.", prProd."Base Unit of Measure", 2);
            AddMstRegField(-103, FORMAT(lwPeso), 'Peso'); // Virtual.
        END;

        IF pwCambs[6] THEN
            AddMstRegField(49, prProd."Country/Region of Origin Code", 'Pais');
        IF pwCambs[7] THEN
            AddMstRegField(75005, prProd.Sociedad, 'Sociedad');

        IF pwCambs[2] THEN
            AddMstRegField(75008, FORMAT(prProd."Fecha Almacen", 0, 9), 'Fecha_Almacen');
        // AddMstRegField(, FORMAT(), 'Fecha_Prevista_Almacen',0,9); // No se guarda en Navision
        IF pwCambs[3] THEN
            AddMstRegField(75009, FORMAT(prProd."Fecha Comercializacion", 0, 9), 'Fecha_Comercializacion');

        IF pwCambs[4] THEN BEGIN
            GetPrecioVta(prProd, GestFechaPrecio, lwPrecConImpt, lwPreSinImpt, lwDivisa);
            AddMstRegField(-300, FORMAT(lwPreSinImpt, 0, 9), 'Precio_sin_Impuestos');  // Virtual.
            AddMstRegField(-325, FORMAT(lwPrecConImpt, 0, 9), 'Precio_con_Impuestos');  // Virtual.
            lwDivisa := GestCurrency(lwDivisa); // Actualiza la moneda si es la local
            AddMstRegField(-501, lwDivisa, 'Moneda');  // Virtual.
        END;

        //SetAlowEmptyValues(FALSE);
    end;

    procedure GestNotityProd(prXProd: Record 27; prProd: Record 27)
    var
        lwOk: Boolean;
        lwCambs: array[10] of Boolean;
    begin
        // GestNotityProd

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF NOT rConfMdM."Notifica a MdM" THEN
            EXIT;

        // #209115 JPT prXProd lo vamos a buscar ya que no siempre llega bien
        prXProd := prProd;
        IF NOT prXProd.FIND THEN
            CLEAR(prXProd);


        CLEAR(lwCambs);
        lwCambs[2] := (prProd."Fecha Almacen" <> prXProd."Fecha Almacen") AND (prProd."Fecha Almacen" <> 0D);
        lwCambs[3] := (prProd."Fecha Comercializacion" <> prXProd."Fecha Comercializacion") AND (prProd."Fecha Comercializacion" <> 0D);
        lwCambs[6] := (prProd."Country/Region of Origin Code" <> prXProd."Country/Region of Origin Code") AND (prProd."Country/Region of Origin Code" <> '');
        lwCambs[7] := (prProd.Sociedad <> prXProd.Sociedad) AND (prProd.Sociedad <> '');

        lwOk := lwCambs[2] OR lwCambs[3] OR lwCambs[6] OR lwCambs[7];

        //lwOk := lwOk OR (prProd."Base Unit of Measure" <> prXProd."Base Unit of Measure");

        IF lwOk THEN BEGIN
            lwCambs[6] := TRUE;
            lwCambs[7] := TRUE;
            NotifyProd(prProd, 1, lwCambs);
            ProcesaNotif;
        END;
    end;

    procedure GestNotityUnid(prXUnid: Record 5404; prUnid: Record 5404; pwDelete: Boolean)
    var
        lwPeso: Decimal;
        lrProd: Record 27;
        lwCambs: array[10] of Boolean;
    begin
        // GestNotityUnid

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF NOT rConfMdM."Notifica a MdM" THEN
            EXIT;

        CLEAR(lwCambs);
        IF (prXUnid.Weight <> prUnid.Weight) OR (prXUnid.Code <> prUnid.Code) OR pwDelete THEN BEGIN
            IF lrProd.GET(prUnid."Item No.") AND (lrProd."Base Unit of Measure" = prUnid.Code) THEN BEGIN
                IF NOT lrProd."Gestionado MdM" THEN
                    EXIT;

                IF pwDelete THEN
                    lwPeso := 0
                ELSE
                    lwPeso := prUnid.Weight;

                lwCambs[1] := TRUE;
                NotifyProd(lrProd, 1, lwCambs);
                AddMstRegField(-103, FORMAT(lwPeso), 'Peso'); // Virtual.
                ProcesaNotif;
            END;
        END;
    end;

    procedure GestNotityPrec(prXrPrec: Record 7002; var prPrec: Record 7002; pwDelete: Boolean)
    var
        lwPrecConImpt: array[2] of Decimal;
        lwPrecSinImpt: array[2] of Decimal;
        lrProd: Record 27;
        lrPrec: Record 7002;
        lrPrTmp: Record 7002 temporary;
        lwEnc: Boolean;
        lwCambs: array[10] of Boolean;
        lwDivisa: array[2] of Code[10];
        lwFechaPrec: Date;
    begin
        // GestNotityPrec

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF NOT rConfMdM."Notifica a MdM" THEN
            EXIT;

        CLEAR(lwPrecConImpt);
        CLEAR(lwPrecSinImpt);
        CLEAR(lwDivisa);

        IF NOT lrProd.GET(prPrec."Item No.") THEN
            EXIT;
        IF NOT lrProd."Gestionado MdM" THEN
            EXIT;

        // Si el codigo de unidad de medida no es la del producto, NO notifica nada
        //IF (lrProd."Base Unit of Measure" <> prPrec."Unit of Measure Code") THEN
        //  EXIT;

        // En vez de utilizar prXrPrec de entrada (que a veces viene mal) lo busco en la BBDD - JPT 29/03/2019
        // Rectifico  - No funciona en Rename
        /* No funciona en rename
        prXrPrec := prPrec;
        IF NOT prXrPrec.FIND THEN
          CLEAR(prXrPrec);
        */

        lwFechaPrec := GestFechaPrecio; // Fecha del dia

        // OJO: Determinamos el ultimo precio de venta, no el actual
        // Actualizacion.... NI CASO realmente es el actual
        IF (prXrPrec."Starting Date" <> prPrec."Starting Date") OR (prXrPrec."Ending Date" <> prPrec."Ending Date") OR
           (prXrPrec."Unit Price" <> prPrec."Unit Price") OR (prXrPrec."Unit of Measure Code" <> prPrec."Unit of Measure Code") OR
           (prXrPrec."Sales Type" <> prPrec."Sales Type") OR (prXrPrec."VAT Bus. Posting Gr. (Price)" <> prPrec."VAT Bus. Posting Gr. (Price)") OR
           (prXrPrec."Currency Code" <> prPrec."Currency Code") OR (prXrPrec."Sales Code" <> prPrec."Sales Code") OR
           (prXrPrec."Price Includes VAT" <> prPrec."Price Includes VAT") OR pwDelete THEN BEGIN

            IF (lrProd."Base Unit of Measure" = prPrec."Unit of Measure Code") THEN BEGIN
                GetPrecioVta(lrProd, lwFechaPrec, lwPrecConImpt[1], lwPrecSinImpt[1], lwDivisa[1]); // Precios actuales

                // Utilizamos temporales para determinar el último precio de venta

                CLEAR(lrPrec);
                lrPrec.SETRANGE("Item No.", lrProd."No.");
                IF lrPrec.FINDSET THEN BEGIN
                    REPEAT
                        lrPrTmp := lrPrec;
                        lrPrTmp.INSERT;
                    UNTIL lrPrec.NEXT = 0;
                END;

                lrPrTmp := prPrec;
                lwEnc := lrPrTmp.FIND;
                IF lwEnc THEN BEGIN
                    IF pwDelete THEN
                        lrPrTmp.DELETE
                    ELSE BEGIN
                        lrPrTmp := prPrec;
                        lrPrTmp.MODIFY
                    END;
                END
                ELSE
                    IF NOT pwDelete THEN BEGIN
                        lrPrTmp := prPrec;
                        lrPrTmp.INSERT;
                    END;


                // lrPrTmp.SETRANGE("Sales Type", lrPrTmp."Sales Type"::"All Customers");
                CASE rConfMdM."Tipo Precio Venta" OF
                    rConfMdM."Tipo Precio Venta"::"Todos clientes":
                        lrPrTmp.SETRANGE("Sales Type", lrPrTmp."Sales Type"::"All Customers");
                    rConfMdM."Tipo Precio Venta"::"Grupo precio cliente":
                        BEGIN
                            lrPrTmp.SETRANGE("Sales Type", lrPrTmp."Sales Type"::"Customer Price Group");
                            IF rConfMdM."Grupo Precio Cliente" <> '' THEN
                                lrPrec.SETRANGE("Sales Code", rConfMdM."Grupo Precio Cliente");
                        END
                END;

                lrPrTmp.SETFILTER("Currency Code", '%1', '');
                lrPrTmp.SETRANGE("Unit of Measure Code", lrProd."Base Unit of Measure");
                lrPrTmp.SETFILTER("Starting Date", '<=%1', lwFechaPrec);
                lrPrTmp.SETFILTER("Ending Date", '>=%1|%2', lwFechaPrec, 0D);
                lwEnc := lrPrTmp.FINDLAST;
                IF lwEnc THEN BEGIN
                    ConfPrecVta(lrProd, lrPrTmp, lwPrecConImpt[2], lwPrecSinImpt[2], lwDivisa[2]);
                END;
            END;
        END;

        IF (lwPrecConImpt[1] <> lwPrecConImpt[2]) OR (lwPrecSinImpt[1] <> lwPrecSinImpt[2]) OR (lwDivisa[1] <> lwDivisa[2]) THEN BEGIN
            CLEAR(lwCambs);
            //lwCambs[4] := TRUE;
            lwCambs[6] := TRUE;
            lwCambs[7] := TRUE;
            NotifyProd(lrProd, 1, lwCambs);
            AddMstRegField(-300, FORMAT(lwPrecSinImpt[2], 0, 9), 'Precio_sin_Impuestos');  // Virtual.
            AddMstRegField(-325, FORMAT(lwPrecConImpt[2], 0, 9), 'Precio_con_Impuestos');  // Virtual.
            lwDivisa[2] := GestCurrency(lwDivisa[2]); // Actualiza la moneda si es la local
            AddMstRegField(-501, lwDivisa[2], 'Moneda');  // Virtual.
            ProcesaNotif;
        END;

        // Crea una notificacion a futuro
        // IF (lrPrTmp."Starting Date" <> prPrec."Starting Date") OR (lrPrTmp."Ending Date"  <> prPrec."Ending Date") OR pwDelete THEN
        //   cNotifPrec.CreaNotif(prPrec, pwDelete);
        cNotifPrec.CreaNotif2(prXrPrec, prPrec, pwDelete);

    end;

    procedure GestNotityPrecProd(prProd: Record 27)
    var
        lwPrecConImpt: Decimal;
        lwPrecSinImpt: Decimal;
        lrPrec: Record 7002;
        lwCambs: array[10] of Boolean;
        lwDivisa: Code[10];
        lwFechaPrec: Date;
    begin
        // GestNotityPrecProd
        // Notifica el precio de un producto

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF NOT rConfMdM."Notifica a MdM" THEN
            EXIT;

        CLEAR(lwPrecConImpt);
        CLEAR(lwPrecSinImpt);
        CLEAR(lwDivisa);

        lwFechaPrec := GestFechaPrecio; // Fecha del dia
        GetPrecioVta(prProd, lwFechaPrec, lwPrecConImpt, lwPrecSinImpt, lwDivisa); // Precios actuales

        CLEAR(lwCambs);
        //lwCambs[4] := TRUE;
        lwCambs[6] := TRUE;
        lwCambs[7] := TRUE;
        NotifyProd(prProd, 1, lwCambs);
        AddMstRegField(-300, FORMAT(lwPrecSinImpt, 0, 9), 'Precio_sin_Impuestos');  // Virtual.
        AddMstRegField(-325, FORMAT(lwPrecConImpt, 0, 9), 'Precio_con_Impuestos');  // Virtual.
        lwDivisa := GestCurrency(lwDivisa); // Actualiza la moneda si es la local
        AddMstRegField(-501, lwDivisa, 'Moneda');  // Virtual.
        ProcesaNotif;
    end;

    procedure GetPrecioVta(prProd: Record 27; pwFecha: Date; var pwPrecConImpt: Decimal; var pwPrecSinImpt: Decimal; var pwDivisa: Code[10]) wEnc: Boolean
    var
        lrPrec: Record 7002;
    begin

        // GetPrecioVta

        CLEAR(pwPrecConImpt);
        CLEAR(pwPrecSinImpt);
        CLEAR(pwDivisa);

        CLEAR(lrPrec);

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;

        IF pwFecha = 0D THEN
            pwFecha := GestFechaPrecio;

        lrPrec.SETRANGE("Item No.", prProd."No.");
        //lrPrec.SETRANGE("Sales Type", lrPrec."Sales Type"::"All Customers");
        CASE rConfMdM."Tipo Precio Venta" OF
            rConfMdM."Tipo Precio Venta"::"Todos clientes":
                lrPrec.SETRANGE("Sales Type", lrPrec."Sales Type"::"All Customers");
            rConfMdM."Tipo Precio Venta"::"Grupo precio cliente":
                BEGIN
                    lrPrec.SETRANGE("Sales Type", lrPrec."Sales Type"::"Customer Price Group");
                    IF rConfMdM."Grupo Precio Cliente" <> '' THEN
                        lrPrec.SETRANGE("Sales Code", rConfMdM."Grupo Precio Cliente");
                END;
        END;
        lrPrec.SETFILTER("Currency Code", '%1', ''); // Siempre en divisa local
        lrPrec.SETRANGE("Unit of Measure Code", prProd."Base Unit of Measure");
        IF pwFecha <> 0D THEN BEGIN
            lrPrec.SETFILTER("Starting Date", '<=%1', pwFecha);
            lrPrec.SETFILTER("Ending Date", '>%1|%2', pwFecha, 0D);
        END;
        wEnc := lrPrec.FINDLAST;
        IF wEnc THEN BEGIN
            ConfPrecVta(prProd, lrPrec, pwPrecConImpt, pwPrecSinImpt, pwDivisa);
        END;
    end;

    procedure FindVatConf(prProd: Record 27; prPrec: Record 7002; var prVatSetup: Record 325) Result: Boolean
    var
        lwGRIVAProd: Code[10];
        lwGRIVANeg: Code[10];
    begin
        // FindVatConf
        // Busca la configuracion de IVA

        Result := FALSE;
        CLEAR(lwGRIVANeg);
        CLEAR(lwGRIVAProd);
        CLEAR(prVatSetup);
        lwGRIVAProd := prProd."VAT Prod. Posting Group";
        IF lwGRIVAProd <> '' THEN BEGIN
            IF prPrec."VAT Bus. Posting Gr. (Price)" <> '' THEN
                lwGRIVANeg := prPrec."VAT Bus. Posting Gr. (Price)"
            ELSE IF prProd."VAT Bus. Posting Gr. (Price)" <> '' THEN
                lwGRIVANeg := prProd."VAT Bus. Posting Gr. (Price)"
            ELSE
                lwGRIVANeg := rConfMdM."VAT Bus. Posting Group";
            IF lwGRIVANeg <> '' THEN
                Result := prVatSetup.GET(lwGRIVANeg, lwGRIVAProd);
        END;

        IF NOT Result THEN
            CLEAR(prVatSetup);
    end;

    procedure ConfPrecVta(prProd: Record 27; prPrec: Record 7002; var pwPrecConImpt: Decimal; var pwPrecSinImpt: Decimal; var pwDivisa: Code[10])
    var
        lrVatSetup: Record 325;
        lrDiv: Record 4;
    begin
        // ConfPrecVta

        IF NOT FindVatConf(prProd, prPrec, lrVatSetup) THEN
            CLEAR(lrVatSetup);

        pwDivisa := prPrec."Currency Code";

        IF pwDivisa = '' THEN
            lrDiv.InitRoundingPrecision
        ELSE BEGIN
            lrDiv.GET(pwDivisa);
            lrDiv.TESTFIELD("Amount Rounding Precision");
        END;

        IF prPrec."Price Includes VAT" THEN BEGIN
            pwPrecConImpt := prPrec."Unit Price";
            //pwPrecSinImpt := pwPrecConImpt / (1 + lrVatSetup."VAT %");
            pwPrecSinImpt := ROUND(pwPrecConImpt / (1 + lrVatSetup."VAT %" / 100), lrDiv."Amount Rounding Precision");
        END
        ELSE BEGIN
            pwPrecSinImpt := prPrec."Unit Price";
            //pwPrecConImpt := pwPrecSinImpt * (1 + lrVatSetup."VAT %");
            pwPrecConImpt := ROUND(pwPrecSinImpt * (1 + lrVatSetup."VAT %" / 100), lrDiv."Amount Rounding Precision");
        END;
    end;

    procedure ProcesaNotif()
    var
        NewSessionId: Integer;
    begin
        // ProcesaNotif

        PasarAReal2(FALSE);
        IF rCabRl.FINDSET THEN BEGIN
            COMMIT;
            REPEAT
                // Lo ejecutamos en otra sesion para que no perjudique al usuario...
                // cAsynMng.TraspasaCab(rCabRl);
                STARTSESSION(NewSessionId, CODEUNIT::"MdM Async Sender", COMPANYNAME, rCabRl);
            UNTIL rCabRl.NEXT = 0;
        END;
    end;

    procedure GestColaProy(prStatus: Option Ready,Hold)
    var
        lwActDT: DateTime;
    begin
        // GestColaProy

        /*//fes mig
        IF NOT rConfMdM.Activo THEN
          rConfMdM.GET;
        IF NOT rConfMdM."Activar Cola Proy. Auto." THEN
          EXIT;
        
        rConfMdM.TESTFIELD("Cola proyecto");
        rConfMdM.TESTFIELD("Mov. cola proyecto");
        
        // El activa el mov cola de proyecto
        CLEAR(lrMvJobQ);
        lrMvJobQ.GET(rConfMdM."Mov. cola proyecto");
        
        // Nos aseguramos de darnos un minuto por lo menos
        lwActDT := CURRENTDATETIME + 60000; // Añadimos un minuto
        IF lrMvJobQ."Earliest Start Date/Time" < lwActDT THEN BEGIN
          lrMvJobQ."Earliest Start Date/Time" := lwActDT;
          lrMvJobQ.MODIFY;
        END;
        
        // Se activa la cola de proyecto (No se desativa)
        IF prStatus = prStatus::Ready THEN BEGIN
          CLEAR(lrJobQ);
          lrJobQ.GET(rConfMdM."Cola proyecto");
          lrJobQ.StartQueueFromUI(COMPANYNAME);
        END;
        
        // Movimientos de cola de proyecto
        CASE prStatus OF
          prStatus::Ready : IF lrMvJobQ.Status <> lrMvJobQ.Status::Ready THEN BEGIN
                              lrMvJobQ."Hold On Finish" := FALSE;
                              lrMvJobQ.SetStatus(lrMvJobQ.Status::Ready);
                            END;
          prStatus::Hold  : CASE lrMvJobQ.Status OF
                              lrMvJobQ.Status::Ready        : BEGIN
                                                                lrMvJobQ."Hold On Finish" := FALSE;
                                                                lrMvJobQ.SetStatus(lrMvJobQ.Status::"On Hold");
                                                              END;
                              lrMvJobQ.Status::"In Process" : BEGIN
                                                                lrMvJobQ."Hold On Finish" := TRUE;
                                                                lrMvJobQ.MODIFY;
                                                              END;
                           END;
        
        END;
        *///fes mig

    end;

    procedure ActColaProy()
    begin
        // ActColaProy
        // Activa la cola de proyecto (solo la cola no el movimiento)

        /*//fes mig
        
        IF NOT rConfMdM.Activo THEN
          rConfMdM.GET;
        IF NOT rConfMdM."Activar Cola Proy. Auto." THEN
          EXIT;
        
        // JPT 28/01/19 Buscamos que el usario tenga permisos super
        IF lrUserStp.GET(USERID) THEN BEGIN
          IF NOT lrUserStp."Arranca Cola Proyecto MdM" THEN
            EXIT;
        END ELSE
          EXIT;
        
        IF GUIALLOWED THEN
          rConfMdM.TESTFIELD("Cola proyecto");
        
        // Se activa la cola de proyecto (No se desativa)
        CLEAR(lrJobQ);
        lrJobQ.GET(rConfMdM."Cola proyecto");
        lrJobQ.StartQueueFromUI(COMPANYNAME);
        *///fes mig

    end;

    procedure TrasPasaCab(var prCab: Record 75003)
    begin
        // TrasPasaCab

        //prCab.TESTFIELD(Estado, prCab.Estado::Pendiente);
        IF prCab.Entrada = prCab.Entrada::INT_Excel THEN
            cTrasp.RUN(prCab)
        ELSE
            cAsynMng.TraspasaCab(prCab);
    end;

    procedure RespNoAplica(var prImp: Record 75004 temporary)
    begin
        // RespNoAplica
        // Respuesta de algunos llamadas a elementos que no Aplican a Navision

        EXIT; // No debe de devolverse valor

        IF prImp."Id Tabla" <> -1 THEN  // Si no es un elemento No aplicable
            EXIT;

        IF prImp.Code <> '' THEN
            EXIT;

        // No debe de devolverse valor
        /*
        CASE prImp.Tipo OF
          ELSE prImp.Code := prImp."Code MdM";
        END;
        */

    end;

    procedure SetAlowEmptyValues(pwAllow: Boolean)
    begin
        // SetAlowEmptyValues
        wAllowEmptyValues := pwAllow;
    end;

    procedure GetAlowEmptyValues() wAllow: Boolean
    begin
        // GetAlowEmptyValues

        EXIT(wAllowEmptyValues);
    end;

    procedure GestCurrency(pwDivisa: Code[10]) Result: Code[10]
    begin
        // GestCurrency
        // Si la divisa en blanco, busca la configurada en la empresa

        Result := pwDivisa;
        IF Result = '' THEN BEGIN
            IF NOT rConfMdM.Activo THEN
                rConfMdM.GET;
            Result := rConfMdM."Divisa Local MdM";
        END;
    end;

    procedure GestFechaPrecio() wFecha: Date
    begin
        // GestFechaPrecio
        // Funcion para poder definir en un momento dado si la fecha la tomamos la del sistema o la de trabajo

        wFecha := TODAY;
    end;

    procedure SetEstrAnalitica(var prProd: Record 27) Result: Boolean
    var
        lwCod: Code[21];
        lwCod2: Code[21];
        lrConfEA: Record 75009;
        lwN: Integer;
        lwFId: Integer;
        lwRecR: RecordRef;
        lrFieldR: FieldRef;
        lrValBff: Record 75014 temporary;
        lPValBff: Page 75014;
        lwVal: Variant;
    begin
        // SetEstrAnalitica
        // Se ha creado una automatizacion de campos por estructura analitica

        Result := FALSE;

        lwCod := prProd."Estructura Analitica";
        IF lwCod = '' THEN
            EXIT;

        CLEAR(lwCod2);
        CLEAR(lwN);

        lwRecR.GETTABLE(prProd);
        //prProd.COPY(prProd);
        REPEAT
            lwN += 3;
            lwCod2 := COPYSTR(lwCod, 1, lwN);
            CLEAR(lrConfEA);
            lrConfEA.SETRANGE(Codigo, lwCod2);
            IF lrConfEA.FINDSET THEN BEGIN
                Result := TRUE;
                REPEAT
                    lwFId := lrConfEA."Id Field";
                    IF lwFId > 0 THEN BEGIN
                        lrFieldR := lwRecR.FIELD(lwFId);
                        lPValBff.GetFieldValue(lrFieldR, lrConfEA.Valor, lwVal);
                        lrFieldR.VALIDATE(lwVal);
                        CASE lwFId OF
                            56022:
                                prProd.VALIDATE("Grupo de Negocio", lrConfEA.Valor) // Grupo Negocio
                        END;
                    END;
                UNTIL lrConfEA.NEXT = 0;
            END;
        UNTIL (lwCod = lwCod2);

        lwRecR.SETTABLE(prProd);
    end;

    procedure SetCamposRelacionados(var prProd: Record 27) Result: Boolean
    var
        lrCampRel: Record 75010;
        lrCRlTmp: Record 75010 temporary;
        lrFieldsTmp: Record 2000000026 temporary;
        lwIdFieldOr: Integer;
        lwIdFieldDs: Integer;
        lwIdDim: Integer;
        lwFieldValOr: Text;
        lwFieldValDs: Text;
        lwRecf: RecordRef;
        lwFieldRef: FieldRef;
        lwVal: Variant;
    begin
        // SetCamposRelacionados
        // Devuelve true si se ha cambiado algo

        CLEAR(lrCampRel);
        Result := FALSE;

        // Temporal de campos a considerar
        // Para que sea un poco más rápido No consideraremos todos los campos

        CLEAR(lrFieldsTmp);
        IF lrCampRel.FINDSET THEN BEGIN
            REPEAT
                IF lrCampRel."Id Fld Origen" <> 0 THEN BEGIN
                    IF NOT lrFieldsTmp.GET(lrCampRel."Id Fld Origen") THEN BEGIN
                        lrFieldsTmp.Number := lrCampRel."Id Fld Origen";
                        lrFieldsTmp.INSERT;
                    END;
                END;
            UNTIL lrCampRel.NEXT = 0;
        END;

        // Por cada campo configurado
        CLEAR(lrCampRel);
        lrCampRel.SETCURRENTKEY("Id Fld Origen", "Valor Origen");
        IF lrFieldsTmp.FINDSET THEN BEGIN
            lwRecf.GETTABLE(prProd);
            REPEAT
                lwIdFieldOr := lrFieldsTmp.Number;
                IF lwIdFieldOr > 0 THEN BEGIN
                    lwFieldRef := lwRecf.FIELD(lwIdFieldOr);
                    lwFieldValOr := DELCHR(FORMAT(lwFieldRef.VALUE), '<>');
                END
                ELSE BEGIN // Campos Virtuales
                    CASE lwIdFieldOr OF
                        -299 .. -200:
                            BEGIN // Dimensiones
                                lwIdDim := ABS(lwIdFieldOr + 200);
                                lwFieldValOr := cFuncMdm.GetDimValueT(prProd."No.", lwIdDim);
                            END;
                    END;
                END;

                lwFieldValOr := DELCHR(lwFieldValOr, '<>');
                lrCampRel.SETRANGE("Id Fld Origen", lwIdFieldOr);
                lrCampRel.SETRANGE("Valor Origen", lwFieldValOr);
                IF lrCampRel.FINDSET THEN BEGIN // Pueden informarse diversos destinos por cada origen
                    Result := TRUE;
                    REPEAT
                        // Evitamos una referencia circular
                        lrCRlTmp := lrCampRel;
                        IF lrCRlTmp.FIND THEN
                            ERROR(Text005, lrCampRel.TABLECAPTION, lrCampRel.Id, prProd."No.")
                        ELSE
                            lrCRlTmp.INSERT;

                        lwIdFieldDs := lrCampRel."Id Fld Destino";
                        lwFieldValDs := DELCHR(lrCampRel."Valor Destino");
                        IF lwIdFieldDs > 0 THEN BEGIN
                            lwFieldRef := lwRecf.FIELD(lwIdFieldDs);
                            cTrasp.GetFieldValue(lwFieldRef, lwFieldValDs, lwVal);
                            lwFieldRef.VALIDATE(lwVal);
                        END
                        ELSE BEGIN  // Campos Virtuales
                            CASE lwIdFieldDs OF
                                -299 .. -200:
                                    BEGIN // Dimensiones
                                        lwIdDim := ABS(lwIdFieldDs + 200);
                                        cFuncMdm.ValidaDimValT(prProd, lwIdDim, lwFieldValDs);
                                    END;
                            END;
                        END;
                    UNTIL lrCampRel.NEXT = 0;
                END;
            UNTIL lrFieldsTmp.NEXT = 0;
        END;

        IF Result THEN
            lwRecf.SETTABLE(prProd);
    end;

    procedure SetCamposRelacionados2(var prProd: Record 27; var prTmpField: Record 75005 temporary) Result: Boolean
    var
        lrCampRel: Record 75010;
        lrCRlTmp: Record 75010 temporary;
        lrFieldsTmp: Record 2000000026 temporary;
        lwIdFieldOr: Integer;
        lwIdFieldDs: Integer;
        lwIdDim: Integer;
        lwFieldValOr: Text;
        lwFieldValDs: Text;
        lwRecf: RecordRef;
        lwFieldRef: FieldRef;
        lwVal: Variant;
    begin
        // SetCamposRelacionados2
        // Devuelve true si se ha cambiado algo

        CLEAR(prTmpField);
        CLEAR(lrCampRel);
        Result := FALSE;

        // Temporal de campos a considerar
        // Para que sea un poco más rápido No consideraremos todos los campos

        CLEAR(lrFieldsTmp);
        IF lrCampRel.FINDSET THEN BEGIN
            REPEAT
                IF lrCampRel."Id Fld Origen" <> 0 THEN BEGIN
                    // Miramos que esté en la importacion
                    prTmpField.SETRANGE("Id Field", lrCampRel."Id Fld Origen");
                    IF prTmpField.FINDFIRST THEN BEGIN
                        IF NOT lrFieldsTmp.GET(lrCampRel."Id Fld Origen") THEN BEGIN
                            lrFieldsTmp.Number := lrCampRel."Id Fld Origen";
                            lrFieldsTmp.INSERT;
                        END;
                    END;
                END;
            UNTIL lrCampRel.NEXT = 0;
        END;

        // Por cada campo configurado
        CLEAR(lrCampRel);
        lrCampRel.SETCURRENTKEY("Id Fld Origen", "Valor Origen");
        IF lrFieldsTmp.FINDSET THEN BEGIN
            lwRecf.GETTABLE(prProd);
            REPEAT
                lwIdFieldOr := lrFieldsTmp.Number;
                IF lwIdFieldOr > 0 THEN BEGIN
                    lwFieldRef := lwRecf.FIELD(lwIdFieldOr);
                    lwFieldValOr := DELCHR(FORMAT(lwFieldRef.VALUE), '<>');
                END
                ELSE BEGIN // Campos Virtuales
                    CASE lwIdFieldOr OF
                        -299 .. -200:
                            BEGIN // Dimensiones
                                lwIdDim := ABS(lwIdFieldOr + 200);
                                lwFieldValOr := cFuncMdm.GetDimValueT(prProd."No.", lwIdDim);
                            END;
                    END;
                END;

                lwFieldValOr := DELCHR(lwFieldValOr, '<>');
                lrCampRel.SETRANGE("Id Fld Origen", lwIdFieldOr);
                lrCampRel.SETRANGE("Valor Origen", lwFieldValOr);
                IF lrCampRel.FINDSET THEN BEGIN // Pueden informarse diversos destinos por cada origen
                    Result := TRUE;
                    REPEAT
                        // Evitamos una referencia circular
                        lrCRlTmp := lrCampRel;
                        IF lrCRlTmp.FIND THEN
                            ERROR(Text005, lrCampRel.TABLECAPTION, lrCampRel.Id, prProd."No.")
                        ELSE
                            lrCRlTmp.INSERT;

                        lwIdFieldDs := lrCampRel."Id Fld Destino";
                        lwFieldValDs := DELCHR(lrCampRel."Valor Destino");
                        IF lwIdFieldDs > 0 THEN BEGIN
                            lwFieldRef := lwRecf.FIELD(lwIdFieldDs);
                            cTrasp.GetFieldValue(lwFieldRef, lwFieldValDs, lwVal);
                            lwFieldRef.VALIDATE(lwVal);
                        END
                        ELSE BEGIN  // Campos Virtuales
                            CASE lwIdFieldDs OF
                                -299 .. -200:
                                    BEGIN // Dimensiones
                                        lwIdDim := ABS(lwIdFieldDs + 200);
                                        cFuncMdm.ValidaDimValT(prProd, lwIdDim, lwFieldValDs);
                                    END;
                            END;
                        END;
                    UNTIL lrCampRel.NEXT = 0;
                END;
            UNTIL lrFieldsTmp.NEXT = 0;
        END;

        IF Result THEN
            lwRecf.SETTABLE(prProd);
    end;
}

