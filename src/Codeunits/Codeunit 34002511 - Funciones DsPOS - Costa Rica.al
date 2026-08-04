codeunit 34002511 "Funciones DsPOS - Costa Rica"
{
    // MIGRACION BC27 SAAS V2: estructura original conservada.
    // MIGRACION BC27 SAAS V1: DotNet Evento sustituido por buffer temporal AL y No. Series actualizado.

    Permissions = TableData 112 = rm,
                  TableData 114 = rm;

    trigger OnRun()
    begin
        //+#217374
        //... El otro modo sería el que contemplara la firma electronica desde DS-POS.
        CASE wModo OF
            wModo::FE:
                FE(rGblCabVenta);
        END;
    end;

    var
        cfComunes: Codeunit 34002503;
        rGblCabVenta: Record 36;
        wNumLog: Integer;
        wModo: Option ,FE;
        wEvitarMensajeFE: Boolean;
        ID_ACEPTADO: Label 'aceptado';
        ID_RECHAZADO: Label 'rechazado';

    procedure VaciaCampos_Pais()
    var
        rConfTPV: Record 34002501;
    begin
    end;

    procedure Comprobaciones_Iniciales(p_Tienda: Code[20]; p_IdTPV: Code[20])
    var
        rConfTPV: Record 34002501;
        recTienda: Record 34002503;
    begin

        rConfTPV.GET(p_Tienda, p_IdTPV);
        recTienda.GET(p_Tienda);

        rConfTPV.TESTFIELD("No. serie Facturas");
        rConfTPV.TESTFIELD("No. serie facturas Reg.");

        IF recTienda."Permite Anulaciones en POS" THEN BEGIN
            rConfTPV.TESTFIELD("No. serie notas credito");
            rConfTPV.TESTFIELD("No. serie notas credito reg.");
        END;
    end;

    procedure Nueva_Venta(p_Tienda: Code[20]; p_IdTPV: Code[20]; p_Cajero: Code[20]; var p_SalesHeader: Record 36): Code[20]
    var
        rTPV: Record 34002501;
        NoSeriesManagement: Codeunit "No. Series";
    begin

        WITH p_SalesHeader DO BEGIN
            rTPV.RESET;
            rTPV.GET(p_Tienda, p_IdTPV);
            COMMIT;
            CASE "Document Type" OF
                "Document Type"::Invoice:
                    EXIT(NoSeriesManagement.GetNextNo(rTPV."No. serie facturas Reg.", p_SalesHeader."Posting Date", FALSE));
                "Document Type"::"Credit Memo":
                    EXIT(NoSeriesManagement.GetNextNo(rTPV."No. serie notas credito reg.", p_SalesHeader."Posting Date", FALSE));
            END;
        END;
    end;

    procedure Registrar(var p_SalesH: Record 36; var p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Cust: Record 18;
        CustPostGroup: Record 92;
        Error001: Label 'Debe Espeficiar "Grupo contable cliente" para el cliente %1';
        Error002: Label 'No Existe Grupo Contable Cliente %1';
        NoSeriesMgt: Codeunit "No. Series";
        Error003: Label 'Imposible Modificar Cab. Venta';
        rClientesTPV: Record 34002537;
        rConfTPV: Record 34002501;
        NoSeriesLine: Record 309;
        cduSan: Codeunit 56000;
        SalesLine: Record 37;
        intNoInicioSerie: Integer;
        intNoFinalSerie: Integer;
        intFactura: Integer;
        TextoNet: array[10] of Text[250];
        i: Integer;
        cfComunes: Codeunit 34002503;
        rCab: Record 36;
        rHistCab: Record 112;
        Error004: Label 'La Serie NCF No tiene más numeros';
        lcFE: Codeunit 55202;
    begin

        i := 1;
        WHILE i <= p_Evento.GetTextoPaisCount() DO BEGIN
            TextoNet[i] := p_Evento.GetTextoPaisValue(i);
            i += 1;
        END;

        rConfTPV.GET(p_Evento.TextoDato, p_Evento.TextoDato2);

        WITH p_SalesH DO BEGIN

            Cust.GET("Sell-to Customer No.");
            IF Cust."Customer Posting Group" = '' THEN
                EXIT(STRSUBSTNO('%1', Error001, "Sell-to Customer No."));

            IF NOT CustPostGroup.GET(Cust."Customer Posting Group") THEN
                EXIT(STRSUBSTNO('%1', Error002, Cust."Customer Posting Group"));

            //+#217374
            IF NOT cfComunes.RegistroEnLinea(Tienda) THEN
                DatosParaFE(p_SalesH);
            //-#217374

            IF NOT (Devolucion) THEN BEGIN

                // Guardamos la Cédula Para Fututos Casos
                IF rClientesTPV.GET(TextoNet[1]) THEN
                    rClientesTPV.DELETE;

                rClientesTPV.INIT;
                rClientesTPV.Identificacion := TextoNet[1];
                rClientesTPV.Direccion := TextoNet[2];
                rClientesTPV.Nombre := TextoNet[3];
                rClientesTPV.Telefono := TextoNet[4];
                rClientesTPV.INSERT(FALSE);

                "VAT Registration No." := rClientesTPV.Identificacion;
                "Bill-to Name" := rClientesTPV.Nombre;
                "Bill-to Address" := rClientesTPV.Direccion;
                "Sell-to Customer Name" := rClientesTPV.Nombre;
                "Sell-to Address" := rClientesTPV.Direccion;
                "No. Telefono" := rClientesTPV.Telefono;
                "External Document No." := "No.";


                ActualizaCupon(p_SalesH);

                IF ("No. Fiscal TPV" = '') THEN
                    "No. Fiscal TPV" := "Posting No.";


            END
            ELSE BEGIN  // DEVOLUCIONES

                IF cfComunes.RegistroEnLinea(Tienda) THEN BEGIN
                    rHistCab.GET("Anula a Documento");
                    RetrocedeCupon("Anula a Documento", TRUE, p_SalesH."No.");
                END
                ELSE BEGIN
                    rCab.SETCURRENTKEY("Posting No.");
                    rCab.SETRANGE("Posting No.", "Anula a Documento");
                    rCab.FINDFIRST;
                    RetrocedeCupon("Anula a Documento", FALSE, p_SalesH."No.");
                END;

                "No. Fiscal TPV" := "Posting No.";

            END;

        END;
    end;

    procedure Ejecutar_Accion(var p_Evento: Record "DsPOS Event Buffer" temporary; var p_EventoRespuesta: Record "DsPOS Event Buffer" temporary)
    begin

        CASE p_Evento.TextoDato4 OF
            'CUPON':
                AplicaCupon(p_Evento, p_EventoRespuesta);
            'ELIMINARCUPON':
                EliminaCupon(p_Evento, p_EventoRespuesta);
        END;
    end;

    procedure Imprimir(codPrmTienda: Code[20]; codPrmDoc: Code[20]): Boolean
    var
        cfComunes: Codeunit 34002503;
        rSalesH: Record 36;
        rSalesInv: Record 112;
    begin
        EXIT(TRUE);
    end;

    procedure RelacionaAnulacion(var pSalesH: Record 36; CodTienda: Code[20])
    var
        rCab: Record 36;
        rHistCab: Record 112;
    begin
    end;

    procedure AnularFactura(var pSalesH: Record 36): Text
    var
        rConfTPV: Record 34002501;
        NoSeriesMgt: Codeunit "No. Series";
        NoSeriesLine: Record 309;
        Error004: Label 'La Serie NCF No contiene mas numeros';
        Error005: Label 'Nº de Autoriación no puede ser blanco para serie %1';
        cfComunes: Codeunit 34002503;
        rHistCab: Record 112;
        rCab: Record 36;
    begin

        rConfTPV.GET(pSalesH.Tienda, pSalesH.TPV);

        pSalesH."No. Fiscal TPV" := pSalesH."Posting No.";

        IF cfComunes.RegistroEnLinea(pSalesH.Tienda) THEN BEGIN
            rHistCab.GET(pSalesH."Anula a Documento");
            pSalesH."Cod. Cupon" := rHistCab."Cod. Cupon";
            RetrocedeCupon(pSalesH."Anula a Documento", TRUE, pSalesH."No.");
        END
        ELSE BEGIN
            rCab.SETCURRENTKEY("Posting No.");
            rCab.SETRANGE("Posting No.", pSalesH."Anula a Documento");
            rCab.FINDFIRST;
            pSalesH."Cod. Cupon" := rCab."Cod. Cupon";
            RetrocedeCupon(pSalesH."Anula a Documento", FALSE, pSalesH."No.");

            //+#217374
            DatosParaFE(pSalesH);
            //-#217374

        END;
    end;

    procedure ActualizaCupon(pSalesH: Record 36)
    var
        rLinCupon: Record 55171;
        CantidadPendiente: Integer;
        rSalesLines: Record 37;
    begin

        rSalesLines.RESET;
        rSalesLines.SETRANGE("Document Type", pSalesH."Document Type");
        rSalesLines.SETRANGE("Document No.", pSalesH."No.");
        rSalesLines.SETRANGE(Type, rSalesLines.Type::Item);
        IF rSalesLines.FINDSET THEN
            REPEAT
                IF rSalesLines."Cod. Cupon" <> '' THEN BEGIN
                    IF rLinCupon.GET(rSalesLines."Cod. Cupon", rSalesLines."No.") THEN BEGIN
                        rLinCupon."Cantidad Pendiente" -= rSalesLines.Quantity;
                        IF rLinCupon."Cantidad Pendiente" <= 0 THEN
                            rLinCupon."Cantidad Pendiente" := 0;
                        rLinCupon.MODIFY;
                    END;
                END;
            UNTIL rSalesLines.NEXT = 0;
    end;

    procedure Ventas_Registrar_Localizado(var GenGnjLine: Record 81; pSalesH: Record 36)
    begin

        WITH GenGnjLine DO BEGIN
        END;
    end;

    procedure Guardar_Datos_Aparcados(prmNumVenta: Code[20]; p_Evento: Record "DsPOS Event Buffer" temporary)
    var
        rPedidosAparcados: Record 34002535;
        TextoNet: array[10] of Text[250];
        i: Integer;
    begin

        // Almacenamos los datos recibidos
        i := 1;
        WHILE i <= p_Evento.GetTextoPaisCount() DO BEGIN
            TextoNet[i] := p_Evento.GetTextoPaisValue(i);
            i += 1;
        END;

        // Si ya existen datos aparcados los borramos
        IF rPedidosAparcados.GET(prmNumVenta) THEN
            rPedidosAparcados.DELETE;


        // Guardamos los datos en la tabla
        rPedidosAparcados.INIT;
        rPedidosAparcados."No." := prmNumVenta;
        rPedidosAparcados."Numero Cliente" := TextoNet[7];
        rPedidosAparcados."Numero Colegio" := TextoNet[8];
        rPedidosAparcados."Nombre Colegio" := TextoNet[9];
        rPedidosAparcados."Tipo Documento" := TextoNet[6];
        rPedidosAparcados.Identificacion := TextoNet[1];
        rPedidosAparcados.Nombre := TextoNet[3];
        rPedidosAparcados.Direccion := TextoNet[2];
        rPedidosAparcados."E-Mail" := TextoNet[5];
        rPedidosAparcados.Telefono := TextoNet[4];
        rPedidosAparcados.INSERT(FALSE);
    end;

    procedure EliminaCupon(var p_Evento: Record "DsPOS Event Buffer" temporary; var p_Evento_Respuesta: Record "DsPOS Event Buffer" temporary)
    var
        rSalesLines: Record 37;
        error001: Label 'El cupón %1 esta en estado de error : no impreso, anulado ó caducado';
        error002: Label 'El cupón %1 no existe';
        error003: Label 'El cupón %1 no tiene productos pendientes.';
        error004: Label 'El cupón %1 no se ha podido borrar.';
        text001: Label 'Cupón %1 aplicado correctamente';
        Numero_Cupon: Code[20];
        Numero_Documento: Code[20];
        text002: Label 'Cupón %1 eliminado correctamente';
    begin

        // Nº de cupon recibido y Nº de Documento
        Numero_Cupon := p_Evento.TextoDato6;
        Numero_Documento := p_Evento.TextoDato3;

        // Buscamos en la tabla 37 Sales Line
        rSalesLines.RESET;
        rSalesLines.SETRANGE("Document No.", Numero_Documento);
        rSalesLines.SETRANGE("Cod. Cupon", Numero_Cupon);
        rSalesLines.DELETEALL;

        // Devolvemos el mensaje y la acción para actualizar las lineas
        p_Evento_Respuesta.AccionRespuesta := 'Actualizar_Lineas';
        p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(text002, Numero_Cupon);
    end;

    procedure RetrocedeCupon(pDocOrigen: Code[20]; pOnLine: Boolean; pDocAnula: Code[20])
    var
        rLinFac: Record 113;
        rLin: Record 37;
        rLinCupon: Record 55171;
        rCab: Record 36;
        rLinOrigen: Record 37;
        rCabFac: Record 112;
        rLinOrigenFac: Record 113;
    begin

        IF pOnLine THEN BEGIN
            rLin.RESET;
            rLin.SETRANGE("Document Type", rLin."Document Type"::"Credit Memo");
            rLin.SETRANGE("Document No.", pDocAnula);
            IF rLin.FINDFIRST THEN BEGIN
                REPEAT
                    rLinOrigenFac.RESET;
                    rLinOrigenFac.SETRANGE("Document No.", pDocOrigen);
                    rLinOrigenFac.SETRANGE("No.", rLin."No.");
                    IF rLinOrigenFac.FINDFIRST THEN BEGIN
                        REPEAT
                            IF rLinOrigenFac."Cod. Cupon" <> '' THEN BEGIN
                                IF rLinCupon.GET(rLinOrigenFac."Cod. Cupon", rLin."No.") THEN BEGIN
                                    rLinCupon."Cantidad Pendiente" += rLin.Quantity;
                                    rLinCupon.MODIFY(FALSE);
                                END;
                            END;
                        UNTIL rLinOrigenFac.NEXT = 0;
                    END;
                UNTIL rLin.NEXT = 0;
            END;
        END
        ELSE BEGIN
            rLin.RESET;
            rLin.SETRANGE("Document Type", rLin."Document Type"::"Credit Memo");
            rLin.SETRANGE("Document No.", pDocAnula);
            IF rLin.FINDFIRST THEN BEGIN
                rCab.RESET;
                rCab.SETCURRENTKEY("Posting No.");
                rCab.SETRANGE("Posting No.", pDocOrigen);
                IF NOT rCab.FINDFIRST THEN
                    EXIT;
                REPEAT
                    rLinOrigen.RESET;
                    rLinOrigen.SETRANGE("Document Type", rLinOrigen."Document Type"::Invoice);
                    rLinOrigen.SETRANGE("Document No.", rCab."No.");
                    rLinOrigen.SETRANGE("No.", rLin."No.");
                    IF rLinOrigen.FINDFIRST THEN BEGIN
                        REPEAT
                            IF rLinOrigen."Cod. Cupon" <> '' THEN BEGIN
                                IF rLinCupon.GET(rLinOrigen."Cod. Cupon", rLin."No.") THEN BEGIN
                                    rLinCupon."Cantidad Pendiente" += rLin.Quantity;
                                    rLinCupon.MODIFY(FALSE);
                                END;
                            END;
                        UNTIL rLinOrigen.NEXT = 0;
                    END;
                UNTIL rLin.NEXT = 0;
            END;
        END;
    end;

    procedure AplicaCupon(var p_Evento: Record "DsPOS Event Buffer" temporary; var p_Evento_Respuesta: Record "DsPOS Event Buffer" temporary)
    var
        rCabCupon: Record 55170;
        rCabCupon2: Record 55170;
        rLinCupon: Record 55171;
        rSalesLine: Record 37;
        NoLinea: Integer;
        error001: Label 'El cupón %1 esta en estado de error : no impreso, anulado ó caducado';
        error002: Label 'El cupón %1 no existe';
        error003: Label 'El cupón %1 no tiene productos pendientes.';
        rSalesH: Record 36;
        error004: Label 'El cupón %1 ya esta aplicado en esta venta.';
        error005: Label 'Imposible Aplicar cupones para diferentes colegios en la misma venta.';
        text001: Label 'Cupón %1 aplicado correctamente';
        wCupon: Text;
        Cupon: Code[20];
    begin

        Cupon := p_Evento.TextoDato6;

        IF rCabCupon.GET(Cupon) THEN BEGIN

            IF (rCabCupon.Impreso) AND (WORKDATE >= rCabCupon."Valido Desde") AND (WORKDATE <= rCabCupon."Valido Hasta") AND
               (rCabCupon.Anulado = FALSE) THEN BEGIN

                rLinCupon.RESET;
                rLinCupon.SETRANGE("No. Cupon", Cupon);
                rLinCupon.SETFILTER("Cantidad Pendiente", '>%1', 0);

                IF rLinCupon.FINDSET THEN BEGIN

                    NoLinea := 0;

                    rSalesLine.RESET;
                    rSalesLine.SETRANGE("Document Type", rSalesLine."Document Type"::Invoice);
                    rSalesLine.SETRANGE("Document No.", p_Evento.TextoDato3);
                    IF rSalesLine.FINDSET THEN
                        REPEAT

                            NoLinea := rSalesLine."Line No.";

                            IF rSalesLine."Cod. Cupon" = Cupon THEN BEGIN
                                p_Evento_Respuesta.AccionRespuesta := 'ERROR';
                                p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(error004, Cupon);
                                EXIT;
                            END;

                            IF (rSalesLine."Cod. Cupon" <> '') AND
                               (rSalesLine."Cod. Cupon" <> rCabCupon."No. Cupon") THEN BEGIN
                                rCabCupon2.RESET;
                                rCabCupon2.GET(rSalesLine."Cod. Cupon");
                                IF rCabCupon."Cod. Colegio" <> rCabCupon2."Cod. Colegio" THEN BEGIN
                                    p_Evento_Respuesta.AccionRespuesta := 'ERROR';
                                    p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(error005, Cupon);
                                    EXIT;
                                END;
                            END;

                        UNTIL rSalesLine.NEXT = 0;

                    REPEAT
                        IF rLinCupon."Cantidad Pendiente" > 0 THEN BEGIN
                            NoLinea += 10000;

                            rSalesLine.RESET;
                            rSalesLine.INIT;
                            rSalesLine.VALIDATE("Document Type", rSalesLine."Document Type"::Invoice);
                            rSalesLine.VALIDATE("Document No.", p_Evento.TextoDato3);
                            rSalesLine.VALIDATE("Line No.", NoLinea);
                            rSalesLine.VALIDATE(Type, rSalesLine.Type::Item);
                            rSalesLine.VALIDATE("No.", rLinCupon."Cod. Producto");

                            IF rLinCupon.Cantidad > 0 THEN
                                rSalesLine.VALIDATE(Quantity, rLinCupon.Cantidad)
                            ELSE
                                rSalesLine.VALIDATE(Quantity, 1);

                            rSalesLine.VALIDATE("Line Discount %", rLinCupon."% Descuento");
                            rSalesLine."Cod. Cupon" := Cupon;
                            rSalesLine.INSERT(TRUE);
                        END;
                    UNTIL rLinCupon.NEXT = 0;

                    rSalesH.GET(rSalesLine."Document Type"::Invoice, p_Evento.TextoDato3);
                    WITH rSalesH DO BEGIN
                        "Cod. Cupon" := Cupon;
                        "Salesperson Code" := rCabCupon."Cod. Vendedor";
                        MODIFY(FALSE);
                    END;

                    p_Evento_Respuesta.AccionRespuesta := 'Actualizar_Lineas';
                    p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(text001, Cupon);

                END
                ELSE BEGIN
                    p_Evento_Respuesta.AccionRespuesta := 'ERROR';
                    p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(error003, Cupon);
                END;

            END
            ELSE BEGIN
                p_Evento_Respuesta.AccionRespuesta := 'ERROR';
                p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(error001, Cupon);
            END;

        END
        ELSE BEGIN
            p_Evento_Respuesta.AccionRespuesta := 'ERROR';
            p_Evento_Respuesta.TextoRespuesta := STRSUBSTNO(error002, Cupon);
        END;
    end;

    procedure Linea_LocalizadaOFF(var prOrigen: Record 37; var prDestino: Record 37)
    begin

        prDestino."Cod. Cupon" := prOrigen."Cod. Cupon";
    end;

    procedure AntesDeImprimir(pCodVenta: Code[20])
    var
        lcFE_CR: Codeunit 55202;
    begin
        //+#184407

        //Factura ELectronica
        //+#217374
        //... La firma electronica se realizará en Central.
        //lcFE_CR.TiqueteElectronica(pCodVenta);
        //-#217374
        //Factura ELectronica
    end;

    procedure FE(pSalesHeader: Record 36)
    var
        lcFE: Codeunit 55202;
        lrSIH: Record 112;
        lrSCMH: Record 114;
        lrLog: Record 55201;
        lOk: Boolean;
    begin
        //+#217374
        CASE pSalesHeader."Document Type" OF
            pSalesHeader."Document Type"::Invoice:
                BEGIN
                    IF lrSIH.GET(pSalesHeader."Last Posting No.") THEN BEGIN
                        IF lrSIH."Tipo Doc Electronico" = lrSIH."Tipo Doc Electronico"::Factura THEN BEGIN
                            lrSIH."Tipo Doc Electronico" := lrSIH."Tipo Doc Electronico"::Tiquete;
                            lrSIH.MODIFY;
                        END;

                        lOk := FALSE;
                        IF lrLog.GET(3, lrSIH."No.") THEN BEGIN
                            IF (lrLog.Estado = '') OR (lrLog.Estado = 'procesando') THEN BEGIN
                                lcFE.Parametros(TRUE, lrSIH.Tienda);
                                lcFE.ComprobarDocumentoElectronicoLOG(lrLog);
                                lOk := TRUE;
                            END;
                        END;
                        IF NOT lOk THEN
                            lcFE.TiqueteElectronico_vCentral(lrSIH."No.");
                    END;
                END;

            pSalesHeader."Document Type"::"Credit Memo":
                BEGIN
                    IF lrSCMH.GET(pSalesHeader."Last Posting No.") THEN
                        //... Estos datos puede ser que no se hayan grabado en la tienda. Lo hacemos ahora, antes de la firma.
                        IF lrSCMH."No. Doc Historico" = '' THEN BEGIN
                            lrSIH.GET(lrSCMH."Anula a Documento");
                            lrSCMH."No. Doc Historico" := lrSIH."No.";
                            lrSCMH."Numero Referencia FE" := lrSIH.Consecutivo;
                            //... Para la siguiente asignacion no comprobamos que la factura sea tiquete o factura. Debe ser siempre tiquete.
                            lrSCMH."Tipo Doc. Ref NC" := lrSCMH."Tipo Doc. Ref NC"::"Tiquete Electronico";
                            IF lrSCMH.Devolucion THEN
                                lrSCMH."Codigo Referencia" := lrSCMH."Codigo Referencia"::"Devolucion Parcial"
                            ELSE
                                lrSCMH."Codigo Referencia" := lrSCMH."Codigo Referencia"::"Devolucion Total";
                            lrSCMH.MODIFY;

                        END;
                    lOk := FALSE;
                    IF lrLog.GET(1, lrSCMH."No.") THEN BEGIN
                        IF (lrLog.Estado = '') OR (lrLog.Estado = 'procesando') THEN BEGIN
                            lcFE.Parametros(TRUE, lrSCMH.Tienda);
                            lcFE.ComprobarDocumentoElectronicoLOG(lrLog);
                            lOk := TRUE;
                        END;
                    END;
                    IF NOT lOk THEN
                        lcFE.TiqueteElectronicoNCR_vCentral(lrSCMH."No.");
                END;
        END;
    end;

    procedure FinalProcesoRegistro(pNumLog: Integer)
    begin
        //+#217374
        //... Los que hayan quedado pendientes de firma, se intentarán firmar.
        wNumLog := pNumLog;
        FirmarRegistrados;
    end;

    procedure Parametros_2(rp_CabVenta: Record 36; pNumLog: Integer; pEvitarMensajeFE: Boolean)
    begin
        //+#217374
        rGblCabVenta := rp_CabVenta;
        wNumLog := pNumLog;
        wModo := wModo::FE;
        wEvitarMensajeFE := pEvitarMensajeFE;
    end;

    procedure LogFirmaEnCentral(pSalesHeader: Record 36; pError: Text[1024])
    var
        lrSIH: Record 112;
        lrSCMH: Record 114;
        lEstado: Integer;
        lcLote: Codeunit 34002522;
        TextL001: Label 'Obtención certificado digital sin error para %1';
        TextL002: Label 'Error: %1';
        TextL003: Label 'No se configuió firmar %1';
        TextL004: Label 'Pendiente de comprobar la firma para %1';
    begin
        //+#217374
        //... Registramos el LOG de la firma.
        //...

        lcLote.Parametros(wNumLog);
        lEstado := -1;

        IF pError = '' THEN BEGIN
            lEstado := 0;
            CASE pSalesHeader."Document Type" OF
                pSalesHeader."Document Type"::Invoice:
                    IF lrSIH.GET(pSalesHeader."Last Posting No.") THEN BEGIN
                        IF UPPERCASE(lrSIH.Estado) = UPPERCASE(ID_ACEPTADO) THEN
                            lEstado := 1;

                        IF UPPERCASE(lrSIH.Estado) = '' THEN
                            lEstado := 2;
                    END;

                pSalesHeader."Document Type"::"Credit Memo":
                    IF lrSCMH.GET(pSalesHeader."Last Posting No.") THEN BEGIN
                        IF UPPERCASE(lrSCMH.Estado) = UPPERCASE(ID_ACEPTADO) THEN
                            lEstado := 1;

                        IF UPPERCASE(lrSCMH.Estado) = '' THEN
                            lEstado := 2;
                    END;

            END;
        END;

        CASE lEstado OF
            -1:
                lcLote.InsertarDetalle(pSalesHeader, 2, TRUE, STRSUBSTNO(TextL002, pError));
            0:
                lcLote.InsertarDetalle(pSalesHeader, 2, TRUE, STRSUBSTNO(TextL003, pSalesHeader."No. Fiscal TPV"));
            1:
                lcLote.InsertarDetalle(pSalesHeader, 2, FALSE, STRSUBSTNO(TextL001, pSalesHeader."No. Fiscal TPV"));
            2:
                lcLote.InsertarDetalle(pSalesHeader, 2, TRUE, STRSUBSTNO(TextL004, pSalesHeader."No. Fiscal TPV"));
        END;
    end;

    procedure FirmarRegistrados()
    var
        lrSIH: Record 112;
        lrSCMH: Record 114;
        lProcesados: Integer;
        lTotal: Integer;
        cduPOS: Codeunit 34002503;
        TextL001: Label '<Firmando documentos DsPOS :\\Facturas @@@@@@@@@@@@@@@@@@@@1\Notas de Credito  @@@@@@@@@@@@@@@@@@@@2>';
        rParametros: Record 34002522;
        lrSalesH: Record 36;
        lwProgreso: Dialog;
        lcCostaRica: Codeunit 34002511;
        lFechaReferencia: Date;
    begin
        //#217374

        lFechaReferencia := TODAY;

        SLEEP(3000);  //Intentar que de tiempo a comprobar.

        lrSIH.RESET;
        lrSIH.SETCURRENTKEY("Venta TPV", "Posting Date", Estado);
        lrSIH.SETRANGE("Venta TPV", TRUE);
        lrSIH.SETRANGE("Posting Date", lFechaReferencia - 31, lFechaReferencia);
        lrSIH.SETFILTER(Estado, '<>%1&<>%2', ID_ACEPTADO, ID_RECHAZADO);

        IF lrSIH.FINDFIRST THEN BEGIN

            lTotal := lrSIH.COUNT;
            lProcesados := 0;

            REPEAT

                CLEARLASTERROR;

                lrSalesH.INIT;
                lrSalesH."No." := lrSIH."External Document No.";
                lrSalesH."Document Type" := lrSalesH."Document Type"::Invoice;
                lrSalesH."No. Fiscal TPV" := lrSIH."No. Fiscal TPV";
                lrSalesH."Posting Date" := lrSIH."Posting Date";
                lrSalesH.Tienda := lrSIH.Tienda;
                lrSalesH.TPV := lrSIH.TPV;
                lrSalesH."Posting No." := lrSIH."No.";
                lrSalesH."Last Posting No." := lrSIH."No.";

                COMMIT;

                //... Para poder ejecutar el RUN, lo haremos sobre otra instancia de la CU.
                lcCostaRica.Parametros_2(lrSalesH, wNumLog, TRUE);
                IF lcCostaRica.RUN THEN
                    lcCostaRica.LogFirmaEnCentral(lrSalesH, '')
                ELSE
                    lcCostaRica.LogFirmaEnCentral(lrSalesH, COPYSTR(GETLASTERRORTEXT, 1, 1024));


            UNTIL lrSIH.NEXT = 0;

        END;

        SLEEP(3000);

        lrSCMH.RESET;
        lrSCMH.SETCURRENTKEY("Venta TPV", "Posting Date", Estado);
        lrSCMH.SETRANGE("Venta TPV", TRUE);
        lrSCMH.SETRANGE("Posting Date", lFechaReferencia - 31, lFechaReferencia);
        lrSCMH.SETFILTER(Estado, '<>%1&<>%2', ID_ACEPTADO, ID_RECHAZADO);

        IF lrSCMH.FINDFIRST THEN BEGIN

            lTotal := lrSCMH.COUNT;
            lProcesados := 0;

            REPEAT

                CLEARLASTERROR;

                lrSalesH.INIT;
                lrSalesH."No." := lrSCMH."External Document No.";
                lrSalesH."Document Type" := lrSalesH."Document Type"::"Credit Memo";
                lrSalesH."No. Fiscal TPV" := lrSCMH."No. Fiscal TPV";
                lrSalesH."Posting Date" := lrSCMH."Posting Date";
                lrSalesH.Tienda := lrSCMH.Tienda;
                lrSalesH.TPV := lrSCMH.TPV;
                lrSalesH."Posting No." := lrSCMH."No.";
                lrSalesH."Last Posting No." := lrSCMH."No.";

                COMMIT;

                //... Para poder ejecutar el RUN, lo haremos sobre otra instancia de la CU.
                lcCostaRica.Parametros_2(lrSalesH, wNumLog, TRUE);
                IF lcCostaRica.RUN THEN
                    lcCostaRica.LogFirmaEnCentral(lrSalesH, '')
                ELSE
                    lcCostaRica.LogFirmaEnCentral(lrSalesH, COPYSTR(GETLASTERRORTEXT, 1, 1024));


            UNTIL lrSCMH.NEXT = 0;

        END;

        IF GUIALLOWED THEN
            lwProgreso.CLOSE;

    end;

    procedure DatosParaFE(var lrSalesH: Record 36)
    var
        lClave: Text[60];
        lConsecutivo: Text[20];
        lTipo: Code[2];
        lcFE: Codeunit 55202;
        lrLog: Record 55201;
    begin
        //+#217374
        lTipo := '04';
        IF lrSalesH."Document Type" = lrSalesH."Document Type"::"Credit Memo" THEN
            lTipo := '03';
        lcFE.Parametros(TRUE, lrSalesH.Tienda);
        lClave := lcFE.GetClave(lrSalesH."Posting Date", lConsecutivo, lTipo);
        lrSalesH.Clave := lClave;
        lrSalesH.Consecutivo := lConsecutivo;

        lrLog.INIT;
        IF lTipo = '04' THEN
            lrLog."Tipo Documento" := lrLog."Tipo Documento"::TE
        ELSE
            lrLog."Tipo Documento" := lrLog."Tipo Documento"::NC;
        lrLog.NoDocumento := lrSalesH."Posting No.";
        lrLog."Clave Doc" := lClave;
        lrLog."Consecutivo Doc" := lConsecutivo;
        lrLog."Fecha Doc" := CURRENTDATETIME;
        lrLog.Estado := '';
        lrLog."Estado Interfaz" := lrLog."Estado Interfaz"::Pendiente;
        lrLog.INSERT(TRUE);
    end;

    procedure CambiarTipoDocumentoATiquete(pDocumento: Code[20])
    var
        lrSIH: Record 112;
    begin
        //+#308268
        IF lrSIH.GET(pDocumento) THEN BEGIN
            IF lrSIH."Tipo Doc Electronico" = lrSIH."Tipo Doc Electronico"::Factura THEN BEGIN
                lrSIH."Tipo Doc Electronico" := lrSIH."Tipo Doc Electronico"::Tiquete;
                lrSIH.MODIFY;
            END;
        END;
        //-#308268
    end;

}