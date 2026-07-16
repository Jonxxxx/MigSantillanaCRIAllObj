codeunit 75008 "MdM Notifica Precios"
{
    // Una problematica con la que nos encontramos es que MdM no tiene encuenta las fechas para los precios, por lo que el ultimo precio notificado es el bueno
    // Eso choca con Navision ya que se pueden configurar precios de compra a fecha futura
    // En cuanto se Crea precio con fecha futura, se genera un movimiento de cola de proyecto que activará la notificacion a la fecha de inicio del precio
    // 
    // JPT $001 02/04/2019 - Nueva funcionalidad: Modificamos para que no se cree una cola de proyecto para cada producto sino una por dia..

    TableNo = 472;

    trigger OnRun()
    begin

        IF STRPOS("Parameter String", Text001) = 1 THEN
            GestPrecio("Parameter String");
        // Sea como sea lanza el segundo proceso
        GestPrecio2;
    end;

    var
        Text001: Label 'Precio';
        cGestMaestros: Codeunit 75001;
        rConfMdM: Record 75000;
        Text002: Label 'MdM. Activa Notificacion precios de producto ';

    procedure GetParam(pwIdProd: Code[20]) Result: Text
    begin
        // GetParam

        Result := STRSUBSTNO('%1(%2)', Text001, pwIdProd);
    end;

    procedure GestPrecio(pwParam: Text)
    var
        lwParm: Text;
        lwPos: Integer;
        lrProd: Record 27;
    begin
        // GestPrecio

        lwParm := UPPERCASE(DELCHR(pwParam, '<>'));
        lwPos := STRPOS(lwParm, UPPERCASE(Text001));
        IF lwPos <> 1 THEN
            EXIT;
        lwParm := COPYSTR(lwParm, STRLEN(Text001) + 1);
        lwParm := DELCHR(lwParm, '<>', '()');

        IF lrProd.GET(lwParm) THEN
            cGestMaestros.GestNotityPrecProd(lrProd);
    end;

    procedure GestPrecio2()
    var
        lwFecha: Date;
        lrPrecFt: Record 75011;
        lwPrd: Code[20];
        lrProd: Record 27;
    begin
        // GestPrecio2
        // $001

        lwFecha := TODAY;

        CLEAR(lrPrecFt);
        lrPrecFt.SETCURRENTKEY(Producto, Fecha);
        lrPrecFt.SETFILTER(Fecha, '<=%1', lwFecha);
        IF lrPrecFt.FINDSET THEN BEGIN
            CLEAR(lwPrd);
            REPEAT
                IF lwPrd <> lrPrecFt.Producto THEN BEGIN
                    lwPrd := lrPrecFt.Producto;
                    IF lrProd.GET(lwPrd) THEN
                        cGestMaestros.GestNotityPrecProd(lrProd);
                END;
            UNTIL lrPrecFt.NEXT = 0;
            lrPrecFt.DELETEALL;
        END;
    end;

    procedure CreaNotif(var prPrec: Record 7002; pwDelete: Boolean)
    var
        lwFecha: Date;
        lwFecha2: Date;
        lrJQueueE: Record 472;
        lwExist: Boolean;
        lwOk: Boolean;
    begin
        // CreaNotif
        // Crea la cola de proyecto la cual a su vez generará una notificacion de precios al MdM cuando llegue la fecha indicada
        // Obsoleto

        // Solo si se trata de fechas futuras
        lwFecha := cGestMaestros.GestFechaPrecio;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;

        // Solo precios futuros
        //IF ((prPrec."Ending Date" <= lwFecha) AND (prPrec."Ending Date" <> 0D)) THEN
        // Modificacion para que tenga en cuenta solo precios futuros... con fecha de inicio futura
        IF ((prPrec."Ending Date" <= lwFecha) AND (prPrec."Ending Date" <> 0D)) OR (prPrec."Starting Date" <= lwFecha) THEN
            pwDelete := TRUE;

        lwExist := lrJQueueE.GET(prPrec.IdJobQueueEntry);
        IF lwExist THEN
            lwExist := lrJQueueE."Job Queue Category Code" = rConfMdM."Job Queue Category";

        IF lwExist THEN BEGIN
            IF pwDelete THEN
                lrJQueueE.DELETE(TRUE)
            ELSE BEGIN
                lwFecha2 := prPrec."Starting Date";
                IF lwFecha2 <= lwFecha THEN
                    lwFecha2 := CALCDATE('<+1D>', lwFecha); // Mañana
                lrJQueueE."Earliest Start Date/Time" := CREATEDATETIME(lwFecha2, HoraInicio);
                lrJQueueE.MODIFY(TRUE);
                cGestMaestros.ActColaProy; // Nos aseguramos que la cola está activada
                                           //lwOk := CODEUNIT.RUN(75001); // Nos aseguramos que la cola está activada
            END;
        END;

        IF (NOT lwExist) AND (NOT pwDelete) THEN BEGIN
            // Crea un movimiento de cola de proyecto nuevo
            CLEAR(lrJQueueE);
            lrJQueueE.INSERT(TRUE);
            lrJQueueE.VALIDATE("Job Queue Category Code", rConfMdM."Job Queue Category");
            lrJQueueE.VALIDATE(Description, Text002);
            lrJQueueE.VALIDATE("Object Type to Run", lrJQueueE."Object Type to Run"::Codeunit);
            lrJQueueE.VALIDATE("Object ID to Run", 75008);
            lrJQueueE.VALIDATE("Parameter String", GetParam(prPrec."Item No."));
            lwFecha2 := prPrec."Starting Date";
            IF lwFecha2 <= lwFecha THEN
                lwFecha2 := CALCDATE('<+1D>', lwFecha); // Mañana
            lrJQueueE."Earliest Start Date/Time" := CREATEDATETIME(lwFecha2, HoraInicio);
            lrJQueueE.MODIFY(TRUE);

            prPrec.IdJobQueueEntry := lrJQueueE.ID; // Anotamos la id de la cola de proyecto en la linea de precio
                                                    //prPrec.MODIFY;  // No debe de modifiarse ya que el precio viene por referencia
            cGestMaestros.ActColaProy; // Nos aseguramos que la cola está activada
                                       //lwOk := CODEUNIT.RUN(75001); // Nos aseguramos que la cola está activada
        END;
    end;

    procedure CreaNotif2(var XprPrec: Record 7002; var prPrec: Record 7002; pwDelete: Boolean)
    var
        lwFecha: Date;
        lwOk: Boolean;
    begin
        // CreaNotif2
        // $001 Una linea de precios a futuro que servira para que se lance la notificacion el dia de vencimiento

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;

        IF pwDelete THEN BEGIN
            GestPrecFut(prPrec, prPrec."Starting Date", 0, TRUE);
            GestPrecFut(prPrec, prPrec."Ending Date", 1, TRUE);
        END
        ELSE BEGIN
            IF (XprPrec."Starting Date" <> prPrec."Starting Date") THEN BEGIN
                GestPrecFut(XprPrec, XprPrec."Starting Date", 0, TRUE);
                GestPrecFut(prPrec, prPrec."Starting Date", 0, FALSE);
            END;
            IF (XprPrec."Ending Date" <> prPrec."Ending Date") THEN BEGIN
                GestPrecFut(XprPrec, XprPrec."Ending Date", 1, TRUE);
                GestPrecFut(prPrec, prPrec."Ending Date", 1, FALSE);
            END;
        END;

        cGestMaestros.ActColaProy; // Nos aseguramos que la cola está activada
    end;

    procedure GestPrecFut(var prPrec: Record 7002; pwFecha: Date; pwTipo: Option Inicio,Fin; pwDelete: Boolean)
    var
        lwFecha: Date;
        lwExist: Boolean;
        lrPrecFt: Record 75011;
        lrRecRf: RecordRef;
        lwOK: Boolean;
        lwDel2: Boolean;
    begin
        // GestPrecFut
        // $001 Una linea de precios a futuro que servira para que se lance la notificacion el dia de vencimiento

        IF pwFecha = 0D THEN
            EXIT;

        // Solo si se trata de fechas futuras
        IF NOT pwDelete THEN BEGIN
            lwFecha := cGestMaestros.GestFechaPrecio;
            IF pwFecha < lwFecha THEN
                pwDelete := TRUE;
        END;

        lrRecRf.GETTABLE(prPrec);

        CLEAR(lrPrecFt);
        lrPrecFt.SETRANGE(Producto, prPrec."Item No.");
        lrPrecFt.SETRANGE(Fecha, pwFecha);
        lrPrecFt.SETRANGE(Tipo, pwTipo);
        lrPrecFt.SETRANGE(PricePos, lrRecRf.RECORDID);
        lwExist := lrPrecFt.FINDFIRST;

        IF lwExist THEN BEGIN
            IF pwDelete THEN BEGIN
                lrPrecFt.DELETE;
                lwOK := TRUE;
            END;
        END;

        IF (NOT lwExist) AND (NOT pwDelete) THEN BEGIN
            // Crea un registro nuevo
            CLEAR(lrPrecFt);
            lrPrecFt.Producto := prPrec."Item No.";
            lrPrecFt.Fecha := pwFecha;
            lrPrecFt.PricePos := lrRecRf.RECORDID;
            lrPrecFt.Tipo := pwTipo;
            lrPrecFt.INSERT(TRUE);
            lwOK := TRUE;
        END;

        // Ahora Gestionamos la cola de proyecto
        IF lwOK THEN BEGIN
            CLEAR(lrPrecFt);
            lrPrecFt.SETRANGE(Fecha, pwFecha);
            lwDel2 := lrPrecFt.ISEMPTY;
            GestMovCola2(pwFecha, lwDel2);
        END;
    end;

    procedure GestMovCola2(pwFecha: Date; pwDelete: Boolean)
    var
        lwFecha: Date;
        lwFecha2: Date;
        lrJQueueE: Record 472;
        lwExist: Boolean;
        lwOk: Boolean;
        lwIdCdUn: Integer;
        lwDT: DateTime;
    begin
        // GestMovCola2
        // $001 JPT 01/04/2019 Nueva funcionalidad
        // Crea la cola de proyecto la cual a su vez generará una notificacion de precios al MdM cuando llegue la fecha indicada

        IF pwFecha = 0D THEN
            EXIT;

        // Solo si se trata de fechas futuras
        IF NOT pwDelete THEN BEGIN
            lwFecha := cGestMaestros.GestFechaPrecio;
            IF pwFecha < lwFecha THEN
                pwDelete := TRUE;
        END;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;

        lwIdCdUn := 75008;
        lwDT := CREATEDATETIME(pwFecha, HoraInicio);

        CLEAR(lrJQueueE);
        lrJQueueE.SETRANGE("Job Queue Category Code", rConfMdM."Job Queue Category");
        lrJQueueE.SETRANGE("Object Type to Run", lrJQueueE."Object Type to Run"::Codeunit);
        lrJQueueE.SETRANGE("Object ID to Run", lwIdCdUn);
        lrJQueueE.SETRANGE("Earliest Start Date/Time", lwDT);
        //lrJQueueE.SETRANGE("Parameter String"        ,'');
        lwExist := lrJQueueE.FINDFIRST;

        IF lwExist THEN BEGIN
            IF pwDelete THEN
                lrJQueueE.DELETE(TRUE)
        END;

        IF (NOT lwExist) AND (NOT pwDelete) THEN BEGIN
            // Crea un movimiento de cola de proyecto nuevo
            CLEAR(lrJQueueE);
            lrJQueueE.INSERT(TRUE);
            lrJQueueE.VALIDATE("Job Queue Category Code", rConfMdM."Job Queue Category");
            lrJQueueE.VALIDATE(Description, Text002);
            lrJQueueE.VALIDATE("Object Type to Run", lrJQueueE."Object Type to Run"::Codeunit);
            lrJQueueE.VALIDATE("Object ID to Run", lwIdCdUn);
            lrJQueueE."Earliest Start Date/Time" := lwDT;
            lrJQueueE.MODIFY(TRUE);
        END;

        cGestMaestros.ActColaProy; // Nos aseguramos que la cola está activada
    end;

    procedure HoraInicio() Result: Time
    begin
        // HoraInicio
        // Diez minutos pasados medianoche
        Result := 001000T;
    end;
}

