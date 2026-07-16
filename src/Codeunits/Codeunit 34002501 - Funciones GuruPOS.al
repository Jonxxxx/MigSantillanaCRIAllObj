codeunit 34002501 "Funciones GuruPOS"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.


    trigger OnRun()
    begin
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        Error001: Label 'User %1 is not TPV user';
        rConfTPV: Record 34002500;
        rBotones: Record 34002507;
        cuManejaParametros: Codeunit 34002500;
        rSalesHeaderPOS: Record 34002512;
        rSalesLinePOS: Record 34002513;
        I: Integer;
        Ventana: Dialog;
        txt0001: Label 'Procesing line #1######';
        rCust: Record 18;
        rCustPostGroup: Record 92;
        fTipoNCF: Page 34002524;
        ReleaseSalesDoc: Codeunit 414;
        rGenJournalLine: Record 81;
        rFormPagosTPV: Record 34002514;
        rPagosTPV: Record 34002515;
        rDocumentDim: Record 357;
        rTPV: Record 34002503;
        rSHP: Record 34002512;
        rCurrExchRate: Record 330;
        rformasPago: Record 34002514;
        wBalance: Decimal;
        Error002: Label 'Debe elegir un tipo de NCF';
        Error003: Label 'Fecha de registro debe ser igual a la fecha del dia';
        rSalesLine: Record 37;
        rSalesPrice: Record 7002;
        //TODO: Ver rItemCrossReference: Record 5717;
        rItem: Record 27;
        Error004: Label 'There is not buttons or Actions defined';
        rGlobalSalesHeader: Record 36;
        rSalesLines: Record 37;

    procedure BuscaCodBarra(Itemcode: Code[20]; rSalesHeader: Record 36): Boolean
    var
        //TODO: Ver rItemCrossRef: Record 5717;
        rSalesLine1: Record 37;
        NoLinea: Integer;
        rSalesLine: Record 37;
        Encontrado: Boolean;
        rItem: Record 27;
    begin
        //CPMCR-CEC+
        /*
        rConfTPV.GET;
        IF NOT rConfTPV."Sumar lineas" THEN
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FIND('-') THEN
              BEGIN
                rSalesLine1.RESET;
                rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                IF rSalesLine1.FIND('+') THEN
                  NoLinea := rSalesLine1."Line No."
                ELSE
                  NoLinea := 10000;
                rSalesLine.INIT;
                rSalesLine."Document Type"   := rSalesHeader."Document Type";
                rSalesLine.VALIDATE("Document Type");
                rSalesLine."Document No."    := rSalesHeader."No.";
                rSalesLine.VALIDATE("Document No.");
                rSalesLine."Line No."        := NoLinea + 1;
                rSalesLine.VALIDATE("Line No.");
                rSalesLine.Type              := rSalesLine.Type::Item;
                rSalesLine.VALIDATE(Type);
                rSalesLine."No."             := rItemCrossRef."Item No.";
                rSalesLine.VALIDATE("No.");
                rSalesLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                rSalesLine.VALIDATE("Unit of Measure Code");
                rSalesLine.Quantity          := 1;
                rSalesLine.VALIDATE(Quantity);
                rSalesLine.VALIDATE("Qty. to Ship",1);
                rSalesLine.VALIDATE("Qty. to Invoice",1);
                rSalesLine.INSERT(TRUE);
                Encontrado := TRUE;
              END
            ELSE
              Encontrado := FALSE;
        
            //Si no encuentra Cod. barra busca No. producto.
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rSalesLine1.RESET;
                    rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                    rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                    IF rSalesLine1.FIND('+') THEN
                      NoLinea := rSalesLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rSalesLine.INIT;
                    rSalesLine."Document Type"   := rSalesHeader."Document Type";
                    rSalesLine.VALIDATE("Document Type");
                    rSalesLine."Document No."    := rSalesHeader."No.";
                    rSalesLine.VALIDATE("Document No.");
                    rSalesLine."Line No."        := NoLinea + 1;
                    rSalesLine.VALIDATE("Line No.");
                    rSalesLine.Type              := rSalesLine.Type::Item;
                    rSalesLine.VALIDATE(Type);
                    rSalesLine."No."             := rItem."No.";
                    rSalesLine.VALIDATE("No.");
                    rSalesLine.Quantity          := 1;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.VALIDATE("Qty. to Ship",1);
                    rSalesLine.VALIDATE("Qty. to Invoice",1);
                    rSalesLine.INSERT(TRUE);
                    Encontrado := TRUE;
                  END;
               END;
            EXIT(Encontrado);
          END
        ELSE
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FINDFIRST THEN
              BEGIN
                //Se busca productos iguales para sumarlos en
                //una misma linea
                rSalesLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                rSalesLine.RESET;
                rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
                rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
                rSalesLine.SETRANGE(rSalesLine."No.",rItemCrossRef."Item No.");
                rSalesLine.SETRANGE(rSalesLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                rSalesLine.SETRANGE(rSalesLine."Anulada en TPV",FALSE);
                IF rSalesLine.FINDFIRST THEN
                  BEGIN
                    rSalesLine.Quantity += 1;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.MODIFY(TRUE);
                    Encontrado := TRUE;
                  END
                ELSE
                  BEGIN
                    rSalesLine1.RESET;
                    rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                    rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                    IF rSalesLine1.FINDLAST THEN
                      NoLinea := rSalesLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rSalesLine.INIT;
                    rSalesLine."Document Type"   := rSalesHeader."Document Type";
                    rSalesLine.VALIDATE("Document Type");
                    rSalesLine."Document No."    := rSalesHeader."No.";
                    rSalesLine.VALIDATE("Document No.");
                    rSalesLine."Line No."        := NoLinea + 1;
                    rSalesLine.VALIDATE("Line No.");
                    rSalesLine.Type              := rSalesLine.Type::Item;
                    rSalesLine.VALIDATE(Type);
                    rSalesLine."No."             := rItemCrossRef."Item No.";
                    rSalesLine.VALIDATE("No.");
                    rSalesLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                    rSalesLine.VALIDATE("Unit of Measure Code");
                    rSalesLine.Quantity          := 1;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.VALIDATE("Qty. to Ship",1);
                    rSalesLine.VALIDATE("Qty. to Invoice",1);
                    rSalesLine.INSERT(TRUE);
                    Encontrado := TRUE;
                  END;
              END
            ELSE
              Encontrado := FALSE;
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rSalesLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                    rSalesLine.RESET;
                    rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
                    rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
                    rSalesLine.SETRANGE(rSalesLine."No.",rItem."No.");
                    rSalesLine.SETRANGE(rSalesLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                    rSalesLine.SETRANGE(rSalesLine."Anulada en TPV",FALSE);
                    IF rSalesLine.FINDFIRST THEN
                      BEGIN
                        rSalesLine.Quantity += 1;
                        rSalesLine.VALIDATE(Quantity);
                        rSalesLine.MODIFY(TRUE);
                        Encontrado := TRUE;
                      END
                    ELSE
                      BEGIN
                        rSalesLine1.RESET;
                        rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                        rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                        IF rSalesLine1.FINDLAST THEN
                          NoLinea := rSalesLine1."Line No."
                        ELSE
                          NoLinea := 10000;
                        rSalesLine.INIT;
                        rSalesLine."Document Type"   := rSalesHeader."Document Type";
                        rSalesLine.VALIDATE("Document Type");
                        rSalesLine."Document No."    := rSalesHeader."No.";
                        rSalesLine.VALIDATE("Document No.");
                        rSalesLine."Line No."        := NoLinea + 1;
                        rSalesLine.VALIDATE("Line No.");
                        rSalesLine.Type              := rSalesLine.Type::Item;
                        rSalesLine.VALIDATE(Type);
                        rSalesLine."No."             := rItem."No.";
                        rSalesLine.VALIDATE("No.");
                        rSalesLine.Quantity          := 1;
                        rSalesLine.VALIDATE(Quantity);
                        rSalesLine.VALIDATE("Qty. to Ship",1);
                        rSalesLine.VALIDATE("Qty. to Invoice",1);
                        rSalesLine.INSERT(TRUE);
                        Encontrado := TRUE;
                      END;
                  END;
              END;
            EXIT(Encontrado);
          END;
        */
        //CPMCR-CEC-

    end;

    procedure InsertaPedido(IDCajero: Code[20])
    var
        rSalesHeader: Record 36;
        rCajeros: Record 34002502;
        rGrupoCajeros: Record 34002501;
        rDimDefAlmacen: Record 34002505;
        rAlmacen: Record 14;
        rTienda: Record 34002504;
        rDocumentDim: Record 357;
        rTPV_Loc: Record 34002503;
    begin
        //CPMCR-CEC+
        /*
        rSalesHeader.INIT;
        rSalesHeader."Document Type" := rSalesHeader."Document Type"::Order;
        
        IF rTPV_Loc.GET(USERID) THEN
          BEGIN
            rTPV_Loc.TESTFIELD(rTPV_Loc."No. serie Pedidos");
            rSalesHeader."No." := NoSeriesMgt.GetNextNo(rTPV_Loc."No. serie Pedidos",WORKDATE,TRUE);
            rSalesHeader.VALIDATE("No.");
        
            rSalesHeader."Order Date"   := WORKDATE;
            rSalesHeader.VALIDATE("Order Date");
            rSalesHeader."Posting Date" := WORKDATE;
            rSalesHeader.VALIDATE("Posting Date");
            rSalesHeader."Document Date" := WORKDATE;
            rSalesHeader.VALIDATE("Document Date");
            IF rCajeros.GET(IDCajero) THEN
              BEGIN
                rCajeros.TESTFIELD(rCajeros."Grupo Cajero");
                IF rGrupoCajeros.GET(rCajeros."Grupo Cajero") THEN
                  BEGIN
                    //rGrupoCajeros.TESTFIELD(rGrupoCajeros."Cliente al contado");
                    IF rGrupoCajeros."Cliente al contado" <> '' THEN
                      BEGIN
                        rSalesHeader."Sell-to Customer No." := rGrupoCajeros."Cliente al contado";
                        rSalesHeader.VALIDATE("Sell-to Customer No.");
                      END;
                  END;
              END;
            rSalesHeader."Order Date"   := WORKDATE;
            rSalesHeader.VALIDATE("Order Date");
            rSalesHeader."Posting Date" := WORKDATE;
            rSalesHeader.VALIDATE("Posting Date");
            rSalesHeader."Document Date" := WORKDATE;
            rSalesHeader.VALIDATE("Document Date");
        
            //Buscarmos las dimensiones por defecto en el Almacen
            //Correspondiente
            IF rTienda.GET(rCajeros.Tienda) THEN
              IF rAlmacen.GET(rTienda."Cod. Almacen") THEN
                BEGIN
                  rDimDefAlmacen.RESET;
                  rDimDefAlmacen.SETRANGE(rDimDefAlmacen."Cod. Almacen",rAlmacen.Code);
                  IF rDimDefAlmacen.FIND('-') THEN
                    REPEAT
                      rDocumentDim.INIT;
                      rDocumentDim."Table ID" := 36;
                      rDocumentDim.VALIDATE("Table ID");
                      rDocumentDim."Document Type" := rSalesHeader."Document Type";
                      rDocumentDim.VALIDATE("Document Type");
                      rDocumentDim."Document No." := rSalesHeader."No.";
                      rDocumentDim.VALIDATE("Document No.");
                      rDocumentDim."Line No." := 0;
                      rDocumentDim."Dimension Code" := rDimDefAlmacen."Codigo Dimension";
                      rDocumentDim.VALIDATE("Dimension Code");
                      rDocumentDim."Dimension Value Code" := rDimDefAlmacen."Valor Dimension";
                      rDocumentDim.VALIDATE("Dimension Value Code");
                      IF NOT rDocumentDim.INSERT THEN
                        rDocumentDim.MODIFY;
                    UNTIL rDimDefAlmacen.NEXT = 0;
                END;
        
            rSalesHeader."Tipo pedido" := rSalesHeader."Tipo pedido"::TPV;
            rSalesHeader."ID Cajero" := IDCajero;
            rSalesHeader.TPV         := USERID;
            IF rTPV_Loc."NCF Credito fiscal" <> '' THEN
              rSalesHeader.VALIDATE("No. Serie NCF Facturas",rTPV_Loc."NCF Credito fiscal");
            rCajeros.GET(IDCajero);
            rCajeros.TESTFIELD(Tienda);
            rSalesHeader.Tienda := rCajeros.Tienda;
            rSalesHeader.VALIDATE("Location Code",rTienda."Cod. Almacen");
            CLEAR(rSalesHeader."Bill-to Name");
            CLEAR(rSalesHeader."Bill-to Address");
            CLEAR(rSalesHeader."Bill-to Post Code");
            CLEAR(rSalesHeader."Sell-to Customer Name");
            CLEAR(rSalesHeader."Sell-to Address");
            CLEAR(rSalesHeader."Sell-to Post Code");
            rSalesHeader.INSERT(TRUE);
            rSalesHeader.VALIDATE("Location Code",rTienda."Cod. Almacen");
            rSalesHeader.MODIFY;
            COMMIT;
          END
        ELSE
          ERROR(Error001,USERID);
        */
        //CPMCR-CEC-

    end;

    procedure MenuCaja(var intNoOfColumnsAcc: Integer; var intNoOfRowsAcc: Integer; var wCantBotAcc: Integer; var wCantBotPagos: Integer; var IntNoOfColumnsPagos: Integer; var IntNoOfROwsPagos: Integer; var IDSubMenuAcciones: array[5] of Integer)
    var
        rMenVtasTPV: Record 34002506;
        rAcciones: Record 34002508;
        wCantBotAcciones: Integer;
        NoColumnasAcciones: Integer;
        NoFilasAcciones: Integer;
        wCantButtsMen2: Integer;
        I: Integer;
        Nombre: Text[30];
        NoColumnasPagos: Integer;
        NoFilasAPagos: Integer;
        rTPV: Record 34002503;
        rBotones: Record 34002507;
        int: Integer;
    begin
        //CPMCR-CEC+
        /*
        IF rTPV.GET(USERID) THEN
          BEGIN
            rTPV.TESTFIELD(rTPV."Menu de acciones");
            //Menu de acciones
            //Buscamos el menu asignado al TPV para acciones
            rMenVtasTPV.GET(rTPV."Menu de acciones");
            rMenVtasTPV.CALCFIELDS(rMenVtasTPV."Cantidad de botones");
            NoColumnasAcciones := rMenVtasTPV.Columnas;
            NoFilasAcciones    := rMenVtasTPV.Filas;
            wCantBotAcc        := rMenVtasTPV."Cantidad de botones";
        
            //Menu de Formas de pago
            //Buscamos el menu asignado al TPV Pagos
            rMenVtasTPV.GET(rTPV."Menu de formas de pago");
            rMenVtasTPV.CALCFIELDS(rMenVtasTPV."Cantidad de botones");
            NoColumnasPagos := rMenVtasTPV.Columnas;
            NoFilasAPagos   := rMenVtasTPV.Filas;
            wCantBotPagos   := rMenVtasTPV."Cantidad de botones";
        
        
            CLEAR(I);
            rMenVtasTPV.RESET;
            rMenVtasTPV.SETRANGE(rMenVtasTPV."Menu pagos",FALSE);
            rMenVtasTPV.SETFILTER(rMenVtasTPV."Sub-Menu ID", '<>%1',0);
            IF rMenVtasTPV.FIND('-') THEN
              REPEAT
                I += 1;
                rMenVtasTPV.CALCFIELDS(rMenVtasTPV."Cantidad de botones");
                IDSubMenuAcciones[I] := rMenVtasTPV."Cantidad de botones";
              UNTIL rMenVtasTPV.NEXT = 0;
        
          END;
        
        IF (wCantBotAcc = 0) OR (NoFilasAcciones = 0) THEN
          ERROR(Error004);
        intNoOfColumnsAcc := ROUND(wCantBotAcc/ NoFilasAcciones,1,'>');
        intNoOfRowsAcc := NoFilasAcciones;
        
        IntNoOfColumnsPagos := ROUND(wCantBotPagos/ NoFilasAPagos,1,'>');
        IntNoOfROwsPagos := NoFilasAPagos;
        */
        //CPMCR-CEC-

    end;

    procedure ActValoresTPV(rSalesHeader: Record 36; var wTotal: Decimal; var wPago: Decimal; var wAcumulado: Decimal; var wDescuentos: Decimal; var wCambio: Decimal; var wBalance: Decimal)
    var
        rSalesLine: Record 37;
        wPreTotal: Decimal;
        wPrecioMenosDescuento: Decimal;
        rPagosTPV: Record 34002515;
    begin
        //CPMCR-CEC+
        /*
        CLEAR(wTotal);
        CLEAR(wDescuentos);
        CLEAR(wPago);
        rSalesLine.RESET;
        rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
        rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
        IF rSalesLine.FINDSET THEN
          REPEAT
            wTotal      += rSalesLine."Outstanding Amount" + rSalesLine."Line Discount Amount";
            wDescuentos += rSalesLine."Line Discount Amount";
          UNTIL rSalesLine.NEXT = 0;
        
        rPagosTPV.RESET;
        rPagosTPV.SETRANGE(rPagosTPV."No. pedido",rSalesHeader."No.");
        IF rPagosTPV.FINDSET THEN
          REPEAT
            wPago += rPagosTPV."Importe (DL)";
          UNTIL rPagosTPV.NEXT = 0;
        
        wBalance := wTotal - wDescuentos - wPago;
        IF wBalance < 0 THEN
          wBalance := 0;
        
        wCambio := wTotal -wDescuentos - wPago;
        IF wCambio > 0 THEN
          wCambio := 0;
        
        IF wPago = 0 THEN
          wCambio := 0;
        */
        //CPMCR-CEC-

    end;

    procedure AnulaPedidos(rSalesHeader: Record 36)
    var
        rSalesHeaderPOS: Record 34002512;
        rSalesLinesPOS: Record 34002513;
        rSalesLine: Record 37;
        rSalesLine1: Record 37;
        rSalesHeader1: Record 36;
    begin
        //CPMCR-CEC+
        /*
        rSalesHeaderPOS.INIT;
        rSalesHeaderPOS.TRANSFERFIELDS(rSalesHeader);
        rSalesHeaderPOS."Nulo TPV" := TRUE;
        rSalesHeaderPOS.INSERT;
        rSalesLine.RESET;
        rSalesLine.SETRANGE("Document Type",rSalesHeader."Document Type");
        rSalesLine.SETRANGE("Document No.",rSalesHeader."No.");
        IF rSalesLine.FIND('-') THEN
          REPEAT
            rSalesLinesPOS.INIT;
            rSalesLinesPOS.TRANSFERFIELDS(rSalesLine);
            IF NOT rSalesLinesPOS.INSERT THEN
              rSalesLinesPOS.MODIFY;
            IF rSalesLine1.GET(rSalesLine."Document Type",rSalesLine."Document No.",rSalesLine."Line No.") THEN
              rSalesLine1.DELETE;
          UNTIL rSalesLine.NEXT = 0;
        rSalesHeader1.GET(rSalesHeader."Document Type", rSalesHeader."No.");
        rSalesHeader1.DELETE;
        */
        //CPMCR-CEC-

    end;

    procedure AccionesMenuPago(boton: Integer; MenuID: Code[20]; NoPed: Code[20]; wBalance: Decimal)
    begin
        //+
        /*
        rBotones.RESET;
        rBotones.SETRANGE(rBotones."ID boton",boton);
        rBotones.SETRANGE(rBotones."ID Menu",MenuID);
        rBotones.FIND('-');
        
        rformasPago.GET(rBotones.Pago);
        IF rformasPago."Cod. divisa" <> '' THEN
          BEGIN
            rCurrExchRate.RESET;
            rCurrExchRate.SETRANGE("Currency Code",rformasPago."Cod. divisa");
            rCurrExchRate.SETRANGE(rCurrExchRate."Starting Date",0D,WORKDATE);
            rCurrExchRate.FIND('+');
            IF (rCurrExchRate."Exchange Rate Amount" - rCurrExchRate."Relational Exch. Rate Amount") < 0 THEN
              wBalance := ROUND(wBalance/rCurrExchRate."Relational Exch. Rate Amount")
            ELSE
              wBalance := ROUND(wBalance * rCurrExchRate."Relational Exch. Rate Amount");
          END;
        
        cuManejaParametros.RecPed(NoPed,rBotones.Pago,rBotones.Descripcion,wBalance);
        */
        //CPMCR-CEC-

    end;

    procedure RegistraPedidos(rSalesHeader: Record 36; wCambio: Decimal)
    var
        rSalesLine: Record 37;
        rSalesLine1: Record 34002513;
        rSalesLine2: Record 37;
        err001: Label 'Nothing to post';
        Err002: Label 'ORDER WITH REMAINING AMOUNT';
    begin
        //CPMCR-CEC+
        /*
        //para controlar la asignacion del NCF
        cuManejaParametros.Recibe_Paso(0);
        
        IF NOT (rSalesHeader."Posting Date" = WORKDATE) THEN
          ERROR(Error003);
        
        IF NOT ValidaPedido(rSalesHeader) THEN
          ERROR(err001);
        
        wBalance := 0;
        
        //Validamos venta a credito cliente
        rCust.GET(rSalesHeader."Sell-to Customer No.");
        IF NOT rCust."Permite venta a credito" THEN
          IF NOT ValidaVtaCredito(rSalesHeader) THEN
              ERROR(Err002);
        //**
        
        rConfTPV.GET;
        IF rConfTPV."Compresion de ventas" THEN
          BEGIN
            ReleaseSalesDoc.PerformManualRelease(rSalesHeader);
        
            rSalesHeaderPOS.INIT;
            rSalesHeaderPOS.TRANSFERFIELDS(rSalesHeader);
            //Verificamos si es venta a credito
            IF ValidaVtaCredito(rSalesHeader) THEN
              rSalesHeaderPOS."Venta a credito" := FALSE
            ELSE
              rSalesHeaderPOS."Venta a credito" := TRUE;
            rSalesHeaderPOS."Importe a liquidar" := wBalance;
            rSalesHeaderPOS.INSERT(TRUE);
        
            //Pasamos dimension Cabecera y lineas
            rDocumentDim.RESET;
            rDocumentDim.SETRANGE(rDocumentDim."Table ID",36);
            rDocumentDim.SETRANGE(rDocumentDim."Document Type",rDocumentDim."Document Type"::Order);
            rDocumentDim.SETRANGE(rDocumentDim."Document No.",rSalesHeader."No.");
            rDocumentDim.SETRANGE(rDocumentDim."Line No.",0);
            IF rDocumentDim.FIND('-') THEN
              REPEAT
                rDocumentDimPOS.TRANSFERFIELDS(rDocumentDim);
                rDocumentDimPOS."Table ID" := 34002512;
                rDocumentDimPOS.INSERT;
              UNTIL rDocumentDim.NEXT = 0;
        
            rDocumentDim.RESET;
            rDocumentDim.SETRANGE(rDocumentDim."Table ID",37);
            rDocumentDim.SETRANGE(rDocumentDim."Document Type",rDocumentDim."Document Type"::Order);
            rDocumentDim.SETRANGE(rDocumentDim."Document No.",rSalesHeader."No.");
            IF rDocumentDim.FIND('-') THEN
              REPEAT
                rDocumentDimPOS.TRANSFERFIELDS(rDocumentDim);
                rDocumentDimPOS."Table ID" := 34002513;
                rDocumentDimPOS.INSERT;
              UNTIL rDocumentDim.NEXT = 0;
        
            //Funcionalidad NCF en TPV
            rConfTPV.GET;
            IF rConfTPV."Funcionalidad NCF TPV Activa" THEN
              BEGIN
                IF rCust.GET(rSalesHeaderPOS."Sell-to Customer No.") THEN
                  BEGIN
                    rCust.TESTFIELD("Customer Posting Group");
                    rCustPostGroup.GET(rCust."Customer Posting Group");
                    IF rCustPostGroup."No. Serie NCF Factura Venta" = '' THEN
                      BEGIN
                        cuManejaParametros.Recibe(rSalesHeaderPOS."No.",0,0);
                        COMMIT;
                        CLEAR(fTipoNCF);
                        fTipoNCF.RUNMODAL;
        
                        //Se valida que el usuario elija un tipo de NCF
                        //IF NOT cuManejaParametros.ValidaPassword THEN
                        //  ERROR(Error002);
                        COMMIT;
                        WHILE cuManejaParametros.Envia_Paso = 0 DO
                          BEGIN
                            CLEAR(fTipoNCF);
                            fTipoNCF.RUNMODAL;
                          END;
        
        
        
        
                        CLEAR(fTipoNCF);
                      END
                    ELSE
                      BEGIN
                        rSalesHeaderPOS."No. Comprobante Fiscal" := NoSeriesMgt.GetNextNo(rCustPostGroup."No. Serie NCF Factura Venta",
                                                                                          rSalesHeaderPOS."Posting Date",TRUE);
                        rSalesHeaderPOS.MODIFY(TRUE);
                        COMMIT;
                      END;
                  END;
              END;
            Ventana.OPEN(txt0001);
            rSalesLine.RESET;
            rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
            rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
            IF rSalesLine.FIND('-') THEN
              REPEAT
                rSalesLine1.INIT;
                rSalesLine1.TRANSFERFIELDS(rSalesLine);
                rSalesLine1.INSERT(TRUE);
        
                //Borramos las dimensiones de las lineas
                rDocumentDim.RESET;
                rDocumentDim.SETRANGE("Table ID",37);
                rDocumentDim.SETRANGE("Document Type",rDocumentDim."Document Type"::Order);
                rDocumentDim.SETRANGE("Document No.",rSalesLine."Document No.");
                rDocumentDim.SETRANGE("Line No.",rSalesLine."Line No.");
                IF rDocumentDim.FIND('-') THEN
                  rDocumentDim.DELETE(TRUE);
        
                IF rSalesLine2.GET(rSalesLine."Document Type",rSalesLine."Document No.",rSalesLine."Line No.") THEN
                  rSalesLine2.DELETE;
                Ventana.UPDATE(1,rSalesLine.Description);
              UNTIL rSalesLine.NEXT = 0;
        
            //Inserta La forma de pago Cambio
            IF wCambio <> 0 THEN
              BEGIN
                rFormPagosTPV.RESET;
                rFormPagosTPV.SETRANGE(rFormPagosTPV.Cambio,TRUE);
                rFormPagosTPV.FIND('-');
                rPagosTPV.INIT;
                rPagosTPV."Forma pago TPV" := rFormPagosTPV."ID Pago";
                rPagosTPV."No. pedido"     := rSalesHeaderPOS."No.";
                rPagosTPV."Importe (DL)"   := wCambio;
                rPagosTPV.Importe          := wCambio;
                rPagosTPV.Fecha            := WORKDATE;
                rPagosTPV.Hora             := TIME;
                rPagosTPV.INSERT;
              END;
        
            Ventana.CLOSE;
        
            //Eliminamos las dimensiones de la cabecera
            rDocumentDim.RESET;
            rDocumentDim.SETRANGE("Table ID",36);
            rDocumentDim.SETRANGE("Document Type",rDocumentDim."Document Type"::Order);
            rDocumentDim.SETRANGE("Document No.",rSalesLine."Document No.");
            rDocumentDim.SETRANGE("Line No.",0);
            IF rDocumentDim.FIND('-') THEN
              rDocumentDim.DELETE(TRUE);
        
            rSalesHeader.DELETE;
        
            //Imprime ticket de venta
            rTPV.GET(USERID);
            rSHP := rSalesHeaderPOS;
            rSHP.SETRECFILTER();
            REPORT.RUNMODAL(rTPV."ID Reporte contado",FALSE,FALSE,rSHP);
          END
        ELSE
          //Si la opcion de compresion de venta no esta activa
          BEGIN
            IF rConfTPV."Funcionalidad NCF TPV Activa" THEN
              BEGIN
                IF rCust.GET(rSalesHeader."Sell-to Customer No.") THEN
                  BEGIN
                    rCust.TESTFIELD("Customer Posting Group");
                    rCustPostGroup.GET(rCust."Customer Posting Group");
                    IF rCustPostGroup."No. Serie NCF Factura Venta" = '' THEN
                      BEGIN
                        cuManejaParametros.Recibe(rSalesHeader."No.",0,0);
                        COMMIT;
                        CLEAR(fTipoNCF);
                        fTipoNCF.RUNMODAL;
        
                        //Se valida que el usuario elija un tipo de NCF
                        //IF NOT cuManejaParametros.ValidaPassword THEN
                        //  ERROR(Error002);
        
                        CLEAR(fTipoNCF);
                      END
                    ELSE
                      BEGIN
                        rSalesHeader."No. Comprobante Fiscal" := NoSeriesMgt.GetNextNo(rCustPostGroup."No. Serie NCF Factura Venta",
                                                                                          rSalesHeaderPOS."Posting Date",TRUE);
                      END;
                  END;
              END;
            COMMIT;
            rSalesHeader."Tipo pedido" := 0;
            rSalesHeader.MODIFY(TRUE);
          END;
        */
        //CPMCR-CEC-

    end;

    procedure ValidaPedido(rSalesHeader: Record 36): Boolean
    var
        rSalesLine: Record 37;
    begin
        rSalesLine.RESET;
        rSalesLine.SETRANGE(rSalesLine."Document Type", rSalesHeader."Document Type");
        rSalesLine.SETRANGE(rSalesLine."Document No.", rSalesHeader."No.");
        IF rSalesLine.FIND('-') THEN
            REPEAT
                IF rSalesLine."Outstanding Amount" <> 0 THEN
                    EXIT(TRUE);
            UNTIL rSalesLine.NEXT = 0;
        EXIT(FALSE);
    end;

    procedure InsertaFormasPago(NoPedido: Code[20]; wImporte: Decimal)
    begin
    end;

    procedure ImpresionEtiquetas()
    var
        rSolicitudEtiquetas: Record 34002517;
        rItem: Record 27;
        rItem1: Record 27;
        rSolicitudEtiquetas1: Record 34002517;
    begin
        /*
        //CPMCR-CEC+
        rSolicitudEtiquetas.RESET;
        rSolicitudEtiquetas.SETRANGE(rSolicitudEtiquetas.Usuario,USERID);
        rSolicitudEtiquetas.SETFILTER(rSolicitudEtiquetas."Fecha solicitud",'<=%1',WORKDATE);
        rSolicitudEtiquetas.SETRANGE(rSolicitudEtiquetas.Confirmada,TRUE);
        IF rSolicitudEtiquetas.FIND('-') THEN
          REPEAT
            IF rSolicitudEtiquetas.Cantidad <> 0 THEN
              BEGIN
                rSolicitudEtiquetas.TESTFIELD(rSolicitudEtiquetas."No. producto");
                rSolicitudEtiquetas.TESTFIELD("ID Reporte");
                rItem.GET(rSolicitudEtiquetas."No. producto");
                rItem1 := rItem;
                rItem1.SETRECFILTER;
                REPORT.RUNMODAL(rSolicitudEtiquetas."ID Reporte",FALSE,FALSE,rItem1);
                IF rSolicitudEtiquetas1.GET(rSolicitudEtiquetas."ID Reporte",USERID,rSolicitudEtiquetas."No. Linea") THEN
                  rSolicitudEtiquetas1.DELETE;
              END;
          UNTIL rSolicitudEtiquetas.NEXT = 0;
        */
        //CPMCR-CEC-

    end;

    procedure BuscaDescripcion(Descr: Text[200]; rSalesHeader: Record 36) Encontrado: Boolean
    var
        rItem: Record 27;
        rSalesLine: Record 37;
        rSalesLine1: Record 37;
        NoLinea: Integer;
    begin
        rItem.RESET;
        rItem.SETCURRENTKEY("Search Description");
        rItem.SETFILTER(rItem."Search Description", '%1', Descr + '@*');
        IF rItem.FIND('+') THEN BEGIN
            rSalesLine1.RESET;
            rSalesLine1.SETRANGE(rSalesLine1."Document Type", rSalesHeader."Document Type");
            rSalesLine1.SETRANGE(rSalesLine1."Document No.", rSalesHeader."No.");
            IF rSalesLine1.FIND('+') THEN
                NoLinea := rSalesLine1."Line No."
            ELSE
                NoLinea := 10000;
            rSalesLine.INIT;
            rSalesLine."Document Type" := rSalesHeader."Document Type";
            rSalesLine.VALIDATE("Document Type");
            rSalesLine."Document No." := rSalesHeader."No.";
            rSalesLine.VALIDATE("Document No.");
            rSalesLine."Line No." := NoLinea + 1;
            rSalesLine.VALIDATE("Line No.");
            rSalesLine.Type := rSalesLine.Type::Item;
            rSalesLine.VALIDATE(Type);
            rSalesLine."No." := rItem."No.";
            rSalesLine.VALIDATE("No.");
            rSalesLine.Quantity := 1;
            rSalesLine.VALIDATE(Quantity);
            rSalesLine.INSERT(TRUE);
            Encontrado := TRUE;
        END
        ELSE
            Encontrado := FALSE;
        EXIT(Encontrado);
    end;

    procedure ValidaVtaCredito(rSalesHeader: Record 36): Boolean
    var
        rSalesline: Record 37;
        wTotal: Decimal;
        wDescuentos: Decimal;
        wPago: Decimal;
    begin
        //CPMCR-CEC+
        /*
        rSalesline.RESET;
        rSalesline.SETRANGE(rSalesline."Document Type",rSalesHeader."Document Type");
        rSalesline.SETRANGE(rSalesline."Document No.",rSalesHeader."No.");
        IF rSalesline.FIND('-') THEN
          REPEAT
            wTotal      += rSalesline."Outstanding Amount" + rSalesline."Line Discount Amount";
            wDescuentos += rSalesline."Line Discount Amount";
          UNTIL rSalesline.NEXT = 0;
        
        rPagosTPV.RESET;
        rPagosTPV.SETRANGE(rPagosTPV."No. pedido",rSalesHeader."No.");
        IF rPagosTPV.FIND('-') THEN
          REPEAT
            wPago += rPagosTPV."Importe (DL)";
          UNTIL rPagosTPV.NEXT = 0;
        
        wBalance := wTotal - wDescuentos - wPago;
        IF wBalance <= 0 THEN
          EXIT(TRUE)
        ELSE
          EXIT(FALSE);
        */
        //CPMCR-CEC-

    end;

    procedure DescuentosGenerales(rSalesHeader: Record 36; PorcientoDesc: Decimal)
    begin
        rSalesLine.RESET;
        rSalesLine.SETRANGE(rSalesLine."Document Type", rSalesHeader."Document Type");
        rSalesLine.SETRANGE(rSalesLine."Document No.", rSalesHeader."No.");
        rSalesLine.SETRANGE(rSalesLine."Anulada en TPV", FALSE);
        IF rSalesLine.FINDFIRST THEN
            REPEAT
                rSalesLine.VALIDATE("Line Discount %", PorcientoDesc);
                rSalesLine.MODIFY(TRUE);
            UNTIL rSalesLine.NEXT = 0;
    end;

    procedure VerificadorPrecio(CodProd_Barr: Code[20]; var DescrProd: Text[100]; rSalesHeader: Record 36): Decimal
    var
        wPrecio: Decimal;
    begin
        //TODO: Ver 
        /*
          //Se busca el precio por medio al codigo de producto   **Esta funcion actualmente solo funciona para la tarifa "All customer" es
          //**Debe completarse para las demas tarifas si es necesario.
          IF rItem.GET(CodProd_Barr) THEN BEGIN
              DescrProd := rItem.Description;
              rSalesPrice.RESET;
              rSalesPrice.SETRANGE(rSalesPrice."Item No.", rItem."No.");
              IF rSalesHeader."Customer Price Group" <> '' THEN
                  rSalesPrice.SETRANGE(rSalesPrice."Sales Code", rSalesHeader."Customer Price Group");
              // rSalesPrice.SETRANGE(rSalesPrice."Sales Type",rSalesPrice."Sales Type"::"All Customers");
              IF rSalesPrice.FINDFIRST THEN BEGIN
                  REPEAT
                      //Si el precio esta activo lo tomamos
                      IF (rSalesPrice."Ending Date" = 0D) OR (rSalesPrice."Ending Date" >= WORKDATE) THEN
                          wPrecio := rSalesPrice."Unit Price"
                      ELSE
                          wPrecio := 0;
                  UNTIL (rSalesPrice.NEXT = 0) OR (wPrecio = 0);
              END
              ELSE
                  wPrecio := 0;
          END
          ELSE
            //Si no se encuentra por producto se busca por Cod. Barra
            BEGIN

              rItemCrossReference.RESET;
              rItemCrossReference.SETRANGE("Cross-Reference Type", rItemCrossReference."Cross-Reference Type"::"Bar Code");
              rItemCrossReference.SETRANGE("Cross-Reference No.", CodProd_Barr);
              IF rItemCrossReference.FINDFIRST THEN BEGIN
                  rSalesPrice.RESET;
                  rSalesPrice.SETRANGE(rSalesPrice."Item No.", rItemCrossReference."Item No.");
                  IF rSalesHeader."Customer Price Group" <> '' THEN
                      rSalesPrice.SETRANGE(rSalesPrice."Sales Code", rSalesHeader."Customer Price Group");
                  IF rItem.GET(rItemCrossReference."Item No.") THEN
                      DescrProd := rItem.Description;
                  //  rSalesPrice.SETRANGE(rSalesPrice."Sales Type",rSalesPrice."Sales Type"::"All Customers");
                  IF rSalesPrice.FINDFIRST THEN BEGIN
                      REPEAT
                          //Si el precio esta activo lo tomamos
                          IF (rSalesPrice."Ending Date" = 0D) OR (rSalesPrice."Ending Date" >= WORKDATE) THEN
                              wPrecio := rSalesPrice."Unit Price"
                      UNTIL rSalesPrice.NEXT = 0;
                  END
                  ELSE
                      wPrecio := 0;
              END
              ELSE
                  wPrecio := 0;
          END;
  */
        EXIT(wPrecio);
    end;

    procedure BuscaCodBarra_PedidosVendedore(Itemcode: Code[20]; rSalesHeader: Record 36): Boolean
    var
        //TODO: Ver rItemCrossRef: Record 5717;
        rSalesLine1: Record 37;
        NoLinea: Integer;
        rSalesLine: Record 37;
        Encontrado: Boolean;
        rItem: Record 27;
    begin
        //CPMCR-CEC+
        /*
        rConfTPV.GET;
        IF NOT rConfTPV."Sumar lineas" THEN
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FIND('-') THEN
              BEGIN
                rSalesLine1.RESET;
                rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                IF rSalesLine1.FIND('+') THEN
                  NoLinea := rSalesLine1."Line No."
                ELSE
                  NoLinea := 10000;
                rSalesLine.INIT;
                rSalesLine."Document Type"   := rSalesHeader."Document Type";
                rSalesLine.VALIDATE("Document Type");
                rSalesLine."Document No."    := rSalesHeader."No.";
                rSalesLine.VALIDATE("Document No.");
                rSalesLine."Line No."        := NoLinea + 1000;
                rSalesLine.VALIDATE("Line No.");
                rSalesLine.Type              := rSalesLine.Type::Item;
                rSalesLine.VALIDATE(Type);
                rSalesLine."No."             := rItemCrossRef."Item No.";
                rSalesLine.VALIDATE("No.");
                rSalesLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                rSalesLine.VALIDATE("Unit of Measure Code");
                rSalesLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                rSalesLine.VALIDATE(Quantity);
                rSalesLine.INSERT(TRUE);
                Encontrado := TRUE;
              END
            ELSE
              Encontrado := FALSE;
        
            //Si no encuentra Cod. barra busca No. producto.
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rSalesLine1.RESET;
                    rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                    rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                    IF rSalesLine1.FIND('+') THEN
                      NoLinea := rSalesLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rSalesLine.INIT;
                    rSalesLine."Document Type"   := rSalesHeader."Document Type";
                    rSalesLine.VALIDATE("Document Type");
                    rSalesLine."Document No."    := rSalesHeader."No.";
                    rSalesLine.VALIDATE("Document No.");
                    rSalesLine."Line No."        := NoLinea + 1000;
                    rSalesLine.VALIDATE("Line No.");
                    rSalesLine.Type              := rSalesLine.Type::Item;
                    rSalesLine.VALIDATE(Type);
                    rSalesLine."No."             := rItem."No.";
                    rSalesLine.VALIDATE("No.");
                    rSalesLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.INSERT(TRUE);
                    Encontrado := TRUE;
                  END;
               END;
            EXIT(Encontrado);
          END
        ELSE
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FIND('-') THEN
              BEGIN
                //Se busca productos iguales para sumarlos en
                //una misma linea
                rSalesLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                rSalesLine.RESET;
                rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
                rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
                rSalesLine.SETRANGE(rSalesLine."No.",rItemCrossRef."Item No.");
                rSalesLine.SETRANGE(rSalesLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                rSalesLine.SETRANGE(rSalesLine."Anulada en TPV",FALSE);
                IF rSalesLine.FIND('-') THEN
                  BEGIN
                    rSalesLine.Quantity += cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.MODIFY(TRUE);
                    Encontrado := TRUE;
                  END
                ELSE
                  BEGIN
                    rSalesLine1.RESET;
                    rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                    rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                    IF rSalesLine1.FIND('+') THEN
                      NoLinea := rSalesLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rSalesLine.INIT;
                    rSalesLine."Document Type"   := rSalesHeader."Document Type";
                    rSalesLine.VALIDATE("Document Type");
                    rSalesLine."Document No."    := rSalesHeader."No.";
                    rSalesLine.VALIDATE("Document No.");
                    rSalesLine."Line No."        := NoLinea + 1000;
                    rSalesLine.VALIDATE("Line No.");
                    rSalesLine.Type              := rSalesLine.Type::Item;
                    rSalesLine.VALIDATE(Type);
                    rSalesLine."No."             := rItemCrossRef."Item No.";
                    rSalesLine.VALIDATE("No.");
                    rSalesLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                    rSalesLine.VALIDATE("Unit of Measure Code");
                    rSalesLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.INSERT(TRUE);
                    Encontrado := TRUE;
                  END;
              END
            ELSE
              Encontrado := FALSE;
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rSalesLine.SETCURRENTKEY("Document Type","Document No.","Line No.");
                    rSalesLine.RESET;
                    rSalesLine.SETRANGE(rSalesLine."Document Type",rSalesHeader."Document Type");
                    rSalesLine.SETRANGE(rSalesLine."Document No.",rSalesHeader."No.");
                    rSalesLine.SETRANGE(rSalesLine."No.",rItem."No.");
                    rSalesLine.SETRANGE(rSalesLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                    rSalesLine.SETRANGE(rSalesLine."Anulada en TPV",FALSE);
                    IF rSalesLine.FIND('-') THEN
                      BEGIN
                        rSalesLine.Quantity += 1;
                        rSalesLine.VALIDATE(Quantity);
                        rSalesLine.MODIFY(TRUE);
                        Encontrado := TRUE;
                      END
                    ELSE
                      BEGIN
                        rSalesLine1.RESET;
                        rSalesLine1.SETRANGE(rSalesLine1."Document Type",rSalesHeader."Document Type");
                        rSalesLine1.SETRANGE(rSalesLine1."Document No.",rSalesHeader."No.");
                        IF rSalesLine1.FIND('+') THEN
                          NoLinea := rSalesLine1."Line No."
                        ELSE
                          NoLinea := 10000;
                        rSalesLine.INIT;
                        rSalesLine."Document Type"   := rSalesHeader."Document Type";
                        rSalesLine.VALIDATE("Document Type");
                        rSalesLine."Document No."    := rSalesHeader."No.";
                        rSalesLine.VALIDATE("Document No.");
                        rSalesLine."Line No."        := NoLinea + 1000;
                        rSalesLine.VALIDATE("Line No.");
                        rSalesLine.Type              := rSalesLine.Type::Item;
                        rSalesLine.VALIDATE(Type);
                        rSalesLine."No."             := rItem."No.";
                        rSalesLine.VALIDATE("No.");
                        rSalesLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                        rSalesLine.VALIDATE(Quantity);
                        rSalesLine.INSERT(TRUE);
                        Encontrado := TRUE;
                      END;
                  END;
              END;
            EXIT(Encontrado);
          END;
        */
        //CPMCR-CEC-

    end;

    procedure BuscaCodBarra_PedidosConsVend(Itemcode: Code[20]; rTransferHeader: Record 5740): Boolean
    var
        //TODO: Ver rItemCrossRef: Record 5717;
        rTransferLine1: Record 5741;
        NoLinea: Integer;
        rTransferLine: Record 5741;
        Encontrado: Boolean;
        rItem: Record 27;
    begin
        //CPMCR-CEC+
        /*
        rConfTPV.GET;
        IF NOT rConfTPV."Sumar lineas" THEN
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FIND('-') THEN
              BEGIN
                rTransferLine1.RESET;
                rTransferLine1.SETRANGE(rTransferLine1."Document No.",rTransferHeader."No.");
                IF rTransferLine1.FIND('+') THEN
                  NoLinea := rTransferLine1."Line No."
                ELSE
                  NoLinea := 10000;
                rTransferLine.INIT;
                rTransferLine."Document No."    := rTransferHeader."No.";
                rTransferLine.VALIDATE("Document No.");
                rTransferLine."Line No."        := NoLinea + 1000;
                rTransferLine.VALIDATE("Line No.");
                rTransferLine."Item No."             := rItemCrossRef."Item No.";
                rTransferLine.VALIDATE("Item No.");
                rTransferLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                rTransferLine.VALIDATE("Unit of Measure Code");
                rTransferLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                rTransferLine."Item No."             := rItemCrossRef."Item No.";
                rTransferLine.VALIDATE("Item No.");
                rTransferLine.VALIDATE(Quantity);
                rTransferLine.INSERT(TRUE);
                rTransferLine."Item No."             := rItemCrossRef."Item No.";
                rTransferLine.VALIDATE("Item No.");
                rTransferLine.MODIFY(TRUE);
        
        
                Encontrado := TRUE;
              END
            ELSE
              Encontrado := FALSE;
        
            //Si no encuentra Cod. barra busca No. producto.
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rTransferLine1.RESET;
                    rTransferLine1.SETRANGE(rTransferLine1."Document No.",rTransferHeader."No.");
                    IF rTransferLine1.FIND('+') THEN
                      NoLinea := rTransferLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rTransferLine.INIT;
                    rTransferLine."Document No."    := rTransferHeader."No.";
                    rTransferLine.VALIDATE("Document No.");
                    rTransferLine."Line No."        := NoLinea + 1000;
                    rTransferLine.VALIDATE("Line No.");
                    rTransferLine."Item No."             := rItem."No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rTransferLine.VALIDATE(Quantity);
                    rTransferLine."Item No."             := rItem."No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine.INSERT(TRUE);
                    rTransferLine."Item No."             := rItem."No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine.MODIFY(TRUE);
                    Encontrado := TRUE;
                  END;
               END;
            EXIT(Encontrado);
          END
        ELSE
          BEGIN
            rItemCrossRef.RESET;
            rItemCrossRef.SETCURRENTKEY(rItemCrossRef."Cross-Reference No.");
            rItemCrossRef.SETRANGE("Cross-Reference No.",Itemcode);
            IF rItemCrossRef.FIND('-') THEN
              BEGIN
                //Se busca productos iguales para sumarlos en
                //una misma linea
                rTransferLine.SETCURRENTKEY("Document No.","Line No.");
                rTransferLine.RESET;
                rTransferLine.SETRANGE(rTransferLine."Document No.",rTransferHeader."No.");
                rTransferLine.SETRANGE(rTransferLine."Item No.",rItemCrossRef."Item No.");
                rTransferLine.SETRANGE(rTransferLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                IF rTransferLine.FIND('-') THEN
                  BEGIN
                    rTransferLine.Quantity += cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rTransferLine.VALIDATE(Quantity);
                    rTransferLine.MODIFY(TRUE);
                    Encontrado := TRUE;
                  END
                ELSE
                  BEGIN
                    rTransferLine1.RESET;
                    rTransferLine1.SETRANGE(rTransferLine1."Document No.",rTransferHeader."No.");
                    IF rTransferLine1.FIND('+') THEN
                      NoLinea := rTransferLine1."Line No."
                    ELSE
                      NoLinea := 10000;
                    rTransferLine.INIT;
                    rTransferLine."Document No."    := rTransferHeader."No.";
                    rTransferLine.VALIDATE("Document No.");
                    rTransferLine."Line No."        := NoLinea + 1000;
                    rTransferLine.VALIDATE("Line No.");
                    rTransferLine."Item No."             := rItemCrossRef."Item No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine."Unit of Measure Code" := rItemCrossRef."Unit of Measure";
                    rTransferLine.VALIDATE("Unit of Measure Code");
                    rTransferLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                    rTransferLine.VALIDATE(Quantity);
                    rTransferLine."Item No."             := rItemCrossRef."Item No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine.INSERT(TRUE);
                    rTransferLine."Item No."             := rItem."No.";
                    rTransferLine.VALIDATE("Item No.");
                    rTransferLine.MODIFY(TRUE);
        
                    Encontrado := TRUE;
                  END;
              END
            ELSE
              Encontrado := FALSE;
            IF Encontrado = FALSE THEN
              BEGIN
                IF rItem.GET(Itemcode) THEN
                  BEGIN
                    rTransferLine.SETCURRENTKEY("Document No.","Line No.");
                    rTransferLine.RESET;
                    rTransferLine.SETRANGE(rTransferLine."Document No.",rTransferHeader."No.");
                    rTransferLine.SETRANGE(rTransferLine."Item No.",rItem."No.");
                    rTransferLine.SETRANGE(rTransferLine."Unit of Measure Code",rItemCrossRef."Unit of Measure");
                    IF rTransferLine.FIND('-') THEN
                      BEGIN
                        rTransferLine.Quantity += 1;
                        rTransferLine.VALIDATE(Quantity);
                        rTransferLine.MODIFY(TRUE);
                        Encontrado := TRUE;
                      END
                    ELSE
                      BEGIN
                        rTransferLine1.RESET;
                        rTransferLine1.SETRANGE(rTransferLine1."Document No.",rTransferHeader."No.");
                        IF rTransferLine1.FIND('+') THEN
                          NoLinea := rTransferLine1."Line No."
                        ELSE
                          NoLinea := 10000;
                        rTransferLine.INIT;
                        rTransferLine."Document No."    := rTransferHeader."No.";
                        rTransferLine.VALIDATE("Document No.");
                        rTransferLine."Line No."        := NoLinea + 1000;
                        rTransferLine.VALIDATE("Line No.");
                        rTransferLine."Item No."             := rItem."No.";
                        rTransferLine.VALIDATE("Item No.");
                        rTransferLine.Quantity          := cuManejaParametros.EnviaCantidad_PantallaVendedo;
                        rTransferLine.VALIDATE(Quantity);
                        rTransferLine."Item No."             := rItem."No.";
                        rTransferLine.VALIDATE("Item No.");
                        rTransferLine.INSERT(TRUE);
                        rTransferLine."Item No."             := rItem."No.";
                        rTransferLine.VALIDATE("Item No.");
                        rTransferLine.MODIFY(TRUE);
                        Encontrado := TRUE;
                      END;
                  END;
              END;
            EXIT(Encontrado);
          END;
        */
        //CPMCR-CEC-

    end;

    procedure ValidaTienda(SalesHeader: Record 36)
    var
        rSalesHeader: Record 36;
        rCajeros: Record 34002502;
        rGrupoCajeros: Record 34002501;
        rDimDefAlmacen: Record 34002505;
        rAlmacen: Record 14;
        rTienda: Record 34002504;
        rDocumentDim: Record 357;
        rTPV: Record 34002503;
    begin
        //CPMCR-CEC+
        /*
        rSalesHeader.GET(SalesHeader."Document Type",SalesHeader."No.");
        IF rTPV.GET(USERID) THEN
          BEGIN
            IF rCajeros.GET(rSalesHeader."ID Cajero") THEN;
            //Buscarmos las dimensiones por defecto en el Almacen
            //Correspondiente
            IF rTienda.GET(rCajeros.Tienda) THEN
              IF rAlmacen.GET(rTienda."Cod. Almacen") THEN
                BEGIN
                  rDimDefAlmacen.RESET;
                  rDimDefAlmacen.SETRANGE(rDimDefAlmacen."Cod. Almacen",rAlmacen.Code);
                  IF rDimDefAlmacen.FIND('-') THEN
                    REPEAT
                      rDocumentDim.INIT;
                      rDocumentDim."Table ID" := 36;
                      rDocumentDim.VALIDATE("Table ID");
                      rDocumentDim."Document Type" := rSalesHeader."Document Type";
                      rDocumentDim.VALIDATE("Document Type");
                      rDocumentDim."Document No." := rSalesHeader."No.";
                      rDocumentDim.VALIDATE("Document No.");
                      rDocumentDim."Line No." := 0;
                      rDocumentDim."Dimension Code" := rDimDefAlmacen."Codigo Dimension";
                      rDocumentDim.VALIDATE("Dimension Code");
                      rDocumentDim."Dimension Value Code" := rDimDefAlmacen."Valor Dimension";
                      rDocumentDim.VALIDATE("Dimension Value Code");
                      IF NOT rDocumentDim.INSERT THEN
                        rDocumentDim.MODIFY;
                    UNTIL rDimDefAlmacen.NEXT = 0;
                END;
        
            rSalesHeader."Tipo pedido" := rSalesHeader."Tipo pedido"::TPV;
            rSalesHeader.TPV         := USERID;
            SalesHeader.VALIDATE("Location Code",rTienda."Cod. Almacen");
        //    rSalesHeader.MODIFY;
          END
        ELSE
          ERROR(Error001,USERID);
        */
        //CPMCR-CEC-

    end;

    procedure AplicaCupon(NoPedido: Code[20]; NoCupon: Code[20])
    var
        rCabCupon: Record 51009;
        rLinCupon: Record 51010;
        Loc_Error001: Label 'Coupon No. %1 not found';
        Loc_Error002: Label 'The Coupon %1 is not asociated to with customer no. %2';
        rLinCupon2: Record 51010;
        loc_rSalesLine: Record 37;
    begin
        IF rGlobalSalesHeader.GET(1, NoPedido) THEN BEGIN
            IF rCabCupon.GET(NoCupon) THEN BEGIN
                IF rCabCupon."Cod. Cliente" = rGlobalSalesHeader."Sell-to Customer No." THEN BEGIN
                    rLinCupon.RESET;
                    rLinCupon.SETRANGE("No. Cupon", NoCupon);
                    rLinCupon.SETFILTER("Cantidad Pendiente", '>%1', 0);
                    IF rLinCupon.FINDSET THEN
                        REPEAT
                            loc_rSalesLine.RESET;
                            loc_rSalesLine.SETRANGE("Document Type", 1);
                            loc_rSalesLine.SETRANGE("Document No.", NoPedido);
                            loc_rSalesLine.SETRANGE(Type, loc_rSalesLine.Type::Item);
                            loc_rSalesLine.SETRANGE("No.", rLinCupon."Cod. Producto");
                            loc_rSalesLine.SETRANGE(Quantity, rLinCupon.Cantidad);
                            IF loc_rSalesLine.FINDFIRST THEN BEGIN
                                IF rLinCupon."Precio Venta" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Unit Price", rLinCupon."Precio Venta");
                                IF rLinCupon."% Descuento" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Line Discount %", rLinCupon."% Descuento");
                                loc_rSalesLine."Cod. Cupon" := NoCupon;
                                loc_rSalesLine.MODIFY;
                                rLinCupon2.GET(NoCupon, rLinCupon."Cod. Producto");
                                rLinCupon2."Cantidad Pendiente" := 0;
                                rLinCupon2.MODIFY;
                            END;
                        UNTIL rLinCupon.NEXT = 0;
                END
                ELSE
                    ERROR(Loc_Error002, NoCupon, rGlobalSalesHeader."Sell-to Customer No." + rGlobalSalesHeader."Sell-to Customer Name");
            END
            ELSE
                ERROR(Loc_Error001, NoCupon);
        END;
    end;

    procedure AplicaCuponSinCliente(NoPedido: Code[20]; NoCupon: Code[20])
    var
        rCabCupon: Record 51009;
        rLinCupon: Record 51010;
        Loc_Error001: Label 'Coupon No. %1 not found';
        Loc_Error002: Label 'The Coupon %1 is not asociated to with customer no. %2';
        rLinCupon2: Record 51010;
        loc_rSalesLine: Record 37;
    begin
        /* Comentario Control para que se le otorgue el descuento a todos los items del pedido
        IF rGlobalSalesHeader.GET(1,NoPedido) THEN
          BEGIN
            IF rCabCupon.GET(NoCupon) THEN
              BEGIN
                IF (rCabCupon.Impreso) AND (WORKDATE >= rCabCupon."Valido Desde") AND (WORKDATE <= rCabCupon."Valido Hasta") THEN
                  BEGIN
                    rCabCupon.CALCFIELDS(Pendiente);
                    IF rCabCupon.Pendiente THEN
                      BEGIN
                        loc_rSalesLine.RESET;
                        loc_rSalesLine.SETRANGE("Document Type",1);
                        loc_rSalesLine.SETRANGE("Document No.",NoPedido);
                        loc_rSalesLine.SETRANGE(Type,loc_rSalesLine.Type::Item);
                        IF loc_rSalesLine.FINDFIRST THEN
                          REPEAT
                            IF rLinCupon."Precio Venta" <> 0 THEN
                              loc_rSalesLine.VALIDATE("Unit Price",rLinCupon."Precio Venta");
                            IF rCabCupon."Descuento a Padres de Familia" <> 0 THEN
                              loc_rSalesLine.VALIDATE("Line Discount %",rCabCupon."Descuento a Padres de Familia");
                            loc_rSalesLine."Cod. Cupon" := NoCupon;
                            loc_rSalesLine.MODIFY;
        
                            rGlobalSalesHeader.GET(loc_rSalesLine."Document Type",loc_rSalesLine."Document No.");
                            rGlobalSalesHeader.VALIDATE("Cod. Cupon",NoCupon);
                            rGlobalSalesHeader.VALIDATE("Salesperson Code",rCabCupon."Cod. Vendedor");
                            rGlobalSalesHeader.MODIFY;
        
                          UNTIL loc_rSalesLine.NEXT = 0;
                      END;
                  END;
              END;
          END;
         */
        IF rGlobalSalesHeader.GET(1, NoPedido) THEN BEGIN
            IF rCabCupon.GET(NoCupon) THEN BEGIN
                IF (rCabCupon.Impreso) AND (WORKDATE >= rCabCupon."Valido Desde") AND (WORKDATE <= rCabCupon."Valido Hasta") AND
                   (rCabCupon.Anulado = FALSE) THEN BEGIN
                    rLinCupon.RESET;
                    rLinCupon.SETRANGE("No. Cupon", NoCupon);
                    rLinCupon.SETFILTER("Cantidad Pendiente", '>%1', 0);
                    IF rLinCupon.FINDSET THEN
                        REPEAT
                            loc_rSalesLine.RESET;
                            loc_rSalesLine.SETRANGE("Document Type", 1);
                            loc_rSalesLine.SETRANGE("Document No.", NoPedido);
                            loc_rSalesLine.SETRANGE(Type, loc_rSalesLine.Type::Item);
                            loc_rSalesLine.SETRANGE("No.", rLinCupon."Cod. Producto");
                            loc_rSalesLine.SETRANGE(Quantity, 0, rLinCupon."Cantidad Pendiente");
                            IF loc_rSalesLine.FINDFIRST THEN BEGIN
                                IF rLinCupon."Precio Venta" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Unit Price", rLinCupon."Precio Venta");
                                IF rLinCupon."% Descuento" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Line Discount %", rLinCupon."% Descuento");
                                loc_rSalesLine."Cod. Cupon" := NoCupon;
                                loc_rSalesLine.MODIFY;

                                rGlobalSalesHeader.GET(loc_rSalesLine."Document Type", loc_rSalesLine."Document No.");
                                rGlobalSalesHeader.VALIDATE("Cod. Cupon", NoCupon);
                                rGlobalSalesHeader.VALIDATE("Salesperson Code", rCabCupon."Cod. Vendedor");
                                rGlobalSalesHeader.MODIFY;

                            END;
                        UNTIL rLinCupon.NEXT = 0;
                END;
            END
            ELSE
                ERROR(Loc_Error001, NoCupon);
        END;

    end;

    procedure ActualizaCupon(rSalesHeader_Loc: Record 36)
    var
        rLinCupon: Record 51010;
        CantidadPendiente: Integer;
    begin
        rSalesLines.RESET;
        rSalesLines.SETRANGE("Document Type", rSalesHeader_Loc."Document Type");
        rSalesLines.SETRANGE("Document No.", rSalesHeader_Loc."No.");
        rSalesLines.SETRANGE(Type, rSalesLines.Type::Item);
        rSalesLines.SETFILTER(rSalesLines."Cod. Cupon", '<>%1', '');
        IF rSalesLines.FINDSET THEN
            REPEAT
                CantidadPendiente := 0;
                IF rLinCupon.GET(rSalesLines."Cod. Cupon", rSalesLines."No.") THEN BEGIN
                    CantidadPendiente := rLinCupon."Cantidad Pendiente" - ABS(rSalesLines.Quantity);
                    IF CantidadPendiente < 0 THEN
                        rLinCupon."Cantidad Pendiente" := 0
                    ELSE
                        rLinCupon."Cantidad Pendiente" := CantidadPendiente;
                    rLinCupon.MODIFY;
                END;
            UNTIL rSalesLines.NEXT = 0;
    end;

    procedure BuscaTarifa(CodCliente: Code[20]; CodProducto: Code[40]): Decimal
    var
        rSalesHeader_Loc: Record 36;
        txt001: Label 'test';
        rSalesLines_Loc: Record 37;
        wPrecio: Decimal;
    begin
        //Si es el codigo del producto
        IF rItem.GET(CodProducto) THEN BEGIN
            rSalesHeader_Loc.RESET;
            rSalesHeader_Loc.INIT;
            rSalesHeader_Loc.VALIDATE("Document Type", 1);
            rSalesHeader_Loc."No." := txt001;
            rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
            rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
            rSalesHeader_Loc.INSERT(TRUE);

            rSalesLines_Loc.INIT;
            rSalesLines_Loc.VALIDATE("Document Type", 1);
            rSalesLines_Loc."Document No." := txt001;
            rSalesLines_Loc."Line No." := 1000;
            rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
            rSalesLines_Loc.VALIDATE("No.", CodProducto);
            rSalesLines_Loc.VALIDATE(Quantity, 1);
            rSalesLines_Loc.INSERT(TRUE);
            wPrecio := rSalesLines_Loc."Unit Price";


            IF rSalesHeader_Loc.DELETE(TRUE) THEN;

            EXIT(wPrecio);
        END
        ELSE BEGIN
            //TODO: Ver rItemCrossReference.RESET;
            //TODO: Ver rItemCrossReference.SETRANGE("Cross-Reference Type", rItemCrossReference."Cross-Reference Type"::"Bar Code");
            //TODO: Ver rItemCrossReference.SETRANGE(rItemCrossReference."Cross-Reference No.", CodProducto);
            //TODO: Ver IF rItemCrossReference.FINDFIRST THEN BEGIN
            rSalesHeader_Loc.RESET;
            rSalesHeader_Loc.INIT;
            rSalesHeader_Loc.VALIDATE("Document Type", 1);
            rSalesHeader_Loc."No." := txt001;
            rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
            rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
            rSalesHeader_Loc.INSERT(TRUE);

            rSalesLines_Loc.INIT;
            rSalesLines_Loc.VALIDATE("Document Type", 1);
            rSalesLines_Loc."Document No." := txt001;
            rSalesLines_Loc."Line No." := 1000;
            rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
            //TODO: Ver rSalesLines_Loc.VALIDATE("No.", rItemCrossReference."Item No.");
            rSalesLines_Loc.VALIDATE(Quantity, 1);
            rSalesLines_Loc.INSERT(TRUE);
            wPrecio := rSalesLines_Loc."Unit Price";
            IF rSalesHeader_Loc.DELETE(TRUE) THEN;

            EXIT(wPrecio);

            //TODO: Ver END;
        END;
    end;
}

