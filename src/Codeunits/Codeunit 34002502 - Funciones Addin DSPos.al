codeunit 55896 "Funciones Addin DSPos"
{
    trigger OnRun()
    var
        lcFuncComunes: Codeunit 55897;
    begin
        //+#121213
        //... Aprovechamos que el evento OnRun() no estaba "ocupado", para tener controlado el registro.
        w_OkRegistro := FALSE;
        IF lcFuncComunes.Registrar(w_Evento, w_Resultado) THEN
            w_OkRegistro := TRUE;
        //-#121213
    end;

    var
        cCostaRica: Codeunit 55905;
        w_Evento: Record "DsPOS Event Buffer" temporary;
        w_Resultado: Record "DsPOS Event Buffer" temporary;
        w_OkRegistro: Boolean;

    procedure Comprobaciones_Iniciales()
    var
        rConfGeneral: Record 55894;
        rTiendas: Record 55897;
        rConfTPV: Record 55895;
        rMenu: Record 55903;
        Error001: Label 'No existe Configuración General DSPoS.';
        Error003: Label 'Debe Asignar un TPV a este equipo.\Imposible Continuar';
        Error005: Label 'Debe Especificar País en Configuración General DSPoS';
        Error007: Label 'El día abierto para el TPV es %1\Debe cerrarlo o cambiar la fecha de trabajo del sistema';
        cControl: Codeunit 55915;
    begin

        CrearAcciones;

        IF NOT rConfGeneral.GET() THEN
            ERROR(Error001);

        rConfGeneral.TESTFIELD(Pais);

        rConfTPV.RESET;
        rConfTPV.SETCURRENTKEY("Usuario windows");
        rConfTPV.SETRANGE("Usuario windows", TraerUsuarioWindows());
        IF NOT rConfTPV.FINDFIRST THEN
            ERROR(Error003);

        rTiendas.GET(TiendaActual);
        rTiendas.TESTFIELD("Cod. Almacen");
        rTiendas.TESTFIELD("ID Reporte contado");
        rTiendas.TESTFIELD("Cantidad de Copias Contado");

        rConfGeneral.TESTFIELD("Nombre Divisa Local");
        WITH rConfTPV DO BEGIN
            GET(TiendaActual, TpvActual);
            TESTFIELD("Menu de acciones");
            TESTFIELD("Menu de Formas de Pago");
            TESTFIELD("No. serie Facturas");
            TESTFIELD("No. serie facturas Reg.");

            IF rTiendas."Permite Anulaciones en POS" THEN BEGIN
                rTiendas.TESTFIELD("ID Reporte nota credito");
                rTiendas.TESTFIELD("Cantidad de Copias Credito");
                TESTFIELD("No. serie notas credito");
                TESTFIELD("No. serie notas credito reg.");
            END;
        END;

        Comprobar_Estado(rConfTPV);
        Comprobar_FormPagos(rConfTPV);
        Comprobar_Botones(rConfTPV."Menu de Formas de Pago", rConfTPV."Menu de acciones");
        Comprobar_Minimos(rConfTPV."Menu de acciones");
        Comprobar_Bancos(rConfTPV);

        cCostaRica.Comprobaciones_Iniciales(TiendaActual(), TpvActual());

        IF cControl.DiaAbierto(rTiendas."Cod. Tienda", rConfTPV."Id TPV") <> WORKDATE THEN
            ERROR(Error007, cControl.DiaAbierto(rTiendas."Cod. Tienda", rConfTPV."Id TPV"));
    end;

    procedure Comprobar_FormPagos(prConfTPV: Record 55895)
    var
        rFormPago: Record 55907;
        wLocal: Boolean;
        Error001: Label 'Debe Definir una forma de Pago Cash para Divisa Local';
        Error002: Label 'Debe Definir un Icono para la forma de pago %1';
        rTarj: Record 55909;
        Error003: Label 'Debe Definir un Icono para el tipo Tarjeta %1';
        lrConf: Record 55894;
        lComprobarIdPago: Boolean;
    begin

        rFormPago.RESET;
        rFormPago.SETRANGE("Efectivo Local", TRUE);
        IF NOT rFormPago.FINDFIRST THEN
            ERROR(Error001);

        //Actualizamos los iconos replicados
        rFormPago.RESET;
        IF rFormPago.FINDSET THEN
            REPEAT
                rFormPago.CALCFIELDS("Icono Nav");
                IF rFormPago."Icono Nav".HASVALUE THEN BEGIN
                    rFormPago.Icono := rFormPago."Icono Nav";
                    rFormPago.MODIFY;
                END;
            UNTIL rFormPago.NEXT = 0;

        //+#116527
        lComprobarIdPago := FALSE;
        lComprobarIdPago := FALSE;
        //-#116527

        rFormPago.RESET;
        IF rFormPago.FINDSET THEN
            REPEAT
                rFormPago.CALCFIELDS(Icono);
                IF NOT rFormPago.Icono.HASVALUE THEN
                    IF (NOT lComprobarIdPago) OR (rFormPago."ID Pago" <> 'EXIVA') THEN   //#116527
                        IF PagoEstaActivo(prConfTPV."Menu de Formas de Pago", rFormPago."ID Pago") OR
                           (rFormPago."Efectivo Local") OR (rFormPago."Tipo Tarjeta" <> '') THEN
                            ERROR(STRSUBSTNO(Error002, rFormPago."ID Pago"));
            UNTIL rFormPago.NEXT = 0;
    end;

    procedure Comprobar_Botones(MenuPagos: Code[10]; MenuAcciones: Code[10])
    var
        rBotones: Record 55905;
    begin

        WITH rBotones DO BEGIN
            RESET;
            SETFILTER("ID Menu", MenuPagos + '|' + MenuAcciones);
            IF FINDSET THEN
                REPEAT
                    IF Activo THEN BEGIN
                        TESTFIELD(Etiqueta);
                        IF "ID Menu" = MenuPagos THEN
                            TESTFIELD(Pago)
                        ELSE
                            TESTFIELD(Accion);
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    procedure Comprobar_Minimos(IdMenu: Code[10])
    var
        rAcciones: Record 55906;
        rBotones: Record 55905;
        Error001: Label 'La accion obligatoria %1 no se encuentra en el menu acciones %2 ó no esta marcada como Activa';
        lwError: Boolean;
    begin

        rAcciones.RESET;
        rAcciones.SETCURRENTKEY("Tipo Accion");
        rAcciones.SETRANGE("Tipo Accion", rAcciones."Tipo Accion"::Obligatoria);
        IF rAcciones.FINDSET THEN BEGIN
            rBotones.SETCURRENTKEY(Accion);
            REPEAT
                rBotones.SETRANGE("ID Menu", IdMenu);
                rBotones.SETRANGE(Accion, rAcciones."ID Accion");
                IF NOT rBotones.FINDFIRST THEN BEGIN

                    rBotones.INIT;
                    rBotones."ID Menu" := IdMenu;
                    rBotones.Descripcion := rAcciones.Descripcion;
                    rBotones.Accion := rAcciones."ID Accion";
                    rBotones.Etiqueta := UPPERCASE(rAcciones.Descripcion);
                    rBotones.Color := 0;
                    rBotones.Activo := TRUE;
                    rBotones."Descuento %" := 0;
                    rBotones.Seguridad := rBotones.Seguridad::" ";
                    rBotones.Pago := '';
                    rBotones.Tipo := rBotones.Tipo::" ";
                    rBotones."No." := '';
                    rBotones."Tipo Accion" := rAcciones."Tipo Accion"::Obligatoria;
                    rBotones.Orden := 0;

                    rBotones.INSERT(TRUE);

                END
            UNTIL rAcciones.NEXT = 0;
        END;
    end;

    procedure PagoEstaActivo(pMenu: Code[10]; pFPago: Code[20]): Boolean
    var
        rBotones: Record 55905;
    begin

        rBotones.RESET;
        rBotones.SETRANGE(Pago, pFPago);
        rBotones.SETRANGE("ID Menu", pMenu);
        IF NOT rBotones.FINDFIRST THEN
            EXIT(FALSE)
        ELSE
            EXIT(rBotones.Activo);
    end;

    procedure Comprobar_Bancos(recPrmCfgTPV: Record 55895)
    var
        recBotones: Record 55905;
        recFormPago: Record 55907;
        recBancosTienda: Record 55898;
        Error001: Label 'Debe configurar una cuenta de banco para la tienda %1 con divisa local';
        Error002: Label 'Debe configurar una cuenta de banco para la tienda %1 con divisa %2';
    begin

        recBancosTienda.RESET;
        recBancosTienda.SETRANGE("Cod. Tienda", recPrmCfgTPV.Tienda);
        recBancosTienda.SETRANGE("Cod. Divisa", '');
        IF NOT recBancosTienda.FINDFIRST THEN
            ERROR(Error001, recPrmCfgTPV.Tienda);

        recBotones.RESET;
        recBotones.SETRANGE("ID Menu", recPrmCfgTPV."Menu de Formas de Pago");
        recBotones.SETRANGE(Activo, TRUE);
        recBotones.SETFILTER(Pago, '<>%1', '');
        IF recBotones.FINDSET THEN
            REPEAT
                recFormPago.GET(recBotones.Pago);
                IF recFormPago."Cod. divisa" <> '' THEN BEGIN
                    recBancosTienda.RESET;
                    recBancosTienda.SETRANGE("Cod. Tienda", recPrmCfgTPV.Tienda);
                    recBancosTienda.SETRANGE("Cod. Divisa", recFormPago."Cod. divisa");
                    IF NOT recBancosTienda.FINDFIRST THEN
                        ERROR(Error002, recPrmCfgTPV.Tienda, recFormPago."Cod. divisa");
                END;
            UNTIL recBotones.NEXT = 0;
    end;

    procedure ServidorBBDD(pOpcion: Integer): Text[100]
    begin
        // En SaaS no se expone el servidor SQL ni el nombre físico de la base.
        exit('');
    end;

    procedure LeerRespuesta(pRespuesta: Text) Resultado: Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        cFuncComunes: Codeunit 55897;
        lcAnular: Codeunit 55915;
        TextL001: Label 'No se ha podido realizar la anulación. Salga de la pantalla de anulación e intentélo en unos segundos';
        lOk: Boolean;
    begin

        Resultado := '';

        IF pRespuesta = '' THEN
            EXIT;

        //MESSAGE(pRespuesta);

        Evento.LoadFromXml(pRespuesta);

        CASE Evento.TipoEvento OF
            0:
                ;
            1:
                AsignarTPV(Evento.TextoDato, Evento.TextoDato2);
            2:
                Resultado := ComprobarLogin(Evento.TextoDato, Evento.TextoDato2);
            6:
                Resultado := cFuncComunes.Nueva_Venta(Evento.TextoDato, Evento.TextoDato2, Evento.TextoDato3, FALSE);
            7:
                Resultado := cFuncComunes.Insertar_Producto(Evento.TextoDato4, Evento.TextoDato, Evento.TextoDato2, Evento.TextoDato3, Evento.DatoDecimal);
            8:
                Resultado := cFuncComunes.Ejecutar_Accion(Evento);
            9:
                Resultado := cFuncComunes.Insertar_Pago(Evento);

            //+#118629
            //10: Resultado := cFuncComunes.AnularFactura(Evento.TextoDato,Evento.TextoDato2,Evento.TextoDato5,Evento.TextoDato3);
            10:
                BEGIN
                    CLEARLASTERROR;

                    COMMIT;  //+#148807

                    lcAnular.Parametros(Evento.TextoDato, Evento.TextoDato2, Evento.TextoDato5, Evento.TextoDato3);

                    //+#144756
                    lOk := lcAnular.RUN;
                    lcAnular.RetornoValores(Resultado);
                    //IF NOT lcAnular.RUN THEN BEGIN
                    IF NOT lOk THEN BEGIN
                        //-#144756

                        //+#121213
                        //... Registramos el error.
                        cFuncComunes.RegistrarError(2, Evento.TextoDato, Evento.TextoDato2, Evento.TextoDato3, GETLASTERRORTEXT);
                        //-#121213

                        //+#232158
                        //MESSAGE(GETLASTERRORTEXT+'. '+ TextL001);
                        MESSAGE(GETLASTERRORTEXT);
                        //-#232158

                        //+#144756
                        //EXIT;
                        EXIT(Resultado);
                        //-#144756

                    END;
                END;
            //-#118629

            12:
                Resultado := cFuncComunes.Eliminar_Pago(Evento);
            13:
                Resultado := cFuncComunes.Nueva_Venta(Evento.TextoDato, Evento.TextoDato2, Evento.TextoDato3, TRUE);
            14:
                Resultado := cFuncComunes.ActualizarDivisas(Evento.TextoDato, Evento.TextoDato2);
            15:
                Resultado := cFuncComunes.PrecioDisponibilidad(Evento);
            16:
                Resultado := cFuncComunes.Crear_Devolucion(Evento);
            17:
                Resultado := cFuncComunes.Imprimir(Evento.TextoDato, Evento.TextoDato3);
            18:
                Resultado := cFuncComunes.ValidaIDCliente(Evento.TextoDato6, Evento.IntDato1);
            19:
                Resultado := ComprobarSupervisor(Evento.TextoDato);
            20:
                Resultado := cFuncComunes.Devolver_Datos_Localizados(Evento);
            21:
                Resultado := cFuncComunes.Desaparcar_Pedido(Evento.TextoDato5);
            22:
                Resultado := cFuncComunes.ImportePropuestoPagoNCR(Evento); //+#70132
            23:
                Resultado := cFuncComunes.Actualiza_Venta_Contacto(Evento.TextoDato3, Evento.TextoDato4);
        END;

        COMMIT;
        EXIT(Resultado);
    end;

    procedure AsignarTPV(pTPV: Code[20]; pTienda: Code[20])
    var
        rConfTPV: Record 55895;
    begin

        WITH rConfTPV DO BEGIN
            GET(pTienda, pTPV);
            "Usuario windows" := TraerUsuarioWindows;
            MODIFY;
        END;
    end;

    procedure ComprobarLogin(pUsuario: Code[20]; pPassword: Text[30]): Text
    var
        rCaj: Record 55899;
        rTie: Record 55897;
        rConf: Record 55894;
        Error001: Label 'El Cajero %1 no existe para la tienda %2';
        Error002: Label 'La clave es incorrecta para el Cajero %1';
        Evento: Record "DsPOS Event Buffer" temporary;
        NumError: Integer;
        Error003: Label 'El Cajero %1 no tiene configurado un Grupo de Cajero';
        rGrupoCaj: Record 55901;
        Error004: Label 'El Grupo de Cajero %1 no existe';
        Error005: Label 'Defina un Cliente al Contado para el Grupo de Cajeros %1';
        cControl: Codeunit 55915;
        cfComunes: Codeunit 55897;
    begin

        NumError := 0;
        CASE TRUE OF
            NOT rCaj.GET(TiendaActual, pUsuario):
                NumError := 1;
            (LOWERCASE(rCaj.Contrasena) <> LOWERCASE(pPassword)) AND (NumError = 0):
                NumError := 2;
            (rCaj."Grupo Cajero" = '') AND (NumError = 0):
                NumError := 3;
            NOT (rGrupoCaj.GET(TiendaActual, rCaj."Grupo Cajero")) AND (NumError = 0):
                NumError := 4;
            (rGrupoCaj."Cliente al contado" = '') AND (NumError = 0):
                NumError := 5;
        END;

        Evento.TipoEvento := 2;
        IF NumError <> 0 THEN
            Evento.AccionRespuesta := 'ERROR';

        CASE NumError OF
            1:
                Evento.TextoRespuesta := STRSUBSTNO(Error001, pUsuario, TiendaActual);
            2:
                Evento.TextoRespuesta := STRSUBSTNO(Error002, pUsuario);
            3:
                Evento.TextoRespuesta := STRSUBSTNO(Error003, pUsuario);
            4:
                Evento.TextoRespuesta := STRSUBSTNO(Error004, rCaj."Grupo Cajero");
            5:
                Evento.TextoRespuesta := STRSUBSTNO(Error005, rCaj."Grupo Cajero");
        END;

        IF NumError = 0 THEN BEGIN
            Evento.TextoDato := TpvActual;
            Evento.TextoDato2 := rGrupoCaj."Cliente al contado";
            Evento.TextoDato3 := pUsuario;
            Evento.TextoDato4 := TiendaActual;
            Evento.IntDato1 := cfComunes.Pais();
            Evento.IntDato2 := cControl.TraerTurnoActual(Evento.TextoDato4, Evento.TextoDato, WORKDATE);

        END;

        EXIT(Evento.aXml());

    end;

    procedure TiendaActual(): Code[20]
    var
        rConf: Record 55894;
        rTPV: Record 55895;
    begin

        rTPV.RESET;
        rTPV.SETCURRENTKEY(Tienda, "Usuario windows");
        rTPV.SETRANGE("Usuario windows", TraerUsuarioWindows);
        rTPV.FINDFIRST;
        EXIT(rTPV.Tienda);
    end;

    procedure TpvActual(): Code[20]
    var
        rConf: Record 55894;
        rTiendas: Record 55897;
        rTPV: Record 55895;
    begin

        rTPV.RESET;
        rTPV.SETCURRENTKEY(Tienda, "Usuario windows");
        rTPV.SETRANGE("Usuario windows", TraerUsuarioWindows);
        rTPV.FINDFIRST;
        EXIT(rTPV."Id TPV");
    end;

    procedure CrearAcciones()
    var
        accion1: Label 'CAMBCANT|Cambiar Cantidad';
        accion2: Label 'CAMBPREC|Cambiar Precio';
        accion3: Label 'DTOGENERAL|Descuento General Pedido';
        accion4: Label 'ANULARLINEA|Anular Linea';
        accion5: Label 'NUEVOPEDIDO|Nuevo Pedido';
        accion6: Label 'ANULARPEDIDO|Anular Pedido';
        accion7: Label 'REGISTRAR|Registrar Pedido';
        rAcciones: Record 55906;
        Pos: Integer;
        accion8: Label 'DTOLINEA|Descuento Linea';
        accion9: Label 'CUPON|Insertar Cupon';
        accion10: Label 'APARCARPEDIDO|Aparcar pedido';
        accion11: Label 'ELIMINARCUPON|Eliminar Cupon';
        accion12: Label 'REIMPRIMIR|Reimprimir Históricos';
        accion13: Label 'EXIVA|Exención de IVA';
        Text001: Label 'Indique la Cantidad:';
        Text002: Label 'Indique el Precio:';
        Text003: Label 'Indique el % de Descuento:';
        rConf: Record 55894;
        text004: Label 'Indique el Nº de Cupón';
        text005: Label 'Eliminar el cupón actual';
        text006: Label 'Introduzca Nº Exención IVA';
    begin

        rConf.GET;
        rConf.TESTFIELD(Pais);

        Pos := STRPOS(accion1, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion1, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion1, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::"Accion Linea";
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Numerico;
        rAcciones."Literal Pedir Datos" := Text001;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion2, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion2, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion2, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::"Accion Linea";
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Numerico;
        rAcciones."Literal Pedir Datos" := Text002;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion3, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion3, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion3, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Accion;
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Numerico;
        rAcciones."Literal Pedir Datos" := Text003;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion4, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion4, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion4, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::"Accion Linea";
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion5, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion5, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion5, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Obligatoria;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion6, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion6, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion6, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Accion;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion7, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion7, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion7, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Obligatoria;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion8, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion8, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion8, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::"Accion Linea";
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Numerico;
        rAcciones."Literal Pedir Datos" := Text003;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion10, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion10, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion10, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Obligatoria;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion12, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion12, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion12, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Accion;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion9, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion9, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion9, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Accion;
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Texto;
        rAcciones."Literal Pedir Datos" := text004;
        IF rAcciones.INSERT THEN;

        Pos := STRPOS(accion11, '|');
        rAcciones.RESET;
        rAcciones.INIT;
        rAcciones."ID Accion" := COPYSTR(accion11, 1, Pos - 1);
        rAcciones.Descripcion := COPYSTR(accion11, Pos + 1);
        rAcciones."Tipo Accion" := rAcciones."Tipo Accion"::Accion;
        rAcciones."Necesita Datos" := TRUE;
        rAcciones."Tipo Datos" := rAcciones."Tipo Datos"::Texto;
        rAcciones."Literal Pedir Datos" := text005;
        IF rAcciones.INSERT THEN;
    end;

    procedure TraerUsuarioWindows(): Text[64]
    begin
        exit(CopyStr(UserId(), 1, 64));
    end;

    procedure Comprobar_Estado(recPrmTPV: Record 55895)
    var
        cduControl: Codeunit 55915;
    begin
        cduControl.ComprobarEstadoTPV(recPrmTPV);
    end;

    procedure RegistrarAddin()
    begin
        // SaaS no permite registrar ensamblados cliente/.NET.
    end;

    procedure ComprobarSupervisor(pPassword: Text[30]): Text
    var
        Error001: Label 'La contraseña introducida no es correcta.';
        Evento: Record "DsPOS Event Buffer" temporary;
        rCaj: Record 55899;
    begin

        // Inicializar Objeto Navision

        // Tipo Evento .NET
        Evento.TipoEvento := 19;

        // Obtener el supervisor con el password introducido
        rCaj.RESET;
        rCaj.SETRANGE(Tienda, TiendaActual());
        rCaj.SETRANGE(Tipo, 2);
        rCaj.SETRANGE(Contrasena, pPassword);

        // Si la constraseña se ha encontrado
        IF NOT rCaj.FINDFIRST THEN BEGIN
            Evento.TextoRespuesta := STRSUBSTNO(Error001);
            Evento.AccionRespuesta := 'ERROR';
        END;

        // Devolvemos el evento a DsPOS
        EXIT(Evento.aXml());
    end;

    procedure SetParameters(var p_Evento: Record "DsPOS Event Buffer" temporary; var p_Resultado: Record "DsPOS Event Buffer" temporary)
    begin
        //+#121213
        w_Evento := p_Evento;
        w_Resultado := p_Resultado;
    end;

    procedure GetParameters(var v_Evento: Record "DsPOS Event Buffer" temporary; var v_Resultado: Record "DsPOS Event Buffer" temporary; var v_OkRegistro: Boolean)
    begin
        //+#121213
        v_Evento := w_Evento;
        v_Resultado := w_Resultado;
        v_OkRegistro := w_OkRegistro;
    end;

}
