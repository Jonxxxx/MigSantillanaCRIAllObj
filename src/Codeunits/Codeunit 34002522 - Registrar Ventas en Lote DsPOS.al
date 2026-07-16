codeunit 34002522 "Registrar Ventas en Lote DsPOS"
{
    // $001 24/07/15 JML : Añado dimensiones por defecto POS
    // #44884  26/02/2016  MOI   En el proceso nocturno, si la factura o las lineas tiene un cupon este se tiene que marcar como pendiente FALSE.
    //                           En el proceso nocturno, si las lineas de la nota de credito tiene un cupon este se tiene que marcar como pendiente TRUE.
    // 
    // #65232  PLB 10/05/2017: Temas Varios DSPOS - Mejoras
    //            03/07/2017: Si no tiene pagos y el cliente permite venta a crédito, no guardar el error en la tabla
    // 
    // #76946  RRT 20.01.2018: Creacion de la funcion localizada FinalProcesoRegistro()
    // #75918  RRT 15.03.2018: Testear exclusividad "Nº fiscal TPV" en Bolivia. Para que sea generico se establece una funcion en la CU del pais para
    //            comprobar inconvenientes antes de registrar.
    // 
    // #116510 RRT 07.11.2018: Actualizacion de DS-POS en Honduras.
    //         #57166  28/09/16    JMB   :   Se actualiza los nº de serie al registrar el documento
    // 
    // #126073 RRT 22.04.2018: Seguimiento y registro del error que pudiera ocurrir al ejecutar FE() en Guatemala.
    // #201856 RRT 25.02.2018: Replantear el control cuando no han llegado los pagos.
    // #232158 RRT 27.06.2019: Adaptacion a FE 2.0
    // #232158 RRT 18.11.2019: En la empresa <ACTIVA EDUCA> de Guatemala la facturacion electronica debe ser con
    //             el metodo anterior. Se ha modificado la funcion Registro_Localizado()
    // 
    // #246745 RRT 29.07.2019: Que en la funcion TestIntegridad() se devuelva FALSE, si faltan datos de pagos o no se ha completado la transaccion.
    // #257334 RRT 28.08.2019: Para prevenir errores en la liquidacion de un documento, se comprueba que todos los registros en <Transacciones TPV Caja> correspondan a la misma transaccion.
    // #273889 RRT 15.10.2019: Se quita el control sobre "Pagos TPV" temporalmente.
    // #348662 RRT 26.11.2020: Unificacion de DS-POS.
    // #305288 RRT 10.03.2020: Revisar el test de integridad para Honduras.
    // #350950 RRT 23.12.2020: Se ha visto que no se estaba especificando el num. documento en el log de derrores.
    // 
    // 
    // DE MOMENTO SOLO SE REGISTRA.
    // . no hay autoliquidacion. es decir la funcion liquidarpendientes() esta desactivado.
    // . solo se testean las lineas.   ni pagos ni nada maas. desasteriscar.
    // . LA FUNCION TIENEPAGO DEVUELVE SIEMPRE TRUE.  BUSCAR RRT Y ELIMINAR LINEAS

    Permissions = TableData 112 = rimd,
                  TableData 114 = rimd,
                  TableData 34002504 = rimd;

    trigger OnRun()
    var
        rCabLog: Record 34002533;
        Text000: Label 'Registrar Facturas en su Fecha.,Solicitar Nueva Fecha de Registro.';
        Text001: Label 'Se procederá a Registrar y Liquidar todas las ventas de Tienda\¿Desea Continuar?';
        Text002: Label 'Proceso Terminado';
        Error001: Label 'Cancelado a Peticion del Usuario';
        CduPOS: Codeunit 34002502;
        Error002: Label 'Proceso Solo Disponible en Servidor Central';
        recTPV: Record 34002501;
        Seleccion: Integer;
        PagFecha: Page 34002559;
        Error003: Label 'La fecha de registro no puede ser inferior a la fecha actual';
    begin
        //+999 PLB
        //IF USERID <> 'SANTILLANA-NAV\DYNASOFT' THEN
        //  ERROR('El sistema está en modo depuracion, se está trabajando para resolver un problema con la liquidacion del DSPos. En breve esta opcion volverá a estar habilitada.');
        //-999 PLB


        IF GUIALLOWED THEN BEGIN

            //TODO: Ver recTPV.SETRANGE("Usuario windows", CduPOS.TraerUsuarioWindows);
            IF recTPV.FINDFIRST THEN
                ERROR(Error002);

            IF NOT CONFIRM(Text001, FALSE) THEN
                ERROR(Error001);

            Seleccion := STRMENU(Text000, 1);
            IF Seleccion = 0 THEN
                ERROR(Error001);

            IF Seleccion = 2 THEN BEGIN
                CLEAR(PagFecha);
                PagFecha.LOOKUPMODE(TRUE);

                IF PagFecha.RUNMODAL = ACTION::Yes THEN BEGIN
                    wFechaProceso := PagFecha.DevolverFecha();
                    CASE TRUE OF
                        (wFechaProceso = 0D):
                            ERROR(Error001);
                        (wFechaProceso < TODAY):
                            ERROR(Error003);
                        (wFechaProceso < WORKDATE):
                            ERROR(Error003);
                    END;
                END
                ELSE
                    ERROR(Error001);

            END;

        END;

        BorrarDocumentosDuplicados;

        rCabLog.INIT;
        rCabLog.Fecha := WORKDATE;
        rCabLog."Hora Inicio" := FormatTime(TIME);
        rCabLog.INSERT(TRUE);
        wNumLog := rCabLog."No. Log";

        RegistroNocturno();
        LiquidarRegistrados();

        rCabLog."Fecha Fin" := WORKDATE;
        rCabLog."Hora Fin" := FormatTime(TIME);
        rCabLog.MODIFY(FALSE);

        //+76946
        Final_Localizado;
        //-76946


        IF GUIALLOWED THEN
            MESSAGE(Text002);
    end;

    var
        dlgProgreso: Dialog;
        wNumLog: Integer;
        wFechaProceso: Date;
        cfComunes: Codeunit 34002503;
        cGuatemala: Codeunit 34002508;

    procedure RegistroNocturno()
    var
        recCabVta: Record 36;
        intProcesados: Integer;
        intTotal: Integer;
        cduPOS: Codeunit 34002503;
        Text001: Label 'Registrando documentos DsPOS :\\Facturas @@@@@@@@@@@@@@@@@@@@1\Notas de crédito  @@@@@@@@@@@@@@@@@@@@2';
        Text002: Label 'Registrada Correctamente';
        Text003: Label ' Error Registro: %1';
        rParametros: Record 34002522;
        Text004: Label 'Liquidada Correctamente.';
        Text005: Label 'Error Liquidar Fac: %1';
        Text006: Label 'Registrada Correctamente.';
        Text007: Label 'Error Registro : %1';
        Text008: Label 'Liquidada Correctamente.';
        Text009: Label 'Error Liquidacion NC: %1';
        rPagos: Record 34002521;
        rTiendas: Record 34002503;
        rLinVta: Record 37;
        wPagoEncontrado: Boolean;
        rCliente: Record 18;
        rTPV: Record 34002501;
        Text010: Label 'La venta no tiene cobros asocidados y el cliente "%1" no tiene la marca "%2".';
        rTipoPago: Record 34002513;
        rTransCajaTPV: Record 34002523;
        SigTransaccion: Integer;
    begin

        IF GUIALLOWED THEN
            dlgProgreso.OPEN(Text001);


        WITH recCabVta DO BEGIN
            RESET;
            SETRANGE("Document Type", "Document Type"::Invoice);
            SETRANGE("Venta TPV", TRUE);
            SETRANGE("Registrado TPV", TRUE);

            IF FINDSET THEN BEGIN

                intTotal := COUNT;
                intProcesados := 0;

                REPEAT

                    //+#201856
                    //... Revisamos si están las lineas (y pagos¿?)
                    //+#75918
                    //IF TestRegistroViable(recCabVta) THEN BEGIN
                    //-75918
                    IF TestRegistroViable(recCabVta) AND TestIntegridad(recCabVta) THEN BEGIN
                        //-#201856

                        CLEARLASTERROR;
                        AsignarDimensiones(recCabVta);
                        COMMIT;

                        Ship := TRUE;
                        Invoice := TRUE;
                        wPagoEncontrado := FALSE;

                        IF wFechaProceso <> 0D THEN
                            "Posting Date" := wFechaProceso;

                        rCliente.GET("Sell-to Customer No.");

                        //+#65232
                        /*
                        rPagos.RESET;
                        rPagos.SETRANGE("No. Borrador" , "No.");
                        wPagoEncontrado := rPagos.FINDFIRST;

                        IF wPagoEncontrado OR (rCliente."Permite venta a credito") THEN BEGIN
                        */
                        IF NOT TienePago("No.", "Posting No.") AND NOT rCliente."Permite venta a credito" THEN
                            CrearPagoBorrador(recCabVta);

                        IF TienePago("No.", "Posting No.") OR rCliente."Permite venta a credito" THEN BEGIN
                            //-#65232

                            rTPV.RESET;
                            rTPV.GET(Tienda, TPV);
                            IF NOT rTPV."Venta Movil" THEN BEGIN
                                rTiendas.RESET;
                                IF rTiendas.GET(Tienda) THEN
                                    IF ("Location Code" <> rTiendas."Cod. Almacen") AND
                                       (rTiendas."Cod. Almacen" <> '') THEN BEGIN
                                        "Location Code" := rTiendas."Cod. Almacen";

                                        rLinVta.RESET;
                                        rLinVta.SETRANGE("Document No.", "No.");
                                        rLinVta.SETRANGE("Document Type", "Document Type");
                                        IF rLinVta.FINDSET THEN
                                            rLinVta.MODIFYALL("Location Code", rTiendas."Cod. Almacen", FALSE);
                                    END;

                                MODIFY(FALSE);
                                COMMIT;
                            END;


                            COMMIT; //#325138
                            IF CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", recCabVta) THEN BEGIN

                                // #57166 : INI
                                ActualizarSeries(recCabVta."No. Series", recCabVta."No.");                       // Borrador
                                ActualizarSeries(recCabVta."Posting No. Series", recCabVta."Last Posting No.");          // Registradas
                                ActualizarSeries(recCabVta."No. Serie NCF Facturas", recCabVta."No. Comprobante Fiscal");    // NCF
                                                                                                                             // #57166 : FIN

                                //#44884:Inicio
                                marcarCupones(recCabVta);
                                //#44884:Fin

                                InsertarDetalle(recCabVta, 0, FALSE, STRSUBSTNO(Text002, recCabVta."No. Fiscal TPV"));
                                Registro_Localizado(recCabVta);

                                IF wPagoEncontrado THEN BEGIN
                                    rParametros.RESET;
                                    rParametros.Accion := rParametros.Accion::LiquidarFactura;
                                    rParametros.Documento := recCabVta."Last Posting No.";
                                    rParametros.Manual := FALSE;
                                    COMMIT;
                                    IF CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", rParametros) THEN
                                        InsertarDetalle(recCabVta, 1, FALSE, STRSUBSTNO(Text004, recCabVta."No. Fiscal TPV"))
                                    ELSE
                                        InsertarDetalle(recCabVta, 1, TRUE, STRSUBSTNO(Text005, GETLASTERRORTEXT));
                                END;

                            END
                            ELSE
                                InsertarDetalle(recCabVta, 0, TRUE, STRSUBSTNO(Text003, GETLASTERRORTEXT));
                        END
                        //+#65232
                        ELSE IF NOT rCliente."Permite venta a credito" THEN
                            InsertarDetalle(recCabVta, 0, TRUE, STRSUBSTNO(Text010, rCliente."No.", rCliente.FIELDCAPTION("Permite venta a credito")));
                        //-#65232

                        IF GUIALLOWED THEN BEGIN
                            intProcesados += 1;
                            dlgProgreso.UPDATE(1, ROUND(intProcesados / intTotal * 10000, 1));
                        END;

                    END; //+#75918

                UNTIL NEXT = 0;

            END;

            RESET;
            SETRANGE("Document Type", "Document Type"::"Credit Memo");
            SETRANGE("Venta TPV", TRUE);
            SETRANGE("Registrado TPV", TRUE);


            IF FINDSET THEN BEGIN

                intTotal := COUNT;
                intProcesados := 0;

                REPEAT

                    //+#201856
                    //... Revisamos si están las lineas (y pagos¿?)
                    //+#75918
                    //IF TestRegistroViable(recCabVta) THEN BEGIN
                    //-75918
                    IF TestRegistroViable(recCabVta) AND TestIntegridad(recCabVta) THEN BEGIN
                        //-#201856

                        CLEARLASTERROR;
                        AsignarDimensiones(recCabVta);
                        COMMIT;

                        Ship := TRUE;
                        Invoice := TRUE;
                        wPagoEncontrado := FALSE;

                        rCliente.GET("Sell-to Customer No.");

                        IF wFechaProceso <> 0D THEN
                            "Posting Date" := wFechaProceso;
                        //+999
                        //ELSE IF (USERID = 'SANTILLANA-NAV\DYNASOFT') AND ("Posting Date" < CALCDATE('<-CM>',WORKDATE)) THEN
                        //  "Posting Date" := WORKDATE;
                        //-999

                        //+#65232
                        /*
                        rPagos.RESET;
                        rPagos.SETRANGE("No. Borrador" , recCabVta."No.");
                        wPagoEncontrado := rPagos.FINDFIRST;

                        IF wPagoEncontrado OR rCliente."Permite venta a credito"  THEN BEGIN
                        */
                        IF NOT TienePago("No.", "Posting No.") AND NOT rCliente."Permite venta a credito" THEN
                            CrearPagoBorrador(recCabVta);

                        IF TienePago("No.", "Posting No.") OR rCliente."Permite venta a credito" THEN BEGIN
                            //-#65232

                            rTPV.RESET;
                            rTPV.GET(Tienda, TPV);
                            IF NOT rTPV."Venta Movil" THEN BEGIN
                                rTiendas.RESET;
                                IF rTiendas.GET(Tienda) THEN
                                    IF ("Location Code" <> rTiendas."Cod. Almacen") AND
                                       (rTiendas."Cod. Almacen" <> '') THEN BEGIN
                                        "Location Code" := rTiendas."Cod. Almacen";

                                        rLinVta.RESET;
                                        rLinVta.SETRANGE("Document No.", "No.");
                                        rLinVta.SETRANGE("Document Type", "Document Type");
                                        IF rLinVta.FINDSET THEN
                                            rLinVta.MODIFYALL("Location Code", rTiendas."Cod. Almacen", FALSE);
                                    END;

                                MODIFY(FALSE);
                                COMMIT;
                            END;

                            COMMIT; //#325138
                            IF CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", recCabVta) THEN BEGIN

                                // #57166 : INI
                                ActualizarSeries(recCabVta."No. Series", recCabVta."No.");                       // Borrador
                                ActualizarSeries(recCabVta."Posting No. Series", recCabVta."Last Posting No.");          // Registradas
                                ActualizarSeries(recCabVta."No. Serie NCF Abonos", recCabVta."No. Comprobante Fiscal");    // NCF
                                                                                                                           // #57166 : FIN

                                //#44884:Inicio
                                marcarCupones(recCabVta);
                                //#44884:Fin

                                InsertarDetalle(recCabVta, 0, FALSE, STRSUBSTNO(Text006, recCabVta."No. Fiscal TPV"));
                                Registro_Localizado(recCabVta);

                                IF wPagoEncontrado THEN BEGIN
                                    rParametros.RESET;
                                    rParametros.Accion := rParametros.Accion::LiquidarNotaCredito;
                                    rParametros.Documento := recCabVta."Last Posting No.";
                                    rParametros.Manual := FALSE;

                                    COMMIT;
                                    IF CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", rParametros) THEN
                                        InsertarDetalle(recCabVta, 1, FALSE, STRSUBSTNO(Text008, recCabVta."No. Fiscal TPV"))
                                    ELSE
                                        InsertarDetalle(recCabVta, 1, TRUE, STRSUBSTNO(Text009, GETLASTERRORTEXT));
                                END;

                            END
                            ELSE
                                InsertarDetalle(recCabVta, 0, TRUE, STRSUBSTNO(Text007, GETLASTERRORTEXT));
                        END
                        //+#65232
                        ELSE IF NOT rCliente."Permite venta a credito" THEN
                            InsertarDetalle(recCabVta, 0, TRUE, STRSUBSTNO(Text010, rCliente."No.", rCliente.FIELDCAPTION("Permite venta a credito")));
                        //-#65232

                        IF GUIALLOWED THEN BEGIN
                            intProcesados += 1;
                            dlgProgreso.UPDATE(2, ROUND(intProcesados / intTotal * 10000, 1));
                        END;

                    END; //+#75918

                UNTIL NEXT = 0;
            END;

        END;

        IF GUIALLOWED THEN
            dlgProgreso.CLOSE;

    end;

    procedure AsignarDimensiones(var recPrmCabVta: Record 36)
    var
        recLinVta: Record 37;
        recDimPOS: Record 34003053;
        DimMgt: Codeunit 408;
        recTmpDimEntry: Record 480 temporary;
        recDimVal: Record 349;
    begin
        WITH recPrmCabVta DO BEGIN

            SetHideValidationDialog(TRUE);
            //TODO: Ver CreateDim(
            //TODO: Ver DATABASE::Customer, "Bill-to Customer No.",
            //TODO: Ver DATABASE::"Salesperson/Purchaser", "Salesperson Code",
            //TODO: Ver DATABASE::Campaign, "Campaign No.",
            //TODO: Ver DATABASE::"Responsibility Center", "Responsibility Center",
            //TODO: Ver DATABASE::"Customer Template", "Bill-to Customer Template Code");

            recLinVta.RESET;
            recLinVta.SETRANGE("Document Type", "Document Type");
            recLinVta.SETRANGE("Document No.", "No.");
            IF recLinVta.FINDSET THEN
                REPEAT
                    //TODO: Ver  recLinVta.CreateDim(
                    //TODO: Ver   DimMgt.TypeToTableID3(recLinVta.Type), recLinVta."No.",
                    //TODO: Ver   DATABASE::Job, recLinVta."Job No.",
                    //TODO: Ver   DATABASE::"Responsibility Center", recLinVta."Responsibility Center");
                    recLinVta.MODIFY;
                UNTIL recLinVta.NEXT = 0;


            //<$001
            //Añadimos las dimensiones por defecto del POS a la cabecera
            recDimPOS.RESET;
            recDimPOS.SETFILTER("Valor dimension", '<>%1', '');
            IF recDimPOS.FINDSET THEN BEGIN
                REPEAT

                    DimMgt.GetDimensionSet(recTmpDimEntry, "Dimension Set ID");

                    IF recTmpDimEntry.GET("Dimension Set ID", recDimPOS.Dimension) THEN BEGIN
                        recTmpDimEntry."Dimension Value Code" := recDimPOS."Valor dimension";
                        recDimVal.GET(recTmpDimEntry."Dimension Code", recTmpDimEntry."Dimension Value Code");
                        recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
                        recTmpDimEntry.MODIFY;
                    END
                    ELSE BEGIN
                        recTmpDimEntry.INIT;
                        recTmpDimEntry."Dimension Code" := recDimPOS.Dimension;
                        recTmpDimEntry."Dimension Value Code" := recDimPOS."Valor dimension";
                        recDimVal.GET(recTmpDimEntry."Dimension Code", recTmpDimEntry."Dimension Value Code");
                        recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
                        recTmpDimEntry.INSERT;
                    END;

                UNTIL recDimPOS.NEXT = 0;
                recPrmCabVta."Dimension Set ID" := DimMgt.GetDimensionSetID(recTmpDimEntry);
                recPrmCabVta.MODIFY;
            END;

            //Añadimos las dimensiones por defecto del POS a cada linea

            recLinVta.RESET;
            recLinVta.SETRANGE("Document Type", "Document Type");
            recLinVta.SETRANGE("Document No.", "No.");
            IF recLinVta.FINDSET THEN
                REPEAT
                    recDimPOS.RESET;
                    recDimPOS.SETFILTER("Valor dimension", '<>%1', '');
                    IF recDimPOS.FINDSET THEN BEGIN
                        REPEAT

                            recTmpDimEntry.DELETEALL;
                            DimMgt.GetDimensionSet(recTmpDimEntry, recLinVta."Dimension Set ID");

                            IF recTmpDimEntry.GET(recLinVta."Dimension Set ID", recDimPOS.Dimension) THEN BEGIN
                                recTmpDimEntry."Dimension Value Code" := recDimPOS."Valor dimension";
                                recDimVal.GET(recTmpDimEntry."Dimension Code", recTmpDimEntry."Dimension Value Code");
                                recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
                                recTmpDimEntry.MODIFY;
                            END
                            ELSE BEGIN
                                recTmpDimEntry.INIT;
                                recTmpDimEntry."Dimension Code" := recDimPOS.Dimension;
                                recTmpDimEntry."Dimension Value Code" := recDimPOS."Valor dimension";
                                recDimVal.GET(recTmpDimEntry."Dimension Code", recTmpDimEntry."Dimension Value Code");
                                recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
                                recTmpDimEntry.INSERT;
                            END;

                        UNTIL recDimPOS.NEXT = 0;
                        recLinVta."Dimension Set ID" := DimMgt.GetDimensionSetID(recTmpDimEntry);
                        recLinVta.MODIFY;
                    END;

                UNTIL recLinVta.NEXT = 0;

            //$001>

        END;
    end;

    procedure BorrarDocumentosDuplicados()
    var
        rec36: Record 36;
        rec37: Record 37;
        rec112: Record 112;
        rec114: Record 114;
    begin

        rec36.RESET;
        rec36.SETRANGE("Document Type", rec36."Document Type"::Invoice);
        rec36.SETRANGE("Venta TPV", TRUE);
        rec36.SETRANGE("Registrado TPV", TRUE);
        IF rec36.FINDSET THEN BEGIN
            REPEAT
                //+#65232
                //if rec112.GET(rec36."Posting No.") THEN BEGIN
                rec112.SETRANGE("No.", rec36."Posting No.");
                rec112.SETRANGE("No. Fiscal TPV", rec36."No. Fiscal TPV");
                rec112.SETRANGE(TPV, rec36.TPV);
                rec112.SETRANGE(Tienda, rec36.Tienda);
                rec112.SETRANGE("Hora creacion", rec36."Hora creacion");
                IF rec112.FINDFIRST THEN BEGIN
                    //-#65232
                    rec37.RESET;
                    rec37.SETRANGE("Document Type", rec36."Document Type");
                    rec37.SETRANGE("Document No.", rec36."No.");
                    rec37.DELETEALL;
                    rec36.DELETE;
                END;
            UNTIL rec36.NEXT = 0;
        END;

        rec36.RESET;
        rec36.SETRANGE("Document Type", rec36."Document Type"::"Credit Memo");
        rec36.SETRANGE("Venta TPV", TRUE);
        rec36.SETRANGE("Registrado TPV", TRUE);
        IF rec36.FINDSET THEN BEGIN
            REPEAT
                //+#65232
                //IF rec114.GET(rec36."Posting No.") THEN BEGIN
                rec114.SETRANGE("No.", rec36."Posting No.");
                rec114.SETRANGE("No. Fiscal TPV", rec36."No. Fiscal TPV");
                rec114.SETRANGE(TPV, rec36.TPV);
                rec114.SETRANGE(Tienda, rec36.Tienda);
                rec114.SETRANGE("Hora creacion", rec36."Hora creacion");
                IF rec114.FINDFIRST THEN BEGIN
                    //-#65232
                    rec37.RESET;
                    rec37.SETRANGE("Document Type", rec36."Document Type");
                    rec37.SETRANGE("Document No.", rec36."No.");
                    rec37.DELETEALL;
                    rec36.DELETE;
                END;
            UNTIL rec36.NEXT = 0;
        END;
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

    procedure InsertarDetalle(prCab: Record 36; pProceso: Option Registro,Liquidacion,Firma; pError: Boolean; pTexto: Text)
    var
        rLinLog: Record 34002534;
    begin

        WITH rLinLog DO BEGIN

            INIT;

            "No. Log" := wNumLog;
            Error := pError;

            CASE prCab."Document Type" OF
                prCab."Document Type"::Invoice:
                    "Tipo Documento" := "Tipo Documento"::Factura;
                prCab."Document Type"::"Credit Memo":
                    "Tipo Documento" := "Tipo Documento"::"Nota Credito";
            END;

            IF NOT Error THEN BEGIN
                CASE pProceso OF
                    pProceso::Registro:
                        Registrado := TRUE;
                    pProceso::Liquidacion:
                        Liquidado := TRUE;

                    //+#126073
                    pProceso::Firma:
                        Firmado := TRUE;
                //-#126073

                END;
            END;

            "No. Documento" := prCab."No. Fiscal TPV";
            //+#65232
            IF "No. Documento" = '' THEN
                "No. Documento" := prCab."Posting No.";
            //-#65232
            "Fecha Documento" := prCab."Posting Date";
            Tienda := prCab.Tienda;
            TPV := prCab.TPV;

            //+#126073
            //Texto             := pTexto;
            Texto := COPYSTR(pTexto, 1, MAXSTRLEN(Texto));
            //-#126073

            "No. documento NAV" := prCab."Last Posting No.";
            INSERT(TRUE);

        END;
    end;

    procedure LiquidarRegistrados()
    var
        recCabVta: Record 36;
        recCabFac: Record 112;
        recCabNC: Record 114;
        rCliente: Record 18;
        intProcesados: Integer;
        intTotal: Integer;
        cduPOS: Codeunit 34002503;
        Text001: Label 'Liquidando documentos DsPOS :\\Facturas @@@@@@@@@@@@@@@@@@@@1\Notas de crédito  @@@@@@@@@@@@@@@@@@@@2';
        rParametros: Record 34002522;
        Text004: Label 'Liquidada Correctamente.';
        Text005: Label 'Error Liquidar Fac: %1';
        Text008: Label 'Liquidada Correctamente.';
        Text009: Label 'Error Liquidacion NC: %1';
        rPagos: Record 34002521;
        lFechaLimite: Date;
        lDesde: Date;
    begin

        IF GUIALLOWED THEN
            dlgProgreso.OPEN(Text001);

        //+#199415
        lFechaLimite := TODAY;
        IF wFechaProceso > TODAY THEN
            lFechaLimite := wFechaProceso;
        //-#199415

        lDesde := TODAY - 31;
        IF lDesde < 20210701D THEN
            lDesde := 20210701D;

        WITH recCabFac DO BEGIN

            RESET;
            SETCURRENTKEY("Posting Date", Tienda, "Venta TPV");
            SETRANGE("Venta TPV", TRUE);

            //+#199415
            //SETRANGE("Posting Date"   , TODAY -31 , TODAY);
            //SETRANGE("Posting Date"   , TODAY -31 , lFechaLimite);
            SETRANGE("Posting Date", lDesde, lFechaLimite);
            //-#199415

            SETRANGE("Liquidado TPV", FALSE);

            IF FINDSET THEN BEGIN

                intTotal := COUNT;
                intProcesados := 0;

                REPEAT

                    CLEARLASTERROR;

                    //+#65232
                    /*
                    COMMIT;

                    rPagos.RESET;
                    rPagos.SETCURRENTKEY("No. Factura","Cod. divisa");
                    rPagos.SETRANGE("No. Factura", "No.");
                    IF rPagos.FINDFIRST THEN BEGIN
                    */

                    rCliente.GET("Sell-to Customer No.");
                    IF NOT TienePago("Pre-Assigned No.", "No.") AND NOT rCliente."Permite venta a credito" THEN
                        CrearPagoFactura(recCabFac);

                    IF TienePago("Pre-Assigned No.", "No.") THEN BEGIN
                        //-#65232

                        recCabVta.INIT;
                        recCabVta."Document Type" := recCabVta."Document Type"::Invoice;
                        recCabVta."No. Fiscal TPV" := "No. Fiscal TPV";

                        //+#350950
                        IF recCabVta."No. Fiscal TPV" = '' THEN
                            recCabVta."No. Fiscal TPV" := "No.";
                        //-#350950

                        recCabVta."Posting Date" := "Posting Date";
                        recCabVta.Tienda := Tienda;
                        recCabVta.TPV := TPV;

                        rParametros.RESET;
                        rParametros.Accion := rParametros.Accion::LiquidarFactura;
                        rParametros.Documento := "No.";
                        rParametros.Manual := FALSE;
                        COMMIT;

                        IF CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", rParametros) THEN
                            InsertarDetalle(recCabVta, 1, FALSE, STRSUBSTNO(Text004, recCabVta."No. Fiscal TPV"))
                        ELSE
                            InsertarDetalle(recCabVta, 1, TRUE, STRSUBSTNO(Text005, GETLASTERRORTEXT));

                    END;

                    IF GUIALLOWED THEN BEGIN
                        intProcesados += 1;
                        dlgProgreso.UPDATE(1, ROUND(intProcesados / intTotal * 10000, 1));
                    END;

                UNTIL NEXT = 0;

            END;
        END;

        WITH recCabNC DO BEGIN

            RESET;
            SETCURRENTKEY("Posting Date", Tienda, "Venta TPV");
            SETRANGE("Venta TPV", TRUE);
            //+#199415
            //SETRANGE("Posting Date"   , TODAY -31 , TODAY);
            //SETRANGE("Posting Date"   , TODAY -31 , lFechaLimite);
            SETRANGE("Posting Date", lDesde, lFechaLimite);
            //-#199415

            SETRANGE("Liquidado TPV", FALSE);

            IF FINDSET THEN BEGIN

                intTotal := COUNT;
                intProcesados := 0;

                REPEAT

                    CLEARLASTERROR;

                    //+#65232
                    /*
                    COMMIT;

                    rPagos.RESET;
                    rPagos.SETCURRENTKEY("No. Nota Credito");
                    rPagos.SETRANGE("No. Nota Credito", "No.");
                    IF rPagos.FINDFIRST THEN BEGIN
                      COMMIT;
                    */
                    rCliente.GET("Sell-to Customer No.");
                    IF NOT TienePago("Pre-Assigned No.", "No.") AND NOT rCliente."Permite venta a credito" THEN
                        CrearPagoNotaCr(recCabNC);

                    IF TienePago("Pre-Assigned No.", "No.") THEN BEGIN
                        //-#65232

                        recCabVta.INIT;
                        recCabVta."Document Type" := recCabVta."Document Type"::"Credit Memo";
                        recCabVta."No. Fiscal TPV" := "No. Fiscal TPV";

                        //+#350950
                        IF recCabVta."No. Fiscal TPV" = '' THEN
                            recCabVta."No. Fiscal TPV" := "No.";
                        //-#350950

                        recCabVta."Posting Date" := "Posting Date";
                        recCabVta.Tienda := Tienda;
                        recCabVta.TPV := TPV;

                        rParametros.RESET;
                        rParametros.Accion := rParametros.Accion::LiquidarNotaCredito;
                        rParametros.Documento := "No.";
                        rParametros.Manual := FALSE;
                        COMMIT;
                        IF CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", rParametros) THEN
                            InsertarDetalle(recCabVta, 1, FALSE, STRSUBSTNO(Text008, recCabVta."No. Fiscal TPV"))
                        ELSE
                            InsertarDetalle(recCabVta, 1, TRUE, STRSUBSTNO(Text009, GETLASTERRORTEXT));
                    END;

                    IF GUIALLOWED THEN BEGIN
                        intProcesados += 1;
                        dlgProgreso.UPDATE(2, ROUND(intProcesados / intTotal * 10000, 1));
                    END;

                UNTIL NEXT = 0;
            END;

        END;

        IF GUIALLOWED THEN
            dlgProgreso.CLOSE;

    end;

    procedure Registro_Localizado(pSalesH: Record 36)
    var
        lcGuatEduca: Codeunit 34002512;
        lcCostaRica: Codeunit 34002511;
    begin
        //TODO: Ver 
        /*
        CASE cfComunes.Pais() OF
            //+#126073
            //... Se realiza un tratamiento de gestion de los posibles errores en el proceso de firma.
            //5:cGuatemala.FE(pSalesH);
            5:
                BEGIN
                    //+#232158
                    //... FE 2.0
                    IF NOT cGuatemala.TestFE20 THEN BEGIN
                        COMMIT;
                        CLEARLASTERROR;
                        lcGuatEduca.Parametros_2(pSalesH, wNumLog, FALSE);
                        IF lcGuatEduca.RUN THEN
                            lcGuatEduca.LogFirmaEnCentral(pSalesH, '')
                        ELSE
                            lcGuatEduca.LogFirmaEnCentral(pSalesH, COPYSTR(GETLASTERRORTEXT, 1, 1024));
                    END
                    ELSE BEGIN
                        cGuatemala.Parametros_2(pSalesH, wNumLog, FALSE);
                        cGuatemala.LogFirmaEnCentral(pSalesH, '')
                    END;
                    //-#232158
                END;

            //+#217374
            9:
                BEGIN
                    COMMIT;
                    CLEARLASTERROR;
                    lcCostaRica.Parametros_2(pSalesH, wNumLog, FALSE);
                    IF lcCostaRica.RUN THEN
                        lcCostaRica.LogFirmaEnCentral(pSalesH, '')
                    ELSE
                        lcCostaRica.LogFirmaEnCentral(pSalesH, COPYSTR(GETLASTERRORTEXT, 1, 1024));

                END;
        //-#217374
        
        END;*/
    end;

    procedure marcarCupones(pSalesHeader: Record 36)
    var
        lrSalesInvoiceHeader: Record 112;
        lrCabeceraCupon: Record 51009;
        lrSalesInvoiceLine: Record 113;
        lrSalesCrMemoLine: Record 115;
    begin
        //#44884:Inicio
        CASE pSalesHeader."Document Type" OF
            pSalesHeader."Document Type"::Invoice:
                BEGIN
                    lrSalesInvoiceHeader.GET(pSalesHeader."Last Posting No.");

                    IF lrSalesInvoiceHeader."Cod. Cupon" <> '' THEN BEGIN
                        //buscar el cupon
                        lrCabeceraCupon.GET(lrSalesInvoiceHeader."Cod. Cupon");
                        lrCabeceraCupon.Pendiente := FALSE;
                        lrCabeceraCupon.MODIFY(FALSE);
                    END
                    ELSE BEGIN
                        //buscar los cupones asignados a las lineas de la factura
                        lrSalesInvoiceLine.RESET;
                        lrSalesInvoiceLine.SETRANGE(lrSalesInvoiceLine."Document No.", lrSalesInvoiceHeader."No.");
                        IF lrSalesInvoiceLine.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF lrSalesInvoiceLine."Cod. Cupon" <> '' THEN BEGIN
                                    //buscar el cupon
                                    lrCabeceraCupon.GET(lrSalesInvoiceLine."Cod. Cupon");
                                    lrCabeceraCupon.Pendiente := FALSE;
                                    lrCabeceraCupon.MODIFY(FALSE);
                                END;
                            UNTIL lrSalesInvoiceLine.NEXT = 0;
                    END;
                END;
            pSalesHeader."Document Type"::"Credit Memo":
                BEGIN
                    lrSalesCrMemoLine.SETRANGE(lrSalesCrMemoLine."Document No.", pSalesHeader."Last Posting No.");
                    IF lrSalesCrMemoLine.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF lrSalesCrMemoLine."Cod. Cupon" <> '' THEN BEGIN
                                //lrCabeceraCupon.GET(lrSalesInvoiceLine."Cod. Cupon"); //-#65232
                                lrCabeceraCupon.GET(lrSalesCrMemoLine."Cod. Cupon"); //+#65232
                                lrCabeceraCupon.Pendiente := TRUE;
                                lrCabeceraCupon.MODIFY(FALSE);
                            END;
                        UNTIL lrSalesCrMemoLine.NEXT = 0;
                END;
        END;
        //#44884:Fin
    end;

    procedure TienePago(NoBorrador: Code[20]; NoRegistrado: Code[20]): Boolean
    var
        rPagos: Record 34002521;
        rTransCaja: Record 34002523;
    begin
        //+#65232: nueva funcion

        rPagos.RESET;
        rPagos.SETRANGE("No. Borrador", NoBorrador);
        IF NOT rPagos.ISEMPTY THEN
            EXIT(TRUE);

        rTransCaja.RESET;
        rTransCaja.SETCURRENTKEY("No. Registrado", rTransCaja."Cod. divisa");
        rTransCaja.SETRANGE("No. Registrado", NoRegistrado);
        EXIT(NOT rTransCaja.ISEMPTY);
    end;

    procedure CrearPago(NoBorrador: Code[20]; NoRegistrado: Code[20]; Importe: Decimal; EsAbono: Boolean; CodTienda: Code[20]; CodTPV: Code[20]; Fecha: Date; Hora: Time; IdCajero: Code[50])
    var
        rPagos: Record 34002521;
        rTransCaja: Record 34002523;
        rTipoPago: Record 34002513;
        SigTransaccion: Integer;
    begin
        //+#65232: nueva funcion

        rTipoPago.SETRANGE("Efectivo Local", TRUE);
        rTipoPago.FINDFIRST;

        rPagos.INIT;
        rPagos."No. Borrador" := NoBorrador;
        rPagos."Forma pago TPV" := rTipoPago."ID Pago";
        rPagos.Cambio := FALSE;
        rPagos.Tienda := CodTienda;
        rPagos.TPV := CodTPV;
        rPagos."Cod. divisa" := '';
        rPagos."Importe (DL)" := Importe;
        rPagos.Importe := Importe;
        rPagos.Fecha := Fecha;
        rPagos.Hora := Hora;
        IF EsAbono THEN
            rPagos."No. Nota Credito" := NoRegistrado
        ELSE
            rPagos."No. Factura" := NoRegistrado;
        rPagos."Factor divisa" := 1;
        rPagos.INSERT;

        rTransCaja.RESET;
        rTransCaja.SETRANGE("Cod. tienda", CodTienda);
        rTransCaja.SETRANGE("Cod. TPV", CodTPV);
        rTransCaja.SETRANGE(Fecha, Fecha);
        rTransCaja.SETRANGE("No. turno", 999);
        IF rTransCaja.FINDLAST THEN
            SigTransaccion := rTransCaja."No. transaccion" + 1
        ELSE
            SigTransaccion := 1;

        rTransCaja.INIT;
        rTransCaja."Cod. tienda" := CodTienda;
        rTransCaja."Cod. TPV" := CodTPV;
        rTransCaja.Fecha := Fecha;
        rTransCaja."No. turno" := 999;
        rTransCaja."No. transaccion" := SigTransaccion;
        rTransCaja."Tipo transaccion" := rTransCaja."Tipo transaccion"::"Cobro TPV";
        rTransCaja."Id. cajero" := IdCajero;
        rTransCaja.Hora := Hora;
        rTransCaja."Forma de pago" := rPagos."Forma pago TPV";
        rTransCaja.Importe := rPagos.Importe;
        rTransCaja."Importe (DL)" := rPagos."Importe (DL)";
        rTransCaja."Cod. divisa" := rPagos."Cod. divisa";
        rTransCaja."Factor divisa" := rPagos."Factor divisa";
        rTransCaja."No. Registrado" := NoRegistrado;
        rTransCaja.Cambio := rPagos.Cambio;
        rTransCaja.INSERT;
    end;

    procedure CrearPagoBorrador(recCabVta: Record 36)
    begin
        //+#65232: nueva funcion

        WITH recCabVta DO BEGIN
            CALCFIELDS("Amount Including VAT");

            IF "Document Type" = "Document Type"::Invoice THEN
                CrearPago("No.", "Posting No.", "Amount Including VAT", FALSE, Tienda, TPV, "Posting Date", "Hora creacion", "ID Cajero")
            ELSE
                CrearPago("No.", "Posting No.", -"Amount Including VAT", TRUE, Tienda, TPV, "Posting Date", "Hora creacion", "ID Cajero");
        END;
    end;

    procedure CrearPagoFactura(recCabVta: Record 112)
    var
        recMovCliente: Record 21;
        optPrmTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin
        //+#65232: nueva funcion

        WITH recCabVta DO BEGIN
            IF GetMovClientePendiente(recMovCliente, recCabVta."Sell-to Customer No.", optPrmTipoDoc::Invoice, recCabVta."No.") THEN BEGIN
                recMovCliente.CALCFIELDS("Remaining Amt. (LCY)");

                CrearPago(recCabVta."Pre-Assigned No.", "No.", recMovCliente."Remaining Amt. (LCY)", FALSE, Tienda, TPV, "Posting Date", "Hora creacion", "ID Cajero")
            END;
        END;
    end;

    procedure CrearPagoNotaCr(recCabVta: Record 114)
    var
        recMovCliente: Record 21;
        optPrmTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin
        //+#65232: nueva funcion

        WITH recCabVta DO BEGIN
            IF GetMovClientePendiente(recMovCliente, recCabVta."Sell-to Customer No.", optPrmTipoDoc::Invoice, recCabVta."No.") THEN BEGIN
                recMovCliente.CALCFIELDS("Remaining Amt. (LCY)");

                CrearPago(recCabVta."Pre-Assigned No.", "No.", recMovCliente."Remaining Amt. (LCY)", TRUE, Tienda, TPV, "Posting Date", "Hora creacion", "ID Cajero")
            END;
        END;
    end;

    procedure GetMovClientePendiente(var recMovCliente: Record 21; codPrmCliente: Code[20]; optPrmTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; codPrmDoc: Code[20]): Boolean
    begin
        //+#65232: nueva funcion

        recMovCliente.RESET;
        recMovCliente.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        recMovCliente.SETRANGE("Document Type", optPrmTipoDoc);
        recMovCliente.SETRANGE("Document No.", codPrmDoc);
        recMovCliente.SETRANGE("Customer No.", codPrmCliente);
        recMovCliente.SETRANGE(Open, TRUE);
        EXIT(recMovCliente.FINDFIRST);
    end;

    procedure Final_Localizado()
    var
        lcGuatemala: Codeunit 34002508;
        lcCostaRica: Codeunit 34002511;
    begin
        //+76946
        //TODO: Ver 
        /*
        CASE cfComunes.Pais() OF
            5:
                lcGuatemala.FinalProcesoRegistro(wNumLog);

            //+#217374
            9:
                lcCostaRica.FinalProcesoRegistro(wNumLog);
        //-#217374
        
    END;*/
    end;

    procedure TestRegistroViable(lrCV: Record 36): Boolean
    var
        lResult: Boolean;
        lcBolivia: Codeunit 34002505;
    begin
        //+#75918
        lResult := TRUE;
        //TODO: Ver 
        /*
        CASE cfComunes.Pais() OF
            2:
                BEGIN
                    lcBolivia.Parametros(wNumLog);
                    lResult := lcBolivia.TestRegistroViable(lrCV, 1, 0);
                END;
        END;*/

        EXIT(lResult);
    end;

    procedure ActualizarSeries(SeriesCode: Code[10]; LastNoSerieUsed: Code[20])
    var
        SeriesLine: Record 309;
        lrConf: Record 34002500;
    begin
        //+#116510
        //... Esta funcionalidad solo se ejecuta para Honduras.
        IF lrConf.FINDFIRST THEN
            IF lrConf.Pais <> lrConf.Pais::Honduras THEN
                EXIT;


        //+#57166
        SeriesLine.INIT;
        SeriesLine.SETRANGE(SeriesLine."Series Code", SeriesCode);

        IF (SeriesLine.FINDFIRST) AND (LastNoSerieUsed <> '') THEN BEGIN

            SeriesLine."Last No. Used" := LastNoSerieUsed;
            SeriesLine."Last Date Used" := TODAY;

            SeriesLine.MODIFY(FALSE);

        END;
    end;

    procedure Parametros(pNumLog: Integer)
    begin
        //+#126073
        wNumLog := pNumLog;
    end;

    procedure TestIntegridad(lrSH: Record 36): Boolean
    var
        lrSL: Record 37;
        lrPagos: Record 34002521;
        lrTransCaja: Record 34002523;
        TextL001: Label 'No se han encontrado pagos TPV asociados';
        TextL002: Label 'No se han encontrado transacciones caja TPV';
        lrTransCajaAux: Record 34002523;
        TextL003: Label 'Presuntas transacciones diferentes con el mismo num. registro';
        TextL004: Label 'Diferencia entre el importe total del documento y el total de liquidacion';
        lImporteLiquidacion: Decimal;
        lPais: Integer;
        lImportePagos: Decimal;
    begin
        //+#201856

        //TODO: Ver lPais := cfComunes.Pais;

        lrSL.RESET;
        lrSL.SETRANGE("Document Type", lrSH."Document Type");
        lrSL.SETRANGE("Document No.", lrSH."No.");
        IF NOT lrSL.FINDFIRST THEN
            EXIT(FALSE);

        //... Si se trata de El Salvador, salimos de la funcion. No realizamos comprobacion.
        IF lPais = 6 THEN
            EXIT(TRUE);


        IF (lPais = 7) OR (lPais = 9) THEN BEGIN  //Honduras y Costa Rica
            lrPagos.RESET;
            lrPagos.SETRANGE("No. Borrador", lrSH."No.");
            IF NOT lrPagos.FINDFIRST THEN BEGIN
                InsertarDetalle(lrSH, 0, TRUE, TextL001);
                EXIT(FALSE);
            END;

            //+#305288
            lrPagos.CALCSUMS(Importe);
            lImportePagos := lrPagos.Importe;
            //-#305288

        END;

        //IF lPais <> 7 THEN BEGIN  //... De momento, no lo aplicamos en Honduras.
        lrTransCaja.RESET;
        lrTransCaja.SETCURRENTKEY("No. Registrado");
        lrTransCaja.SETRANGE("No. Registrado", lrSH."Posting No.");
        IF NOT lrTransCaja.FINDFIRST THEN BEGIN
            InsertarDetalle(lrSH, 0, TRUE, TextL002);
            EXIT(FALSE);
        END;
        //#-246745

        //#+257334
        //... Si los datos comprarados difieren podemos pensar que se han mezclado transacciones.
        lrTransCajaAux := lrTransCaja;
        REPEAT
            IF (lrTransCajaAux.Fecha <> lrTransCaja.Fecha) OR
               (lrTransCajaAux.Hora <> lrTransCaja.Hora) OR
               (lrTransCajaAux."Cod. tienda" <> lrTransCaja."Cod. tienda") OR
               (lrTransCajaAux."Cod. TPV" <> lrTransCaja."Cod. TPV") THEN BEGIN

                InsertarDetalle(lrSH, 0, TRUE, TextL003);
                EXIT(FALSE);
            END;

        UNTIL lrTransCaja.NEXT = 0;
        //#-246745
        //END;


        //#+291272
        IF (lPais = 7) OR (lPais = 9) THEN BEGIN  //Costa Rica o Honduras.
            lrSH.CALCFIELDS("Amount Including VAT");
            lrTransCaja.RESET;
            lrTransCaja.SETCURRENTKEY("No. Registrado");
            lrTransCaja.SETRANGE("No. Registrado", lrSH."Posting No.");
            lrTransCaja.CALCSUMS(Importe);
            lImporteLiquidacion := lrTransCaja.Importe;

            //+#305288
            IF lImporteLiquidacion = 0 THEN
                lImporteLiquidacion := lImportePagos;
            //-#305288

            IF lrSH."Document Type" = lrSH."Document Type"::"Credit Memo" THEN
                lImporteLiquidacion := -1 * lImporteLiquidacion;

            IF lrSH."Amount Including VAT" <> lImporteLiquidacion THEN BEGIN
                InsertarDetalle(lrSH, 0, TRUE, TextL004);
                EXIT(FALSE);
            END;
        END;
        //#-291272

        EXIT(TRUE);
    end;
}

