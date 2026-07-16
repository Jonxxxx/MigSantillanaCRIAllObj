codeunit 34002521 "Control TPV"
{
    // #118629 RRT,  22.02.2018: Si se produce un error en la anulacion se estaba grabando un NCR de forma incorrecta.
    // #144756 RRT,  11.09.2018: Error de sincronizacion con DS-POS.


    trigger OnRun()
    var
        lcFComunes: Codeunit 34002503;
    begin
        //+#118629
        //... Aprovechamos esta funcion para mejorar el proceso de anulacion. Por lo visto, aun en caso de error en el proceso de anulacion. Se estaba realizando un
        //... COMMIT. Debe ser por la interaccion con el Add-ins, no lo sé.
        //... Por lo menos de esta forma podemos evitarlo y tenemos el error controlado.

        //+#144756
        //... Obtenemos la respuesta para sincronizar correctamente con DS-POS.
        //lcFComunes.AnularFactura(wcodPrmTienda,wcodPrmTPV,wcodPrmCajero,wcodPrmDoc);
        //TODO: Ver - Ver codigo completowRespuesta := lcFComunes.AnularFactura(wcodPrmTienda, wcodPrmTPV, wcodPrmCajero, wcodPrmDoc);
        //-#144756
    end;

    var
        wcodPrmTienda: Code[20];
        wcodPrmTPV: Code[20];
        wcodPrmCajero: Code[20];
        wcodPrmDoc: Code[20];
        wRespuesta: Text;

    procedure AbrirDia(codPrmTienda: Code[20]; codPrmTPV: Code[20]; datPrmFecha: Date; codPrmUsuario: Code[20])
    var
        Error001: Label 'El dia ya está abierto.';
        recControlTPV: Record 34002524;
        recTPV: Record 34002501;
        recCajero: Record 34002505;
        decFondo: Decimal;
        Error002: Label 'Debe cerrar el dia %1 antes de abrir el actual.';
        Error003: Label 'El dia %1 ya está cerrado. Debe reabrirlo un supervisor.';
        Error004: Label '¿Desea reabrir el dia %1?';
        Error005: Label 'Solo se puede reabrir el dia una vez.';
        Continuar: Boolean;
        Error006: Label 'Solo se puede reabrir el dia %1 veces.';
        text001: Label 'El dia que intenta abrir %1 es diferente a la Fecha Actual %2\¿Continuar?';
        recTiendas: Record 34002503;
    begin

        recTiendas.GET(codPrmTienda);
        recTPV.GET(codPrmTienda, codPrmTPV);
        recCajero.GET(codPrmTienda, codPrmUsuario);

        //Comprueba que no este abierto el dia
        IF recControlTPV.GET(codPrmTienda, codPrmTPV, datPrmFecha) THEN
            IF recControlTPV.Estado = recControlTPV.Estado::Abierto THEN
                ERROR(Error001);

        //Comprueba que no este abierto otro dia
        recControlTPV.RESET;
        recControlTPV.SETRANGE("No. tienda", codPrmTienda);
        recControlTPV.SETRANGE("No. TPV", codPrmTPV);
        recControlTPV.SETRANGE(Estado, recControlTPV.Estado::Abierto);
        IF recControlTPV.FINDFIRST THEN
            ERROR(Error002, recControlTPV.Fecha);

        //Si el dia de trabajo esta cerrado, pide confirmacion para abrirlo de nuevo
        IF recControlTPV.GET(codPrmTienda, codPrmTPV, datPrmFecha) THEN BEGIN
            CASE recCajero.Tipo OF
                recCajero.Tipo::Cajero:
                    ERROR(Error003, datPrmFecha);
                recCajero.Tipo::Supervisor:
                    BEGIN

                        IF recTiendas."No. Reaperturas Permitidas" = 0 THEN BEGIN
                            IF recControlTPV."Usuario reapertura" <> '' THEN
                                ERROR(Error005);
                        END
                        ELSE
                            IF (recControlTPV."No. Reaperturas" + 1) > recTiendas."No. Reaperturas Permitidas" THEN
                                ERROR(STRSUBSTNO(Error006, recTiendas."No. Reaperturas Permitidas"));

                        IF CONFIRM(Error004, FALSE, datPrmFecha) THEN BEGIN
                            IF SolicitarMotivoReapertura(recControlTPV."Motivo reapertura") THEN BEGIN
                                recControlTPV.Estado := recControlTPV.Estado::Abierto;
                                recControlTPV."Usuario reapertura" := recCajero.ID;
                                recControlTPV."Hora reapertura" := FormatTime(TIME);
                                recControlTPV."No. Reaperturas" += 1;
                                recControlTPV.MODIFY;
                            END;
                        END;
                    END;
            END;
        END
        ELSE BEGIN

            IF WORKDATE <> TODAY THEN
                IF NOT CONFIRM(STRSUBSTNO(text001, WORKDATE, TODAY), FALSE) THEN
                    EXIT;

            IF PedirFondoDeCaja(decFondo) THEN BEGIN
                recControlTPV.INIT;
                recControlTPV."No. tienda" := recTPV.Tienda;
                recControlTPV."No. TPV" := recTPV."Id TPV";
                recControlTPV.Fecha := WORKDATE;
                recControlTPV."Hora apertura" := FormatTime(TIME);
                recControlTPV."Usuario apertura" := recCajero.ID;
                recControlTPV.Estado := recControlTPV.Estado::Abierto;
                recControlTPV.INSERT(TRUE);
                //Se abre el turno automáticamente cuando se abre el dia.
                AbrirTurnoAuto(recControlTPV, decFondo);
            END;
        END;
    end;

    procedure CerrarDia(recPrmControl: Record 34002524; codPrmUsuario: Code[20])
    var
        recControlTPV: Record 34002524;
        recControlTurno: Record 34002529;
        recDecCaja: Record 34002528;
        Error001: Label 'El dia ya está cerrado.';
        Error002: Label 'El turno %1 está abierto. Debe cerrarlo antes de cerrar el dia.';
        recTrans: Record 34002523;
        decDescuadre: Decimal;
    begin

        WITH recPrmControl DO BEGIN

            recControlTPV.RESET;
            recControlTPV.SETRANGE("No. tienda", "No. tienda");
            recControlTPV.SETRANGE("No. TPV", "No. TPV");
            recControlTPV.SETRANGE(Fecha, Fecha);
            recControlTPV.SETRANGE(Estado, recControlTPV.Estado::Abierto);
            IF NOT recControlTPV.FINDFIRST THEN
                ERROR(Error001);

            //Comprueba que no haya ningún turno abierto
            recControlTurno.RESET;
            recControlTurno.SETRANGE("No. tienda", "No. tienda");
            recControlTurno.SETRANGE("No. TPV", "No. TPV");
            recControlTurno.SETRANGE(Fecha, Fecha);
            recControlTurno.SETRANGE(Estado, recControlTurno.Estado::Abierto);
            IF recControlTurno.FINDFIRST THEN
                ERROR(Error002, recControlTurno."No. turno");

            // El ultimo parametro borra
            EliminarBorradores("No. tienda", "No. TPV", TRUE);

            recPrmControl."Hora cierre" := FormatTime(TIME);
            recPrmControl."Usuario cierre" := codPrmUsuario;
            recPrmControl.Estado := recPrmControl.Estado::Cerrado;
            recPrmControl.MODIFY;

        END;
    end;

    procedure AbrirTurnoAuto(recPrmControl: Record 34002524; decPrmFondo: Decimal)
    var
        Error001: Label 'El dia %1 no está abierto.';
        recControlDia: Record 34002529;
        recControlTurno: Record 34002529;
        Error002: Label 'El turno ya está abierto.';
    begin
        recControlTurno.INIT;
        recControlTurno."No. tienda" := recPrmControl."No. tienda";
        recControlTurno."No. TPV" := recPrmControl."No. TPV";
        recControlTurno.Fecha := recPrmControl.Fecha;
        recControlTurno."Hora apertura" := recPrmControl."Hora apertura";
        recControlTurno."Usuario apertura" := recPrmControl."Usuario apertura";
        recControlTurno.Estado := recControlTurno.Estado::Abierto;
        recControlTurno.INSERT(TRUE);
        recControlTurno.ActualizarFondoCaja(recPrmControl."Usuario apertura", decPrmFondo);
    end;

    procedure AbrirTurno(codPrmTienda: Code[20]; codPrmTPV: Code[20]; codPrmFecha: Date; codPrmUsuario: Code[20])
    var
        Error001: Label 'El dia %1 no está abierto.';
        recControlDia: Record 34002524;
        recControlTurno: Record 34002529;
        decFondo: Decimal;
        Error002: Label 'El turno ya está abierto.';
    begin

        //Comprobar que el dia esté abierto
        recControlDia.RESET;
        recControlDia.SETRANGE("No. tienda", codPrmTienda);
        recControlDia.SETRANGE("No. TPV", codPrmTPV);
        recControlDia.SETRANGE(Fecha, codPrmFecha);
        IF recControlDia.FINDFIRST THEN BEGIN
            IF recControlDia.Estado <> recControlDia.Estado::Abierto THEN
                ERROR(Error001, codPrmFecha);
        END
        ELSE
            ERROR(Error001, codPrmFecha);

        //comprobar que el turno no esté abierto
        recControlTurno.RESET;
        recControlTurno.SETRANGE("No. tienda", codPrmTienda);
        recControlTurno.SETRANGE("No. TPV", codPrmTPV);
        recControlTurno.SETRANGE(Fecha, codPrmFecha);
        recControlTurno.SETRANGE(Estado, recControlTurno.Estado::Abierto);
        IF recControlTurno.FINDFIRST THEN
            ERROR(Error002);

        IF PedirFondoDeCaja(decFondo) THEN BEGIN
            recControlTurno.INIT;
            recControlTurno."No. tienda" := codPrmTienda;
            recControlTurno."No. TPV" := codPrmTPV;
            recControlTurno.Fecha := WORKDATE;
            recControlTurno."Hora apertura" := FormatTime(TIME);
            recControlTurno."Usuario apertura" := codPrmUsuario;
            recControlTurno.Estado := recControlTurno.Estado::Abierto;
            recControlTurno.INSERT(TRUE);
            recControlTurno.ActualizarFondoCaja(codPrmUsuario, decFondo);
        END;
    end;

    procedure CerrarTurno(recPrmTurno: Record 34002529; codPrmUsuario: Code[20]): Boolean
    var
        recTPV: Record 34002501;
        recTienda: Record 34002503;
        recDecCaja: Record 34002528;
        Error001: Label 'El turno ya está cerrado.';
        Error002: Label 'El TPV %1 de la tienda %2 no esta asignado al usuario %3';
        Error003: Label 'El descuadre de la caja es superior al permitido.\Debe realziar la declaracion de caja o el turno debe cerrarlo un Supervisor.';
        recTrans: Record 34002523;
        Error004: Label 'El usario de cierre no coincide con el usuario de apertura.\Usuario Apertura: %1 - Usuario Actual: %2';
        Text001: Label 'No se introducido fondo de caja ¿Desea continuar?';
        Text002: Label 'No sa ha registrado ninguna venta ¿Desea continuar?';
        recCajero: Record 34002505;
        decDescuadre: Decimal;
        Text003: Label 'El descuadre de la caja es superior al permitido.\Como Supervisor puede continuar.\¿Desea Continuar?';
        continuar: Boolean;
        text005: Label 'Proceso cancelado';
        rFormPago: Record 34002513;
    begin

        //Comprueba que el usuario sea el que ha abierto el turno o un supervisor

        WITH recPrmTurno DO BEGIN

            //Comprueba que el turno no este cerrado
            IF Estado = Estado::Cerrado THEN
                ERROR(Error001);

            recCajero.GET("No. tienda", codPrmUsuario);
            //Comprueba que el usuario de cierre sea el mismo que el usuario de apertura
            IF recCajero.Tipo <> recCajero.Tipo::Supervisor THEN
                IF "Usuario apertura" <> codPrmUsuario THEN
                    ERROR(Error004, "Usuario apertura", codPrmUsuario);

            //Comprueba que se haya introducido el fondo de caja.
            recTrans.RESET;
            recTrans.SETRANGE("Cod. tienda", "No. tienda");
            recTrans.SETRANGE("Cod. TPV", "No. TPV");
            recTrans.SETRANGE(Fecha, Fecha);
            recTrans.SETRANGE("No. turno", "No. turno");
            recTrans.SETRANGE("Tipo transaccion", recTrans."Tipo transaccion"::Fondo);
            IF NOT recTrans.FINDFIRST THEN
                IF NOT CONFIRM(Text001, FALSE) THEN
                    EXIT;

            //Comprueba si hay transacciones y si no pide confirmacion para cerrar
            recTrans.RESET;
            recTrans.SETRANGE("Cod. tienda", "No. tienda");
            recTrans.SETRANGE("Cod. TPV", "No. TPV");
            recTrans.SETRANGE(Fecha, Fecha);
            recTrans.SETRANGE("No. turno", "No. turno");
            recTrans.SETFILTER("Tipo transaccion", '<>%1', recTrans."Tipo transaccion"::Fondo);
            IF NOT recTrans.FINDFIRST THEN
                IF NOT CONFIRM(Text002, FALSE) THEN
                    EXIT;

            //Control de la declacion de caja
            recTienda.GET("No. tienda");
            IF recTienda."Control de caja" THEN BEGIN

                recDecCaja.RESET;
                recDecCaja.SETRANGE("No. tienda", "No. tienda");
                recDecCaja.SETRANGE("No. TPV", "No. TPV");
                recDecCaja.SETRANGE(Fecha, Fecha);
                recDecCaja.SETRANGE("No. turno", "No. turno");
                IF recDecCaja.FINDSET THEN
                    REPEAT
                        rFormPago.GET(recDecCaja."Forma de pago");
                        IF rFormPago."Realizar recuento" THEN
                            decDescuadre += recDecCaja.TraerDiferencia;
                    UNTIL recDecCaja.NEXT = 0;

                IF ABS(decDescuadre) > recTienda."Descuadre maximo en caja" THEN BEGIN
                    CASE recCajero.Tipo OF
                        recCajero.Tipo::Cajero:
                            ERROR(Error003);
                        recCajero.Tipo::Supervisor:
                            IF NOT CONFIRM(Text003, FALSE) THEN
                                EXIT;
                    END;
                END;
            END;

            "Hora cierre" := FormatTime(TIME);
            "Usuario cierre" := codPrmUsuario;
            Estado := Estado::Cerrado;
            MODIFY;
            EXIT(TRUE);
        END;
    end;

    procedure ComprobarDeclaracionCaja()
    begin
    end;

    procedure MostrarFicha(recPrmControl: Record 34002524)
    var
        frmFichaControl: Page 34002533;
    begin
        frmFichaControl.SETRECORD(recPrmControl);
        frmFichaControl.RUNMODAL;
    end;

    procedure BuscarTPVUsuario(var recPrmTPV: Record 34002501)
    var
        Error001: Label 'El usuario %1 no tiene asignado un TPV.';
    begin
        recPrmTPV.RESET;
        recPrmTPV.SETRANGE("Usuario windows", USERID);
        IF NOT recPrmTPV.FINDFIRST THEN
            ERROR(Error001, USERID);
    end;

    procedure FormatTime(timEntrada: Time): Time
    var
        texHora: Text;
        timSalida: Time;
    begin
        texHora := FORMAT(timEntrada);
        EVALUATE(timSalida, texHora);
        EXIT(timSalida);
    end;

    procedure PedirFondoDeCaja(var decPrmFondo: Decimal): Boolean
    var
        frmFondo: Page 34002540;
    begin
        IF frmFondo.RUNMODAL = ACTION::Yes THEN BEGIN
            decPrmFondo := frmFondo.TraerFondo;
            EXIT(TRUE);
        END;
    end;

    procedure LoginCajero(codPrmTienda: Code[20]; var codPrmUsuario: Code[20]): Boolean
    var
        recGrupoCajeros: Record 34002507;
        recCajero: Record 34002505;
        frmUserPass: Page 34002541;
        codUser: Code[20];
        texPass: Text[30];
        Error001: Label 'El Cajero %1 no existe para la tienda %2';
        Error002: Label 'La contraseña es incorrecta para el Cajero %1';
        Error003: Label 'El Cajero %1 no tiene configurado un Grupo de Cajero';
        Error004: Label 'El Grupo de Cajero %1 no existe';
        Error005: Label 'Defina un Cliente al Contado para el Grupo de Cajeros %1';
    begin

        IF frmUserPass.RUNMODAL = ACTION::Yes THEN BEGIN

            frmUserPass.TraerDatos(codUser, texPass);

            IF NOT recCajero.GET(codPrmTienda, codUser) THEN
                ERROR(Error001, codUser, codPrmTienda);

            IF (LOWERCASE(recCajero.Contrasena) <> LOWERCASE(texPass)) THEN
                ERROR(Error002, codUser);

            IF (recCajero."Grupo Cajero" = '') THEN
                ERROR(Error003, codUser);

            IF NOT (recGrupoCajeros.GET(codPrmTienda, recCajero."Grupo Cajero")) THEN
                ERROR(Error004, recCajero."Grupo Cajero");

            IF (recGrupoCajeros."Cliente al contado" = '') THEN
                ERROR(Error005, recCajero."Grupo Cajero");

            codPrmUsuario := codUser;

            EXIT(TRUE);
        END;
    end;

    procedure ComprobarEstadoTPV(recPrmTPV: Record 34002501): Boolean
    var
        Error001: Label 'El dia esta cerrado. Debe abrirlo desde control de TPVs.';
        recControlTPV: Record 34002524;
        recControlTurnos: Record 34002529;
        Error002: Label 'No hay ningún turno abierto. Debe abrirlo desde control de TPVs.';
        Error003: Label 'El dia Abierto para el TPV %1 es %2 , la fecha en la que intenta vender es %3\Cierre el dia o cambie la fecha de trabajo';
    begin

        //El dia debe estar abierto
        recControlTPV.RESET;
        recControlTPV.SETRANGE("No. tienda", recPrmTPV.Tienda);
        recControlTPV.SETRANGE("No. TPV", recPrmTPV."Id TPV");
        recControlTPV.SETRANGE(Fecha, WORKDATE);
        recControlTPV.SETRANGE(Estado, recControlTPV.Estado::Abierto);
        IF recControlTPV.FINDFIRST THEN BEGIN
            //El turno debe estar abierto
            recControlTurnos.RESET;
            recControlTurnos.SETRANGE("No. tienda", recControlTPV."No. tienda");
            recControlTurnos.SETRANGE("No. TPV", recControlTPV."No. TPV");
            recControlTurnos.SETRANGE(Fecha, recControlTPV.Fecha);
            recControlTurnos.SETRANGE(Estado, recControlTPV.Estado::Abierto);
            IF NOT recControlTurnos.FINDFIRST THEN
                ERROR(Error002);
        END
        ELSE
            IF ((DiaAbierto(recPrmTPV.Tienda, recPrmTPV."Id TPV") <> WORKDATE) AND
               (DiaAbierto(recPrmTPV.Tienda, recPrmTPV."Id TPV") <> 0D))
             THEN
                ERROR(Error003, recPrmTPV."Id TPV", DiaAbierto(recPrmTPV.Tienda, recPrmTPV."Id TPV"), WORKDATE)
            ELSE
                ERROR(Error001);
    end;

    procedure SolicitarMotivoReapertura(var texPrmMotivo: Text[60]): Boolean
    var
        frmMotivo: Page 34002542;
        actAccion: Action;
        texMotivo: Text[60];
    begin
        REPEAT
            CLEAR(frmMotivo);
            actAccion := frmMotivo.RUNMODAL;
            IF actAccion = ACTION::OK THEN
                texMotivo := frmMotivo.TraerMotivo;
        UNTIL (texMotivo <> '') OR (actAccion <> ACTION::OK);

        IF actAccion = ACTION::OK THEN BEGIN
            texPrmMotivo := texMotivo;
            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    end;

    procedure TraerTurnoActual(codPrmTienda: Code[20]; codPrmTPV: Code[20]; datPrmFecha: Date): Integer
    var
        recTurnos: Record 34002529;
    begin
        //Siempre es el turno abierto. Ya que no se puede utilizar otro turno hasta que se cierra.
        recTurnos.RESET;
        recTurnos.SETRANGE("No. tienda", codPrmTienda);
        recTurnos.SETRANGE("No. TPV", codPrmTPV);
        recTurnos.SETRANGE(Fecha, datPrmFecha);
        recTurnos.SETRANGE(Estado, recTurnos.Estado::Abierto);
        recTurnos.FINDFIRST;  //Dejo que de error ya que no se deberia poder vender si no hay un turno abierto
        EXIT(recTurnos."No. turno");
    end;

    procedure UsuarioSuper(codPrmTienda: Code[20]; codPrmUsuario: Code[20]): Boolean
    var
        recCajero: Record 34002505;
    begin
        recCajero.GET(codPrmTienda, codPrmUsuario);
        EXIT(recCajero.Tipo = recCajero.Tipo::Supervisor);
    end;

    procedure EliminarBorradores(codPrmTienda: Code[20]; codPrmTPV: Code[20]; CierreDia: Boolean)
    var
        recCabVta: Record 36;
        rec: Integer;
        rPagosTPV: Record 34002521;
        wDialog: Dialog;
        wNreg: Decimal;
        wTotalRegs: Decimal;
        Text001: Label 'Limpiando registros obsoletos @1@@@@@@@@@@@@';
    begin

        recCabVta.RESET;
        recCabVta.SETRANGE("Venta TPV", TRUE);
        recCabVta.SETRANGE(Tienda, codPrmTienda);
        recCabVta.SETRANGE(TPV, codPrmTPV);
        recCabVta.SETRANGE("Registrado TPV", FALSE);

        IF NOT (CierreDia) THEN
            recCabVta.SETRANGE(Aparcado, FALSE);

        IF recCabVta.FINDSET THEN BEGIN
            wTotalRegs := recCabVta.COUNT;
            wNreg := 0;
            wDialog.OPEN(Text001);
            REPEAT
                rPagosTPV.RESET;
                rPagosTPV.SETRANGE("No. Borrador", recCabVta."No.");
                rPagosTPV.DELETEALL;
                recCabVta."Posting No." := '';
                recCabVta."Posting No. Series" := '';
                recCabVta.MODIFY(FALSE);
                recCabVta.DELETE(TRUE);
                wNreg += 1;
                wDialog.UPDATE(1, ROUND((wNreg / wTotalRegs) * 10000, 1));
            UNTIL recCabVta.NEXT = 0;
            wDialog.CLOSE;
        END;
    end;

    procedure DiaAbierto(pTienda: Code[20]; pTpv: Code[20]): Date
    var
        recControlTPV: Record 34002524;
    begin

        recControlTPV.RESET;
        recControlTPV.SETRANGE("No. tienda", pTienda);
        recControlTPV.SETRANGE("No. TPV", pTpv);
        recControlTPV.SETRANGE(Estado, recControlTPV.Estado::Abierto);
        IF recControlTPV.FINDFIRST THEN
            EXIT(recControlTPV.Fecha)
    end;

    procedure Parametros(codPrmTienda: Code[20]; codPrmTPV: Code[20]; codPrmCajero: Code[20]; codPrmDoc: Code[20])
    begin
        //+#118629
        wcodPrmTienda := codPrmTienda;
        wcodPrmTPV := codPrmTPV;
        wcodPrmCajero := codPrmCajero;
        wcodPrmDoc := codPrmDoc;
    end;

    procedure RetornoValores(var vRespuesta: Text)
    begin
        //+#144756
        vRespuesta := wRespuesta;
    end;
}

