codeunit 34002513 "Funciones DsPOS - ComuneZ"
{
    //Ver codigo completo
    /*
    Permissions = TableData 112 = rimd,
                  TableData 114 = rimd;
    TableNo = 34002522;

    trigger OnRun()
    begin

        CASE Accion OF
            Accion::LiquidarFactura:
                LiquidaFacturaTPV(Documento);
            Accion::LiquidarNotaCredito:
                LiquidaNotaCreditoTPV(Documento);
        END;
    end;

    var
        cDominicana: Codeunit 34002504;
        cBolivia: Codeunit 34002505;
        cParaguay: Codeunit 34002506;
        cEcuador: Codeunit 34002507;
        cGuatemala: Codeunit 34002508;
        cSalvador: Codeunit 34002509;
        cHonduras: Codeunit 34002510;
        cCostaRica: Codeunit 34002511;
        FE_CR: Codeunit 52504;

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
        rCajeros: Record 34002505;
        rGrupoCajeros: Record 34002507;
        rDimDefAlmacen: Record 34002519;
        rAlmacen: Record 14;
        rTienda: Record 34002503;
        rTPV: Record 34002501;
        NoSeriesMgt: Codeunit 396;
        recTmpDimEntry: Record 480 temporary;
        cDimManag: Codeunit 408;
        Error001: Label 'No se ha podido crear el pedido de venta';
        Text001: Label ' Nº Venta %1';
        cControl: Codeunit 34002521;
        recControlTPV: Record 34002524;
        rDimEntry: Record 480;
        Evento: DotNet ;
    begin

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

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

        Evento.TipoEvento := 6;

        CASE Pais OF
            1:
                Evento.TextoDato7 := cDominicana.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader); // Dominicana
            2:
                cBolivia.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);                         // Bolivia
            3:
                Evento.TextoDato7 := cParaguay.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);   // Paraguay
            4:
                Evento.TextoDato7 := cEcuador.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);     // Ecuador
            5:
                Evento.TextoDato7 := cGuatemala.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);   // Guatemala
            6:
                Evento.TextoDato7 := cSalvador.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);    // Salvador
            7:
                Evento.TextoDato7 := cHonduras.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);    // Honduras
            9:
                Evento.TextoDato7 := cCostaRica.Nueva_Venta(p_Tienda, p_IdTPV, p_Cajero, rSalesHeader);   // Costa Rica
        END;

        IF rSalesHeader.INSERT(FALSE) THEN BEGIN
            Evento.TextoDato := rSalesHeader."No.";
            Evento.TextoDato2 := STRSUBSTNO('%1', rSalesHeader."Posting Date");
            Evento.TextoDato3 := rSalesHeader."Sell-to Customer Name";
            Evento.TextoDato4 := rSalesHeader."VAT Registration No.";
            Evento.TextoDato5 := rSalesHeader."Sell-to Customer No.";
            Evento.TextoDato8 := rSalesHeader."Cod. Colegio";
            Evento.TextoDato9 := rSalesHeader."Nombre Colegio";
            Evento.TextoRespuesta := STRSUBSTNO(Text001, rSalesHeader."No.");
            Evento.AccionRespuesta := 'Actualizar_Todo';
            IF NOT p_Devolucion THEN
                Actualizar_Totales(Evento.TextoDato, Evento, TRUE, p_Devolucion);
        END
        ELSE BEGIN
            Evento.AccionRespuesta := 'ERROR';
            Evento.TextoRespuesta := Error001;
        END;

        IF NOT p_Devolucion THEN
            EXIT(Evento.aXml())
        ELSE
            EXIT(rSalesHeader."No.");
    end;

    procedure Buscar_Producto(var p_Producto: Code[20]; var p_Medida: Code[10])
    var
        rItemCrossRef: Record 5717;
        rItem: Record 27;
        rItemIdentifier: Record 7704;
    begin

        // 1 - Cod. Barras (ref Cruzadas)
        // 2 - Identificadores
        // 3 - Codigo producto

        rItemCrossRef.RESET;
        rItemCrossRef.SETCURRENTKEY("Cross-Reference No.");
        rItemCrossRef.SETRANGE("Cross-Reference No.", p_Producto);
        rItemCrossRef.SETRANGE("Cross-Reference Type", rItemCrossRef."Cross-Reference Type"::"Bar Code");

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
        rConfTPV: Record 34002501;
        CodProd: Code[20];
        uMedida: Code[10];
        NuevaLinea: Boolean;
        Evento: DotNet ;
        Error001: Label 'Imposible Modificar Línea de Pedido';
        Error002: Label 'El Producto %1 No Tiene Precio Configurado';
        Error003: Label 'Imposible Insertar Línea de Pedido';
        Error004: Label 'El Producto %1 no existe';
        rTienda: Record 34002503;
        Error005: Label 'El número máximo de líneas (%1) para este pedido se ha superado';
        Text001: Label 'Añadido/s %1 unidad/es del producto %2';
        dto: Decimal;
    begin

        rConfTPV.GET(p_Tienda, p_IdTPV);
        rTienda.GET(p_Tienda);
        CodProd := p_Producto;

        Buscar_Producto(CodProd, uMedida);

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

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
            rSalesLine.VALIDATE("Location Code", rTienda."Cod. Almacen");


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

    procedure Ejecutar_Accion(p_Evento: DotNet ): Text
    var
        Evento: DotNet ;
        rAccion: Record 34002512;
        rLinPed: Record 37;
        Error: Boolean;
        Mensaje: array[2] of Text;
        Text001: Label 'Linea eliminada Correctamente';
        Text002: Label 'Cantidad modificada Correctamente';
        Text003: Label 'Descuento en Linea Aplicado Correctamente';
        Text004: Label 'Precio Modificado Correctamente';
        Text005: Label 'Descuento General Aplicado Correctamente';
        Text006: Label 'Venta Correctamente Archivada';
        Error001: Label 'No ha sido posible borrar la linea Seleccionada';
        Error002: Label 'Imposible Modificar Línea de Pedido';
        Error003: Label 'No se encuentra la línea de Pedido';
        Error004: Label 'No se encuentra el pedido';
        rCabFac: Record 36;
        Error005: Label 'No se encuentra la venta a archivar';
        i: Integer;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

        Evento.TipoEvento := p_Evento.TipoEvento;

        IF rAccion.GET(p_Evento.TextoDato4) THEN BEGIN
            CASE p_Evento.TextoDato4 OF

                'ANULARLINEA':
                    BEGIN
                        FOR i := 1 TO p_Evento.IntDato1 DO BEGIN
                            rLinPed.RESET;
                            IF NOT (rLinPed.GET(rLinPed."Document Type"::Invoice, p_Evento.TextoDato3, SELECTSTR(i, p_Evento.TextoDato6))) THEN BEGIN
                                Error := TRUE;
                                Mensaje[1] := Error003;
                            END
                            ELSE
                                IF NOT rLinPed.DELETE(TRUE) THEN BEGIN
                                    Error := TRUE;
                                    Mensaje[1] := Error001;
                                END
                                ELSE BEGIN
                                    Mensaje[1] := Text001;
                                    Mensaje[2] := 'Actualizar_Lineas';
                                END;
                        END
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
                        Error := NOT ((Registrar(p_Evento, Evento)));

                        Mensaje[1] := Evento.TextoRespuesta;
                        Mensaje[2] := Evento.AccionRespuesta;
                        IF NOT Error THEN BEGIN
                            //Factura ELectronica
                            FE_CR.TiqueteElectronica(Evento.TextoDato4);
                            //Factura ELectronica
                            Imprimir(p_Evento.TextoDato, Evento.TextoDato4);
                        END;
                    END;

                'CUPON':
                    BEGIN

                        CASE Pais OF
                            1:
                                cDominicana.Ejecutar_Accion(p_Evento, Evento);
                            2:
                                cBolivia.Ejecutar_Accion(p_Evento, Evento);
                            3:
                                cParaguay.Ejecutar_Accion(p_Evento, Evento);
                            4:
                                cEcuador.Ejecutar_Accion(p_Evento, Evento);
                            5:
                                cGuatemala.Ejecutar_Accion(p_Evento, Evento);
                            6:
                                cSalvador.Ejecutar_Accion(p_Evento, Evento);
                            7:
                                cHonduras.Ejecutar_Accion(p_Evento, Evento);
                            9:
                                cCostaRica.Ejecutar_Accion(p_Evento, Evento);
                        END;

                        Error := (Evento.TextoRespuesta = 'ERROR');
                        Mensaje[1] := Evento.TextoRespuesta;
                        Mensaje[2] := Evento.AccionRespuesta;

                    END;


                'ELIMINARCUPON':
                    BEGIN

                        CASE Pais OF
                            1:
                                cDominicana.Ejecutar_Accion(p_Evento, Evento);
                            2:
                                cBolivia.Ejecutar_Accion(p_Evento, Evento);
                            3:
                                cParaguay.Ejecutar_Accion(p_Evento, Evento);
                            4:
                                cEcuador.Ejecutar_Accion(p_Evento, Evento);
                            5:
                                cGuatemala.Ejecutar_Accion(p_Evento, Evento);
                            6:
                                cSalvador.Ejecutar_Accion(p_Evento, Evento);
                            7:
                                cHonduras.Ejecutar_Accion(p_Evento, Evento);
                            9:
                                cCostaRica.Ejecutar_Accion(p_Evento, Evento);
                        END;

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
                            Mensaje[2] := 'Actualizar_Lineas';
                        END;
                    END;

                'APARCARPEDIDO':
                    BEGIN

                        rCabFac.RESET;

                        IF rCabFac.GET(rCabFac."Document Type"::Invoice, p_Evento.TextoDato3) THEN BEGIN

                            rCabFac.Aparcado := TRUE;
                            rCabFac.MODIFY(FALSE);

                            CASE Pais OF
                                1:
                                    cDominicana.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                2:
                                    cBolivia.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                3:
                                    cParaguay.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                4:
                                    cEcuador.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                5:
                                    cGuatemala.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                6:
                                    cSalvador.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                7:
                                    cHonduras.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                                9:
                                    cCostaRica.Guardar_Datos_Aparcados(p_Evento.TextoDato3, p_Evento);
                            END;

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

    procedure Insertar_Pago(var p_Evento: DotNet ): Text
    var
        Evento: DotNet ;
        rPagos: Record 34002521;
        rfPago: Record 34002513;
        Text001: Label 'Linea de Pago insertada Correctamente';
        rTarj: Record 34002515;
        Text002: Label 'No existe %1 ni como forma de pago ni como tipo de tarjeta';
        EsDevolucion: Boolean;
        rCab: Record 36;
        decImportes: array[10] of Decimal;
        exacto: Boolean;
        Documento: Code[20];
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

        Evento.TipoEvento := p_Evento.TipoEvento;
        Documento := p_Evento.TextoDato3;

        EsDevolucion := rCab.GET(rCab."Document Type"::"Credit Memo", Documento);

        CASE p_Evento.TextoDato6 OF
            'DSPOS_EXACTO':
                BEGIN
                    exacto := TRUE;
                    rPagos.RESET;
                    rPagos.SETRANGE("No. Borrador", p_Evento.TextoDato3);
                    IF rPagos.FINDSET THEN
                        rPagos.DELETEALL;
                    IF NOT (EsDevolucion) THEN
                        rCab.GET(rCab."Document Type"::Invoice, p_Evento.TextoDato3);
                    ActValoresTPV(rCab, decImportes[1], decImportes[2], decImportes[3], decImportes[4], decImportes[5], decImportes[6]);
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
            RESET;
            IF NOT GET(p_Evento.TextoDato3, p_Evento.TextoDato4, FALSE) THEN BEGIN
                "Tipo Tarjeta" := rTarj.Codigo;
                VALIDATE("Forma pago TPV", p_Evento.TextoDato4);
                Fecha := WORKDATE;
                "No. Borrador" := p_Evento.TextoDato3;
                Tienda := p_Evento.TextoDato;
                TPV := p_Evento.TextoDato2;
                IF exacto THEN
                    VALIDATE(Importe, decImportes[5])
                ELSE
                    VALIDATE(Importe, p_Evento.DatoDecimal);
                Cajero := p_Evento.TextoDato5;
                Hora := FormatTime(TIME);
                Cambio := FALSE;
                INSERT;
            END
            ELSE BEGIN
                VALIDATE(Importe, p_Evento.DatoDecimal);
                Hora := FormatTime(TIME);
                MODIFY;
            END;
        END;


        Evento.AccionRespuesta := 'Actualizar_Pagos';
        Evento.TextoRespuesta := Text001;
        Actualizar_Totales(p_Evento.TextoDato3, Evento, FALSE, EsDevolucion);
        EXIT(Evento.aXml());
    end;

    procedure Eliminar_Pago(var p_Evento: DotNet ): Text
    var
        Evento: DotNet ;
        rPagosTPV: Record 34002521;
        Text001: Label 'Pago %1 Eliminado Correctamente';
        Text002: Label 'Pago %1 NO Encontrado';
        EsDevolucion: Boolean;
        rCab: Record 36;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

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

    procedure Registrar(var p_Evento: DotNet ; var p_Resultado: DotNet ): Boolean
    var
        recTienda: Record 34002503;
        rCab: Record 34002500;
        rSalesH: Record 36;
        rCust: Record 18;
        recLinVta: Record 37;
        cduNoSeries: Codeunit 396;
        wApagar: Decimal;
        Error001: Label 'Fecha de registro debe ser igual a la fecha del día';
        Error002: Label 'Debe Especificar Nº de Identificación Fiscal';
        Error003: Label 'ORDER WITH REMAINING AMOUNT';
        Error004: Label 'ORDER WITH REMAINING AMOUNT';
        Error005: Label 'ORDER WITH REMAINING AMOUNT';
        Error006: Label 'Imposible Modificar Registro';
        Error007: Label 'La línea de Venta %1 no tiene asignado precio.';
        Text001: Label 'Factura %1 Registrada Correctamente';
        cComunes: Codeunit 34002503;
        recParam: Record 34002522;
        texto: Text;
        recPagosTPV: Record 34002521;
        recTPV: Record 34002501;
        Text003: Label 'Factura TPV %1';
        rHistFact: Record 112;
        Es_Devolucion: Boolean;
        Text004: Label 'Devolución TPV %1';
        Text005: Label 'Devolucion %1 Registrada Correctamente';
        SalesLine: Record 37;
        cRegistro: Codeunit 34002522;
        cControl: Codeunit 34002521;
    begin

        rSalesH.RESET;
        IF NOT rSalesH.GET(rSalesH."Document Type"::Invoice, p_Evento.TextoDato3) THEN
            Es_Devolucion := rSalesH.GET(rSalesH."Document Type"::"Credit Memo", p_Evento.TextoDato3);

        recTPV.GET(p_Evento.TextoDato, p_Evento.TextoDato2);

        WITH rSalesH DO BEGIN

            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", rSalesH."Document Type");
            SalesLine.SETRANGE("Document No.", rSalesH."No.");
            IF SalesLine.FINDSET THEN
                REPEAT
                    IF SalesLine."Unit Price" = 0 THEN BEGIN
                        p_Resultado.TextoRespuesta := STRSUBSTNO(Error007, SalesLine."Line No.");
                        EXIT(FALSE);
                    END;
                UNTIL SalesLine.NEXT = 0;

            IF "VAT Registration No." = '' THEN BEGIN
                p_Resultado.TextoRespuesta := Error002;
                EXIT(FALSE);
            END;

            ComprobarCambioCliente(rSalesH, p_Evento.TextoPais.GetValue(7));
            "Venta a credito" := Es_Vta_Credito(rSalesH);

            rCust.GET("Sell-to Customer No.");
            IF "Venta a credito" THEN
                IF NOT rCust."Permite venta a credito" THEN BEGIN
                    p_Resultado.TextoRespuesta := Error003;
                    EXIT(FALSE);
                END;

            "Hora creacion" := FormatTime(TIME);
            "ID Cajero" := p_Evento.TextoDato5;
            TPV := p_Evento.TextoDato2;
            Ship := FALSE;
            Invoice := TRUE;

            "Cod. Colegio" := p_Evento.TextoPais.GetValue(8);
            "Nombre Colegio" := COPYSTR(p_Evento.TextoPais.GetValue(9), 1, MAXSTRLEN("Nombre Colegio"));


            IF "Posting No." = '' THEN
                IF NOT Es_Devolucion THEN BEGIN
                    "No. Series" := recTPV."No. serie Facturas";
                    "Posting No. Series" := recTPV."No. serie facturas Reg.";
                    "Posting No." := cduNoSeries.GetNextNo(recTPV."No. serie facturas Reg.", "Posting Date", TRUE);
                    "Posting Description" := STRSUBSTNO(Text003, rSalesH."Posting No.");
                END
                ELSE BEGIN
                    "No. Series" := recTPV."No. serie notas credito";
                    "Posting No. Series" := recTPV."No. serie notas credito reg.";
                    "Posting No." := cduNoSeries.GetNextNo(recTPV."No. serie notas credito reg.", "Posting Date", TRUE);
                    "Posting Description" := STRSUBSTNO(Text004, rSalesH."Posting No.");
                END;

            IF rSalesH.Devolucion THEN
                RelacionaDevolucion(rSalesH);

            p_Resultado.TextoRespuesta := '';
            CASE Pais OF
                1:
                    p_Resultado.TextoRespuesta := cDominicana.Registrar(rSalesH, p_Evento); // Dominicana
                2:
                    p_Resultado.TextoRespuesta := cBolivia.Registrar(rSalesH, p_Evento);    // Bolivia
                3:
                    p_Resultado.TextoRespuesta := cParaguay.Registrar(rSalesH, p_Evento);   // Paraguay
                4:
                    p_Resultado.TextoRespuesta := cEcuador.Registrar(rSalesH, p_Evento);    // Ecuador
                5:
                    p_Resultado.TextoRespuesta := cGuatemala.Registrar(rSalesH, p_Evento);    // Guatemala
                6:
                    p_Resultado.TextoRespuesta := cSalvador.Registrar(rSalesH, p_Evento);    // Guatemala
                7:
                    p_Resultado.TextoRespuesta := cHonduras.Registrar(rSalesH, p_Evento);    // Honduras
                9:
                    p_Resultado.TextoRespuesta := cCostaRica.Registrar(rSalesH, p_Evento);    // Costa Rica
            END;

            IF p_Resultado.TextoRespuesta <> '' THEN
                EXIT(FALSE);

            IF "No. Fiscal TPV" = '' THEN
                "No. Fiscal TPV" := "Posting No.";

            IF NOT MODIFY(FALSE) THEN BEGIN
                p_Resultado.TextoRespuesta := Error006;
                p_Resultado.AccionRespuesta := 'ERROR';
                EXIT(FALSE);
            END;

            recPagosTPV.RESET;
            recPagosTPV.SETRANGE("No. Borrador", rSalesH."No.");
            IF recPagosTPV.FINDSET THEN BEGIN
                REPEAT
                    IF NOT Es_Devolucion THEN
                        recPagosTPV."No. Factura" := "Posting No."
                    ELSE
                        recPagosTPV."No. Nota Credito" := "Posting No.";
                    recPagosTPV.Fecha := "Posting Date";
                    recPagosTPV.MODIFY;
                UNTIL recPagosTPV.NEXT = 0;
            END;

            IF RegistroEnLinea(p_Evento.TextoDato) THEN BEGIN

                ActualizarDatoPago(rSalesH);
                COMMIT;

                IF (CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", rSalesH)) THEN BEGIN

                    GuardarVentaTPV(rSalesH, TRUE);

                    recParam.INIT;
                    IF NOT Es_Devolucion THEN
                        recParam.Accion := recParam.Accion::LiquidarFactura
                    ELSE
                        recParam.Accion := recParam.Accion::LiquidarNotaCredito;

                    recParam.Documento := rSalesH."Last Posting No.";
                    COMMIT;

                    IF (CODEUNIT.RUN(CODEUNIT::"Funciones DsPOS - Comunes", recParam)) THEN BEGIN

                        p_Resultado.AccionRespuesta := 'Nueva_Venta';
                        IF NOT Es_Devolucion THEN
                            p_Resultado.TextoRespuesta := STRSUBSTNO(Text001, rSalesH."Last Posting No.")
                        ELSE
                            p_Resultado.TextoRespuesta := STRSUBSTNO(Text005, rSalesH."Last Posting No.");

                        p_Resultado.TextoDato4 := rSalesH."Last Posting No.";
                        cControl.EliminarBorradores(p_Evento.TextoDato, p_Evento.TextoDato2, FALSE);
                        EXIT(TRUE);
                    END;

                END
                ELSE BEGIN
                    p_Resultado.AccionRespuesta := 'ERROR';
                    p_Resultado.TextoRespuesta := GETLASTERRORTEXT;
                    CLEARLASTERROR;
                    EXIT(FALSE);
                END;

            END
            ELSE BEGIN

                recLinVta.RESET;
                recLinVta.SETRANGE("Document Type", "Document Type");
                recLinVta.SETRANGE("Document No.", "No.");
                recLinVta.SETFILTER(Quantity, '<>0');
                IF NOT recLinVta.FINDFIRST THEN BEGIN
                    p_Resultado.TextoRespuesta := Error004;
                    EXIT(FALSE);
                END;

                "Registrado TPV" := TRUE;

                ActualizarDatoPago(rSalesH);
                GuardarVentaTPV(rSalesH, FALSE);

                IF MODIFY(FALSE) THEN BEGIN
                    p_Resultado.AccionRespuesta := 'Nueva_Venta';

                    IF NOT Es_Devolucion THEN
                        p_Resultado.TextoRespuesta := STRSUBSTNO(Text001, rSalesH."Posting No.")
                    ELSE
                        p_Resultado.TextoRespuesta := STRSUBSTNO(Text005, rSalesH."Posting No.");

                    p_Resultado.TextoDato4 := rSalesH."No.";
                    cControl.EliminarBorradores(p_Evento.TextoDato, p_Evento.TextoDato2, FALSE);
                    EXIT(TRUE);
                END
                ELSE BEGIN
                    p_Resultado.TextoRespuesta := Error006;
                    p_Resultado.AccionRespuesta := 'ERROR';
                    EXIT(FALSE);
                END;

            END;


        END;
    end;

    procedure Crear_Devolucion(p_Evento: DotNet ): Text
    var
        Evento: DotNet ;
        rSalesH: Record 36;
        rSalesInvH: Record 112;
        rSalesLin: Record 37;
        rSalesInvLin: Record 113;
        NotaCredito: Code[20];
        rCabDevol: Record 36;
        rLinDevol: Record 37;
        Text001: Label 'Se ha creado la devolución %1';
        NoLin: Integer;
        i: Integer;
        ArrayNav: array[60] of Integer;
        varArray: DotNet Array;
        wDateTime: DateTime;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

        Evento.TipoEvento := 16;
        i := 1;
        WHILE i < (p_Evento.ArrayEnteros.Length + 1) DO BEGIN
            ArrayNav[i] := p_Evento.ArrayEnteros.GetValue(i - 1);
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
        CASE Pais OF
            3:
                Evento.TextoDato7 := cParaguay.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);      // Paraguay
            4:
                Evento.TextoDato7 := cEcuador.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);     // Ecuador
            5:
                Evento.TextoDato7 := cGuatemala.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);   // Guatemala
            6:
                Evento.TextoDato7 := cSalvador.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);    // Salvador
            7:
                Evento.TextoDato7 := cHonduras.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);    // Honduras
            9:
                Evento.TextoDato7 := cCostaRica.Nueva_Venta(rCabDevol.Tienda, rCabDevol.TPV, rCabDevol."ID Cajero", rCabDevol);   // Costa Rica
        END;

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

    procedure Actualizar_Totales(p_Venta: Code[20]; var p_Evento: DotNet ; EsNueva: Boolean; Devolucion: Boolean)
    var
        varArray: DotNet Array;
        [RunOnClient]
        Evento: DotNet ;
        rSalesH: Record 36;
        decDummy: Decimal;
        i: Integer;
        decImportes: array[10] of Decimal;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

        i := 1;
        varArray := varArray.CreateInstance(Evento.GetTypeOfDecimal(), 10);

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

            ActValoresTPV(rSalesH, decImportes[1], decImportes[2], decImportes[3], decImportes[4], decImportes[5], decImportes[6]);
            WHILE i <= 6 DO BEGIN
                varArray.SetValue(decImportes[i], i);
                i += 1;
            END;
        END;

        p_Evento.ArrayTotales := varArray;
    end;

    procedure ActValoresTPV(recPrmCabVta: Record 36; var decPrmTotal: Decimal; var decPrmPago: Decimal; var decPrmDescuentos: Decimal; var decPrmCambio: Decimal; var decPrmBalance: Decimal; var decPrmTotalProds: Decimal)
    var
        recLinVta: Record 37;
        recPagosTPV: Record 34002521;
    begin

        CLEAR(decPrmTotal);
        CLEAR(decPrmDescuentos);
        CLEAR(decPrmPago);

        recLinVta.RESET;
        recLinVta.SETRANGE("Document Type", recPrmCabVta."Document Type");
        recLinVta.SETRANGE("Document No.", recPrmCabVta."No.");
        IF recLinVta.FINDSET THEN
            REPEAT
                decPrmTotal += recLinVta."Outstanding Amount" + recLinVta."Line Discount Amount";
                decPrmDescuentos += recLinVta."Line Discount Amount";
                decPrmTotalProds += recLinVta.Quantity;
            UNTIL recLinVta.NEXT = 0;

        recPagosTPV.RESET;
        recPagosTPV.SETRANGE("No. Borrador", recPrmCabVta."No.");
        IF recPagosTPV.FINDSET THEN
            REPEAT
                decPrmPago += recPagosTPV."Importe (DL)";
            UNTIL recPagosTPV.NEXT = 0;

        decPrmBalance := decPrmTotal - decPrmDescuentos - decPrmPago;
        IF decPrmBalance < 0 THEN
            decPrmBalance := 0;

        decPrmCambio := decPrmTotal - decPrmDescuentos - decPrmPago;
        IF decPrmCambio > 0 THEN
            decPrmCambio := 0;

        IF decPrmPago = 0 THEN
            decPrmCambio := 0;
    end;

    procedure ActualizarDatoPago(recPrmCabVta: Record 36)
    var
        recPagosTPV: Record 34002521;
        decDummy: array[10] of Decimal;
        decCambio: Decimal;
    begin

        ActValoresTPV(recPrmCabVta, decDummy[1], decDummy[2], decDummy[3], decCambio, decDummy[4], decDummy[5]);

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
        rPagosTPV: Record 34002521;
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
        rConfGeneral: Record 34002500;
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
        recPagosTPV: Record 34002521;
        recFormPagosTPV: Record 34002513;
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
                recPagosTPV.INSERT;
            END;
        END;
    end;

    procedure Imprimir(codPrmTienda: Code[20]; codPrmDoc: Code[20]): Text
    var
        recCabFac: Record 112;
        recCabNC: Record 114;
        recCabVta: Record 36;
        recTienda: Record 34002503;
        i: Integer;
        Evento: DotNet ;
        Text001: Label 'Las facturas Manuales no se pueden imprimir';
    begin

        CASE Pais OF
            2:
                BEGIN
                    IF NOT cBolivia.Imprimir(codPrmTienda, codPrmDoc) THEN BEGIN
                        IF ISNULL(Evento) THEN
                            Evento := Evento.Evento();
                        Evento.TipoEvento := 17;
                        Evento.TextoRespuesta := Text001;
                        Evento.AccionRespuesta := 'ERROR';
                        EXIT(Evento.aXml());
                    END;
                END;
        END;

        COMMIT;

        IF recTienda.GET(codPrmTienda) THEN
            IF recTienda."Registro En Linea" THEN BEGIN
                recCabFac.RESET;
                recCabFac.SETRANGE("No.", codPrmDoc);
                IF recCabFac.FINDFIRST THEN BEGIN
                    recTienda.TESTFIELD("ID Reporte contado");
                    WHILE i < recTienda."Cantidad de Copias Contado" DO BEGIN
                        i += 1;
                        REPORT.RUN(recTienda."ID Reporte contado", FALSE, FALSE, recCabFac);
                    END;
                END
                ELSE BEGIN
                    recCabNC.RESET;
                    recCabNC.SETRANGE("No.", codPrmDoc);
                    IF recCabNC.FINDFIRST THEN BEGIN
                        recTienda.TESTFIELD("ID Reporte nota credito");
                        WHILE i < recTienda."Cantidad copias nota credito" DO BEGIN
                            i += 1;
                            REPORT.RUN(recTienda."ID Reporte nota credito", TRUE, TRUE, recCabNC);
                        END;
                    END;
                END;

            END
            ELSE BEGIN
                recCabVta.RESET;
                recCabVta.SETRANGE("Document Type", recCabVta."Document Type"::Invoice);
                recCabVta.SETRANGE("No.", codPrmDoc);
                IF recCabVta.FINDFIRST THEN BEGIN
                    recTienda.TESTFIELD("ID Reporte contado");
                    WHILE i < recTienda."Cantidad de Copias Contado" DO BEGIN
                        i += 1;
                        REPORT.RUN(recTienda."ID Reporte contado", FALSE, FALSE, recCabVta);
                    END;
                END
                ELSE BEGIN
                    recCabVta.RESET;
                    recCabVta.SETRANGE("Document Type", recCabVta."Document Type"::"Credit Memo");
                    recCabVta.SETRANGE("No.", codPrmDoc);
                    IF recCabVta.FINDFIRST THEN BEGIN
                        recTienda.TESTFIELD("ID Reporte nota credito");
                        WHILE i < recTienda."Cantidad copias nota credito" DO BEGIN
                            i += 1;
                            REPORT.RUN(recTienda."ID Reporte nota credito", FALSE, FALSE, recCabVta);
                        END;
                    END;
                END;
            END;
    end;

    procedure AnularFactura(codPrmTienda: Code[20]; codPrmTPV: Code[20]; codPrmCajero: Code[20]; codPrmDoc: Code[20]): Text
    var
        recCabVta: Record 36;
        recLinVta: Record 37;
        recCab: Record 36;
        recLin: Record 37;
        recCabFac: Record 112;
        recLinFac: Record 113;
        recTPV: Record 34002501;
        Evento: DotNet ;
        Error001: Label 'La factura %1 ya está anulada.';
        Error002: Label 'No se ha podido insertar la nota de crédito.';
        Text002: Label 'Factura anulada correctamente.';
        recCabNC: Record 114;
        rPagos: Record 34002521;
        rPagosNC: Record 34002521;
        cduNoSeries: Codeunit 396;
        Text003: Label 'Anula a Fact. TPV %1';
        cRegistro: Codeunit 34002522;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

        Evento.TipoEvento := 10;
        recTPV.GET(codPrmTienda, codPrmTPV);

        IF RegistroEnLinea(codPrmTienda) THEN BEGIN

            recCabFac.GET(codPrmDoc);
            IF recCabFac."Anulado TPV" THEN BEGIN
                Evento.TextoRespuesta := 'ERROR';
                Evento.AccionRespuesta := STRSUBSTNO(Error001, recCabFac."No.");
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
            CASE Pais OF
                1:
                    Evento.TextoRespuesta := cDominicana.AnularFactura(recCabVta);
                3:
                    Evento.TextoRespuesta := cParaguay.AnularFactura(recCabVta); // Paraguay
                4:
                    Evento.TextoRespuesta := cEcuador.AnularFactura(recCabVta); // Ecuador
                5:
                    Evento.TextoRespuesta := cGuatemala.AnularFactura(recCabVta); // Guatemala
                6:
                    Evento.TextoRespuesta := cSalvador.AnularFactura(recCabVta); // Salvador
                7:
                    Evento.TextoRespuesta := cHonduras.AnularFactura(recCabVta); // Honduras
                9:
                    Evento.TextoRespuesta := cCostaRica.AnularFactura(recCabVta); // Costa Rica
            END;

            IF Evento.TextoRespuesta <> '' THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                EXIT(Evento.aXml());
            END;

            recCabVta.MODIFY;
            COMMIT;

            IF NOT (CODEUNIT.RUN(CODEUNIT::"Ventas-Registrar DsPOS", recCabVta)) THEN BEGIN
                Evento.TextoRespuesta := GETLASTERRORTEXT;
                Evento.AccionRespuesta := 'ERROR';
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

                Imprimir(codPrmTienda, recCabVta."Last Posting No.");

            END;

        END
        ELSE BEGIN

            recCab.GET(recCab."Document Type"::Invoice, codPrmDoc);
            IF recCab."Anulado TPV" THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
                Evento.TextoRespuesta := STRSUBSTNO(Error001, recCab."No.");
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
            recCabVta.INSERT(FALSE);
            recCabVta."Posting Description" := STRSUBSTNO(Text003, recCab."Posting No.");
            recCabVta.VALIDATE("Cod. Colegio", recCab."Cod. Colegio");
            recCabVta.VALIDATE("Salesperson Code", recCab."Salesperson Code");

            recCabVta."Bill-to Name" := recCab."Bill-to Name";
            recCabVta."Bill-to Address" := recCab."Bill-to Address";
            recCabVta."VAT Registration No." := recCab."VAT Registration No.";

            recCabVta."Sell-to Customer Name" := recCab."Sell-to Customer Name";
            recCabVta."Sell-to Address" := recCab."Sell-to Address";

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

                    Linea_LocalizadaOFF(recLin, recLinVta);

                    recLinVta.INSERT(FALSE);
                UNTIL recLin.NEXT = 0;


            Evento.TextoRespuesta := '';
            CASE Pais OF
                3:
                    Evento.TextoRespuesta := cParaguay.AnularFactura(recCabVta); // Paraguay
                4:
                    Evento.TextoRespuesta := cEcuador.AnularFactura(recCabVta); // Ecuador
                5:
                    Evento.TextoRespuesta := cGuatemala.AnularFactura(recCabVta); // Guatemala
                6:
                    Evento.TextoRespuesta := cSalvador.AnularFactura(recCabVta); // Salvador
                7:
                    Evento.TextoRespuesta := cHonduras.AnularFactura(recCabVta); // Honduras
                9:
                    Evento.TextoRespuesta := cCostaRica.AnularFactura(recCabVta); // Costa Rica
            END;

            IF Evento.TextoRespuesta <> '' THEN BEGIN
                Evento.AccionRespuesta := 'ERROR';
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
                    rPagosNC.INSERT(FALSE);
                UNTIL rPagos.NEXT = 0;

            // Anulamos las transacciones de caja
            GuardarAnulacionTPV(recCabVta, FALSE);
            Evento.AccionRespuesta := 'OK';
            Evento.TextoRespuesta := Text002;

            RelacionaAnulacion(recCabVta, codPrmTienda);

            // Imprimir Nota de Credito OFF
            Imprimir(codPrmTienda, recCabVta."No.");

        END;

        EXIT(Evento.aXml());
    end;

    procedure PrecioDisponibilidad(p_Evento: DotNet ): Text
    var
        Evento: DotNet ;
        rCabVta: Record 36;
        rLinVtaTMP: Record 37 temporary;
        Umed: Code[10];
        CodProd: Code[20];
        rTiendas: Record 34002503;
        rItem: Record 27;
        varArray: DotNet Array;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

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
            VALIDATE("No.", CodProd);
            VALIDATE("Unit of Measure Code", Umed);
            VALIDATE(Quantity, 1);
            VALIDATE("Location Code", rTiendas."Cod. Almacen");
        END;

        rItem.RESET;
        rItem.GET(CodProd);
        rItem.SETFILTER("Location Filter", rTiendas."Cod. Almacen");
        rItem.CALCFIELDS(Inventory);

        varArray := varArray.CreateInstance(Evento.GetTypeOfDecimal(), 10);
        varArray.SetValue(rLinVtaTMP."Unit Price", 1);
        varArray.SetValue(rItem.Inventory, 2);

        Evento.AccionRespuesta := 'OK';
        Evento.ArrayTotales := varArray;

        EXIT(Evento.aXml());
    end;

    procedure LiquidaFacturaTPV(codPrmDoc: Code[20])
    var
        recCabFac: Record 112;
        recPagosTPV: Record 34002521;
        cduDim: Codeunit 408;
        recTempDimSet: Record 480 temporary;
        recTempDimSet2: Record 480 temporary;
        optTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin

        //Esta función genera los pagos según divisa y liquida la factura TPV

        recCabFac.GET(codPrmDoc);

        //Primero se comprueba que no se haya liquidado el mov. cliente
        IF MovClientePendiente(recCabFac."Bill-to Customer No.", optTipoDoc::Invoice, recCabFac."No.") THEN BEGIN
            recCabFac.CALCFIELDS("Remaining Amount");
            RegistrarPagoFactura(recCabFac, recCabFac."Remaining Amount")

        END;
    end;

    procedure RegistrarPagoFactura(recPrmCabFac: Record 112; pImporte: Decimal)
    var
        recCfgPOS: Record 34002500;
        recBancosTienda: Record 34002504;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        intLinea: Integer;
        Text001: Label 'Liq. factura TPV Doc. %1';
    begin
        recCfgPOS.GET;
        recCfgPOS.TESTFIELD("Nombre libro diario");
        recCfgPOS.TESTFIELD("Nombre seccion diario");

        recBancosTienda.GET(recPrmCabFac.Tienda, '');
        recBancosTienda.TESTFIELD("Cod. Banco");

        WITH recPrmCabFac DO BEGIN
            recLinDiaGen.INIT;
            recLinDiaGen.VALIDATE("Journal Template Name", recCfgPOS."Nombre libro diario");
            recLinDiaGen.VALIDATE("Journal Batch Name", recCfgPOS."Nombre seccion diario");
            recLinDiaGen.VALIDATE("Salespers./Purch. Code", "Salesperson Code");
            recLinDiaGen.VALIDATE("Account Type", recLinDiaGen."Account Type"::Customer);
            recLinDiaGen.VALIDATE("Account No.", "Bill-to Customer No.");
            recLinDiaGen.VALIDATE("Posting Date", "Posting Date");

            recLinDiaGen.VALIDATE("Applies-to Doc. Type", recLinDiaGen."Applies-to Doc. Type"::Invoice);
            recLinDiaGen.VALIDATE("Applies-to Doc. No.", "No.");
            recLinDiaGen.VALIDATE("Document Type", recLinDiaGen."Document Type"::Payment);

            recLinDiaGen."Document No." := "No.";
            recLinDiaGen.Description := STRSUBSTNO(Text001, "No. Fiscal TPV");
            recLinDiaGen."Bal. Account Type" := recLinDiaGen."Bal. Account Type"::"Bank Account";
            recLinDiaGen.VALIDATE("Bal. Account No.", recBancosTienda."Cod. Banco");
            recLinDiaGen."External Document No." := "External Document No.";
            //recLinDiaGen.VALIDATE("Currency Code",          recPrmPagoTPV."Cod. divisa");
            recLinDiaGen.VALIDATE(Amount, -pImporte);
            cduRegDia.RunWithCheck(recLinDiaGen);
        END;
    end;

    procedure LiquidaNotaCreditoTPV(codPrmDoc: Code[20])
    var
        recCabNC: Record 114;
        recPagosTPV: Record 34002521;
        cduDim: Codeunit 408;
        recTempDimSet: Record 480 temporary;
        recTempDimSet2: Record 480 temporary;
        optTipoDoc: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
    begin

        //Esta función genera los pagos según divisa y liquida la nota de crédito TPV

        recCabNC.GET(codPrmDoc);

        //Primero se comprueba que no se haya liquidado el mov. cliente
        IF MovClientePendiente(recCabNC."Bill-to Customer No.", optTipoDoc::"Credit Memo", recCabNC."No.") THEN BEGIN

            recPagosTPV.RESET;
            recPagosTPV.SETCURRENTKEY("No. Nota Credito", "Cod. divisa");
            recPagosTPV.SETRANGE("No. Nota Credito", recCabNC."No.");
            recPagosTPV.SETRANGE(Tienda, recCabNC.Tienda);
            recPagosTPV.SETRANGE(TPV, recCabNC.TPV);
            IF recPagosTPV.FINDSET THEN
                REPEAT
                    recPagosTPV.SETRANGE("Cod. divisa", recPagosTPV."Cod. divisa");
                    recPagosTPV.FINDLAST;
                    recPagosTPV.SETRANGE("Cod. divisa");
                    recPagosTPV.CALCFIELDS("Importe Total divisa");
                    IF recPagosTPV."Importe Total divisa" < 0 THEN BEGIN
                        RegistrarPagoNotaCredito(recCabNC, recPagosTPV)
                    END;
                UNTIL recPagosTPV.NEXT = 0;

            recCabNC."Liquidado TPV" := TRUE;
            recCabNC.MODIFY(FALSE);

            recPagosTPV.RESET;
            recPagosTPV.SETCURRENTKEY("No. Nota Credito", "Cod. divisa");
            recPagosTPV.SETRANGE("No. Nota Credito", recCabNC."No.");
            recPagosTPV.SETRANGE(Tienda, recCabNC.Tienda);
            recPagosTPV.SETRANGE(TPV, recCabNC.TPV);
            IF recPagosTPV.FINDSET THEN
                REPEAT
                    recPagosTPV.SETRANGE("Cod. divisa", recPagosTPV."Cod. divisa");
                    recPagosTPV.FINDLAST;
                    recPagosTPV.SETRANGE("Cod. divisa");
                    recPagosTPV.CALCFIELDS("Importe Total divisa");
                    IF recPagosTPV."Importe Total divisa" > 0 THEN
                        RegistrarPagoNotaCredito(recCabNC, recPagosTPV);

                UNTIL recPagosTPV.NEXT = 0;


        END;
    end;

    procedure RegistrarPagoNotaCredito(recPrmCabNC: Record 114; recPrmPagoTPV: Record 34002521)
    var
        recCfgPOS: Record 34002500;
        recBancosTienda: Record 34002504;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        intLinea: Integer;
        Text001: Label 'Liq. Devolucion TPV Doc. %1';
    begin
        recCfgPOS.GET;
        recCfgPOS.TESTFIELD("Nombre libro diario");
        recCfgPOS.TESTFIELD("Nombre seccion diario");

        recBancosTienda.GET(recPrmPagoTPV.Tienda, recPrmPagoTPV."Cod. divisa");
        recBancosTienda.TESTFIELD("Cod. Banco");

        WITH recPrmCabNC DO BEGIN
            recLinDiaGen.INIT;
            recLinDiaGen.VALIDATE("Journal Template Name", recCfgPOS."Nombre libro diario");
            recLinDiaGen.VALIDATE("Journal Batch Name", recCfgPOS."Nombre seccion diario");
            recLinDiaGen.VALIDATE("Salespers./Purch. Code", "Salesperson Code");
            recLinDiaGen.VALIDATE("Account Type", recLinDiaGen."Account Type"::Customer);
            recLinDiaGen.VALIDATE("Account No.", "Bill-to Customer No.");
            recLinDiaGen.VALIDATE("Posting Date", "Posting Date");

            IF recPrmPagoTPV."Importe Total divisa" < 0 THEN BEGIN
                recLinDiaGen.VALIDATE("Applies-to Doc. Type", recLinDiaGen."Applies-to Doc. Type"::"Credit Memo");
                recLinDiaGen.VALIDATE("Applies-to Doc. No.", "No.");
                recLinDiaGen.VALIDATE("Document Type", recLinDiaGen."Document Type"::Refund);
            END
            ELSE BEGIN
                recLinDiaGen.VALIDATE("Applies-to Doc. Type", recLinDiaGen."Applies-to Doc. Type"::Refund);
                recLinDiaGen.VALIDATE("Applies-to Doc. No.", "No.");
                recLinDiaGen.VALIDATE("Document Type", recLinDiaGen."Document Type"::Payment);
            END;

            recLinDiaGen."Document No." := "No.";
            recLinDiaGen.Description := STRSUBSTNO(Text001, "No. Fiscal TPV");
            recLinDiaGen."Bal. Account Type" := recLinDiaGen."Bal. Account Type"::"Bank Account";
            recLinDiaGen.VALIDATE("Bal. Account No.", recBancosTienda."Cod. Banco");
            recLinDiaGen."External Document No." := "External Document No.";
            recLinDiaGen.VALIDATE("Currency Code", recPrmPagoTPV."Cod. divisa");
            recLinDiaGen.VALIDATE(Amount, -recPrmPagoTPV."Importe Total divisa");
            cduRegDia.RunWithCheck(recLinDiaGen);
        END;
    end;

    procedure AnulaPagoFacturaTPV(codPrmFac: Code[20]; codPrmHNC: Code[20])
    var
        recCfgPOS: Record 34002500;
        recCabNC: Record 114;
        recCabFac: Record 112;
        recPagosTPV: Record 34002521;
        recBancosTienda: Record 34002504;
        recLinDiaGen: Record 81;
        cduRegDia: Codeunit 12;
        Text001: Label 'Liq. Nota Crédito TPV Doc. %1';
    begin
        //Esta función busca los pagos introducidos en la factura y liquida la nota de credito contra las mismas cuenta de banco.

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
        EXIT(recMovCliente.FINDFIRST);
    end;

    procedure Efectivo_Local(): Code[20]
    var
        rFpago: Record 34002513;
    begin

        rFpago.RESET;
        rFpago.SETCURRENTKEY("Efectivo Local", "Cod. divisa");
        rFpago.SETRANGE("Efectivo Local", TRUE);
        rFpago.FINDFIRST;
        EXIT(rFpago."ID Pago");
    end;

    procedure GuardarVentaTPV(recPrmCabVta: Record 36; blnRegistroEnLinea: Boolean)
    var
        recPagosTPV: Record 34002521;
        Text001: Label 'Liq. factura TPV Doc. %1';
        recVentaTPV: Record 34002530;
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
        recPagosTPV: Record 34002521;
        Text001: Label 'Liq. factura TPV Doc. %1';
        recVentaTPV: Record 34002530;
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

    procedure InsertarTransaccionCaja(recPrmVentaTPV: Record 34002530; recPrmPago: Record 34002521; PrmNumReg: Code[20])
    var
        recTrans: Record 34002523;
        cduControlTPV: Codeunit 34002505;
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
        recTienda: Record 34002503;
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
        Evento: DotNet ;
        rConf: Record 34002501;
        rBotones: Record 34002511;
        rFPago: Record 34002513;
        rDivPos: Record 34002531;
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

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

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
                    "Sell-to Customer Template Code" := '';
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
                    IF SalesLine.FINDSET THEN
                        SalesLine.MODIFYALL("Sell-to Customer No.", "Sell-to Customer No.", FALSE);
                END;


        // Colegio
    end;

    procedure VentaaCliente(var pSalesH: Record 36; Cliente: Code[20])
    var
        GLsetup: Record 98;
        Cust: Record 18;
        cfComunes: Codeunit 34002503;
    begin

        Cust.GET(pSalesH."Sell-to Customer No.");
        WITH pSalesH DO BEGIN
            "Bill-to Customer No." := Cust."Bill-to Customer No.";
            "Bill-to Customer Template Code" := '';
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

                CreateDim(
                  DATABASE::Customer, "Bill-to Customer No.",
                  DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                  DATABASE::Campaign, "Campaign No.",
                  DATABASE::"Responsibility Center", "Responsibility Center",
                  DATABASE::"Customer Template", "Bill-to Customer Template Code");

            END;

        END;
    end;

    procedure RelacionaAnulacion(var pSalesH: Record 36; CodTienda: Code[20])
    begin

        CASE Pais OF
            1:
                cDominicana.RelacionaAnulacion(pSalesH, CodTienda);
            2:
                cBolivia.RelacionaAnulacion(pSalesH, CodTienda); // Bolivia;
            3:
                cParaguay.RelacionaAnulacion(pSalesH, CodTienda); // Paraguay;
            4:
                cEcuador.RelacionaAnulacion(pSalesH, CodTienda);  // Ecuador;
            5:
                cGuatemala.RelacionaAnulacion(pSalesH, CodTienda);  // Guatemala;
            6:
                cSalvador.RelacionaAnulacion(pSalesH, CodTienda);  // Salvador;
            7:
                cHonduras.RelacionaAnulacion(pSalesH, CodTienda);  // Honduras;
            9:
                cCostaRica.RelacionaAnulacion(pSalesH, CodTienda);  // Costa Rica;
        END;

        IF pSalesH.MODIFY THEN;
    end;

    procedure DeconfiguraAnulaciones(var rec: Record 34002503)
    var
        rTPV: Record 34002501;
        Text001: Label 'Se va a proceder a desconfigurar de la tienda y todas sus POS asignadas la configuración de notas de crédito.\ ¿Continuar?';
        rTienda: Record 34002503;
    begin

        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;

        WITH rTPV DO BEGIN
            RESET;
            SETRANGE(Tienda, rec."Cod. Tienda");
            IF FINDFIRST THEN
                REPEAT
                    CLEAR("NCF Credito fiscal NCR");
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
        rTienda: Record 34002503;
    begin

        rTienda.GET(pTienda);
        EXIT(rTienda."Permite Anulaciones en POS");
    end;

    procedure EsCentral(): Boolean
    var
        recTPV: Record 34002501;
        cduPOS: Codeunit 34002502;
    begin

        recTPV.RESET;
        recTPV.SETCURRENTKEY("Usuario windows");
        recTPV.SETRANGE("Usuario windows", cduPOS.TraerUsuarioWindows);
        EXIT(NOT (recTPV.FINDFIRST));
    end;

    procedure ValidaIDCliente(ID: Code[20]; TipoID: Integer): Text
    var
        Mensaje: Text;
        Evento: DotNet ;
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento();

        Evento.TipoEvento := 18;

        CASE Pais OF
            4:
                Mensaje := cEcuador.ValidaIDCliente(ID, TipoID);
        END;

        IF Mensaje <> '' THEN BEGIN
            Evento.TextoRespuesta := Mensaje;
            Evento.AccionRespuesta := 'ERROR';
        END
        ELSE
            Evento.AccionRespuesta := 'OK';

        EXIT(Evento.aXml());
    end;

    procedure Devolver_Datos_Localizados(pEvento: DotNet ): Text
    begin

        CASE Pais OF
            1:
                EXIT(cDominicana.Devolver_Datos_Localizados(pEvento.IntDato1, pEvento.TextoDato, pEvento.TextoDato2, pEvento.IntDato2));
            ELSE
                EXIT(DevolverSiguienteNum(pEvento.TextoDato, pEvento.TextoDato2, pEvento.TextoDato6, pEvento.IntDato2));
        END;
    end;

    procedure Devolver_NCF(prTrans: Record 34002530): Code[20]
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

    procedure Devolver_NCF_TransCaja(prTrans: Record 34002523): Code[20]
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
        Evento: DotNet ;
        Error001: Label 'El pedido aparcado nº %1 se ha recuperado correctamente.';
        Error002: Label 'El pedido aparcado nº %1 no se ha encontrado en la tabla Sales Header';
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

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

    procedure AnulaA_AnuladoPor(prTrans: Record 34002530): Code[20]
    var
        prTrans2: Record 34002530;
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
        Evento: DotNet ;
        NoSeriesManagement: Codeunit 396;
        text001: Label 'NCF Actualizado CORRECTAMENTE';
        rConfTPV: Record 34002501;
        Serie: Code[20];
    begin

        IF ISNULL(Evento) THEN
            Evento := Evento.Evento;

        COMMIT;
        Evento.TipoEvento := 20;

        IF pSerie = '' THEN BEGIN
            rConfTPV.GET(pTienda, pTPV);
            IF pAnul > 0 THEN
                Serie := rConfTPV."NCF Credito fiscal NCR"
            ELSE
                Serie := rConfTPV."NCF Credito fiscal";
        END
        ELSE
            Serie := pSerie;

        Evento.TextoDato := NoSeriesManagement.TryGetNextNo(Serie, WORKDATE);
        Evento.TextoDato2 := Serie;

        Evento.TextoRespuesta := text001;
        Evento.AccionRespuesta := 'OK';
        EXIT(Evento.aXml())
    end;

    procedure Linea_LocalizadaOFF(var prOrigen: Record 37; var prDestino: Record 37)
    begin

        CASE Pais OF
            5:
                cGuatemala.Linea_LocalizadaOFF(prOrigen, prDestino);
            6:
                cSalvador.Linea_LocalizadaOFF(prOrigen, prDestino);
            7:
                cHonduras.Linea_LocalizadaOFF(prOrigen, prDestino);
            9:
                cCostaRica.Linea_LocalizadaOFF(prOrigen, prDestino);
        END;
    end;
    */
}

