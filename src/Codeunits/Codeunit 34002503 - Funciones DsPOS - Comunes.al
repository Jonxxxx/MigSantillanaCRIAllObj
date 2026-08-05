codeunit 55897 "Funciones DsPOS - Comunes"
{
    // MIGRACION BC27 SAAS V1: Costa Rica únicamente; Evento DotNet sustituido por buffer temporal AL.
    Permissions = TableData 112 = rimd,
                  TableData 114 = rimd,
                  TableData 55902 = rimd;
    TableNo = 55916;

    trigger OnRun()
    var
        optTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin
        CASE Rec.Accion OF
            //+#65232
            //Accion::LiquidarFactura     : LiquidaFacturaTPV(Documento);
            //Accion::LiquidarNotaCredito : LiquidaNotaCreditoTPV(Documento);
            Rec.Accion::LiquidarFactura:
                LiquidaDocumentoTPV(Rec.Documento, optTipoDoc::Invoice);
            Rec.Accion::LiquidarNotaCredito:
                LiquidaDocumentoTPV(Rec.Documento, optTipoDoc::"Credit Memo");
        //-#65232
        END;
    end;

    var
        cCostaRica: Codeunit 55905;
        Text010: Label 'No se pudo realizar el envio electrónico del documento %1';
        wCupon4Log: Code[20];

    procedure InsertarDimTemp(DimCode: Code[20]; DimValue: Code[20]; var P_recTmpDimEntry: Record 480 temporary)
    var
        recDimVal: Record 349;
        cDimManag: Codeunit 408;
    begin

        recDimVal.GET(DimCode, DimValue);
        P_recTmpDimEntry."Dimension Code" := DimCode;
        P_recTmpDimEntry."Dimension Value Code" := DimValue;
        P_recTmpDimEntry."Dimension Value ID" := recDimVal."Dimension Value ID";
        IF P_recTmpDimEntry.INSERT THEN;
    end;

    procedure Nueva_Venta(p_Tienda: Code[20]; p_IdTPV: Code[20]; p_Cajero: Code[20]; p_Devolucion: Boolean): Text
    var
        rSalesHeader: Record 36;
        rCajeros: Record 55899;
        rGrupoCajeros: Record 55901;
        rDimDefAlmacen: Record 55913;
        rAlmacen: Record 14;
        rTienda: Record 55897;
        rTPV: Record 55895;
        NoSeriesMgt: Codeunit Microsoft.Foundation.NoSeries."No. Series";
        recTmpDimEntry: Record 480 temporary;
        cDimManag: Codeunit 408;
        Error001: Label 'No se ha podido crear el pedido de venta';
        Text001: Label ' Nº Venta %1';
        cControl: Codeunit 55915;
        recControlTPV: Record 55918;
        rDimEntry: Record 480;
        Evento: Record "DsPOS Event Buffer" temporary;
        lNumLog: Integer;
        TextL002: Label 'Esta clave ya ha sido utilizada anteriormente. Hay que revisar la configuración de las series';
        lTextoError: Text[150];
        lNotificacion: Text[160];
    begin
        //+#90735
        ControlDeAcceso(p_Tienda, TRUE);
        rSalesHeader.LOCKTABLE;
        //-#90735

        //+88460
        lNumLog := IniciarLog(1, p_Tienda, p_IdTPV);
        //-88460

        rTienda.GET(p_Tienda);
        rTPV.GET(p_Tienda, p_IdTPV);
        rCajeros.GET(p_Tienda, p_Cajero);
        rGrupoCajeros.GET(p_Tienda, rCajeros."Grupo Cajero");

        rSalesHeader.INIT;
        IF p_Devolucion THEN BEGIN
            rSalesHeader.VALIDATE("Document Type", rSalesHeader."Document Type"::"Credit Memo");
            rSalesHeader."No." := NoSeriesMgt.GetNextNo(rTPV."No. serie notas credito", WORKDATE, TRUE);
            rSalesHeader.Devolucion := TRUE;
        END
        ELSE BEGIN
            rSalesHeader.VALIDATE("Document Type", rSalesHeader."Document Type"::Invoice);
            rSalesHeader."No." := NoSeriesMgt.GetNextNo(rTPV."No. serie Facturas", WORKDATE, TRUE);
        END;

        rSalesHeader.VALIDATE("Sell-to Customer No.", rGrupoCajeros."Cliente al contado");

        rSalesHeader.VALIDATE("Order Date", cControl.DiaAbierto(p_Tienda, p_IdTPV));
        rSalesHeader.VALIDATE("Posting Date", rSalesHeader."Order Date");
        rSalesHeader.VALIDATE("Document Date", rSalesHeader."Order Date");
        rSalesHeader.VALIDATE("Hora creacion", FormatTime(TIME));

        // Si es registro en linea añadimos las dimensiones del alamcen
        // en caso de ser negativo se recrearan en central en el proceso de registro nocturno
        IF rTienda.GET(rCajeros.Tienda) THEN
            IF rTienda."Registro En Linea" THEN BEGIN
                IF rAlmacen.GET(rTienda."Cod. Almacen") THEN BEGIN
                    CLEAR(recTmpDimEntry);
                    rDimDefAlmacen.RESET;
                    rDimDefAlmacen.SETRANGE("Cod. Almacen", rAlmacen.Code);
                    IF rDimDefAlmacen.FINDSET THEN BEGIN
                        REPEAT
                            InsertarDimTemp(rDimDefAlmacen."Codigo Dimension", rDimDefAlmacen."Valor Dimension", recTmpDimEntry);
                        UNTIL rDimDefAlmacen.NEXT = 0;

                        // En caso de que la cabecera ya tuviera dimensiones se las añadimos
                        IF rSalesHeader."Dimension Set ID" <> 0 THEN BEGIN
                            rDimEntry.RESET;
                            rDimEntry.SETRANGE("Dimension Set ID", rSalesHeader."Dimension Set ID");
                            IF rDimEntry.FINDSET THEN
                                REPEAT
                                    InsertarDimTemp(rDimEntry."Dimension Code", rDimEntry."Dimension Value Code", recTmpDimEntry);
                                UNTIL rDimEntry.NEXT = 0;
                        END;
                        rSalesHeader."Dimension Set ID" := cDimManag.GetDimensionSetID(recTmpDimEntry);
                    END;
                END;
            END;

        rSalesHeader."Venta TPV" := TRUE;
        rSalesHeader."ID Cajero" := p_Cajero;
        rSalesHeader.TPV := p_IdTPV;
        rSalesHeader."External Document No." := rSalesHeader."No.";
        rSalesHeader.Tienda := p_Tienda;
        rSalesHeader.Turno := cControl.TraerTurnoActual(p_Tienda, p_IdTPV, WORKDATE);
        rSalesHeader.VALIDATE("Location Code", rTienda."Cod. Almacen");
        rSalesHeader.VALIDATE("Currency Code", '');

        Evento.TipoEvento := 6;
        Evento.TextoDato7 := cCostaRica.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);   // Costa Rica

        IF rSalesHeader.INSERT(FALSE) THEN BEGIN
            Evento.TextoDato := rSalesHeader."No.";
            Evento.TextoDato2 := STRSUBSTNO('%1', rSalesHeader."Posting Date");
            Evento.TextoDato3 := rSalesHeader."Sell-to Customer Name";
            Evento.TextoDato4 := rSalesHeader."VAT Registration No.";
            Evento.TextoDato5 := rSalesHeader."Sell-to Customer No.";
            Evento.TextoDato8 := rSalesHeader."Cod. Colegio";
            Evento.TextoDato9 := rSalesHeader."Nombre Colegio";
            Evento.TextoRespuesta := STRSUBSTNO(Text001, rSalesHeader."No.");

            //+#76946
            //... Este mensaje se dará en el caso que en el registro del documento anterior, haya habido error en el envío electrónico.
            rTPV.GET(p_Tienda, p_IdTPV);
            IF rTPV."Texto aviso FE" <> '' THEN BEGIN
                Evento.TextoRespuesta := Evento.TextoRespuesta + '. ' + rTPV."Texto aviso FE";
                GrabarTextoAvisoFE(p_Tienda, p_IdTPV, '');
            END;
            //-#76946

            Evento.AccionRespuesta := 'Actualizar_Todo';
            IF NOT p_Devolucion THEN
                Actualizar_Totales(Evento.TextoDato, Evento, TRUE, p_Devolucion);
        END
        ELSE BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := Error001;
        END;

        //+#12123
        lTextoError := COPYSTR(Evento.TextoRespuesta, 1, 150);  //+#232158
        IF TestIDYaUtilizado(rSalesHeader, TRUE, lNotificacion) THEN BEGIN
            IF lTextoError <> '' THEN
                lTextoError := lTextoError + '. ';

            lTextoError := COPYSTR(lTextoError + lNotificacion, 1, 150);
        END;
        //-#12123


        //+88460
        ModificarDatosLog(lNumLog, 2, rSalesHeader."Document Type", rSalesHeader."No.", rSalesHeader."Posting No.", rSalesHeader."No. Fiscal TPV", rSalesHeader."No. Comprobante Fiscal",
        //+#12123
        //                Evento.TextoRespuesta);
                          lTextoError);
        //-#12123
        //-88460



        //+90735
        ControlDeAcceso(p_Tienda, FALSE);
        //-90735

        IF NOT p_Devolucion THEN
            EXIT(Evento.aXml())
        ELSE
            EXIT(rSalesHeader."No.");
    end;

    procedure Buscar_Producto(var p_Producto: Code[20]; var p_Medida: Code[10])
    var
        rItemCrossRef: Record "Item Reference";
        rItem: Record 27;
        rItemIdentifier: Record 7704;
    begin

        // 1 - Cod. Barras (ref Cruzadas)
        // 2 - Identificadores
        // 3 - Codigo producto

        rItemCrossRef.RESET;
        rItemCrossRef.SETCURRENTKEY("Reference No.");
        rItemCrossRef.SETRANGE("Reference No.", p_Producto);
        rItemCrossRef.SETRANGE("Reference Type", rItemCrossRef."Reference Type"::"Bar Code");

        IF rItemCrossRef.FINDFIRST THEN BEGIN
            p_Producto := rItemCrossRef."Item No.";
            p_Medida := rItemCrossRef."Unit of Measure";
        END
        ELSE
            IF rItemIdentifier.GET(p_Producto) THEN BEGIN
                p_Producto := rItemIdentifier."Item No.";
                IF (rItemIdentifier."Unit of Measure Code" = '') THEN BEGIN
                    IF rItem.GET(p_Producto) THEN
                        p_Medida := rItem."Base Unit of Measure"
                    ELSE
                        p_Medida := rItemIdentifier."Unit of Measure Code"
                END
                ELSE
                    p_Medida := rItemIdentifier."Unit of Measure Code";
            END
            ELSE
                IF rItem.GET(p_Producto) THEN
                    p_Medida := rItem."Base Unit of Measure"
                ELSE BEGIN
                    rItem.SETCURRENTKEY(ISBN);
                    rItem.SETRANGE(ISBN, p_Producto);
                    IF rItem.FINDFIRST THEN
                        p_Producto := rItem."No."
                    ELSE
                        p_Producto := '';
                END;
    end;

    procedure Insertar_Producto(p_Producto: Code[20]; p_Tienda: Code[20]; p_IdTPV: Code[20]; p_NumVenta: Code[20]; p_Cantidad: Decimal): Text
    var
        rSalesLine: Record 37;
        rSalesHeader: Record 36;
        rConfTPV: Record 55895;
        CodProd: Code[20];
        uMedida: Code[10];
        NuevaLinea: Boolean;
        Evento: Record "DsPOS Event Buffer" temporary;
        Error001: Label 'Imposible Modificar Línea de Pedido';
        Error002: Label 'El Producto %1 No Tiene Precio Configurado';
        Error003: Label 'Imposible Insertar Línea de Pedido';
        Error004: Label 'El Producto %1 no existe';
        rTienda: Record 55897;
        Error005: Label 'El n·mero Maximo de líneas (%1) para este pedido se ha superado';
        Error006: Label 'Se ha producido un error inesperado. Se está intentando modificar una factura ya emitida por el TPV (%1). Por favor, pulse el botón de "Nueva venta".';
        Text001: Label 'Añadido/s %1 unidad/es del producto %2';
        dto: Decimal;
        rSalesH: Record 36;
    begin
        //+#65232
        // No podemos permitir que se están creando/modificando líneas de una factura ya registrada en TPV
        rSalesHeader.GET(rSalesHeader."Document Type"::Invoice, p_NumVenta);
        IF rSalesHeader."Posting No." <> '' THEN BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Error006, p_NumVenta);
            EXIT(Evento.aXml());
        END;
        //-#65232

        rConfTPV.GET(p_Tienda, p_IdTPV);
        rTienda.GET(p_Tienda);
        CodProd := p_Producto;

        Buscar_Producto(CodProd, uMedida);

        Evento.TipoEvento := 7;
        IF (CodProd = '') THEN BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Error004, p_Producto);
            EXIT(Evento.aXml());
        END;

        IF (rTienda."Agrupar Lineas") THEN BEGIN
            rSalesLine.RESET;
            rSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            rSalesLine.SETRANGE("Document Type", rSalesLine."Document Type"::Invoice);
            rSalesLine.SETRANGE("Document No.", p_NumVenta);
            rSalesLine.SETRANGE("No.", CodProd);
            rSalesLine.SETRANGE("Unit of Measure Code", uMedida);
            rSalesLine.SETRANGE("Anulada en TPV", FALSE);
            IF rSalesLine.FINDFIRST THEN BEGIN
                rSalesLine.VALIDATE(Quantity, rSalesLine.Quantity + p_Cantidad);
                IF NOT (rSalesLine.MODIFY(FALSE)) THEN BEGIN
                    Evento.AccionRespuesta := 'ERROR';
                    Evento.TextoRespuesta := Error001;
                END;
            END
            ELSE
                NuevaLinea := TRUE;
        END;

        IF ((NOT rTienda."Agrupar Lineas") OR NuevaLinea) THEN BEGIN

            IF rTienda."No. Maximo de Lineas" > 0 THEN BEGIN
                rSalesLine.RESET;
                rSalesLine.SETRANGE("Document Type", rSalesLine."Document Type"::Invoice);
                rSalesLine.SETRANGE("Document No.", p_NumVenta);

                IF rSalesLine.COUNT >= rTienda."No. Maximo de Lineas" THEN BEGIN
                    Evento.AccionRespuesta := 'ERROR';
                    Evento.TextoRespuesta := STRSUBSTNO(Error005, rTienda."No. Maximo de Lineas");
                    EXIT(Evento.aXml());
                END;
            END;

            rSalesLine.INIT;
            rSalesLine.VALIDATE("Document Type", rSalesLine."Document Type"::Invoice);
            rSalesLine.VALIDATE("Document No.", p_NumVenta);
            rSalesLine.VALIDATE("Line No.", SigNoLinea(p_NumVenta));
            rSalesLine.VALIDATE(Type, rSalesLine.Type::Item);
            rSalesLine.VALIDATE("No.", CodProd);
            rSalesLine.VALIDATE("Unit of Measure Code", uMedida);
            rSalesLine.VALIDATE(Quantity, p_Cantidad);

            rSalesH.GET(rSalesLine."Document Type", rSalesLine."Document No.");
            rSalesLine.VALIDATE("Location Code", rSalesH."Location Code");

            IF NOT rSalesLine.INSERT(FALSE) THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                Evento.TextoRespuesta := Error003;
            END;

        END;

        IF Evento.AccionRespuesta <> 'ERROR' THEN BEGIN
            Evento.TextoDato2 := CodProd;
            Evento.TextoRespuesta := STRSUBSTNO(Text001, p_Cantidad, p_Producto);
            Evento.AccionRespuesta := 'Actualizar_Lineas';
            Actualizar_Totales(p_NumVenta, Evento, FALSE, FALSE);
        END;

        EXIT(Evento.aXml());
    end;

    procedure Ejecutar_Accion(p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rAccion: Record 55906;
        rLinPed: Record 37;
        Error: Boolean;
        Mensaje: array[2] of Text;
        Text001: Label 'Linea eliminada Correctamente';
        Text002: Label 'Cantidad modificada Correctamente';
        Text003: Label 'Descuento en Linea Aplicado Correctamente';
        Text004: Label 'Precio Modificado Correctamente';
        Text005: Label 'Descuento General Aplicado Correctamente';
        Text006: Label 'Venta Correctamente Archivada';
        Text007: Label 'Exención de IVA añadido correctamente';
        Error001: Label 'No ha sido posible borrar la linea Seleccionada';
        Error002: Label 'Imposible Modificar Línea de Pedido';
        Error003: Label 'No se encuentra la línea de Pedido';
        Error004: Label 'No se encuentra el pedido';
        rCabFac: Record 36;
        Error005: Label 'No se encuentra la venta a archivar';
        i: Integer;
        Text008: Label 'Especifique cuenta de Exención de IVA para la Tienda %1';
        rTienda: Record 55897;
        lcFunciones: Codeunit 55896;
        lNotificar: Boolean;
        TextL001: Label 'Intentelo en unos segundos';
        lSeguir: Boolean;
        lrCV: Record 36;
        Error006: Label 'Esta línea de pedido corresponde a un pedido registrado y no deberá visualizarse. Por favor, salga de la pantalla de ventas y vuelva a entrar.';
    begin

        Evento.TipoEvento := p_Evento.TipoEvento;

        IF rAccion.GET(p_Evento.TextoDato4) THEN BEGIN
            CASE p_Evento.TextoDato4 OF

                'EXIVA':
                    BEGIN

                        rTienda.GET(p_Evento.TextoDato);

                        IF rTienda."Cuenta Excencion IVA" = '' THEN BEGIN
                            Error := TRUE;
                            Evento.AccionRespuesta := 'ERROR';
                            Mensaje[1] := STRSUBSTNO(Text008, p_Evento.TextoDato);
                        END
                        ELSE BEGIN
                            Insertar_Pago(p_Evento);
                            Mensaje[1] := Text007;
                            Mensaje[2] := 'Actualizar_Pagos';
                        END;

                    END;

                'ANULARLINEA':
                    BEGIN
                        FOR i := 1 TO p_Evento.IntDato1 DO BEGIN
                            rLinPed.RESET;
                            IF NOT (rLinPed.GET(rLinPed."Document Type"::Invoice, p_Evento.TextoDato3, SELECTSTR(i, p_Evento.TextoDato6))) THEN BEGIN
                                Error := TRUE;
                                Mensaje[1] := Error003;
                            END
                            ELSE BEGIN

                                //+#148711
                                //... Si el pedido ya esta registrado, se está visualizando por error.
                                //... Por ello, se indicará que la linea no se puede eliminar, y que hay que salir de la pantalla.
                                lSeguir := TRUE;
                                IF lrCV.GET(rLinPed."Document Type", rLinPed."Document No.") THEN BEGIN
                                    IF lrCV."Registrado TPV" THEN BEGIN
                                        Error := TRUE;
                                        Mensaje[1] := Error006;
                                        lSeguir := FALSE;
                                    END;
                                END;

                                //-#148711
                                IF lSeguir THEN BEGIN //#+148711

                                    IF NOT rLinPed.DELETE(TRUE) THEN BEGIN
                                        Error := TRUE;
                                        Mensaje[1] := Error001;
                                    END
                                    ELSE BEGIN
                                        Mensaje[1] := Text001;
                                        Mensaje[2] := 'Actualizar_Lineas';
                                    END;
                                END; //-#148711
                            END;
                        END;
                    END;


                'CAMBCANT':
                    BEGIN
                        FOR i := 1 TO p_Evento.IntDato1 DO BEGIN
                            IF NOT (rLinPed.GET(rLinPed."Document Type"::Invoice, p_Evento.TextoDato3, SELECTSTR(i, p_Evento.TextoDato6))) THEN BEGIN
                                Error := TRUE;
                                Mensaje[1] := Error003;
                            END
                            ELSE BEGIN
                                rLinPed.VALIDATE(Quantity, p_Evento.DatoDecimal);
                                IF NOT rLinPed.MODIFY(FALSE) THEN BEGIN
                                    Error := TRUE;
                                    Mensaje[1] := Error002;
                                END
                                ELSE BEGIN
                                    Mensaje[1] := Text002;
                                    Mensaje[2] := 'Actualizar_Lineas';
                                END;
                            END;
                        END;
                    END;

                'DTOLINEA':
                    BEGIN
                        FOR i := 1 TO p_Evento.IntDato1 DO BEGIN
                            rLinPed.RESET;
                            IF NOT (rLinPed.GET(rLinPed."Document Type"::Invoice, p_Evento.TextoDato3, SELECTSTR(i, p_Evento.TextoDato6))) THEN BEGIN
                                Error := TRUE;
                                Mensaje[1] := Error003;
                            END
                            ELSE BEGIN
                                rLinPed.VALIDATE("Line Discount %", p_Evento.DatoDecimal);
                                IF NOT rLinPed.MODIFY(FALSE) THEN BEGIN
                                    Error := TRUE;
                                    Mensaje[1] := Error002;
                                END
                                ELSE BEGIN
                                    Mensaje[1] := Text003;
                                    Mensaje[2] := 'Actualizar_Lineas';
                                END;
                            END;
                        END;
                    END;

                'CAMBPREC':
                    BEGIN
                        FOR i := 1 TO p_Evento.IntDato1 DO BEGIN
                            rLinPed.RESET;
                            IF NOT (rLinPed.GET(rLinPed."Document Type"::Invoice, p_Evento.TextoDato3, SELECTSTR(i, p_Evento.TextoDato6))) THEN BEGIN
                                Error := TRUE;
                                Mensaje[1] := Error003;
                            END
                            ELSE BEGIN
                                rLinPed.VALIDATE("Unit Price", p_Evento.DatoDecimal);
                                IF NOT rLinPed.MODIFY(FALSE) THEN BEGIN
                                    Error := TRUE;
                                    Mensaje[1] := Error002;
                                END
                                ELSE BEGIN
                                    Mensaje[1] := Text004;
                                    Mensaje[2] := 'Actualizar_Lineas';
                                END;
                            END;
                        END;
                    END;

                'REGISTRAR':
                    BEGIN
                        //+#121213
                        //... De momento el seguimiento se realiza sólo en el caso en que el registro se realice en una BD que no sea Central.
                        //... Cuando el registro es en linea se realizan COMMITs que quita el sentido a esta prevención.
                        //  Error := NOT((Registrar(p_Evento,Evento)));

                        lNotificar := TRUE;
                        IF RegistroEnLinea(p_Evento.TextoDato) THEN BEGIN
                            Error := NOT ((Registrar(p_Evento, Evento)));
                        END
                        ELSE BEGIN
                            COMMIT; //+#232158

                            CLEARLASTERROR;
                            lcFunciones.SetParameters(p_Evento, Evento);
                            IF NOT lcFunciones.RUN THEN BEGIN
                                //... Debemos llegar aquí en caso de error.
                                lNotificar := FALSE;
                                IF GETLASTERRORTEXT <> '' THEN BEGIN
                                    RegistrarError(0, p_Evento.TextoDato, p_Evento.TextoDato2, p_Evento.TextoDato3, GETLASTERRORTEXT);
                                    //+#232158
                                    MESSAGE(GETLASTERRORTEXT);
                                    //MESSAGE(GETLASTERRORTEXT+'. '+TextL001);
                                    //-#232158

                                END;
                            END
                            ELSE BEGIN
                                lcFunciones.GetParameters(p_Evento, Evento, Error);
                                Error := NOT Error;
                            END;

                        END;
                        //-#121213

                        IF lNotificar THEN BEGIN //+#121213
                            Mensaje[1] := Evento.TextoRespuesta;
                            Mensaje[2] := Evento.AccionRespuesta;

                            IF NOT Error THEN BEGIN
                                AntesDeImprimir(Evento.TextoDato4);  //+#184407
                                Imprimir(p_Evento.TextoDato, Evento.TextoDato4);
                            END;
                        END;  //+#121213

                    END;

                'CUPON':
                    BEGIN

                        cCostaRica.Ejecutar_Accion(p_Evento, Evento);

                        Error := (Evento.TextoRespuesta = 'ERROR');
                        Mensaje[1] := Evento.TextoRespuesta;
                        Mensaje[2] := Evento.AccionRespuesta;

                    END;


                'ELIMINARCUPON':
                    BEGIN

                        cCostaRica.Ejecutar_Accion(p_Evento, Evento);

                        Error := (Evento.TextoRespuesta = 'ERROR');
                        Mensaje[1] := Evento.TextoRespuesta;
                        Mensaje[2] := Evento.AccionRespuesta;

                    END;


                'DTOGENERAL':
                    BEGIN
                        rLinPed.RESET;
                        rLinPed.SETRANGE("Document Type", rLinPed."Document Type"::Invoice);
                        rLinPed.SETRANGE("Document No.", p_Evento.TextoDato3);
                        IF NOT (rLinPed.FINDFIRST) THEN BEGIN
                            Error := TRUE;
                            Mensaje[1] := Error003;
                        END
                        ELSE BEGIN
                            REPEAT
                                rLinPed.VALIDATE("Line Discount %", p_Evento.DatoDecimal);
                                IF NOT rLinPed.MODIFY(FALSE) THEN BEGIN
                                    Error := TRUE;
                                    Mensaje[1] := Error002;
                                END
                            UNTIL rLinPed.NEXT = 0;
                            Mensaje[1] := Text005;
                            Mensaje[2] := 'Actualizar_Todo';
                        END;
                    END;

                'APARCARPEDIDO':
                    BEGIN

                        rCabFac.RESET;

                        IF rCabFac.GET(rCabFac."Document Type"::Invoice, p_Evento.TextoDato3) THEN BEGIN

                            rCabFac.Aparcado := TRUE;
                            rCabFac.MODIFY(FALSE);

                            cCostaRica.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);

                            Mensaje[1] := Text006;
                            Mensaje[2] := 'Nueva_Venta';

                        END
                        ELSE BEGIN

                            Error := TRUE;
                            Mensaje[1] := Error005;

                        END;
                    END;

            END;

            Evento.TextoRespuesta := Mensaje[1];
            IF Error THEN
                Evento.AccionRespuesta := 'ERROR'
            ELSE BEGIN
                Evento.AccionRespuesta := Mensaje[2];
                Actualizar_Totales(p_Evento.TextoDato3, Evento, FALSE, FALSE);
            END;
        END;

        EXIT(Evento.aXml());
    end;

    procedure Insertar_Pago(var p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rPagos: Record 55915;
        rfPago: Record 55907;
        Text001: Label 'Linea de Pago insertada Correctamente';
        rTarj: Record 55909;
        Text002: Label 'No existe %1 ni como forma de pago ni como tipo de tarjeta';
        EsDevolucion: Boolean;
        rCab: Record 36;
        decImportes: array[10] of Decimal;
        exacto: Boolean;
        Documento: Code[20];
        lPais: Integer;
        lDocNCRPago: Code[20];
        lrFP: Record 55907;
    begin

        Evento.TipoEvento := p_Evento.TipoEvento;
        Documento := p_Evento.TextoDato3;

        //+#70132
        //... En los parametros debemos poder obtener el NCR de pago. He visto que TextoData7 estaba libre.
        lDocNCRPago := '';
        IF lrFP.GET(p_Evento.TextoDato4) THEN
            IF lrFP."Tipo Compensacion NC" = lrFP."Tipo Compensacion NC"::Si THEN
                IF p_Evento.TextoDato8 <> '' THEN
                    lDocNCRPago := p_Evento.TextoDato7;
        lPais := Pais;
        //-#70132

        EsDevolucion := rCab.GET(rCab."Document Type"::"Credit Memo", Documento);
        //+#65232
        IF NOT EsDevolucion THEN
            rCab.GET(rCab."Document Type"::Invoice, Documento);
        //-#65232

        CASE p_Evento.TextoDato6 OF
            'DSPOS_EXACTO':
                BEGIN
                    exacto := TRUE;
                    rPagos.RESET;
                    rPagos.SETRANGE("No. Borrador", p_Evento.TextoDato3);
                    rPagos.SETFILTER(rPagos."Forma pago TPV", '<>EXIVA');
                    IF rPagos.FINDSET THEN
                        rPagos.DELETEALL;
                    //+#65232
                    //IF NOT(EsDevolucion) THEN
                    //  rCab.GET(rCab."Document Type"::Invoice, p_Evento.TextoDato3);
                    //-#65232
                    ActValoresTPV(rCab, decImportes[1], decImportes[2], decImportes[3], decImportes[4], decImportes[5], decImportes[6], decImportes[7]);
                    p_Evento.TextoDato4 := Efectivo_Local;
                END;
            'DSPOS_EFECTIVO':
                p_Evento.TextoDato4 := Efectivo_Local;
        END;

        rTarj.INIT;
        IF NOT rfPago.GET(p_Evento.TextoDato4) THEN
            IF NOT rTarj.GET(p_Evento.TextoDato4) THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                Evento.TextoRespuesta := STRSUBSTNO(Text002, p_Evento.TextoDato4);
            END;

        WITH rPagos DO BEGIN

            // Obtener datos de Sales Header
            //rCab.GET(rCab."Document Type"::Invoice, p_Evento.TextoDato3); //-#65232
            rCab.CALCFIELDS(Amount);
            rCab.CALCFIELDS("Amount Including VAT");

            RESET;
            IF NOT GET(p_Evento.TextoDato3, p_Evento.TextoDato4, FALSE) THEN BEGIN

                // Modificar registro
                "Tipo Tarjeta" := rTarj.Codigo;
                VALIDATE("Forma pago TPV", p_Evento.TextoDato4);
                Fecha := WORKDATE;
                "No. Borrador" := p_Evento.TextoDato3;
                Tienda := p_Evento.TextoDato;
                TPV := p_Evento.TextoDato2;

                IF p_Evento.TextoDato4 = 'EXIVA' THEN BEGIN
                    VALIDATE(Importe, (rCab."Amount Including VAT" - rCab.Amount));
                    "No. Documento Exencion" := p_Evento.TextoDato6;
                END
                ELSE IF exacto THEN
                    VALIDATE(Importe, decImportes[5])
                ELSE
                    VALIDATE(Importe, p_Evento.DatoDecimal);

                IF Evento.AccionRespuesta <> 'ERROR' THEN BEGIN
                    Cajero := p_Evento.TextoDato5;
                    Hora := FormatTime(TIME);
                    Cambio := FALSE;

                    //+#70132
                    CASE lPais OF
                    //Dominicana
                    END;
                    //-#70132

                    INSERT;
                END;

            END
            ELSE BEGIN

                IF p_Evento.TextoDato4 = 'EXIVA' THEN BEGIN
                    VALIDATE(Importe, (rCab."Amount Including VAT" - rCab.Amount));
                    "No. Documento Exencion" := p_Evento.TextoDato6;
                END
                ELSE
                    VALIDATE(Importe, p_Evento.DatoDecimal);

                Hora := FormatTime(TIME);

                //+#70132
                CASE lPais OF
                //Dominicana
                END;
                //-#70132

                MODIFY;

            END;
        END;


        IF Evento.AccionRespuesta <> 'ERROR' THEN BEGIN
            Evento.AccionRespuesta := 'Actualizar_Pagos';
            Evento.TextoRespuesta := Text001;
            Actualizar_Totales(p_Evento.TextoDato3, Evento, FALSE, EsDevolucion);
        END;

        EXIT(Evento.aXml());
    end;

    procedure Eliminar_Pago(var p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rPagosTPV: Record 55915;
        Text001: Label 'Pago %1 Eliminado Correctamente';
        Text002: Label 'Pago %1 NO Encontrado';
        EsDevolucion: Boolean;
        rCab: Record 36;
    begin

        Evento.TipoEvento := p_Evento.TipoEvento;

        EsDevolucion := rCab.GET(rCab."Document Type"::"Credit Memo", p_Evento.TextoDato3);

        rPagosTPV.RESET;
        IF rPagosTPV.GET(p_Evento.TextoDato3, p_Evento.TextoDato4, FALSE) THEN BEGIN
            rPagosTPV.DELETE(FALSE);
            Evento.AccionRespuesta := 'Actualizar_Pagos';
            Evento.TextoRespuesta := STRSUBSTNO(Text001, p_Evento.TextoDato4);
            Actualizar_Totales(p_Evento.TextoDato3, Evento, FALSE, EsDevolucion);
        END
        ELSE BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Text002, p_Evento.TextoDato4);
        END;

        EXIT(Evento.aXml());
    end;

    procedure Registrar(var p_Evento: Record "DsPOS Event Buffer" temporary; var p_Resultado: Record "DsPOS Event Buffer" temporary): Boolean
    var
        recTienda: Record 55897;
        rCab: Record 55894;
        rSalesH: Record 36;
        rCust: Record 18;
        recLinVta: Record 37;
        wApagar: Decimal;
        Error001: Label 'Fecha de registro debe ser igual a la fecha del día';
        Error002: Label 'Debe Especificar Nº de Identificación Fiscal';
        Error003: Label 'ORDER WITH REMAINING AMOUNT';
        Error004: Label 'ORDER WITH REMAINING AMOUNT';
        Error005: Label 'ORDER WITH REMAINING AMOUNT';
        Error006: Label 'Imposible Modificar Registro';
        Error007: Label 'La línea de Venta %1 no tiene asignado precio.';
        Text001: Label 'Factura %1 Registrada Correctamente';
        cComunes: Codeunit 55897;
        recParam: Record 55916;
        texto: Text;
        recTPV: Record 55895;
        rHistFact: Record 112;
        Text005: Label 'Devolucion %1 Registrada Correctamente';
        cRegistro: Codeunit 55916;
        cControl: Codeunit 55915;
        Es_NotaCr: Boolean;
        lNumLog: Integer;
        lTextoAviso: Text[1024];
        lMensajeError: Text[1024];
    begin
        //+#90735
        ControlDeAcceso(p_Evento.TextoDato, TRUE);
        //-#90735

        rSalesH.RESET;

        //+#65232
        //IF NOT rSalesH.GET(rSalesH."Document Type"::Invoice, p_Evento.TextoDato3) THEN
        //Es_Devolucion := rSalesH.GET(rSalesH."Document Type"::"Credit Memo", p_Evento.TextoDato3);
        IF NOT rSalesH.GET(rSalesH."Document Type"::Invoice, p_Evento.TextoDato3) THEN BEGIN
            Es_NotaCr := rSalesH.GET(rSalesH."Document Type"::"Credit Memo", p_Evento.TextoDato3);
            IF NOT Es_NotaCr THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := Error004;
                EXIT(FALSE);
            END;
        END;
        //-#65232

        recTPV.GET(p_Evento.TextoDato, p_Evento.TextoDato2);

        WITH rSalesH DO BEGIN
            //+#65232
            //SalesLine.RESET;
            //SalesLine.SETRANGE("Document Type" , rSalesH."Document Type");
            //SalesLine.SETRANGE("Document No."  , rSalesH."No.");
            //IF SalesLine.FINDSET THEN
            //  REPEAT
            //    IF SalesLine."Unit Price" = 0 THEN BEGIN
            //      p_Resultado.TextoRespuesta := STRSUBSTNO(Error007,SalesLine."Line No.");
            //      EXIT(FALSE);
            //    END;
            //  UNTIL SalesLine.NEXT = 0;
            recLinVta.RESET;
            recLinVta.SETRANGE("Document Type", "Document Type");
            recLinVta.SETRANGE("Document No.", "No.");
            recLinVta.SETFILTER(Quantity, '<>0');
            IF recLinVta.ISEMPTY THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := Error004 + ' 1!!';
                EXIT(FALSE);
            END;

            recLinVta.SETRANGE(Quantity);
            recLinVta.SETRANGE("Unit Price", 0);
            IF recLinVta.FINDFIRST THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := STRSUBSTNO(Error007, recLinVta."Line No.");
                EXIT(FALSE);
            END;
            recLinVta.SETRANGE("Unit Price");
            //-#65232

            IF "VAT Registration No." = '' THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := Error002;
                EXIT(FALSE);
            END;

            ComprobarCambioCliente(rSalesH, p_Evento.GetTextoPaisValue(7));
            "Venta a credito" := Es_Vta_Credito(rSalesH);

            rCust.GET("Sell-to Customer No.");
            IF "Venta a credito" THEN
                IF NOT rCust."Permite venta a credito" THEN BEGIN
                    ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                    p_Resultado.TextoRespuesta := Error003;
                    EXIT(FALSE);
                END;

            //+#70132
            IF NOT TestFormaPago(rSalesH, lMensajeError) THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := lMensajeError;
                EXIT(FALSE);
            END;
            //-#70132

            "Hora creacion" := FormatTime(TIME);
            "ID Cajero" := p_Evento.TextoDato5;
            TPV := p_Evento.TextoDato2;
            Ship := FALSE;
            Invoice := TRUE;

            "Cod. Colegio" := p_Evento.GetTextoPaisValue(8);
            "Nombre Colegio" := COPYSTR(p_Evento.GetTextoPaisValue(9), 1, MAXSTRLEN("Nombre Colegio"));


            IF NOT MODIFY(FALSE) THEN BEGIN
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                p_Resultado.TextoRespuesta := Error006;
                p_Resultado.AccionRespuesta := 'ERROR';
                EXIT(FALSE);
            END;

            //+#144756
            //... Actualizaciones El Salvador.
            Actualiza_Venta_Contacto_2(rSalesH);
            //-#144756

            //+88460
            lNumLog := IniciarLog(0, p_Evento.TextoDato, p_Evento.TextoDato2);
            //-88460

            RegistrarAsignaPostingNo(rSalesH, recTPV);
            IF Devolucion THEN
                RelacionaDevolucion(rSalesH);

            p_Resultado.TextoRespuesta := RegistrarPorPais(rSalesH, p_Evento);
            IF p_Resultado.TextoRespuesta <> '' THEN BEGIN
                IF NOT MODIFY THEN;
                p_Resultado.AccionRespuesta := 'ERROR';
                ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735

                //+88460
                ModificarDatosLog(lNumLog, 2, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                  p_Resultado.TextoRespuesta);
                //-88460
                EXIT(FALSE);
            END;

            // IMPORTANTE: Si a partir de aquí el registro no finaliza correctamente, se puede perde la serie de registro y el nº fiscal

            RegistrarActualizaPagos(rSalesH);
            //-#65225

            //+88460
            ModificarDatosLog(lNumLog, 3, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
            //-88460

            IF RegistroEnLinea(p_Evento.TextoDato) THEN BEGIN
                //+#65232
                IF NOT MODIFY(FALSE) THEN BEGIN
                    ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                    p_Resultado.TextoRespuesta := Error006;
                    p_Resultado.AccionRespuesta := 'ERROR';

                    //+88460
                    ModificarDatosLog(lNumLog, 4, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                    p_Resultado.TextoRespuesta);
                    //-88460

                    EXIT(FALSE);
                END;
                //-#65232

                IF NOT "Venta a credito" THEN //+#65232
                    ActualizarDatoPago(rSalesH);

                //+88460
                ModificarDatosLog(lNumLog, 5, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                //-88460

                COMMIT;

                IF (CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", rSalesH)) THEN BEGIN

                    //+88460
                    ModificarDatosLog(lNumLog, 6, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                    //-88460

                    GuardarVentaTPV(rSalesH, TRUE);

                    recParam.INIT;
                    //IF NOT Es_Devolucion THEN //-#65232
                    IF NOT Es_NotaCr THEN //+#65232
                        recParam.Accion := recParam.Accion::LiquidarFactura
                    ELSE
                        recParam.Accion := recParam.Accion::LiquidarNotaCredito;

                    recParam.Documento := rSalesH."Last Posting No.";

                    //+#120811
                    //... Actualizamos los datos fiscales.
                    Post_Registrar(rSalesH, TRUE, recTPV);
                    //-#120811


                    //+88460
                    ModificarDatosLog(lNumLog, 7, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                    //-88460

                    COMMIT;

                    IF (CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", recParam)) THEN BEGIN

                        p_Resultado.AccionRespuesta := 'Nueva_Venta';
                        //IF NOT Es_Devolucion THEN //-#65232
                        IF NOT Es_NotaCr THEN //+#65232
                            p_Resultado.TextoRespuesta := STRSUBSTNO(Text001, rSalesH."Last Posting No.")
                        ELSE
                            p_Resultado.TextoRespuesta := STRSUBSTNO(Text005, rSalesH."Last Posting No.");

                        p_Resultado.TextoDato4 := rSalesH."Last Posting No.";

                        //+88460
                        ModificarDatosLog(lNumLog, 8, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                        //-88460

                        //+76946
                        CLEARLASTERROR;
                        IF NOT FE_Por_Pais(rSalesH, TRUE) THEN BEGIN
                            lTextoAviso := COPYSTR(STRSUBSTNO(Text010, rSalesH."Last Posting No.") + '. ' + GETLASTERRORTEXT, 1, 1024);
                            //... Según como se puede activar el siguiente mensaje, en lugar de grabar en la tabla de TPVs.
                            //MESSAGE(lTextoAviso);
                            GrabarTextoAvisoFE(p_Evento.TextoDato, p_Evento.TextoDato2, lTextoAviso);
                            CLEARLASTERROR;
                        END;
                        //-76946


                        cControl.EliminarBorradores(p_Evento.TextoDato, p_Evento.TextoDato2, FALSE);
                        ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                        EXIT(TRUE);
                    END;

                END
                ELSE BEGIN
                    p_Resultado.AccionRespuesta := 'ERROR';
                    p_Resultado.TextoRespuesta := GETLASTERRORTEXT;

                    //+88460
                    ModificarDatosLog(lNumLog, 9, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                      p_Resultado.TextoRespuesta);
                    //-88460

                    ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                    CLEARLASTERROR;
                    EXIT(FALSE);
                END;

            END
            ELSE BEGIN

                //+#65232
                //recLinVta.RESET;
                //recLinVta.SETRANGE("Document Type" , "Document Type");
                //recLinVta.SETRANGE("Document No."  , "No.");
                //recLinVta.SETFILTER(Quantity,'<>0');
                //IF NOT recLinVta.FINDFIRST THEN BEGIN
                //  p_Resultado.TextoRespuesta := Error004;
                //  EXIT(FALSE);
                //END;
                //-#65232

                "Registrado TPV" := TRUE;

                //+#211509
                //+#273889
                //... Esta funcion se ejecutara despues de GuardarVentaTPV(). En la funcion ActualizarDatoPago() se crean registros de pago por el cambio
                //... y no se replican debido a que no estan marcados como Registrado.
                //ActualizarEstadoRegistro(rSalesH);
                //-#211509

                IF NOT "Venta a credito" THEN //+#65232
                    ActualizarDatoPago(rSalesH);
                GuardarVentaTPV(rSalesH, FALSE);

                //+#211509
                ActualizarEstadoRegistro(rSalesH);
                //-#211509

                //+88460
                ModificarDatosLog(lNumLog, 10, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                //-88460

                IF MODIFY(FALSE) THEN BEGIN

                    //+#121213
                    //... El proceso de registro con esta modificación queda más controlado. Elimino el COMMIT.
                    //COMMIT; //+#65232
                    //-#121213

                    p_Resultado.AccionRespuesta := 'Nueva_Venta';

                    //IF NOT Es_Devolucion THEN //-#65232
                    IF NOT Es_NotaCr THEN //+#65232
                        p_Resultado.TextoRespuesta := STRSUBSTNO(Text001, rSalesH."Posting No.")
                    ELSE
                        p_Resultado.TextoRespuesta := STRSUBSTNO(Text005, rSalesH."Posting No.");

                    p_Resultado.TextoDato4 := rSalesH."No.";

                    //+88460
                    ModificarDatosLog(lNumLog, 11, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", '');
                    //-88460

                    //... Guatemala. Llamada a la funcion para FE 2.0. Como novedad, si hay algun error no puede concluir la venta.
                    lTextoAviso := '';
                    // Eliminado: lógica exclusiva de otros países.

                    IF lTextoAviso <> '' THEN BEGIN
                        //... Si no devolvemos un ERROR, el campo Registrado TPV y otros valores indican que la venta ha ido OK. Por ello, hay que hacer ROLLBACK
                        ERROR(lTextoAviso);

                        lTextoAviso := COPYSTR(lTextoAviso, 1, 150);

                        p_Resultado.TextoRespuesta := lTextoAviso;
                        p_Resultado.AccionRespuesta := 'ERROR';
                        ModificarDatosLog(lNumLog, 13, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                          p_Resultado.TextoRespuesta);

                        ControlDeAcceso(p_Evento.TextoDato, FALSE);

                        EXIT(FALSE);


                    END
                    ELSE BEGIN
                        cControl.EliminarBorradores(p_Evento.TextoDato, p_Evento.TextoDato2, FALSE);
                        ModificarDatosLog(lNumLog, 14, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                          '');
                        ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                        EXIT(TRUE);
                    END;

                END
                ELSE BEGIN
                    p_Resultado.TextoRespuesta := Error006;
                    p_Resultado.AccionRespuesta := 'ERROR';
                    //+88460
                    ModificarDatosLog(lNumLog, 12, rSalesH."Document Type", rSalesH."No.", rSalesH."Last Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal",
                                      p_Resultado.TextoRespuesta);
                    //-88460
                    ControlDeAcceso(p_Evento.TextoDato, FALSE); //+90735
                    EXIT(FALSE);
                END;

            END;

        END;

    end;

    procedure RegistrarPorPais(var p_SalesH: Record 36; var p_Evento: Record "DsPOS Event Buffer" temporary) Respuesta: Text
    begin
        //+#65232
        Respuesta := cCostaRica.Registrar(p_SalesH, p_Evento);

        IF (Respuesta = '') AND (p_SalesH."No. Fiscal TPV" = '') THEN
            p_SalesH."No. Fiscal TPV" := p_SalesH."Posting No.";
    end;

    procedure RegistrarActualizaPagos(var p_SalesH: Record 36)
    var
        recPagosTPV: Record 55915;
    begin
        //+#65225
        WITH p_SalesH DO BEGIN
            recPagosTPV.RESET;
            recPagosTPV.SETRANGE("No. Borrador", "No.");
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                recPagosTPV.MODIFYALL("No. Nota Credito", "Posting No.")
            ELSE
                recPagosTPV.MODIFYALL("No. Factura", "Posting No.");
            recPagosTPV.MODIFYALL(Fecha, "Posting Date");
        END;
    end;

    procedure RegistrarAsignaPostingNo(var p_SalesH: Record 36; p_recTPV: Record 55895)
    var
        cduNoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";
        Text003: Label 'Factura TPV %1';
        Text004: Label 'Devolución TPV %1';
    begin
        //+#65225
        WITH p_SalesH DO BEGIN
            IF "Posting No." = '' THEN
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    "No. Series" := p_recTPV."No. serie notas credito";
                    "Posting No. Series" := p_recTPV."No. serie notas credito reg.";
                    "Posting No." := cduNoSeries.GetNextNo(p_recTPV."No. serie notas credito reg.", "Posting Date", TRUE);
                    "Posting Description" := STRSUBSTNO(Text004, "Posting No.");
                END
                ELSE BEGIN
                    "No. Series" := p_recTPV."No. serie Facturas";
                    "Posting No. Series" := p_recTPV."No. serie facturas Reg.";
                    "Posting No." := cduNoSeries.GetNextNo(p_recTPV."No. serie facturas Reg.", "Posting Date", TRUE);
                    "Posting Description" := STRSUBSTNO(Text003, "Posting No.");
                END;
        END;
    end;

    procedure Crear_Devolucion(p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rSalesH: Record 36;
        rSalesInvH: Record 112;
        rSalesLin: Record 37;
        rSalesInvLin: Record 113;
        NotaCredito: Code[20];
        rCabDevol: Record 36;
        rLinDevol: Record 37;
        Text001: Label 'Se ha creado la devoluci´Š¢n %1';
        NoLin: Integer;
        i: Integer;
        ArrayNav: array[60] of Integer;
        wDateTime: DateTime;
    begin

        Evento.TipoEvento := 16;
        i := 1;
        WHILE i <= p_Evento.GetIntegerArrayCount() DO BEGIN
            ArrayNav[i] := p_Evento.GetIntegerArrayValue(i - 1);
            i += 1;
        END;

        WITH rCabDevol DO BEGIN
            GET("Document Type"::"Credit Memo", Nueva_Venta(p_Evento.TextoDato, p_Evento.TextoDato2, p_Evento.TextoDato4, TRUE));
            IF RegistroEnLinea(p_Evento.TextoDato) THEN BEGIN
                rSalesInvH.GET(p_Evento.TextoDato5);
                VALIDATE("Sell-to Customer No.", rSalesInvH."Sell-to Customer No.");
                VALIDATE("Cod. Colegio", rSalesInvH."Cod. Colegio");
                VALIDATE("Salesperson Code", rSalesInvH."Salesperson Code");
                VALIDATE("Location Code", rSalesInvH."Location Code");
                "Bill-to Name" := rSalesInvH."Bill-to Name";
                "Bill-to Address" := rSalesInvH."Bill-to Address";
                "VAT Registration No." := rSalesInvH."VAT Registration No.";
                "Sell-to Customer Name" := rSalesInvH."Sell-to Customer Name";
                "Sell-to Address" := rSalesInvH."Sell-to Address";
                "Sell-to Contact No." := rSalesInvH."Sell-to Contact No.";
                "Bill-to Contact No." := rSalesInvH."Bill-to Contact No.";

            END
            ELSE BEGIN
                rSalesH.GET(rSalesH."Document Type"::Invoice, p_Evento.TextoDato5);
                VALIDATE("Sell-to Customer No.", rSalesH."Sell-to Customer No.");
                VALIDATE("Cod. Colegio", rSalesH."Cod. Colegio");
                VALIDATE("Salesperson Code", rSalesH."Salesperson Code");
                VALIDATE("Location Code", rSalesH."Location Code");
                "Bill-to Name" := rSalesH."Bill-to Name";
                "Bill-to Address" := rSalesH."Bill-to Address";
                "VAT Registration No." := rSalesH."VAT Registration No.";
                "Sell-to Customer Name" := rSalesH."Sell-to Customer Name";
                "Sell-to Address" := rSalesH."Sell-to Address";
                "Sell-to Contact No." := rSalesH."Sell-to Contact No.";
                "Bill-to Contact No." := rSalesH."Bill-to Contact No.";
            END;
            Devolucion := TRUE;
            VALIDATE("Currency Code", '');
            MODIFY(FALSE);
        END;

        i := 1;
        NoLin := 10000;
        WHILE ArrayNav[i] <> 0 DO BEGIN
            IF RegistroEnLinea(p_Evento.TextoDato) THEN BEGIN
                rSalesInvLin.SETRANGE("Document No.", rSalesInvH."No.");
                rSalesInvLin.SETRANGE("Line No.", ArrayNav[i]);
                IF rSalesInvLin.FINDSET THEN
                    REPEAT
                        WITH rLinDevol DO BEGIN
                            INIT;
                            "Document Type" := rCabDevol."Document Type";
                            "Document No." := rCabDevol."No.";
                            "Line No." := NoLin;
                            VALIDATE(Type, rSalesInvLin.Type);
                            VALIDATE("No.", rSalesInvLin."No.");
                            VALIDATE("Unit of Measure", rSalesInvLin."Unit of Measure");
                            VALIDATE(Quantity, rSalesInvLin.Quantity);
                            VALIDATE("Unit Price", rSalesInvLin."Unit Price");
                            VALIDATE("Line Discount %", rSalesInvLin."Line Discount %");
                            VALIDATE("Line Discount Amount", rSalesInvLin."Line Discount Amount");
                            "Devuelve a Documento" := rSalesInvH."No.";
                            "Devuelve a Linea Documento" := rSalesInvLin."Line No.";
                            INSERT(FALSE);
                        END;
                        NoLin += 10000;
                    UNTIL rSalesInvLin.NEXT = 0;
            END
            ELSE BEGIN
                rSalesLin.SETRANGE("Document Type", rSalesLin."Document Type"::Invoice);
                rSalesLin.SETRANGE("Document No.", rSalesH."No.");
                rSalesLin.SETRANGE("Line No.", ArrayNav[i]);
                IF rSalesLin.FINDSET THEN
                    REPEAT
                        WITH rLinDevol DO BEGIN
                            INIT;
                            "Document Type" := rCabDevol."Document Type";
                            "Document No." := rCabDevol."No.";
                            "Line No." := NoLin;
                            VALIDATE(Type, rSalesLin.Type);
                            VALIDATE("No.", rSalesLin."No.");
                            VALIDATE("Unit of Measure", rSalesLin."Unit of Measure");
                            VALIDATE(Quantity, rSalesLin.Quantity);
                            VALIDATE("Unit Price", rSalesLin."Unit Price");
                            VALIDATE("Line Discount %", rSalesLin."Line Discount %");
                            VALIDATE("Line Discount Amount", rSalesLin."Line Discount Amount");
                            "Devuelve a Documento" := rSalesH."Posting No.";
                            "Devuelve a Linea Documento" := rSalesLin."Line No.";

                            Linea_LocalizadaOFF(rSalesLin, rLinDevol);

                            INSERT(FALSE);
                        END;
                        NoLin += 10000;
                    UNTIL rSalesLin.NEXT = 0;
            END;
            i += 1;
        END;

        // Para obtener el siguiente nº de notas de credito
        Evento.TextoDato7 := cCostaRica.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);

        Evento.TextoDato := rCabDevol."No.";
        Evento.TextoDato2 := STRSUBSTNO('%1', rCabDevol."Posting Date");
        Evento.TextoDato3 := rCabDevol."Sell-to Customer Name";
        Evento.TextoDato4 := rCabDevol."VAT Registration No.";
        Evento.TextoRespuesta := STRSUBSTNO(Text001, rCabDevol."No.");
        Evento.TextoDato5 := rCabDevol."Sell-to Customer No.";
        Evento.TextoDato8 := rCabDevol."Cod. Colegio";
        Evento.TextoDato9 := rCabDevol."Nombre Colegio";

        Evento.AccionRespuesta := 'Actualizar_Todo';
        Actualizar_Totales(Evento.TextoDato, Evento, FALSE, TRUE);
        EXIT(Evento.aXml());
    end;

    procedure Actualizar_Totales(p_Venta: Code[20]; var p_Evento: Record "DsPOS Event Buffer" temporary; EsNueva: Boolean; Devolucion: Boolean)
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rSalesH: Record 36;
        decDummy: Decimal;
        i: Integer;
        decImportes: array[10] of Decimal;
    begin

        i := 1;
        p_Evento.ClearDecimalArray();

        IF NOT (EsNueva) THEN BEGIN
            CASE Devolucion OF
                FALSE:
                    BEGIN
                        IF NOT rSalesH.GET(rSalesH."Document Type"::Invoice, p_Venta) THEN
                            EXIT;
                    END;
                TRUE:
                    BEGIN
                        IF NOT rSalesH.GET(rSalesH."Document Type"::"Credit Memo", p_Venta) THEN
                            EXIT;
                    END;
            END;

            ActValoresTPV(rSalesH, decImportes[1], decImportes[2], decImportes[3], decImportes[4], decImportes[5], decImportes[6], decImportes[7]);
            WHILE i <= 7 DO BEGIN
                p_Evento.SetDecimalArrayValue(i, decImportes[i]);
                i += 1;
            END;
        END;

    end;

    procedure ActValoresTPV(recPrmCabVta: Record 36; var decPrmTotal: Decimal; var decPrmPago: Decimal; var decPrmDescuentos: Decimal; var decPrmCambio: Decimal; var decPrmBalance: Decimal; var decPrmTotalProds: Decimal; var decPrImpuestos: Decimal)
    var
        recLinVta: Record 37;
        recPagosTPV: Record 55915;
    begin
        CLEAR(decPrmTotal);
        CLEAR(decPrmDescuentos);
        CLEAR(decPrmPago);

        recPrmCabVta.CALCFIELDS(Amount);
        recPrmCabVta.CALCFIELDS("Amount Including VAT");
        decPrImpuestos := recPrmCabVta."Amount Including VAT" - recPrmCabVta.Amount;

        IF recPagosTPV.GET(recPrmCabVta."No.", 'EXIVA', FALSE) THEN BEGIN
            recPagosTPV.Importe := decPrImpuestos;
            recPagosTPV."Importe (DL)" := decPrImpuestos;
            recPagosTPV.MODIFY;
        END;

        ObtValoresFac(recPrmCabVta, decPrmTotal, decPrmDescuentos, decPrmTotalProds);
        decPrmPago := ObtImportePago(recPrmCabVta);
        //-#65232

        decPrmBalance := decPrmTotal - decPrmDescuentos - decPrmPago;
        IF decPrmBalance < 0 THEN
            decPrmBalance := 0;

        decPrmCambio := decPrmTotal - decPrmDescuentos - decPrmPago;
        IF decPrmCambio > 0 THEN
            decPrmCambio := 0;

        IF decPrmPago = 0 THEN
            decPrmCambio := 0;

    end;

    procedure ObtValoresFac(recPrmCabVta: Record 36; var decPrmTotal: Decimal; var decPrmDescuentos: Decimal; var decPrmTotalProds: Decimal)
    var
        recLinVta: Record 37;
    begin
        //+#65232
        recLinVta.RESET;
        recLinVta.SETRANGE("Document Type", recPrmCabVta."Document Type");
        recLinVta.SETRANGE("Document No.", recPrmCabVta."No.");
        recLinVta.CALCSUMS("Outstanding Amount", "Line Discount Amount", Quantity);

        decPrmTotal := recLinVta."Outstanding Amount" + recLinVta."Line Discount Amount";
        decPrmDescuentos := recLinVta."Line Discount Amount";
        decPrmTotalProds := recLinVta.Quantity;
    end;

    procedure ObtImportePago(recPrmCabVta: Record 36): Decimal
    var
        recPagosTPV: Record 55915;
    begin
        //+#65232
        recPagosTPV.RESET;
        recPagosTPV.SETRANGE("No. Borrador", recPrmCabVta."No.");
        recPagosTPV.CALCSUMS("Importe (DL)");

        EXIT(recPagosTPV."Importe (DL)");
    end;

    procedure ActualizarDatoPago(recPrmCabVta: Record 36)
    var
        decDummy: array[10] of Decimal;
        decCambio: Decimal;
    begin
        ActValoresTPV(recPrmCabVta, decDummy[1], decDummy[2], decDummy[3], decCambio, decDummy[4], decDummy[5], decDummy[6]);

        IF decCambio <> 0 THEN
            InsertaCambio(recPrmCabVta, decCambio);
    end;

    procedure Valida_Venta(rSalesHeader: Record 36): Boolean
    var
        rSalesLine: Record 37;
    begin

        rSalesLine.RESET;
        rSalesLine.SETRANGE("Document Type", rSalesHeader."Document Type");
        rSalesLine.SETRANGE("Document No.", rSalesHeader."No.");
        IF rSalesLine.FINDSET THEN
            REPEAT
                IF rSalesLine."Outstanding Amount" <> 0 THEN
                    EXIT(TRUE);
            UNTIL rSalesLine.NEXT = 0;

        EXIT(FALSE);
    end;

    procedure Es_Vta_Credito(var pSalesHeader: Record 36): Boolean
    var
        rSalesline: Record 37;
        rPagosTPV: Record 55915;
        wTotal: Decimal;
        wDescuentos: Decimal;
        wPago: Decimal;
    begin

        rSalesline.RESET;
        rSalesline.SETRANGE("Document Type", pSalesHeader."Document Type");
        rSalesline.SETRANGE("Document No.", pSalesHeader."No.");
        IF rSalesline.FINDSET THEN
            REPEAT
                wTotal += rSalesline."Outstanding Amount" + rSalesline."Line Discount Amount";
                wDescuentos += rSalesline."Line Discount Amount";
            UNTIL rSalesline.NEXT = 0;

        rPagosTPV.RESET;
        rPagosTPV.SETRANGE("No. Borrador", pSalesHeader."No.");
        IF rPagosTPV.FINDSET THEN
            REPEAT
                wPago += rPagosTPV."Importe (DL)";
            UNTIL rPagosTPV.NEXT = 0;

        EXIT((wTotal - wDescuentos - wPago) > 0)
    end;

    procedure SigNoLinea(p_Pedido: Code[20]): Integer
    var
        rSalesLine: Record 37;
    begin

        rSalesLine.RESET;
        rSalesLine.SETRANGE("Document Type", rSalesLine."Document Type"::Invoice);
        rSalesLine.SETRANGE("Document No.", p_Pedido);
        IF rSalesLine.FINDLAST THEN
            EXIT(rSalesLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    procedure Pais(): Integer
    var
        rConfGeneral: Record 55894;
    begin

        rConfGeneral.GET();
        rConfGeneral.TESTFIELD(Pais);
        EXIT(rConfGeneral.Pais);
    end;

    procedure GetDimensionSetIDMovCliente(codPrmDocNo: Code[20]): Integer
    var
        recMovCli: Record 21;
    begin

        //Se igualan las dimensiones del pago a las de la factura
        recMovCli.RESET;
        recMovCli.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        recMovCli.SETRANGE("Document Type", recMovCli."Document Type"::Invoice);
        recMovCli.SETRANGE("Document No.", codPrmDocNo);
        IF recMovCli.FINDFIRST THEN
            EXIT(recMovCli."Dimension Set ID")
        ELSE BEGIN
            recMovCli.RESET;
            recMovCli.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
            recMovCli.SETRANGE("Document Type", recMovCli."Document Type"::"Credit Memo");
            recMovCli.SETRANGE("Document No.", codPrmDocNo);
            IF recMovCli.FINDFIRST THEN
                EXIT(recMovCli."Dimension Set ID")
        END;
    end;

    procedure InsertaCambio(recPrmCabVta: Record 36; decPrmImporteCambio: Decimal)
    var
        recPagosTPV: Record 55915;
        recFormPagosTPV: Record 55907;
        TextL001: Label 'REG_CAMBIO';
    begin

        recPagosTPV.RESET;
        recPagosTPV.SETRANGE("No. Borrador", recPrmCabVta."No.");
        recPagosTPV.SETRANGE(Cambio, TRUE);
        IF recPagosTPV.FINDFIRST THEN
            EXIT;

        //Inserta La forma de pago Cambio
        WITH recPrmCabVta DO BEGIN
            IF decPrmImporteCambio <> 0 THEN BEGIN
                recFormPagosTPV.RESET;
                recFormPagosTPV.SETRANGE("Efectivo Local", TRUE);
                recFormPagosTPV.FINDFIRST;

                recPagosTPV.INIT;
                recPagosTPV."Forma pago TPV" := recFormPagosTPV."ID Pago";
                recPagosTPV."No. Borrador" := "No.";
                recPagosTPV.Tienda := Tienda;
                recPagosTPV.TPV := TPV;
                recPagosTPV."Cod. divisa" := '';
                recPagosTPV."Importe (DL)" := decPrmImporteCambio;
                recPagosTPV.Importe := decPrmImporteCambio;
                recPagosTPV.Fecha := WORKDATE;
                recPagosTPV.Hora := FormatTime(TIME);
                recPagosTPV.Cajero := "ID Cajero";
                recPagosTPV."No. Factura" := "Posting No.";
                recPagosTPV.Cambio := TRUE;

                //+#70132
                //-#70132

                recPagosTPV.INSERT;
            END;
        END;
    end;

    procedure Imprimir(codPrmTienda: Code[20]; codPrmDoc: Code[20]): Text
    var
        recCabFac: Record 112;
        recCabNC: Record 114;
        recCabVta: Record 36;
        recTienda: Record 55897;
        i: Integer;
    begin
        IF NOT recTienda.GET(codPrmTienda) THEN
            EXIT('');

        IF recTienda."Registro En Linea" THEN BEGIN
            recCabFac.RESET;
            recCabFac.SETRANGE("No.", codPrmDoc);
            IF recCabFac.FINDFIRST THEN BEGIN
                recTienda.TESTFIELD("ID Reporte contado");
                WHILE i < recTienda."Cantidad de Copias Contado" DO BEGIN
                    i += 1;
                    IF TestFE_Factura(recCabFac) AND (recTienda."ID Reporte contado FE" > 0) THEN
                        REPORT.RUN(recTienda."ID Reporte contado FE", FALSE, FALSE, recCabFac)
                    ELSE
                        REPORT.RUN(recTienda."ID Reporte contado", FALSE, FALSE, recCabFac);
                END;
                EXIT('');
            END;

            recCabNC.RESET;
            recCabNC.SETRANGE("No.", codPrmDoc);
            IF recCabNC.FINDFIRST THEN BEGIN
                recTienda.TESTFIELD("ID Reporte nota credito");
                WHILE i < recTienda."Cantidad copias nota credito" DO BEGIN
                    i += 1;
                    IF TestFE_NCR(recCabNC) AND (recTienda."ID Reporte nota credito FE" > 0) THEN
                        REPORT.RUN(recTienda."ID Reporte nota credito FE", FALSE, FALSE, recCabNC)
                    ELSE
                        REPORT.RUN(recTienda."ID Reporte nota credito", FALSE, FALSE, recCabNC);
                END;
            END;
            EXIT('');
        END;

        recCabVta.RESET;
        recCabVta.SETRANGE("Document Type", recCabVta."Document Type"::Invoice);
        recCabVta.SETRANGE("No.", codPrmDoc);
        IF recCabVta.FINDFIRST THEN BEGIN
            recTienda.TESTFIELD("ID Reporte contado");
            WHILE i < recTienda."Cantidad de Copias Contado" DO BEGIN
                i += 1;
                IF TestFE(recCabVta) AND (recTienda."ID Reporte contado FE" > 0) THEN
                    REPORT.RUN(recTienda."ID Reporte contado FE", FALSE, FALSE, recCabVta)
                ELSE
                    REPORT.RUN(recTienda."ID Reporte contado", FALSE, FALSE, recCabVta);
            END;
            EXIT('');
        END;

        recCabVta.RESET;
        recCabVta.SETRANGE("Document Type", recCabVta."Document Type"::"Credit Memo");
        recCabVta.SETRANGE("No.", codPrmDoc);
        IF recCabVta.FINDFIRST THEN BEGIN
            recTienda.TESTFIELD("ID Reporte nota credito");
            WHILE i < recTienda."Cantidad copias nota credito" DO BEGIN
                i += 1;
                IF TestFE(recCabVta) AND (recTienda."ID Reporte nota credito FE" > 0) THEN
                    REPORT.RUN(recTienda."ID Reporte nota credito FE", FALSE, FALSE, recCabVta)
                ELSE
                    REPORT.RUN(recTienda."ID Reporte nota credito", FALSE, FALSE, recCabVta);
            END;
        END;

        EXIT('');
    end;

    procedure AnularFactura(codPrmTienda: Code[20]; codPrmTPV: Code[20]; codPrmCajero: Code[20]; codPrmDoc: Code[20]): Text
    var
        recCabVta: Record 36;
        recLinVta: Record 37;
        recCab: Record 36;
        recLin: Record 37;
        recCabFac: Record 112;
        recLinFac: Record 113;
        recTPV: Record 55895;
        Evento: Record "DsPOS Event Buffer" temporary;
        Error001: Label 'La factura %1 ya está anulada.';
        Error002: Label 'No se ha podido insertar la nota de Credito.';
        Text002: Label 'Factura anulada correctamente.';
        recCabNC: Record 114;
        rPagos: Record 55915;
        rPagosNC: Record 55915;
        cduNoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";
        Text003: Label 'Anula a Fact. TPV %1';
        cRegistro: Codeunit 55916;
        lNumLog: Integer;
        lOk: Boolean;
        lTextoAviso: Text[1024];
    begin
        //#88460
        ControlDeAcceso(codPrmTienda, TRUE);
        //-88460

        //+88460
        lNumLog := IniciarLog(2, codPrmTienda, codPrmTPV);
        //-88460

        Evento.TipoEvento := 10;
        recTPV.GET(codPrmTienda, codPrmTPV);

        IF RegistroEnLinea(codPrmTienda) THEN BEGIN

            recCabFac.GET(codPrmDoc);
            IF recCabFac."Anulado TPV" THEN BEGIN
                Evento.TextoRespuesta := 'ERROR';
                Evento.AccionRespuesta := STRSUBSTNO(Error001, recCabFac."No.");

                //+88460
                ModificarDatosLog(lNumLog, 2, 0, recCabFac."No.", recCabFac."No.", recCabFac."No. Fiscal TPV", recCabFac."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460

                EXIT(Evento.aXml());
            END;

            recCabVta.INIT;
            recCabVta."Document Type" := recCabVta."Document Type"::"Credit Memo";
            recCabVta."No." := cduNoSeries.GetNextNo(recTPV."No. serie notas credito", WORKDATE, TRUE);
            recCabVta."No. Series" := recTPV."No. serie notas credito";
            recCabVta."Posting No. Series" := recTPV."No. serie notas credito reg.";

            recCabVta.VALIDATE("Sell-to Customer No.", recCabFac."Sell-to Customer No.");
            recCabVta.VALIDATE("Order Date", WORKDATE);
            recCabVta.VALIDATE("Posting Date", WORKDATE);
            recCabVta.VALIDATE("Document Date", WORKDATE);
            recCabVta.VALIDATE("Hora creacion", FormatTime(TIME));

            recCabVta."Venta TPV" := TRUE;
            recCabVta.Tienda := recTPV.Tienda;
            recCabVta.TPV := recTPV."Id TPV";
            recCabVta."ID Cajero" := codPrmCajero;

            recCabVta.VALIDATE("Location Code", recCabFac."Location Code");
            recCabVta.VALIDATE("Currency Code", recCabFac."Currency Code");

            recCabVta.Correction := TRUE;
            recCabVta.Turno := recCabFac.Turno;
            recCabVta."Anula a Documento" := codPrmDoc;
            recCabVta."Posting No." := cduNoSeries.GetNextNo(recCabVta."Posting No. Series", WORKDATE, TRUE);

            recCabVta."Sell-to Contact No." := recCabFac."Sell-to Contact No.";
            recCabVta."Bill-to Contact No." := recCabFac."Bill-to Contact No.";
            recCabVta."Location Code" := recCabFac."Location Code";

            recCabVta.INSERT(TRUE);

            recCabVta."Posting Description" := STRSUBSTNO(Text003, recCabFac."No.");
            recCabVta.VALIDATE("Dimension Set ID", recCabFac."Dimension Set ID");
            recCabVta.VALIDATE("Cod. Colegio", recCabFac."Cod. Colegio");
            recCabVta.VALIDATE("Salesperson Code", recCabFac."Salesperson Code");

            recCabVta."Bill-to Name" := recCabFac."Bill-to Name";
            recCabVta."Bill-to Address" := recCabFac."Bill-to Address";
            recCabVta."VAT Registration No." := recCabFac."VAT Registration No.";
            recCabVta."Sell-to Customer Name" := recCabFac."Sell-to Customer Name";
            recCabVta."Sell-to Address" := recCabFac."Sell-to Address";

            //+#232158 (RRT / MDM)
            recCabVta."Prices Including VAT" := recCabFac."Prices Including VAT";
            //-#232158 (RRT / MDM)

            recCabVta.MODIFY(FALSE);

            recLinFac.RESET;
            recLinFac.SETCURRENTKEY(Devuelto);
            recLinFac.SETRANGE("Document No.", recCabFac."No.");
            recLinFac.SETRANGE(Devuelto, FALSE);
            IF recLinFac.FINDSET THEN
                REPEAT
                    recLinVta.INIT;
                    recLinVta.VALIDATE("Document Type", recCabVta."Document Type");
                    recLinVta.VALIDATE("Document No.", recCabVta."No.");
                    recLinVta."Line No." := recLinFac."Line No.";
                    recLinVta.VALIDATE(Type, recLinFac.Type);
                    recLinVta.VALIDATE("No.", recLinFac."No.");
                    recLinVta.VALIDATE("Location Code", recLinFac."Location Code");
                    recLinVta.VALIDATE(Quantity, recLinFac.Quantity);
                    recLinVta.VALIDATE("Unit Price", recLinFac."Unit Price");
                    recLinVta.VALIDATE("Line Discount %", recLinFac."Line Discount %");
                    recLinVta.VALIDATE("Line Discount Amount", recLinFac."Line Discount Amount");
                    recLinVta."Devuelve a Documento" := recCabFac."No.";
                    recLinVta."Devuelve a Linea Documento" := recLinFac."Line No.";
                    recLinVta.VALIDATE("Dimension Set ID", recLinFac."Dimension Set ID");
                    recLinVta.INSERT(FALSE);
                UNTIL recLinFac.NEXT = 0;

            Evento.TextoRespuesta := '';

            //+88460
            ModificarDatosLog(lNumLog, 3, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                Evento.TextoRespuesta);
            //-88460

            Evento.TextoRespuesta := cCostaRica.AnularFactura(recCabVta); // Costa Rica / #148807

            IF Evento.TextoRespuesta <> '' THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                //+88460
                ModificarDatosLog(lNumLog, 4, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460
                EXIT(Evento.aXml());
            END;

            recCabVta.MODIFY;
            COMMIT;

            IF NOT (CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", recCabVta)) THEN BEGIN
                Evento.TextoRespuesta := GETLASTERRORTEXT;
                Evento.AccionRespuesta := 'ERROR';
                //+88460
                ModificarDatosLog(lNumLog, 5, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460
                CLEARLASTERROR;
            END
            ELSE BEGIN

                recCabFac."Anulado por Documento" := recCabVta."Last Posting No.";
                recCabFac."Anulado TPV" := TRUE;
                recCabFac.MODIFY(FALSE);

                // Hacemos los pagos a la inversa para que se liquiden en central con la NC
                rPagos.RESET;
                rPagos.SETCURRENTKEY("No. Factura", "Cod. divisa");
                rPagos.SETRANGE("No. Factura", codPrmDoc);
                IF rPagos.FINDSET THEN
                    REPEAT
                        rPagosNC.INIT;
                        rPagosNC.TRANSFERFIELDS(rPagos);
                        rPagosNC."Importe (DL)" := -rPagosNC."Importe (DL)";
                        rPagosNC.Importe := -rPagosNC.Importe;
                        rPagosNC."No. Borrador" := recCabVta."No.";
                        rPagosNC."No. Factura" := '';
                        rPagosNC."No. Nota Credito" := recCabVta."Last Posting No.";
                        rPagosNC.Fecha := WORKDATE;
                        rPagosNC.Hora := FormatTime(TIME);
                        rPagosNC.INSERT(FALSE);
                    UNTIL rPagos.NEXT = 0;

                GuardarAnulacionTPV(recCabVta, TRUE);
                AnulaPagoFacturaTPV(codPrmDoc, recCabVta."Last Posting No.");

                Evento.AccionRespuesta := 'OK';
                Evento.TextoRespuesta := Text002;

                //+88460
                ModificarDatosLog(lNumLog, 6, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460

                //+76946
                lOk := TRUE;
                CLEARLASTERROR;
                IF NOT FE_Por_Pais(recCabVta, TRUE) THEN BEGIN
                    Evento.TextoRespuesta := Text002 + ' ' + STRSUBSTNO(Text010, recCabVta."Last Posting No.") + '. ' + GETLASTERRORTEXT;
                    lOk := FALSE;
                    CLEARLASTERROR;
                END;
                //-76946

                // Imprimir Nota de Credito ON
                //+76946
                //Imprimir(codPrmTienda, recCabVta."Last Posting No.");
                IF lOk THEN  //+76946
                    Imprimir(codPrmTienda, recCabVta."Last Posting No.");
                //-76946


                //+88460
                ModificarDatosLog(lNumLog, 7, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460

            END;

        END
        ELSE BEGIN

            recCab.GET(recCab."Document Type"::Invoice, codPrmDoc);
            IF recCab."Anulado TPV" THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                Evento.TextoRespuesta := STRSUBSTNO(Error001, recCab."No.");

                //+88460
                ModificarDatosLog(lNumLog, 8, recCab."Document Type", recCab."No.", recCab."Posting No.", recCab."No. Fiscal TPV", recCab."No. Comprobante Fiscal",
                                  Evento.TextoRespuesta);
                //-88460

                EXIT(Evento.aXml());
            END;

            recCabVta.INIT;
            recCabVta."Document Type" := recCabVta."Document Type"::"Credit Memo";
            recCabVta."No." := cduNoSeries.GetNextNo(recTPV."No. serie notas credito", WORKDATE, TRUE);
            recCabVta."No. Series" := recTPV."No. serie notas credito";
            recCabVta."Posting No. Series" := recTPV."No. serie notas credito reg.";
            recCabVta.VALIDATE("Sell-to Customer No.", recCab."Sell-to Customer No.");
            recCabVta.VALIDATE("Order Date", WORKDATE);
            recCabVta.VALIDATE("Posting Date", WORKDATE);
            recCabVta.VALIDATE("Document Date", WORKDATE);
            recCabVta.VALIDATE("Hora creacion", FormatTime(TIME));

            recCabVta."Venta TPV" := TRUE;
            recCabVta.Tienda := codPrmTienda;
            recCabVta.TPV := codPrmTPV;
            recCabVta."ID Cajero" := codPrmCajero;

            recCabVta.VALIDATE("Location Code", recCab."Location Code");
            recCabVta.VALIDATE("Currency Code", recCab."Currency Code");

            recCabVta."Dimension Set ID" := recCab."Dimension Set ID";
            recCabVta.Correction := TRUE;
            recCabVta.Turno := recCab.Turno;
            recCabVta."Anula a Documento" := recCab."Posting No.";
            recCabVta."Registrado TPV" := TRUE;
            recCabVta."Posting No." := cduNoSeries.GetNextNo(recTPV."No. serie notas credito reg.", WORKDATE, TRUE);

            recCabVta."Sell-to Contact No." := recCab."Sell-to Contact No.";
            recCabVta."Bill-to Contact No." := recCab."Bill-to Contact No.";
            recCabVta."Location Code" := recCab."Location Code";

            recCabVta.INSERT(FALSE);
            recCabVta."Posting Description" := STRSUBSTNO(Text003, recCab."Posting No.");
            recCabVta.VALIDATE("Cod. Colegio", recCab."Cod. Colegio");
            recCabVta.VALIDATE("Salesperson Code", recCab."Salesperson Code");

            recCabVta."Bill-to Name" := recCab."Bill-to Name";
            recCabVta."Bill-to Address" := recCab."Bill-to Address";
            recCabVta."VAT Registration No." := recCab."VAT Registration No.";

            recCabVta."Sell-to Customer Name" := recCab."Sell-to Customer Name";
            recCabVta."Sell-to Address" := recCab."Sell-to Address";

            //+#232158
            //... Al incluir el e-mail, me he fijado que los campos de envio, no salían igual...
            recCabVta."E-Mail" := recCab."E-Mail";
            recCabVta."Ship-to Code" := recCab."Ship-to Code";
            recCabVta."Ship-to Name" := recCab."Ship-to Name";
            recCabVta."Ship-to Name 2" := recCab."Ship-to Name 2";
            recCabVta."Ship-to Address" := recCab."Ship-to Address";
            recCabVta."Ship-to Address 2" := recCab."Ship-to Address 2";
            recCabVta."Ship-to City" := recCab."Ship-to City";
            recCabVta."Ship-to Contact" := recCab."Ship-to Contact";
            //-#232158

            //+#232158 (RRT / MDM)
            recCabVta."Prices Including VAT" := recCab."Prices Including VAT";
            //-#232158 (RRT / MDM)


            recCabVta.MODIFY(FALSE);

            recLin.RESET;
            recLin.SETCURRENTKEY(Devuelto, "Devuelve a Documento");
            recLin.SETRANGE("Document No.", recCab."No.");
            recLin.SETRANGE(Devuelto, FALSE);
            IF recLin.FINDSET THEN
                REPEAT
                    recLinVta.INIT;
                    recLinVta.VALIDATE("Document Type", recCabVta."Document Type");
                    recLinVta.VALIDATE("Document No.", recCabVta."No.");
                    recLinVta."Line No." := recLin."Line No.";
                    recLinVta.VALIDATE(Type, recLin.Type);
                    recLinVta.VALIDATE("No.", recLin."No.");
                    recLinVta.VALIDATE("Location Code", recLin."Location Code");
                    recLinVta.VALIDATE(Quantity, recLin.Quantity);
                    recLinVta.VALIDATE("Unit Price", recLin."Unit Price");
                    recLinVta.VALIDATE("Line Discount %", recLin."Line Discount %");
                    recLinVta.VALIDATE("Line Discount Amount", recLin."Line Discount Amount");
                    recLinVta."Devuelve a Documento" := recCab."Posting No.";
                    recLinVta."Devuelve a Linea Documento" := recLin."Line No.";

                    //+#211509
                    recLinVta."Registrado TPV" := TRUE;
                    //-#211509

                    Linea_LocalizadaOFF(recLin, recLinVta);

                    recLinVta.INSERT(FALSE);
                UNTIL recLin.NEXT = 0;

            //+88460
            ModificarDatosLog(lNumLog, 9, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                              '');
            //-88460

            Evento.TextoRespuesta := '';
            Evento.TextoRespuesta := cCostaRica.AnularFactura(recCabVta); // Costa Rica / #148807

            IF Evento.TextoRespuesta <> '' THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                //+88460
                ModificarDatosLog(lNumLog, 10, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                                Evento.TextoRespuesta);
                //-88460
                EXIT(Evento.aXml());
            END;

            // Marcamos la cabecera como anualada
            recCab."Anulado TPV" := TRUE;
            recCab."Anulado por Documento" := recCabVta."Posting No.";
            recCab.MODIFY(FALSE);

            // Hacemos los pagos a la inversa para que se liquiden en central con la NC
            rPagos.RESET;
            rPagos.SETRANGE("No. Borrador", codPrmDoc);
            IF rPagos.FINDSET THEN
                REPEAT
                    rPagosNC.INIT;
                    rPagosNC.TRANSFERFIELDS(rPagos);
                    rPagosNC."Importe (DL)" := -rPagos."Importe (DL)";
                    rPagosNC.Importe := -rPagos.Importe;
                    rPagosNC.Fecha := WORKDATE;
                    rPagosNC.Hora := FormatTime(TIME);
                    rPagosNC."No. Borrador" := recCabVta."No.";
                    rPagosNC."No. Factura" := '';
                    rPagosNC."No. Nota Credito" := recCabVta."Posting No.";

                    //+#211509
                    rPagosNC."Registrado TPV" := TRUE;
                    //-#211509

                    rPagosNC.INSERT(FALSE);

                UNTIL rPagos.NEXT = 0;

            // Anulamos las transacciones de caja
            GuardarAnulacionTPV(recCabVta, FALSE);
            Evento.AccionRespuesta := 'OK';
            Evento.TextoRespuesta := Text002;

            RelacionaAnulacion(recCabVta, codPrmTienda);

            //+88460
            ModificarDatosLog(lNumLog, 11, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal",
                              Evento.TextoRespuesta);
            //-88460

            //+#232158
            lOk := TRUE;
            //... Adaptacion a FE 2.0

            //... Guatemala. Llamada a la funcion para FE 2.0. Como novedad, si hay algun error no puede concluir la venta.
            lTextoAviso := '';
            // Eliminado: lógica exclusiva de otros países.

            IF lTextoAviso <> '' THEN BEGIN
                //... Si no devolvemos un ERROR, el campo Registrado TPV y otros valores indican que la venta ha ido OK. Por ello, hay que hacer ROLLBACK
                ERROR(lTextoAviso);
            END;
            //-#232158


            // Imprimir Nota de Credito OFF
            //+#76046
            //Imprimir(codPrmTienda, recCabVta."No.");
            IF lOk THEN  //+76946
                         // Imprimir Nota de Credito OFF
                Imprimir(codPrmTienda, recCabVta."No.");
            //-#76946

        END;

        //+88460
        ModificarDatosLog(lNumLog, 12, recCabVta."Document Type", recCabVta."No.", recCabVta."Posting No.", recCabVta."No. Fiscal TPV", recCabVta."No. Comprobante Fiscal", '');
        //-88460

        //#88460
        ControlDeAcceso(codPrmTienda, FALSE);
        //-88460

        EXIT(Evento.aXml());

    end;

    procedure PrecioDisponibilidad(p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rCabVta: Record 36;
        rLinVtaTMP: Record 37 temporary;
        Umed: Code[10];
        CodProd: Code[20];
        rTiendas: Record 55897;
        rItem: Record 27;
        rSalesH: Record 36;
    begin

        Evento.TipoEvento := 15;

        rTiendas.GET(p_Evento.TextoDato);
        CodProd := p_Evento.TextoDato4;
        Buscar_Producto(CodProd, Umed);

        WITH rLinVtaTMP DO BEGIN
            INIT;
            VALIDATE("Document Type", "Document Type"::Invoice);
            VALIDATE("Document No.", p_Evento.TextoDato3);
            VALIDATE("Line No.", 10000);
            VALIDATE(Type, Type::Item);
            Temporal := TRUE; //+#65232 para que no de error si el producto ya está en la factura
            VALIDATE("No.", CodProd);
            VALIDATE("Unit of Measure Code", Umed);
            VALIDATE(Quantity, 1);

            rSalesH.GET("Document Type", "Document No.");

            VALIDATE("Location Code", rSalesH."Location Code");
        END;

        rItem.RESET;
        rItem.GET(CodProd);
        rItem.SETFILTER("Location Filter", rTiendas."Cod. Almacen");
        rItem.CALCFIELDS(Inventory);

        Evento.ClearDecimalArray();
        Evento.SetDecimalArrayValue(1, rLinVtaTMP."Unit Price");
        Evento.SetDecimalArrayValue(2, rItem.Inventory);

        Evento.AccionRespuesta := 'OK';

        EXIT(Evento.aXml());
    end;

    procedure LiquidaDocumentoTPV(codPrmDoc: Code[20]; optTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund)
    var
        recCabFac: Record 112;
        recCabNC: Record 114;
        recPagosTPV: Record 55915;
        recTransCaja: Record 55917;
        CodTienda: Code[20];
        CodCliente: Code[20];
        Factor: Decimal;
    begin
        //+#65232
        // Sustituye a las funciones LiquidaFacturaTPV y LiquidaNotaCreditoTPV

        //Esta función genera los pagos según divisa y liquida la factura o nota de Credito TPV

        IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
            recCabFac.GET(codPrmDoc);
            CodTienda := recCabFac.Tienda;
            CodCliente := recCabFac."Bill-to Customer No.";
            Factor := 1;
        END
        ELSE BEGIN
            recCabNC.GET(codPrmDoc);
            CodTienda := recCabNC.Tienda;
            CodCliente := recCabNC."Bill-to Customer No.";
            Factor := -1
        END;

        //Primero se comprueba que no se haya liquidado el mov. cliente
        IF MovClientePendiente(CodCliente, optTipoDoc, codPrmDoc) THEN BEGIN
            // damos prioridad a la transacción de caja, es más fiable que pagos TPV
            IF TieneTransaccionCaja(recTransCaja, CodTienda, codPrmDoc) THEN BEGIN
                WITH recTransCaja DO BEGIN

                    IF FINDSET THEN
                        REPEAT
                            SETRANGE("Cod. divisa", "Cod. divisa");
                            SETRANGE("NCR regis. de compensacion", "NCR regis. de compensacion");  //+#70132
                            CALCSUMS(Importe);
                            // Primero registramos los pagos
                            IF (Importe * Factor) > 0 THEN;
                            RegistrarPagoDocumento(codPrmDoc, optTipoDoc, "Cod. tienda", "Cod. divisa", Importe, "Forma de pago", "NCR regis. de compensacion");  //+#70132

                            FINDLAST;
                            SETRANGE("Cod. divisa");
                            SETRANGE("NCR regis. de compensacion");  //+#70132
                        UNTIL NEXT = 0;

                    IF FINDSET THEN
                        REPEAT
                            SETRANGE("Cod. divisa", "Cod. divisa");
                            SETRANGE("NCR regis. de compensacion", "NCR regis. de compensacion");  //+#70132
                            CALCSUMS(Importe);
                            // Si quedan reembolsos, se liquidan contra pagos pendientes.
                            IF (Importe * Factor) < 0 THEN
                                RegistrarPagoDocumento(codPrmDoc, optTipoDoc, "Cod. tienda", "Cod. divisa", Importe, "Forma de pago", "NCR regis. de compensacion");  //+#70132

                            FINDLAST;
                            SETRANGE("Cod. divisa");
                            SETRANGE("NCR regis. de compensacion");  //+#70132
                        UNTIL NEXT = 0;

                    IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
                        recCabFac."Liquidado TPV" := TRUE;
                        recCabFac.MODIFY(FALSE);
                    END
                    ELSE BEGIN
                        recCabNC."Liquidado TPV" := TRUE;
                        recCabNC.MODIFY(FALSE);
                    END;

                END;
            END
            ELSE BEGIN
                WITH recPagosTPV DO BEGIN
                    RESET;
                    IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
                        SETCURRENTKEY("No. Factura", "Cod. divisa");
                        SETRANGE("No. Factura", recCabFac."No.");
                    END
                    ELSE BEGIN
                        SETCURRENTKEY("No. Nota Credito", "Cod. divisa");
                        SETRANGE("No. Nota Credito", recCabNC."No.");
                    END;
                    SETRANGE(Tienda, CodTienda);
                    IF FINDSET THEN
                        REPEAT
                            IF "Cod. divisa" = '' THEN
                                SETFILTER("Forma pago TPV", '<>EXIVA');
                            SETRANGE("Cod. divisa", "Cod. divisa");
                            SETRANGE("NCR regis. de compensacion", "NCR regis. de compensacion");  //+#70132
                            CALCFIELDS("Importe Total divisa");
                            // Primero registramos los pagos
                            IF ("Importe Total divisa" * Factor) > 0 THEN
                                RegistrarPagoDocumento(codPrmDoc, optTipoDoc, Tienda, "Cod. divisa", "Importe Total divisa", "Forma pago TPV", "NCR regis. de compensacion");  //+#70132

                            FINDLAST;
                            SETRANGE("Cod. divisa");
                            SETRANGE("Forma pago TPV");
                            SETRANGE("NCR regis. de compensacion");  //+#70132

                        UNTIL NEXT = 0;

                    IF FINDSET THEN
                        REPEAT
                            IF "Cod. divisa" = '' THEN
                                SETFILTER("Forma pago TPV", '<>EXIVA');
                            SETRANGE("Cod. divisa", "Cod. divisa");
                            SETRANGE("NCR regis. de compensacion", "NCR regis. de compensacion");  //+#70132
                            CALCFIELDS("Importe Total divisa");
                            // Si quedan reembolsos, se liquidan contra pagos pendientes.
                            IF ("Importe Total divisa" * Factor) < 0 THEN
                                RegistrarPagoDocumento(codPrmDoc, optTipoDoc, Tienda, "Cod. divisa", "Importe Total divisa", "Forma pago TPV", "NCR regis. de compensacion");  //+#70132

                            FINDLAST;
                            SETRANGE("Cod. divisa");
                            SETRANGE("Forma pago TPV");
                            SETRANGE("NCR regis. de compensacion");  //+#70132
                        UNTIL NEXT = 0;

                    IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
                        recCabFac."Liquidado TPV" := TRUE;
                        recCabFac.MODIFY(FALSE);
                    END
                    ELSE BEGIN
                        recCabNC."Liquidado TPV" := TRUE;
                        recCabNC.MODIFY(FALSE);
                    END;

                END;
            END;
        END
        ELSE BEGIN
            //+#308268
            //... De momento solo lo aplicamos a las facturas.....
            //...
            IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
                IF NOT recCabFac."Liquidado TPV" THEN BEGIN
                    recCabFac."Liquidado TPV" := TRUE;
                    recCabFac.MODIFY;
                END;
            END;
            //-#308268

        END;
    end;

    procedure RegistrarPagoDocumento(codPrmDoc: Code[20]; optTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; codTienda: Code[20]; codDivisa: Code[10]; decImporte: Decimal; CodFormaPago: Code[20]; pNCR: Code[20])
    var
        recCfgPOS: Record 55894;
        recBancosTienda: Record 55898;
        recLinDiaGen: Record 81;
        recLinDiaGen2: Record 81;
        recLinDiaGen3: Record 81;
        recCabFac: Record 112;
        recCabNC: Record 114;
        rTiendas: Record 55897;
        cduRegDia: Codeunit 12;
        intLinea: Integer;
        Text001: Label 'Liq. Factura TPV Doc. %1';
        Text002: Label 'Liq. Devolucion TPV Doc. %1';
        Text003: Label 'EXIVA Doc. %1 Exen: %2';
        SalesPersonCode: Code[10];
        CodCliente: Code[20];
        PostingDate: Date;
        NoFiscal: Code[40];
        ExtDocumentNo: Code[35];
        NoBorrador: Code[20];
        rPagosTPV: Record 55915;
        lwImporteEX: Decimal;
        recFormaPago: Record 55907;
        VatNo: Text[35];
        CustName: Text[80];
        lFormaPagoCompensacionNC: Boolean;
        lrFP: Record 55907;
        lrNCR: Record 114;
        TextL004: Label 'Liq. NCR %1';
    begin
        //+#65232
        // Sustituye a las funciones RegistrarPagoFactura y RegistrarPagoNotaCredito

        recCfgPOS.GET;
        recCfgPOS.TESTFIELD("Nombre libro diario");
        recCfgPOS.TESTFIELD("Nombre seccion diario");

        recBancosTienda.GET(codTienda, codDivisa);
        recBancosTienda.TESTFIELD("Cod. Banco");

        IF optTipoDoc = optTipoDoc::Invoice THEN BEGIN
            recCabFac.GET(codPrmDoc);
            CodCliente := recCabFac."Bill-to Customer No.";
            SalesPersonCode := recCabFac."Salesperson Code";
            PostingDate := recCabFac."Posting Date";
            NoFiscal := recCabFac."No. Fiscal TPV";
            ExtDocumentNo := recCabFac."External Document No.";
            NoBorrador := recCabFac."Pre-Assigned No.";
            VatNo := recCabFac."VAT Registration No."; //+#78451
            CustName := COPYSTR(recCabFac."Bill-to Name", 1, MAXSTRLEN(CustName)); //+#78451

        END
        ELSE BEGIN
            recCabNC.GET(codPrmDoc);
            CodCliente := recCabNC."Bill-to Customer No.";
            SalesPersonCode := recCabNC."Salesperson Code";
            PostingDate := recCabNC."Posting Date";
            NoFiscal := recCabNC."No. Fiscal TPV";
            ExtDocumentNo := recCabNC."External Document No.";
            NoBorrador := recCabNC."Pre-Assigned No.";
            VatNo := recCabNC."VAT Registration No."; //+#78451
            CustName := COPYSTR(recCabNC."Bill-to Name", 1, MAXSTRLEN(CustName)); //+#78451
        END;

        WITH recLinDiaGen DO BEGIN
            INIT;
            VALIDATE("Journal Template Name", recCfgPOS."Nombre libro diario");
            VALIDATE("Journal Batch Name", recCfgPOS."Nombre seccion diario");
            VALIDATE("Salespers./Purch. Code", SalesPersonCode);
            VALIDATE("Account Type", "Account Type"::Customer);
            VALIDATE("Account No.", CodCliente);
            VALIDATE("Posting Date", PostingDate);

            //+999 PLB
            //IF USERID = 'SANTILLANA-NAV\DYNASOFT' THEN
            //  VALIDATE("Posting Date",           WORKDATE);
            //-999 PLB

            IF decImporte > 0 THEN BEGIN
                IF optTipoDoc = optTipoDoc::Invoice THEN
                    VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice)
                ELSE
                    VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Refund);
                VALIDATE("Applies-to Doc. No.", codPrmDoc);
                VALIDATE("Document Type", "Document Type"::Payment);
            END
            ELSE BEGIN
                IF optTipoDoc = optTipoDoc::Invoice THEN
                    VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Payment)
                ELSE
                    VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::"Credit Memo");
                VALIDATE("Applies-to Doc. No.", codPrmDoc);
                VALIDATE("Document Type", "Document Type"::Refund);
            END;

            "Document No." := codPrmDoc;
            IF optTipoDoc = optTipoDoc::Invoice THEN
                Description := STRSUBSTNO(Text001, NoFiscal)
            ELSE
                Description := STRSUBSTNO(Text002, NoFiscal);

            //+#70132
            lFormaPagoCompensacionNC := FALSE;
            IF pNCR <> '' THEN
                IF lrNCR.GET(pNCR) THEN
                    IF lrFP.GET(CodFormaPago) THEN
                        IF lrFP."Tipo Compensacion NC" = lrFP."Tipo Compensacion NC"::Si THEN
                            lFormaPagoCompensacionNC := TRUE;
            //-#70132

            "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
            VALIDATE("Bal. Account No.", recBancosTienda."Cod. Banco");
            "External Document No." := ExtDocumentNo;
            VALIDATE("Currency Code", codDivisa);


            //Comprobamos si tiene exención de IVA
            IF codDivisa = '' THEN BEGIN
                rPagosTPV.RESET;
                rPagosTPV.SETRANGE("No. Borrador", NoBorrador);
                rPagosTPV.SETRANGE("Forma pago TPV", 'EXIVA');
                IF rPagosTPV.FINDFIRST THEN BEGIN
                    lwImporteEX := rPagosTPV."Importe (DL)";
                    recLinDiaGen2.TRANSFERFIELDS(recLinDiaGen);
                END;
            END;

            VALIDATE(Amount, -decImporte + lwImporteEX);
            cduRegDia.RunWithCheck(recLinDiaGen);

            //+#70132
            IF lFormaPagoCompensacionNC THEN BEGIN
                recLinDiaGen3.TRANSFERFIELDS(recLinDiaGen);
                recLinDiaGen3."Applies-to Doc. Type" := recLinDiaGen3."Applies-to Doc. Type"::"Credit Memo";
                recLinDiaGen3."Applies-to Doc. No." := lrNCR."No.";
                recLinDiaGen3.Description := STRSUBSTNO(TextL004, lrNCR."No.");
                recLinDiaGen3.VALIDATE(Amount, -recLinDiaGen.Amount);
                cduRegDia.RunWithCheck(recLinDiaGen3);
            END;
            //-#70132

            IF lwImporteEX <> 0 THEN BEGIN
                rTiendas.GET(codTienda);
                recLinDiaGen2.Description := STRSUBSTNO(Text003, NoFiscal, rPagosTPV."No. Documento Exencion");
                recLinDiaGen2."Bal. Account Type" := recLinDiaGen."Bal. Account Type"::"G/L Account";
                recLinDiaGen2.VALIDATE("Bal. Account No.", rTiendas."Cuenta Excencion IVA");
                recLinDiaGen2.VALIDATE(Amount, -lwImporteEX);
                cduRegDia.RunWithCheck(recLinDiaGen2);
            END;
        END;
    end;

    procedure TieneTransaccionCaja(var recTransCaja: Record 55917; CodTienda: Code[20]; NoRegistrado: Code[20]): Boolean
    begin
        WITH recTransCaja DO BEGIN
            RESET;
            SETCURRENTKEY("No. Registrado", "Cod. divisa");
            SETRANGE("No. Registrado", NoRegistrado);
            SETRANGE("Cod. tienda", CodTienda);
            //SETRANGE(TPV                , recCabFac.TPV);  // Comentar para posibles ventas en diferentes TPV's
            EXIT(NOT ISEMPTY);
        END;
    end;

    procedure LiquidaFacturaTPV_Obsoleto(codPrmDoc: Code[20])
    var
        recCabFac: Record 112;
        recPagosTPV: Record 55915;
        recTienda: Record 55897;
    begin
        //+#65232: Función obsoleta


    end;

    procedure RegistrarPagoFactura_Obsoleto(recPrmCabFac: Record 112; codTienda: Code[20]; codDivisa: Code[10]; decImporte: Decimal)
    var
        recCfgPOS: Record 55894;
        recBancosTienda: Record 55898;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        intLinea: Integer;
        Text001: Label 'Liq. Factura TPV Doc. %1';
        Text002: Label 'EXIVA Doc. %1 Exen: %2';
        rPagosTPV: Record 55915;
        lwImporteEX: Decimal;
    begin
        //+#65232: Función obsoleta

    end;

    procedure LiquidaNotaCreditoTPV_Obsoleto(codPrmDoc: Code[20])
    var
        recCabNC: Record 114;
        recPagosTPV: Record 55915;
    begin

    end;

    procedure RegistrarPagoNotaCredito_Obsoleto(recPrmCabNC: Record 114; recPrmPagoTPV: Record 55915)
    var
        recCfgPOS: Record 55894;
        recBancosTienda: Record 55898;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        intLinea: Integer;
        Text001: Label 'Liq. Devolucion TPV Doc. %1';
        Text002: Label 'EXIVA Doc. %1 Exen: %2';
        rPagosTPV: Record 55915;
        lwImporteEX: Decimal;
    begin

    end;

    procedure AnulaPagoFacturaTPV(codPrmFac: Code[20]; codPrmHNC: Code[20])
    var
        recCfgPOS: Record 55894;
        recCabNC: Record 114;
        recCabFac: Record 112;
        recPagosTPV: Record 55915;
        recBancosTienda: Record 55898;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        Text001: Label 'Liq. Nota Credito TPV Doc. %1';
    begin
        //Esta funció busca los pagos introducidos en la factura y liquida la nota de credito contra las mismas cuenta de banco.

        recCfgPOS.GET;
        recCabFac.GET(codPrmFac);
        recCabNC.GET(codPrmHNC);

        recPagosTPV.RESET;
        recPagosTPV.SETCURRENTKEY("No. Factura", "Cod. divisa");
        recPagosTPV.SETRANGE("No. Factura", recCabFac."No.");
        recPagosTPV.SETRANGE(Tienda, recCabFac.Tienda);
        recPagosTPV.SETRANGE(TPV, recCabFac.TPV);
        IF recPagosTPV.FINDSET THEN
            REPEAT
                recPagosTPV.SETRANGE("Cod. divisa", recPagosTPV."Cod. divisa");
                recPagosTPV.FINDLAST;
                recPagosTPV.CALCFIELDS("Importe Total divisa");
                IF recPagosTPV."Importe Total divisa" <> 0 THEN BEGIN
                    recBancosTienda.GET(recPagosTPV.Tienda, recPagosTPV."Cod. divisa");
                    recBancosTienda.TESTFIELD("Cod. Banco");
                    recLinDiaGen.INIT;
                    recLinDiaGen.VALIDATE("Journal Template Name", recCfgPOS."Nombre libro diario");
                    recLinDiaGen.VALIDATE("Journal Batch Name", recCfgPOS."Nombre seccion diario");
                    recLinDiaGen.VALIDATE("Account Type", recLinDiaGen."Account Type"::Customer);
                    recLinDiaGen.VALIDATE("Account No.", recCabFac."Sell-to Customer No.");
                    recLinDiaGen.VALIDATE("Posting Date", recCabFac."Posting Date");
                    recLinDiaGen.VALIDATE("Applies-to Doc. Type", recLinDiaGen."Applies-to Doc. Type"::"Credit Memo");
                    recLinDiaGen.VALIDATE("Applies-to Doc. No.", recCabNC."No.");
                    recLinDiaGen.VALIDATE("Document Type", recLinDiaGen."Document Type"::Payment);
                    recLinDiaGen."Document No." := recCabNC."No.";
                    recLinDiaGen.Description := STRSUBSTNO(Text001, recCabNC."No.");
                    recLinDiaGen."Bal. Account Type" := recLinDiaGen."Bal. Account Type"::"Bank Account";
                    recLinDiaGen.VALIDATE("Bal. Account No.", recBancosTienda."Cod. Banco");
                    recLinDiaGen."External Document No." := recCabFac."No.";
                    recLinDiaGen.VALIDATE("Salespers./Purch. Code", recCabFac."Salesperson Code");
                    recLinDiaGen.VALIDATE("Currency Code", recPagosTPV."Cod. divisa");
                    recLinDiaGen.VALIDATE(Amount, recPagosTPV."Importe Total divisa");
                    recLinDiaGen.VALIDATE("Dimension Set ID", GetDimensionSetIDMovCliente(codPrmHNC));
                    cduRegDia.RunWithCheck(recLinDiaGen);
                END;
            UNTIL recPagosTPV.NEXT = 0;
    end;

    procedure MovClientePendiente(codPrmCliente: Code[20]; optPrmTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; codPrmDoc: Code[20]): Boolean
    var
        recMovCliente: Record 21;
    begin

        recMovCliente.RESET;
        recMovCliente.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        recMovCliente.SETRANGE("Document Type", optPrmTipoDoc);
        recMovCliente.SETRANGE("Document No.", codPrmDoc);
        recMovCliente.SETRANGE("Customer No.", codPrmCliente);
        recMovCliente.SETRANGE(Open, TRUE);
        //EXIT(recMovCliente.FINDFIRST); //-65232
        EXIT(NOT recMovCliente.ISEMPTY); //+65232
    end;

    procedure Efectivo_Local(): Code[20]
    var
        rFpago: Record 55907;
    begin

        rFpago.RESET;
        rFpago.SETCURRENTKEY("Efectivo Local", "Cod. divisa");
        rFpago.SETRANGE("Efectivo Local", TRUE);
        rFpago.FINDFIRST;
        EXIT(rFpago."ID Pago");
    end;

    procedure GuardarVentaTPV(recPrmCabVta: Record 36; blnRegistroEnLinea: Boolean)
    var
        recPagosTPV: Record 55915;
        Text001: Label 'Liq. factura TPV Doc. %1';
        recVentaTPV: Record 55924;
        recCabFac: Record 112;
        decImporte: Decimal;
        decImporteIVA: Decimal;
        Devolucion: Boolean;
        recCabNC: Record 114;
    begin

        WITH recPrmCabVta DO BEGIN

            IF blnRegistroEnLinea THEN BEGIN

                CASE "Document Type" OF

                    "Document Type"::Invoice:
                        BEGIN

                            recCabFac.GET("Last Posting No.");
                            recCabFac.CALCFIELDS(Amount);
                            recCabFac.CALCFIELDS("Amount Including VAT");

                            decImporte := recCabFac.Amount;
                            decImporteIVA := recCabFac."Amount Including VAT";

                            recCabFac."Cod. Colegio" := recPrmCabVta."Cod. Colegio";
                            recCabFac."Nombre Colegio" := recPrmCabVta."Nombre Colegio";
                            recCabFac.MODIFY(FALSE);

                        END;

                    "Document Type"::"Credit Memo":
                        BEGIN

                            Devolucion := TRUE;
                            recCabNC.GET("Last Posting No.");
                            recCabNC.CALCFIELDS(Amount);
                            recCabNC.CALCFIELDS("Amount Including VAT");

                            decImporte := -recCabNC.Amount;
                            decImporteIVA := -recCabNC."Amount Including VAT";

                            recCabNC."Cod. Colegio" := recPrmCabVta."Cod. Colegio";
                            recCabNC."Nombre Colegio" := recPrmCabVta."Nombre Colegio";
                            recCabNC.MODIFY(FALSE);

                        END;
                END;

            END
            ELSE BEGIN

                CALCFIELDS(Amount);
                CALCFIELDS("Amount Including VAT");
                CASE "Document Type" OF
                    "Document Type"::Invoice:
                        BEGIN
                            decImporte := Amount;
                            decImporteIVA := "Amount Including VAT";
                        END;
                    "Document Type"::"Credit Memo":
                        BEGIN
                            Devolucion := TRUE;
                            decImporte := -Amount;
                            decImporteIVA := -"Amount Including VAT";
                        END;
                END;

            END;

            recVentaTPV.INIT;
            recVentaTPV."Cod. tienda" := Tienda;
            recVentaTPV."Cod. TPV" := TPV;
            recVentaTPV.Fecha := "Posting Date";
            recVentaTPV."Id. cajero" := "ID Cajero";
            recVentaTPV.Hora := FormatTime("Hora creacion");
            recVentaTPV."No. Borrador" := "No.";
            recVentaTPV.Importe := decImporte;
            recVentaTPV."Importe IVA inc." := decImporteIVA;

            IF NOT blnRegistroEnLinea THEN
                recVentaTPV."No. Registrado" := "Posting No."
            ELSE
                recVentaTPV."No. Registrado" := "Last Posting No.";

            recVentaTPV."Cod. cliente" := "Sell-to Customer No.";
            recVentaTPV."Nombre cliente" := "Sell-to Customer Name";

            IF NOT Devolucion THEN
                recVentaTPV."Tipo Transaccion" := recVentaTPV."Tipo Transaccion"::Venta
            ELSE
                recVentaTPV."Tipo Transaccion" := recVentaTPV."Tipo Transaccion"::Anulacion;

            recVentaTPV.INSERT(TRUE);

            recPagosTPV.RESET;
            recPagosTPV.SETRANGE("No. Borrador", "No.");
            IF recPagosTPV.FINDSET THEN
                REPEAT
                    IF NOT Devolucion THEN
                        InsertarTransaccionCaja(recVentaTPV, recPagosTPV, '')
                    ELSE BEGIN
                        recPagosTPV."Importe (DL)" := -recPagosTPV."Importe (DL)";
                        recPagosTPV.Importe := -recPagosTPV.Importe;
                        recPagosTPV.MODIFY(FALSE);
                        InsertarTransaccionCaja(recVentaTPV, recPagosTPV, recPrmCabVta."Posting No.");
                    END;
                UNTIL recPagosTPV.NEXT = 0;

        END;
    end;

    procedure GuardarAnulacionTPV(recPrmCabVta: Record 36; blnRegistroEnLinea: Boolean)
    var
        recCabAbo: Record 114;
        recPagosTPV: Record 55915;
        Text001: Label 'Liq. factura TPV Doc. %1';
        recVentaTPV: Record 55924;
        decImporte: Decimal;
        decImporteIVA: Decimal;
    begin

        WITH recPrmCabVta DO BEGIN

            IF blnRegistroEnLinea THEN BEGIN
                recCabAbo.GET("Last Posting No.");
                recCabAbo.CALCFIELDS(Amount);
                recCabAbo.CALCFIELDS("Amount Including VAT");
                decImporte := recCabAbo.Amount;
                decImporteIVA := recCabAbo."Amount Including VAT";
            END
            ELSE BEGIN
                CALCFIELDS(Amount);
                CALCFIELDS("Amount Including VAT");
                decImporte := Amount;
                decImporteIVA := "Amount Including VAT";
            END;

            recVentaTPV.INIT;
            recVentaTPV."Cod. tienda" := Tienda;
            recVentaTPV."Cod. TPV" := TPV;
            recVentaTPV.Fecha := WORKDATE;
            recVentaTPV."Id. cajero" := "ID Cajero";
            recVentaTPV.Hora := FormatTime(TIME);
            recVentaTPV."Tipo Transaccion" := recVentaTPV."Tipo Transaccion"::Anulacion;
            recVentaTPV."No. Borrador" := "No.";

            IF NOT blnRegistroEnLinea THEN
                recVentaTPV."No. Registrado" := "Posting No."
            ELSE
                recVentaTPV."No. Registrado" := "Last Posting No.";

            recVentaTPV."Cod. cliente" := "Sell-to Customer No.";
            recVentaTPV."Nombre cliente" := "Sell-to Customer Name";

            recVentaTPV.Importe := -decImporte;
            recVentaTPV."Importe IVA inc." := -decImporteIVA;
            recVentaTPV.INSERT(TRUE);

            recPagosTPV.RESET;
            recPagosTPV.SETRANGE("No. Borrador", "No.");
            IF recPagosTPV.FINDSET THEN
                REPEAT
                    IF NOT blnRegistroEnLinea THEN
                        InsertarTransaccionCaja(recVentaTPV, recPagosTPV, recPrmCabVta."Posting No.")
                    ELSE
                        InsertarTransaccionCaja(recVentaTPV, recPagosTPV, recPrmCabVta."Last Posting No.");
                UNTIL recPagosTPV.NEXT = 0;

        END;
    end;

    procedure InsertarTransaccionCaja(recPrmVentaTPV: Record 55924; recPrmPago: Record 55915; PrmNumReg: Code[20])
    var
        recTrans: Record 55917;
    begin

        WITH recPrmVentaTPV DO BEGIN

            recTrans.RESET;
            recTrans."Cod. tienda" := "Cod. tienda";
            recTrans."Cod. TPV" := "Cod. TPV";
            recTrans.Fecha := Fecha;

            CASE "Tipo Transaccion" OF
                "Tipo Transaccion"::Venta:
                    BEGIN
                        recTrans."Tipo transaccion" := recTrans."Tipo transaccion"::"Cobro TPV";
                        recTrans.Importe := recPrmPago.Importe;
                        recTrans."Importe (DL)" := recPrmPago."Importe (DL)";
                        recTrans."No. Registrado" := recPrmPago."No. Factura";
                    END;

                "Tipo Transaccion"::Anulacion:
                    BEGIN
                        recTrans."Tipo transaccion" := recTrans."Tipo transaccion"::Anulacion;
                        recTrans.Importe := recPrmPago.Importe;
                        recTrans."Importe (DL)" := recPrmPago."Importe (DL)";
                        IF PrmNumReg <> '' THEN
                            recTrans."No. Registrado" := PrmNumReg
                        ELSE
                            recTrans."No. Registrado" := recPrmPago."No. Nota Credito";
                    END;
            END;

            recTrans."Id. cajero" := "Id. cajero";
            recTrans.Hora := Hora;
            recTrans."Forma de pago" := recPrmPago."Forma pago TPV";
            recTrans."Cod. divisa" := recPrmPago."Cod. divisa";
            recTrans."Factor divisa" := recPrmPago."Factor divisa";
            recTrans.Cambio := recPrmPago.Cambio;
            recTrans."NCR regis. de compensacion" := recPrmPago."NCR regis. de compensacion"; //+#70132

            recTrans.INSERT(TRUE);

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

    procedure RegistroEnLinea(codPrmTienda: Code[20]): Boolean
    var
        recTienda: Record 55897;
    begin
        recTienda.GET(codPrmTienda);
        EXIT(recTienda."Registro En Linea");
    end;

    procedure TraspasarVtaADevolucion(codPrmTienda: Code[20]; codPrmDoc: Code[20]; codPrmDev: Code[20])
    var
        recLinFac: Record 113;
        recLinPed: Record 37;
        recLinDev: Record 37;
    begin

        IF RegistroEnLinea(codPrmTienda) THEN BEGIN
            recLinFac.RESET;
            recLinFac.SETRANGE("Document No.", codPrmDoc);
            IF recLinFac.FINDSET THEN
                REPEAT
                    recLinDev.INIT;
                    recLinDev."Document Type" := recLinDev."Document Type"::"Credit Memo";
                    recLinDev."Document No." := codPrmDev;
                    recLinDev."Line No." := recLinFac."Line No.";
                    recLinDev.VALIDATE(Type, recLinFac.Type);
                    recLinDev.VALIDATE("No.", recLinFac."No.");
                    recLinDev.VALIDATE("Unit of Measure Code", recLinFac."Unit of Measure Code");
                    recLinDev.VALIDATE(Quantity, recLinFac.Quantity);
                    recLinDev.VALIDATE("Location Code", recLinFac."Location Code");
                    recLinDev.INSERT(TRUE);
                UNTIL recLinFac.NEXT = 0;
        END
        ELSE BEGIN
            recLinPed.RESET;
            recLinPed.SETRANGE("Document Type", recLinPed."Document Type"::Invoice);
            recLinPed.SETRANGE("Document No.", codPrmDoc);
            IF recLinPed.FINDSET THEN
                REPEAT
                    recLinDev.INIT;
                    recLinDev."Document Type" := recLinDev."Document Type"::"Credit Memo";
                    recLinDev."Document No." := codPrmDev;
                    recLinDev."Line No." := recLinPed."Line No.";
                    recLinDev.VALIDATE(Type, recLinPed.Type);
                    recLinDev.VALIDATE("No.", recLinPed."No.");
                    recLinDev.VALIDATE("Unit of Measure Code", recLinPed."Unit of Measure Code");
                    recLinDev.VALIDATE(Quantity, recLinPed.Quantity);
                    recLinDev.VALIDATE("Location Code", recLinPed."Location Code");
                    recLinDev.INSERT(TRUE);
                UNTIL recLinFac.NEXT = 0;
        END;
    end;

    procedure ActualizarDivisas(pTienda: Code[20]; pTPV: Code[20]): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        rConf: Record 55895;
        rBotones: Record 55905;
        rFPago: Record 55907;
        rDivPos: Record 55925;
        rTC: Record 330;
        rDiv: Record 4;
        text001: Label 'TIPO CAMBIO NO DEFINIDO';
        Error001: Label 'No se han definido formas de pago para el menú %1';
    begin

        rConf.RESET;
        rConf.GET(pTienda, pTPV);

        rDivPos.RESET;
        rDivPos.SETRANGE(Tienda, pTienda);
        rDivPos.SETRANGE(TPV, pTPV);
        IF rDivPos.FINDSET THEN
            rDivPos.DELETEALL(FALSE);

        Evento.TipoEvento := 14;

        rBotones.RESET;
        rBotones.SETRANGE("ID Menu", rConf."Menu de Formas de Pago");
        rBotones.SETFILTER(Pago, '<>%1', '');
        IF rBotones.FINDSET THEN BEGIN
            REPEAT
                rFPago.RESET;
                rFPago.GET(rBotones.Pago);
                IF rFPago."Cod. divisa" <> '' THEN BEGIN
                    rTC.RESET;
                    rTC.SETRANGE("Currency Code", rFPago."Cod. divisa");
                    rTC.SETRANGE("Starting Date", 0D, WORKDATE);
                    IF rTC.FINDLAST THEN BEGIN
                        WITH rDivPos DO BEGIN
                            Tienda := pTienda;
                            TPV := pTPV;
                            Divisa := rFPago."Cod. divisa";
                            rDiv.GET(rFPago."Cod. divisa");
                            Descripcion := rDiv.Description;
                            "Tipo Cambio" := rTC."Relational Exch. Rate Amount";
                            "Fecha Valor" := rTC."Starting Date";
                            INSERT(FALSE);
                        END;
                    END
                    ELSE BEGIN
                        WITH rDivPos DO BEGIN
                            Tienda := pTienda;
                            TPV := pTPV;
                            Divisa := rFPago."Cod. divisa";
                            Descripcion := text001;
                            INSERT(FALSE);
                        END;
                    END;
                END;
            UNTIL rBotones.NEXT = 0;
            Evento.AccionRespuesta := 'OK';
        END
        ELSE BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Error001, rConf."Menu de Formas de Pago");
        END;

        EXIT(Evento.aXml());
    end;

    procedure RelacionaDevolucion(var pSalesHeader: Record 36)
    var
        rCabHistFac: Record 112;
        rLinHistFac: Record 113;
        rLinFac: Record 37;
        rLin: Record 37;
        OnLine: Boolean;
        rCab: Record 36;
        wDoc: Code[20];
        TodoDevuelto: Boolean;
    begin

        OnLine := RegistroEnLinea(pSalesHeader.Tienda);

        WITH rLin DO BEGIN
            SETCURRENTKEY(Devuelto, "Devuelve a Documento");
            SETRANGE("Document No.", pSalesHeader."No.");
            SETRANGE("Document Type", pSalesHeader."Document Type");
            SETFILTER("Devuelve a Documento", '<>%1', '');
            IF FINDSET THEN BEGIN
                wDoc := rLin."Devuelve a Documento";
                pSalesHeader."Anula a Documento" := wDoc;
                REPEAT
                    IF OnLine THEN BEGIN
                        rLinHistFac.RESET;
                        rLinHistFac.GET("Devuelve a Documento", "Devuelve a Linea Documento");
                        rLinHistFac."Devuelto en Documento" := "Devuelve a Documento";
                        rLinHistFac."Devuelto en Linea Documento" := "Devuelve a Linea Documento";
                        rLinHistFac.Devuelto := TRUE;
                        rLinHistFac.MODIFY(FALSE);
                    END
                    ELSE BEGIN
                        rCab.RESET;
                        rCab.SETCURRENTKEY("Posting No.");
                        rCab.SETRANGE("Posting No.", rLin."Devuelve a Documento");
                        rCab.FINDSET;
                        rLinFac.RESET;
                        rLinFac.GET(rLinFac."Document Type"::Invoice, rCab."No.", "Devuelve a Linea Documento");
                        rLinFac."Devuelto en Documento" := pSalesHeader."Posting No.";
                        rLinFac."Devuelto en Linea Documento" := "Devuelve a Linea Documento";
                        rLinFac.Devuelto := TRUE;
                        rLinFac.MODIFY(FALSE);
                    END;
                UNTIL rLin.NEXT = 0;

                TodoDevuelto := TRUE;
                IF OnLine THEN BEGIN
                    rLinHistFac.RESET;
                    rLinHistFac.SETRANGE("Document No.", wDoc);
                    IF rLinHistFac.FINDSET THEN
                        REPEAT
                            TodoDevuelto := rLinHistFac.Devuelto
                        UNTIL (rLinHistFac.NEXT = 0) OR NOT (TodoDevuelto);
                    IF TodoDevuelto THEN BEGIN
                        rCabHistFac.GET(wDoc);
                        rCabHistFac."Anulado TPV" := TRUE;
                        //      rCabHistFac."Anulado por Documento" := pSalesHeader."Posting No.";
                        rCabHistFac.MODIFY(FALSE);
                    END;
                END
                ELSE BEGIN
                    rLinFac.RESET;
                    rLinFac.SETRANGE("Document Type", rLinFac."Document Type"::Invoice);
                    rLinFac.SETRANGE("Document No.", rCab."No.");
                    IF rLinFac.FINDSET THEN
                        REPEAT
                            TodoDevuelto := rLinFac.Devuelto
                        UNTIL (rLinFac.NEXT = 0) OR NOT (TodoDevuelto);
                    IF TodoDevuelto THEN BEGIN
                        rCab."Anulado TPV" := TRUE;
                        //      rCab."Anulado por Documento" := pSalesHeader."Posting No.";
                        rCab.MODIFY(FALSE);
                    END;
                END;
            END;
        END;
    end;

    procedure ComprobarCambioCliente(var pSalesH: Record 36; NuevoClie: Code[20])
    var
        Cust: Record 18;
        UserSetupMngt: Codeunit 418;
        GLSetup: Record 98;
        SalesLine: Record 37;
    begin

        IF ((NuevoClie <> pSalesH."Sell-to Customer No.") AND
          (NuevoClie <> '')) THEN
            IF Cust.GET(NuevoClie) THEN
                WITH pSalesH DO BEGIN
                    pSalesH."Sell-to Customer No." := NuevoClie;
                    "Sell-to Customer Name" := COPYSTR(Cust.Name, 1, MAXSTRLEN("Sell-to Customer Name"));
                    "Sell-to Customer Name 2" := COPYSTR(Cust."Name 2", 1, MAXSTRLEN("Sell-to Customer Name 2"));
                    "Sell-to Address" := COPYSTR(Cust.Address, 1, MAXSTRLEN("Sell-to Address"));
                    "Sell-to Address 2" := COPYSTR(Cust."Address 2", 1, MAXSTRLEN("Sell-to Address 2"));
                    "Sell-to City" := Cust.City;
                    "Sell-to Post Code" := Cust."Post Code";
                    "Sell-to County" := Cust.County;
                    "Sell-to Country/Region Code" := Cust."Country/Region Code";
                    "Sell-to Contact" := Cust.Contact;
                    "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                    "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                    "Tax Area Code" := Cust."Tax Area Code";
                    "Tax Liable" := Cust."Tax Liable";
                    "Tax Exemption No." := Cust."Tax Exemption No.";
                    "VAT Registration No." := Cust."VAT Registration No.";
                    "VAT Country/Region Code" := Cust."Country/Region Code";
                    "Shipping Advice" := Cust."Shipping Advice";
                    "Salesperson Code" := Cust."Salesperson Code";
                    "Responsibility Center" := '';
                    "Ship-to Code" := '';

                    VentaaCliente(pSalesH, Cust."No.");

                    Cust.GET("Bill-to Customer No.");
                    IF (Cust."Bill-to Customer No." <> '') AND
                       (Cust."Bill-to Customer No." <> Cust."No.") THEN
                        VentaaCliente(pSalesH, Cust."No.");

                    SalesLine.SETRANGE("Document Type", "Document Type"::Invoice);
                    SalesLine.SETRANGE("Document No.", "No.");
                    IF SalesLine.FINDSET THEN BEGIN
                        SalesLine.MODIFYALL("Sell-to Customer No.", "Sell-to Customer No.", FALSE);
                        SalesLine.MODIFYALL("Bill-to Customer No.", "Bill-to Customer No.", FALSE);
                    END;
                END;


        // Colegio
    end;

    procedure VentaaCliente(var pSalesH: Record 36; Cliente: Code[20])
    var
        GLsetup: Record 98;
        Cust: Record 18;
        cfComunes: Codeunit 55897;
    begin

        Cust.GET(pSalesH."Sell-to Customer No.");
        WITH pSalesH DO BEGIN
            "Bill-to Customer No." := Cust."Bill-to Customer No.";
            "Bill-to Name" := COPYSTR(Cust.Name, 1, MAXSTRLEN("Bill-to Name"));
            "Bill-to Name 2" := COPYSTR(Cust."Name 2", 1, MAXSTRLEN("Bill-to Name 2"));
            "Bill-to Address" := COPYSTR(Cust.Address, 1, MAXSTRLEN("Bill-to Address"));
            "Bill-to Address 2" := COPYSTR(Cust."Address 2", 1, MAXSTRLEN("Bill-to Address 2"));
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to County" := Cust.County;
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            "Payment Method Code" := Cust."Payment Method Code";

            GLsetup.GET;
            IF GLsetup."Bill-to/Sell-to VAT Calc." = GLsetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN BEGIN
                "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                "VAT Country/Region Code" := Cust."Country/Region Code";
                "VAT Registration No." := Cust."VAT Registration No.";
                "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
            END;

            "Customer Posting Group" := Cust."Customer Posting Group";
            "Currency Code" := Cust."Currency Code";
            "Customer Price Group" := Cust."Customer Price Group";
            "Prices Including VAT" := Cust."Prices Including VAT";
            "Allow Line Disc." := Cust."Allow Line Disc.";
            "Invoice Disc. Code" := Cust."Invoice Disc. Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Language Code" := Cust."Language Code";
            "Salesperson Code" := Cust."Salesperson Code";
            "Combine Shipments" := Cust."Combine Shipments";
            Reserve := Cust.Reserve;

            IF cfComunes.RegistroEnLinea(pSalesH.Tienda) THEN BEGIN

                pSalesH.SetHideValidationDialog(TRUE);

                VALIDATE("Payment Terms Code");
                VALIDATE("Prepmt. Payment Terms Code");
                VALIDATE("Payment Method Code");
                VALIDATE("Currency Code");
                VALIDATE("Prepayment %");

                CreateSalesHeaderDimensions(pSalesH);
            END;
        END;
    end;

    local procedure CreateSalesHeaderDimensions(var SalesHeader: Record "Sales Header")
    var
        DefaultDimSources: List of [Dictionary of [Integer, Code[20]]];
        DefaultDimSource: Dictionary of [Integer, Code[20]];
    begin
        if SalesHeader."Bill-to Customer No." <> '' then begin
            Clear(DefaultDimSource);
            DefaultDimSource.Add(Database::Customer, SalesHeader."Bill-to Customer No.");
            DefaultDimSources.Add(DefaultDimSource);
        end;

        if SalesHeader."Salesperson Code" <> '' then begin
            Clear(DefaultDimSource);
            DefaultDimSource.Add(Database::"Salesperson/Purchaser", SalesHeader."Salesperson Code");
            DefaultDimSources.Add(DefaultDimSource);
        end;

        if SalesHeader."Campaign No." <> '' then begin
            Clear(DefaultDimSource);
            DefaultDimSource.Add(Database::Campaign, SalesHeader."Campaign No.");
            DefaultDimSources.Add(DefaultDimSource);
        end;

        if SalesHeader."Responsibility Center" <> '' then begin
            Clear(DefaultDimSource);
            DefaultDimSource.Add(Database::"Responsibility Center", SalesHeader."Responsibility Center");
            DefaultDimSources.Add(DefaultDimSource);
        end;

        SalesHeader.CreateDim(DefaultDimSources);
    end;

    procedure RelacionaAnulacion(var pSalesH: Record 36; CodTienda: Code[20])
    begin

        cCostaRica.RelacionaAnulacion(pSalesH, CodTienda); // Costa Rica / #148807

        IF pSalesH.MODIFY THEN;
    end;

    procedure DeconfiguraAnulaciones(var rec: Record 55897)
    var
        rTPV: Record 55895;
        Text001: Label 'Se va a proceder a desconfigurar de la tienda y todas sus POS asignadas la configuración de notas de Credito.\ Continuar?';
        rTienda: Record 55897;
    begin

        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;

        WITH rTPV DO BEGIN
            RESET;
            SETRANGE(Tienda, rec."Cod. Tienda");
            IF FINDFIRST THEN
                REPEAT
                    CLEAR("NCF Credito fiscal NCR");

                    //+#116527
                    CLEAR("NCF Credito fiscal NCR resg.");
                    //-#116527

                    CLEAR("No. serie notas credito");
                    CLEAR("No. serie notas credito reg.");
                    MODIFY(FALSE);
                UNTIL rTPV.NEXT = 0;
        END;

        WITH rec DO BEGIN
            "ID Reporte nota credito" := 0;
            "Cantidad copias nota credito" := 0;
            MODIFY(FALSE);
        END;
    end;

    procedure PermiteAnulaciones(pTienda: Code[20]): Boolean
    var
        rTienda: Record 55897;
    begin

        rTienda.GET(pTienda);
        EXIT(rTienda."Permite Anulaciones en POS");
    end;

    procedure EsCentral(): Boolean
    var
        recTPV: Record 55895;
        cduPOS: Codeunit 55896;
    begin

        recTPV.RESET;
        recTPV.SETCURRENTKEY("Usuario windows");
        recTPV.SETRANGE("Usuario windows", cduPOS.TraerUsuarioWindows);
        EXIT(NOT (recTPV.FINDFIRST));
    end;

    procedure ValidaIDCliente(ID: Code[20]; TipoID: Integer): Text
    var
        Mensaje: Text;
        Evento: Record "DsPOS Event Buffer" temporary;
    begin

        Evento.TipoEvento := 18;


        IF Mensaje <> '' THEN BEGIN
            Evento.TextoRespuesta := Mensaje;
            Evento.AccionRespuesta := 'ERROR';
        END
        ELSE
            Evento.AccionRespuesta := 'OK';

        EXIT(Evento.aXml());
    end;

    procedure Devolver_Datos_Localizados(pEvento: Record "DsPOS Event Buffer" temporary): Text
    begin

        EXIT(DevolverSiguienteNum(pEvento.TextoDato, pEvento.TextoDato2, pEvento.TextoDato6, pEvento.IntDato2));
    end;

    procedure Devolver_NCF(prTrans: Record 55924): Code[40]
    var
        rSalesInvH: Record 112;
        rSalesCrH: Record 114;
        rSalesH: Record 36;
    begin

        rSalesH.RESET;
        rSalesH.SETRANGE("No.", prTrans."No. Borrador");
        IF rSalesH.FINDFIRST THEN
            EXIT(rSalesH."No. Fiscal TPV")
        ELSE
            CASE prTrans."Tipo Transaccion" OF
                prTrans."Tipo Transaccion"::Venta:
                    BEGIN
                        IF rSalesInvH.GET(prTrans."No. Registrado") THEN
                            EXIT(rSalesInvH."No. Fiscal TPV")
                    END;
                prTrans."Tipo Transaccion"::Anulacion,
                prTrans."Tipo Transaccion"::Abono:
                    BEGIN
                        IF rSalesCrH.GET(prTrans."No. Registrado") THEN
                            EXIT(rSalesCrH."No. Fiscal TPV");
                    END;
            END;
    end;

    procedure Devolver_NCF_TransCaja(prTrans: Record 55917): Code[40]
    var
        rSalesInvH: Record 112;
        rSalesCrH: Record 114;
        rSalesH: Record 36;
    begin

        rSalesH.RESET;
        rSalesH.SETCURRENTKEY("Posting No.");
        rSalesH.SETRANGE("Posting No.", prTrans."No. Registrado");
        IF rSalesH.FINDFIRST THEN
            EXIT(rSalesH."No. Comprobante Fiscal")
        ELSE
            CASE prTrans."Tipo transaccion" OF
                prTrans."Tipo transaccion"::"Cobro TPV":
                    BEGIN
                        IF rSalesInvH.GET(prTrans."No. Registrado") THEN
                            EXIT(rSalesInvH."No. Comprobante Fiscal")
                    END;
                prTrans."Tipo transaccion"::Anulacion:
                    BEGIN
                        IF rSalesCrH.GET(prTrans."No. Registrado") THEN
                            EXIT(rSalesCrH."No. Comprobante Fiscal");
                    END;
            END;
    end;

    procedure Desaparcar_Pedido(p_NumVenta: Code[20]): Text
    var
        rCabFac: Record 36;
        Evento: Record "DsPOS Event Buffer" temporary;
        Error001: Label 'El pedido aparcado nº %1 se ha recuperado correctamente.';
        Error002: Label 'El pedido aparcado nº %1 no se ha encontrado en la tabla Sales Header';
    begin

        rCabFac.RESET;

        IF rCabFac.GET(rCabFac."Document Type"::Invoice, p_NumVenta) THEN BEGIN
            rCabFac.Aparcado := FALSE;
            rCabFac.MODIFY(FALSE);
            Evento.AccionRespuesta := 'Actualizar_Todo';
            Evento.TextoRespuesta := STRSUBSTNO(Error001, p_NumVenta);
            // Actualizar Totales
            Actualizar_Totales(p_NumVenta, Evento, FALSE, FALSE);
        END
        ELSE BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Error002, p_NumVenta);
        END;

        EXIT(Evento.aXml());
    end;

    procedure AnulaA_AnuladoPor(prTrans: Record 55924): Code[40]
    var
        prTrans2: Record 55924;
        rSalesInvH: Record 112;
        rSalesH: Record 36;
        rSalesCrH: Record 114;
        wDoc: Text;
        LF: Char;
        CR: Char;
        vueltas: Integer;
    begin

        LF := 10;
        CR := 13;
        wDoc := '';

        rSalesH.RESET;
        rSalesH.SETRANGE("No.", prTrans."No. Borrador");
        IF rSalesH.FINDFIRST THEN BEGIN

            CASE prTrans."Tipo Transaccion" OF
                prTrans."Tipo Transaccion"::Venta:
                    BEGIN

                        rSalesH.RESET;
                        rSalesH.SETCURRENTKEY("Document Type", "Posting Date", "Anula a Documento");
                        rSalesH.SETRANGE("Document Type", rSalesH."Document Type"::"Credit Memo");
                        rSalesH.SETRANGE("Anula a Documento", prTrans."No. Registrado");

                        IF rSalesH.FINDSET THEN BEGIN
                            REPEAT
                                wDoc += rSalesH."No. Fiscal TPV";
                                vueltas += 1;
                                IF vueltas < rSalesH.COUNT THEN
                                    wDoc += FORMAT(CR, 0, '<CHAR>') + FORMAT(LF, 0, '<CHAR>');
                            UNTIL rSalesH.NEXT = 0;
                            EXIT(wDoc);
                        END;

                    END;

                prTrans."Tipo Transaccion"::Anulacion,
                prTrans."Tipo Transaccion"::Abono:
                    BEGIN
                        prTrans2.RESET;
                        prTrans2.SETCURRENTKEY("No. Registrado");
                        prTrans2.SETRANGE("No. Registrado", rSalesH."Anula a Documento");
                        IF prTrans2.FINDFIRST THEN
                            EXIT(Devolver_NCF(prTrans2));
                    END;
            END;

        END
        ELSE BEGIN

            CASE prTrans."Tipo Transaccion" OF
                prTrans."Tipo Transaccion"::Venta:
                    BEGIN

                        rSalesCrH.RESET;
                        rSalesCrH.SETCURRENTKEY("Posting Date", "Anula a Documento");
                        rSalesCrH.SETRANGE("Anula a Documento", prTrans."No. Registrado");

                        IF rSalesCrH.FINDSET THEN BEGIN
                            REPEAT
                                wDoc += rSalesCrH."No. Fiscal TPV";
                                vueltas += 1;
                                IF vueltas < rSalesCrH.COUNT THEN
                                    wDoc += FORMAT(CR, 0, '<CHAR>') + FORMAT(LF, 0, '<CHAR>');
                            UNTIL rSalesCrH.NEXT = 0;
                            EXIT(wDoc);
                        END;
                    END;

                prTrans."Tipo Transaccion"::Anulacion,
                prTrans."Tipo Transaccion"::Abono:
                    BEGIN

                        rSalesCrH.RESET;
                        rSalesCrH.GET(prTrans."No. Registrado");

                        prTrans2.RESET;
                        prTrans2.SETCURRENTKEY("No. Registrado");
                        prTrans2.SETRANGE("No. Registrado", rSalesCrH."Anula a Documento");
                        IF prTrans2.FINDFIRST THEN
                            EXIT(Devolver_NCF(prTrans2));
                    END;

            END;

        END;
    end;

    procedure DevolverSiguienteNum(pTienda: Code[20]; pTPV: Code[20]; pSerie: Text; pAnul: Integer): Text
    var
        Evento: Record "DsPOS Event Buffer" temporary;
        NoSeriesManagement: Codeunit Microsoft.Foundation.NoSeries."No. Series";
        text001: Label 'NCF Actualizado CORRECTAMENTE';
        rConfTPV: Record 55895;
        Serie: Code[20];
    begin

        COMMIT;
        Evento.TipoEvento := 20;

        IF pSerie = '' THEN BEGIN
            rConfTPV.GET(pTienda, pTPV);
            IF pAnul > 0 THEN
                //+#116527
                //Serie := rConfTPV."NCF Credito fiscal NCR"
                Serie := ObtenerSerieFiscal(rConfTPV, 1)
            //-#116527

            ELSE
                //+#116527
                //Serie := rConfTPV."NCF Credito fiscal";
                Serie := ObtenerSerieFiscal(rConfTPV, 0);
            //-#116527
        END
        ELSE
            Serie := pSerie;

        Evento.TextoDato := NoSeriesManagement.GetNextNo(Serie, WORKDATE, FALSE);
        Evento.TextoDato2 := Serie;

        Evento.TextoRespuesta := text001;
        Evento.AccionRespuesta := 'OK';
        EXIT(Evento.aXml())
    end;

    procedure Linea_LocalizadaOFF(var prOrigen: Record 37; var prDestino: Record 37)
    begin

        cCostaRica.Linea_LocalizadaOFF(prOrigen, prDestino);
    end;

    procedure Actualiza_Venta_Contacto(par_Doc: Code[20]; par_Contacto: Code[20]): Text
    var
        rSalesH: Record 36;
        rSalesLin: Record 37;
        rContact: Record 5050;
        Evento: Record "DsPOS Event Buffer" temporary;
        Error001: Label 'No existe el Colegio %1';
        Text001: Label 'Colegio Actualizado Correctamente';
        rTienda: Record 55897;
        Location: Code[10];
        dto: Decimal;
        rTPV: Record 55895;
        lNumLog: Integer;
        lrAuxTienda: Record 55897;
        lrVentas: Record 36;
        lTienda: Code[20];
        lTPV: Code[20];
    begin

        //+144756
        //... Obtenemos el valor más apropiado de la tienda y .... registramos el LOG.
        lTienda := '';
        lTPV := 'XXX';

        lrVentas.RESET;
        lrVentas.SETCURRENTKEY("No.", "Document Type");
        lrVentas.SETRANGE("No.", par_Doc);
        IF lrVentas.FINDFIRST THEN BEGIN
            lTienda := lrVentas.Tienda;
            lTPV := lrVentas.TPV;
        END
        ELSE BEGIN
            IF lTienda = '' THEN
                IF lrAuxTienda.FINDFIRST THEN
                    lTienda := lrAuxTienda."Cod. Tienda";
        END;

        lNumLog := IniciarLog(6, lTienda, lTPV);
        //-144756

        Evento.TipoEvento := 23;

        Evento.AccionRespuesta := 'OK';
        EXIT(Evento.aXml());

        //+#144756
        ModificarDatosLog(lNumLog, 2, lrVentas."Document Type", par_Doc, lrVentas."Posting No.", lrVentas."No. Fiscal TPV", lrVentas."No. Comprobante Fiscal", par_Contacto);
        //-#144756

        rSalesH.RESET;
        IF NOT rSalesH.GET(rSalesH."Document Type"::Invoice, par_Doc) THEN BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(Error001, par_Contacto);
            EXIT(Evento.aXml());
        END;

        //+#144756
        ModificarDatosLog(lNumLog, 3, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", par_Contacto);
        //-#144756

        rTienda.GET(rSalesH.Tienda);
        rTPV.GET(rSalesH.Tienda, rSalesH.TPV);

        //+#175576
        //IF rTPV."Venta Movil" THEN BEGIN
        IF rTPV."Venta Movil" OR (rTPV."Precio por contacto" = rTPV."Precio por contacto"::"En todos los casos") THEN BEGIN
            //-#1775576
            //+#144756
            ModificarDatosLog(lNumLog, 4, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", par_Contacto);
            //-#144756

            IF par_Contacto <> '' THEN BEGIN
                rContact.RESET;
                IF NOT rContact.GET(par_Contacto) THEN BEGIN
                    Evento.AccionRespuesta := 'OK';
                    EXIT(Evento.aXml());
                END
                ELSE
                    IF rContact."Cod. Almacen" <> '' THEN
                        Location := rContact."Cod. Almacen"
                    ELSE
                        Location := rTienda."Cod. Almacen";
            END
            ELSE
                Location := rTienda."Cod. Almacen";

            //+#144756
            ModificarDatosLog(lNumLog, 5, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", par_Contacto + ': ' + Location);
            //-#144756

            rSalesH.SetHideValidationDialog(TRUE);

            //+#175576
            //rSalesH.VALIDATE("Location Code"       , Location);
            IF rTPV."Venta Movil" THEN
                rSalesH.VALIDATE("Location Code", Location);
            //-#175576

            rSalesH.VALIDATE("Location Code", Location);
            rSalesH.VALIDATE("Sell-to Contact No.", par_Contacto);
            rSalesH.VALIDATE("Bill-to Contact No.", par_Contacto);
            rSalesH.VALIDATE("Cod. Colegio", par_Contacto);
            rSalesH.MODIFY(FALSE);

            rSalesLin.RESET;
            rSalesLin.SETRANGE("Document Type", rSalesH."Document Type");
            rSalesLin.SETRANGE("Document No.", rSalesH."No.");
            IF rSalesLin.FINDFIRST THEN BEGIN
                rSalesLin.SetHideValidationDialog(TRUE);
                REPEAT
                    //+#175576
                    //rSalesLinVALIDATE("Location Code"       , Location);
                    IF rTPV."Venta Movil" THEN
                        rSalesLin.VALIDATE("Location Code", Location);
                    //-#175576

                    rSalesLin.VALIDATE("Location Code", Location);
                    rSalesLin.VALIDATE("Cod. Colegio", rSalesH."Cod. Colegio"); //+#144756
                    dto := rSalesLin."Line Discount %";
                    rSalesLin.VALIDATE(Quantity);
                    rSalesLin.VALIDATE("Line Discount %", dto);
                    rSalesLin.MODIFY(FALSE);
                UNTIL rSalesLin.NEXT = 0;
            END;

            Evento.AccionRespuesta := 'Actualizar_Todo';
            IF par_Contacto <> '' THEN
                Evento.TextoRespuesta := Text001;

            Actualizar_Totales(rSalesH."No.", Evento, FALSE, (rSalesH."Document Type" = rSalesH."Document Type"::"Credit Memo"));

            //+#144756
            ModificarDatosLog(lNumLog, 6, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", par_Contacto + ': ' + Location);
            //-#144756

            EXIT(Evento.aXml());

        END
        ELSE BEGIN
            //+#144756
            ModificarDatosLog(lNumLog, 7, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV", rSalesH."No. Comprobante Fiscal", par_Contacto + ': ' + Location);
            //-#144756

            Evento.AccionRespuesta := 'OK';
            Actualizar_Totales(rSalesH."No.", Evento, FALSE, (rSalesH."Document Type" = rSalesH."Document Type"::"Credit Memo"));
            EXIT(Evento.aXml());
        END;
    end;

    procedure ControlDeAcceso(pTienda: Code[20]; pBloquear: Boolean)
    var
        lrMySession: Record 2000000110;
        lrTienda: Record 55897;
        lNumVeces: Integer;
        lContador: Integer;
        lIDSesionActual: Integer;
    begin
        //+90735
        lrMySession.RESET;
        lrMySession.SETRANGE("User ID", USERID);
        IF NOT lrMySession.FINDFIRST THEN
            EXIT;

        IF pBloquear THEN BEGIN
            lrTienda.RESET;
            lrTienda.GET(pTienda);
            //... Revisamos si alguién está teoricamente realizando una transacción potencialmente conflictiva.
            //... En ese caso, esperamos un poco ... y volvemos a intentar hasta 5 veces, cada 2 segundos.
            //... Conviene no penalizar demasiado la transacción actual, no sea que sea sólo una falsa alarma.
            //... De todas formas, damos hasta 10 segundos para que finalice la transacción que presuntamente está operando.
            lContador := 1;
            lNumVeces := 7;
            lIDSesionActual := lrTienda."ID Sesion";
            WHILE (lrTienda."ID Sesion" <> 0) AND (lrTienda."ID Sesion" <> lrMySession."Session ID") AND (lContador <= lNumVeces) DO BEGIN
                SLEEP(2000);
                lrTienda.GET(pTienda);
                //... Revisamos si una 3era sesion ha cogido el control. En este caso, ampliamos el tiempo.
                IF (lrTienda."ID Sesion" <> 0) AND (lIDSesionActual <> lrTienda."ID Sesion") THEN BEGIN
                    lIDSesionActual := lrTienda."ID Sesion";
                    lContador := 1;
                END
                ELSE
                    lContador := lContador + 1;
            END;

            //... Vamos a registrar que vamos a realizar la transacción, o notificamos que ya hemos acabado, según el valor del parámetro pBloquear
            lrTienda.RESET;
            lrTienda.LOCKTABLE;
            lrTienda.GET(pTienda);
            lrTienda."ID Sesion" := lrMySession."Session ID";
            lrTienda.MODIFY;
        END
        ELSE BEGIN
            //... Se supone que tenemos el bloqueo, pero si por lo que sea no fuera así y
            //... otra transacción ha alterado el valor de "ID Sesion", no hacemos nada.
            lrTienda.RESET;
            lrTienda.LOCKTABLE;
            lrTienda.GET(pTienda);
            IF lrTienda."ID Sesion" = lrMySession."Session ID" THEN BEGIN
                lrTienda."ID Sesion" := 0;
                lrTienda.MODIFY;
            END;
        END;
    end;

    procedure IniciarLog(pProceso: Option Registrar,"Nueva Venta","Anular Factura"; pTienda: Code[20]; pTPV: Code[20]): Integer
    var
        lrTienda: Record 55897;
        lrLog: Record 55902;
        lResult: Integer;
    begin
        //+88460
        //... Iniciar Log.

        lResult := 0;
        IF NOT lrTienda.GET(pTienda) THEN
            EXIT(lResult);

        lrLog.RESET;
        lrLog.LOCKTABLE;

        lrLog.INIT;
        lrLog."ID Proceso" := pProceso;
        lrLog."Punto de proceso" := 1;
        lrLog.Tienda := pTienda;
        lrLog.TPV := pTPV;
        lrLog.INSERT(TRUE);

        lResult := lrLog."No. Log";

        EXIT(lResult);
    end;

    procedure ModificarDatosLog(pIDLog: Integer; pPunto: Integer; pTipoDocumento: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; pID36: Code[20]; pID112_114: Code[20]; pNumFiscalTPV: Code[50]; pNumComprobanteFiscal: Code[50]; pError: Text[1024])
    var
        lrTienda: Record 55897;
        lrLog: Record 55902;
        lResult: Integer;
    begin
        //+88460
        //... Iniciar Log.

        IF pIDLog = 0 THEN
            EXIT;

        lrLog.RESET;
        lrLog.LOCKTABLE;
        lrLog.GET(pIDLog);

        lrLog."Punto de proceso" := pPunto;
        lrLog."Tipo Documento" := pTipoDocumento;
        lrLog."ID. Cab Venta" := pID36;
        lrLog."ID. Historico" := pID112_114;
        lrLog."No. Fiscal TPV" := pNumFiscalTPV;
        lrLog."No. comprobante fiscal" := pNumComprobanteFiscal;
        lrLog."Texto Error" := COPYSTR(pError, 1, MAXSTRLEN(lrLog."Texto Error"));

        //+#328529
        IF wCupon4Log <> '' THEN
            lrLog.Cupon := wCupon4Log;
        //-#328529

        lrLog.MODIFY(TRUE);
    end;

    procedure RegistrarError(pIdOperacion: Integer; pIdTienda: Code[20]; pIdTPV: Code[20]; pIdCabVenta: Code[20]; pTextoError: Text[1024])
    var
        lrAudi: Record 55902;
        lrCV: Record 36;
        lNumLog: Integer;
        lOk: Boolean;
    begin
        //+#121213
        lNumLog := IniciarLog(pIdOperacion, pIdTienda, pIdTPV);

        IF pIdCabVenta <> '' THEN BEGIN  //+#148711

            lOk := lrCV.GET(lrCV."Document Type"::Invoice, pIdCabVenta);
            IF NOT lOk THEN
                lOk := lrCV.GET(lrCV."Document Type"::"Credit Memo", pIdCabVenta);


            IF lOk THEN
                IF lrCV."Venta TPV" THEN BEGIN
                    pTextoError := COPYSTR(pTextoError, 1, MAXSTRLEN(lrAudi."Texto Error"));
                    ModificarDatosLog(lNumLog, 100, lrCV."Document Type", lrCV."No.", lrCV."Posting No.", lrCV."No. Fiscal TPV", lrCV."No. Comprobante Fiscal", pTextoError);
                END;
        END
        //+#148711
        ELSE BEGIN
            pTextoError := COPYSTR(pTextoError, 1, MAXSTRLEN(lrAudi."Texto Error"));
            ModificarDatosLog(lNumLog, 100, 0, '', '', '', '', pTextoError);
        END;
        //-#148711
    end;

    procedure FE_Por_Pais(lrCabVenta: Record 36; pRegistroEnLinea: Boolean): Boolean
    var
        lResult: Boolean;
        lrCfgSant: Record 55226;
        lTipo: Integer;
    begin
        //+76946
        //... Esta función, llama a la función de envio electronico de facturas.
        //... En este momento sólo se habilita para Guatemala. Para hacerlo bien, deberá emplearse una puerta de enlace, para que esta codeunit no diera
        //... errores de compilación.
        //... La otra solución es copiar la codeunit de funciones de Guatemala en cada instalación.
        //...

        lResult := TRUE;
        // Eliminado: lógica exclusiva de otros países.

        EXIT(lResult);
    end;


    procedure GrabarTextoAvisoFE(pTienda: Code[20]; pTPV: Code[20]; pMensaje: Text[1024])
    var
        TPVSetup: Record 55895;
    begin
        TPVSetup.LockTable();
        TPVSetup.Get(pTienda, pTPV);
        TPVSetup."Texto aviso FE" := CopyStr(pMensaje, 1, MaxStrLen(TPVSetup."Texto aviso FE"));
        TPVSetup.Modify();
    end;

    procedure TestFE(SalesHeader: Record 36): Boolean
    begin
        // Costa Rica: los documentos TPV se procesan como documentos electrónicos.
        exit(true);
    end;

    procedure TestFE_Factura(SalesInvoiceHeader: Record 112): Boolean
    begin
        // Costa Rica: las facturas TPV registradas se procesan como documentos electrónicos.
        exit(true);
    end;

    procedure TestFE_NCR(SalesCrMemoHeader: Record 114): Boolean
    begin
        // Costa Rica: las notas de crédito TPV registradas se procesan como documentos electrónicos.
        exit(true);
    end;

    procedure ObtenerSerieFiscal(ConfigTPV: Record 55895; TipoDocumento: Option Factura,NCR): Code[20]
    begin
        case TipoDocumento of
            TipoDocumento::Factura:
                exit(ConfigTPV."NCF Credito fiscal");
            TipoDocumento::NCR:
                exit(ConfigTPV."NCF Credito fiscal NCR");
        end;
    end;

    procedure Post_Registrar(var SalesHeader: Record 36; RegistroEnLinea: Boolean; ConfigTPV: Record 55895)
    begin
        // En el objeto original este procedimiento solo ejecutaba ajustes de Dominicana y Paraguay.
        // Para Costa Rica no existe una actualización posterior específica.
    end;

    procedure TestIDYaUtilizado(SalesHeader: Record 36; Notificar: Boolean; var Notificacion: Text[1024]): Boolean
    var
        SalesLine: Record 37;
        PagoTPV: Record 55915;
        LineasExistentesMsg: Label 'Ya había líneas de venta con este mismo código. Hay que revisar la configuración de series.';
        PagosExistentesMsg: Label 'Ya había líneas de pago con este mismo código. Hay que revisar la configuración de series.';
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if not SalesLine.IsEmpty() then begin
            Notificacion := LineasExistentesMsg;
            if Notificar then
                Message(Notificacion);
            exit(true);
        end;

        PagoTPV.SetRange("No. Borrador", SalesHeader."No.");
        if not PagoTPV.IsEmpty() then begin
            Notificacion := PagosExistentesMsg;
            if Notificar then
                Message(Notificacion);
            exit(true);
        end;

        exit(false);
    end;

    procedure Actualiza_Venta_Contacto_2(var rSalesH: Record 36): Text
    var
        rSalesLin: Record 37;
        lrContact: Record 5050;
        lrTienda: Record 55897;
        lLocation: Code[10];
        lrTPV: Record 55895;
        lNumLog: Integer;
        lDto: Decimal;
    begin
        //+#144756

        IF Pais IN [1, 2, 3, 4, 5, 7, 8, 9] THEN
            EXIT;

        lNumLog := IniciarLog(6, rSalesH.Tienda, rSalesH.TPV);

        IF rSalesH."Cod. Colegio" = '' THEN
            EXIT;

        ModificarDatosLog(lNumLog, 102, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV",
                          rSalesH."No. Comprobante Fiscal", rSalesH."Cod. Colegio");

        lrTienda.GET(rSalesH.Tienda);
        lrTPV.GET(rSalesH.Tienda, rSalesH.TPV);

        //+#175576
        //IF lrTPV."Venta Movil" THEN BEGIN
        IF lrTPV."Venta Movil" OR (lrTPV."Precio por contacto" = lrTPV."Precio por contacto"::"En todos los casos") THEN BEGIN
            //-#1775576

            ModificarDatosLog(lNumLog, 103, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV",
                              rSalesH."No. Comprobante Fiscal", rSalesH."Cod. Colegio");

            lLocation := lrTienda."Cod. Almacen";

            IF lrContact.GET(rSalesH."Cod. Colegio") THEN
                IF lrContact."Cod. Almacen" <> '' THEN
                    lLocation := lrContact."Cod. Almacen";

            //IF lLocation <> rSalesH."Location Code" THEN BEGIN  //+#175576 -

            rSalesH.SetHideValidationDialog(TRUE);

            //+#175576
            //rSalesH.VALIDATE("Location Code"       , lLocation);
            IF lrTPV."Venta Movil" THEN
                rSalesH.VALIDATE("Location Code", lLocation);
            //-#175576

            rSalesH.VALIDATE("Sell-to Contact No.", rSalesH."Cod. Colegio");
            rSalesH.VALIDATE("Bill-to Contact No.", rSalesH."Cod. Colegio");
            rSalesH.VALIDATE("Cod. Colegio", rSalesH."Cod. Colegio");
            rSalesH.MODIFY(FALSE);

            rSalesLin.RESET;
            rSalesLin.SETRANGE("Document Type", rSalesH."Document Type");
            rSalesLin.SETRANGE("Document No.", rSalesH."No.");
            IF rSalesLin.FINDFIRST THEN BEGIN
                rSalesLin.SetHideValidationDialog(TRUE);
                REPEAT
                    //+#175576
                    //rSalesLin.VALIDATE("Location Code"       , lLocation);
                    IF lrTPV."Venta Movil" THEN
                        rSalesLin.VALIDATE("Location Code", lLocation);
                    //-#175576

                    rSalesLin.VALIDATE("Cod. Colegio", rSalesH."Cod. Colegio");
                    lDto := rSalesLin."Line Discount %";
                    rSalesLin.VALIDATE(Quantity);
                    rSalesLin.VALIDATE("Line Discount %", lDto);
                    rSalesLin.MODIFY(FALSE);
                UNTIL rSalesLin.NEXT = 0;
            END;

            ModificarDatosLog(lNumLog, 104, rSalesH."Document Type", rSalesH."No.", rSalesH."Posting No.", rSalesH."No. Fiscal TPV",
                              rSalesH."No. Comprobante Fiscal", rSalesH."Cod. Colegio" + ': ' + lLocation);

            //END; //+#175576

        END;
    end;

    procedure TestFormaPago(lrSH: Record 36; var vMensajeError: Text[1024]): Boolean
    var
        lrPagos: Record 55915;
        lrPagos2: Record 55915;
        lrAuxPagos: Record 55915;
        lrNCR: Record 114;
        lResult: Boolean;
        TextL001: Label 'En el NCR %1M Se ha indicado el  cliente %2 para liquidar la venta con cliente %3';
        TextL002: Label 'Se ha indicado el NCR %1 para liquidar la venta. Sin embargo dicho NCR ha excedido ya su Credito.';
        TextL003: Label 'No se ha encontrado el NCR %1';
        lrTMP_NCR: Record 114 temporary;
        TextL004: Label 'El NCR %1 se ha registrado con divisa %2. Faltaría adaptar los cobros en divisa para la compensación con NCR.';
        lImporteTotal: Decimal;
        lImportePendiente: Decimal;
        lImporteTotalCompensado: Decimal;
        lrFP: Record 55907;
    begin
        //+#70132
        //... Antes de registrar, por si acaso, revisamos que no estemos liquidando de más, mediante la forma de pago mediante NCR.
        //... Se revisará:
        //... 1) Que el cliente sea el mismo, 2) Que el NCR sea en divisa loca,
        //... 3) Que el importe pendiente de liquidar en el documento NCR sea inferior o igual, al importe total ligado al NCR indicado en el pago.
        //... 4) Que el "Importe total compensado" no exceda el importe total del NCR.
        //...

        lResult := TRUE;


        EXIT(lResult);

    end;

    procedure ImportePropuestoPagoNCR(p_Evento: Record "DsPOS Event Buffer" temporary): Text
    var
        lrNCR: Record 114;
        lrSH: Record 36;
        lNCR: Code[20];
        lrPagosTPV: Record 55915;
        lImporteVentaPdte: Decimal;
        lResult: Decimal;
        lDocVenta: Code[20];
        lImportePendiente: Decimal;
        lImporteTotal: Decimal;
        Evento: Record "DsPOS Event Buffer" temporary;
        TextL001: Label 'No se ha podido determinar ningún importe aplicable para este NCR';
        TextL002: Label 'En el NCR %1 se ha indicado el  cliente %2 para liquidar la venta con cliente %3';
        TextL003: Label 'No se ha encontrado el NCR indicado %1';
        lSeguir: Boolean;
    begin
        //+#70132
        //... Esta función debe integrarse con la DLL.
        //... Se debe recibir un primer parametro con el documento de venta y un segundo parametro con el código del NCR asociado.
        lResult := 0;
        lDocVenta := p_Evento.TextoDato;
        lNCR := p_Evento.TextoDato2;

        IF lrSH.GET(lrSH."Document Type"::Invoice, lDocVenta) THEN
            lrSH.CALCFIELDS("Amount Including VAT");

        lSeguir := TRUE;
        IF NOT lrNCR.GET(lNCR) THEN
            lSeguir := FALSE;

        Evento.TipoEvento := p_Evento.TipoEvento;

        IF NOT lSeguir THEN BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := STRSUBSTNO(TextL003, lrNCR."No.");
            EXIT(Evento.aXml());
        END;



        IF lResult = 0 THEN BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := TextL001;
            EXIT(Evento.aXml());
        END;

        Evento.AccionRespuesta := 'OK';
        Evento.DatoDecimal := lResult;

        EXIT(Evento.aXml());

    end;

    procedure AntesDeImprimir(pCodVenta: Code[20])
    begin
        //+#184407
        cCostaRica.AntesDeImprimir(pCodVenta);
    end;

    procedure ActualizarEstadoRegistro(lrSH: Record 36)
    var
        lrSL: Record 37;
        lrPagosTPV: Record 55915;
    begin
        //+#211509
        //... Actualizamos el valor del campo "Registrado TPV" en la tabla 37 - "Sales Line".
        lrSL.RESET;
        lrSL.SETRANGE("Document Type", lrSH."Document Type");
        lrSL.SETRANGE("Document No.", lrSH."No.");
        IF lrSL.FINDFIRST THEN
            REPEAT
                lrSL."Registrado TPV" := TRUE;
                lrSL.MODIFY;
            UNTIL lrSL.NEXT = 0;

        //... También actualizamos el campo en la tabla "Pagos TPV".
        lrPagosTPV.RESET;
        lrPagosTPV.SETRANGE("No. Borrador", lrSH."No.");
        IF lrPagosTPV.FINDFIRST THEN
            REPEAT
                lrPagosTPV."Registrado TPV" := TRUE;
                lrPagosTPV.MODIFY;
            UNTIL lrPagosTPV.NEXT = 0;
    end;

    procedure Log_InfoComplementaria(pCupon: Code[20])
    begin
        //#328529
        wCupon4Log := pCupon;
    end;

}