codeunit 75005 "MdM Async Manager"
{
    SingleInstance = true;
    TableNo = 472;

    trigger OnRun()
    begin
        // FindCabs es más bien para utilizar el Jobs Queue...
        FindCabs;
    end;

    var
        rTmp: Record 75003 temporary;
        rConfMdM: Record 75000;
        rConfSant: Record 56001;
        rAsSender: Codeunit 75006;
        cGest: Codeunit 75001;
        cTrasp: Codeunit 75007;
        rCab: Record 75003;

    procedure FindCabs()
    var
        lwOK: Boolean;
        lwInt: Integer;
        lwInt2: Integer;
        lwMin: Integer;
        lwCDT: DateTime;
        lwNInts: Integer;
    begin
        // FindCabs

        CLEAR(rCab);
        //rCab.SETRANGE(Entrada , rCab.Entrada::INT_WS);
        rCab.SETFILTER(Entrada, '%1|%2', rCab.Entrada::INT_WS, rCab.Entrada::NOTIFICA);
        rCab.SETFILTER("Estado Envio", '<%1', rCab."Estado Envio"::Finalizado);

        lwCDT := CURRENTDATETIME;

        IF rCab.FINDSET THEN BEGIN
            REPEAT
                lwNInts := rCab.Attempt + 1;
                rCab.GetIntDates2(lwInt2, lwInt, lwNInts);

                lwOK := (rCab."Last Attempt" = 0DT);
                IF NOT lwOK THEN BEGIN
                    // Primero 5 intentos cada 5 minutos
                    // Despues 5 intentos cada 15 minutos
                    // Finalmente 5 intentos cada 3 horas
                    CASE lwInt2 OF
                        1:
                            lwMin := 5;
                        2:
                            lwMin := 15;
                        3:
                            lwMin := 180;
                    END;
                    IF lwInt2 < 4 THEN
                        lwOK := ((lwCDT - rCab."Last Attempt") * 60000) > lwMin
                    ELSE BEGIN // Si pasa de los 3 intentos cada 3 horas la desestimamos
                        rCab."Estado Envio" := rCab."Estado Envio"::Desestimada;
                        rCab.MODIFY;
                    END;
                END;

                IF lwOK THEN BEGIN
                    IF NOT rTmp.GET(rCab.Id) THEN BEGIN
                        rTmp.COPY(rCab);
                        rTmp.INSERT;
                    END;
                END;

            UNTIL rCab.NEXT = 0;
            Ejecuta;
        END;

        // Por si acaso, al final de todo, elimino registros antiguos
        BorraRegsAntiguos;

        // Desactivamos la cola si no hay nada que mandar
        SetHoldQ;
    end;

    procedure Ejecuta()
    var
        lwTipo: Option Insert,Update,Delete,Error;
        lwErrCode: Code[20];
        lwErrDescription: Text[1024];
        lwIsError: Boolean;
    begin
        //Ejecuta

        COMMIT;
        // Solo procesamos lo que tenemos en el temporal
        IF rTmp.FIND('-') THEN BEGIN
            REPEAT
                // Recuperamos el registro real
                CLEAR(rCab);
                IF rCab.GET(rTmp.Id) THEN
                    TraspasaCab(rCab);
            UNTIL rTmp.NEXT = 0;
        END;
    end;

    procedure TraspasaCab(var prCab: Record 75003)
    var
        lwErrCode: Code[20];
        lwErrDescription: Text;
        lwIsError: Boolean;
    begin
        // TraspasaCab

        IF prCab.Entrada = prCab.Entrada::INT_Excel THEN
            EXIT;

        CLEARLASTERROR;
        COMMIT;
        prCab.NewIntent;
        lwIsError := FALSE;
        //prCab."Texto Error" := '';
        IF prCab.Entrada = prCab.Entrada::INT_WS THEN BEGIN
            IF prCab.Estado = prCab.Estado::Pendiente THEN BEGIN
                lwIsError := NOT cTrasp.RUN(prCab);
                IF lwIsError THEN BEGIN
                    prCab.Estado := prCab.Estado::Error;
                    lwErrDescription := GETLASTERRORTEXT;
                    prCab."Texto Error" := COPYSTR(lwErrDescription, 1, 250);
                END
                ELSE
                    prCab."Texto Error" := '';
            END
            ELSE BEGIN
                IF prCab.Estado = prCab.Estado::Error THEN
                    lwErrDescription := prCab."Texto Error";
            END;

            IF prCab.Estado = prCab.Estado::Error THEN BEGIN
                lwErrCode := '100';
                //TODO: Ver rAsSender.BuildXMLError(prCab, lwErrCode, lwErrDescription);
            END
            ELSE BEGIN
                //TODO: Ver rAsSender.BuildXMLRequest(prCab);
            END;
        END;

        //TODO: Ver rAsSender.Send(prCab); // Enviamos la respuesta asincrona

        cGest.GestColaProy(0); // Nos aseguramos que la cola de proyecto está activada
        prCab.MODIFY;
    end;

    procedure BorraRegsAntiguos()
    var
        lrCab: Record 75003;
        lwFechaB: DateTime;
        lwDias: Text;
    begin
        // BorraRegsAntiguos
        // Se eliminan todos los registros anteriores a n dias

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        IF rConfMdM."Dias Borrado Historico" = 0 THEN
            EXIT;

        lwDias := STRSUBSTNO('<-%1D>', rConfMdM."Dias Borrado Historico");
        lwFechaB := CREATEDATETIME(CALCDATE(lwDias, TODAY), 000000T);

        CLEAR(lrCab);
        lrCab.SETFILTER("Fecha Creacion", '<%1', lwFechaB);
        //lrCab.SETFILTER(Entrada, '<>%1',  lrCab.Entrada::NOTIFICA);
        lrCab.SETFILTER(Estado, '<>%1', lrCab.Estado::Pendiente);
        lrCab.SETRANGE(Entrada, lrCab.Entrada::INT_WS, lrCab.Entrada::INT_Excel);
        lrCab.DELETEALL(TRUE);

        // Borramos tambien las notificaciones
        CLEAR(lrCab);
        lrCab.SETFILTER("Fecha Creacion", '<%1', lwFechaB);
        lrCab.SETRANGE(Entrada, lrCab.Entrada::NOTIFICA);
        lrCab.SETRANGE("Estado Envio", lrCab."Estado Envio"::Finalizado);
        lrCab.DELETEALL(TRUE);
    end;

    procedure SetHoldQ()
    var
        lrCab2: Record 75003;
    begin
        // SetHoldQ

        // Desactivamos la cola si no hay nada que mandar
        CLEAR(lrCab2);
        lrCab2.SETFILTER(Entrada, '<>%1', lrCab2.Entrada::INT_Excel);
        lrCab2.SETFILTER("Estado Envio", '<%1', lrCab2."Estado Envio"::Finalizado);
        IF lrCab2.ISEMPTY THEN
            cGest.GestColaProy(1);
    end;

    procedure GetSistemaOrigen() Result: Text
    begin
        // GetSistemaOrigen

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;
        Result := DELCHR(rConfMdM."Sistema Origen", '<>');

        IF Result = '' THEN BEGIN
            rConfSant.GET;
            Result := rConfSant.GetSistemaOrigen;
        END;
    end;
}

