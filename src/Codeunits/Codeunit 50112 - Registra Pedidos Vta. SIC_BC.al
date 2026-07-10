codeunit 50112 "Registra Pedidos Vta. SIC_BC"
{
    // Proyecto: Implementacion Microsoft Dynamic
    // 
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------------
    // No.        Fecha           Firma    Descripcion
    // ------------------------------------------------------------------------
    // 001        01/02/2024      LDP      Mejoras Integracion DSPOS-SIC.
    // 002        26/02/2024      LDP      SANTINAV-5844 Problemas en la replicación Equipo Canal 3
    // 003        12/10/2024      LDP      SANTINAV-7408: Problemas cola de proyecto Transfer_SIC / DS-POS
    // 004        04/02/2025      LDP      SANTINAV-7551
    // 005        12-05-2025      LDP      SANTINAV-8823

    Permissions = TableData 36 = rimd,
                  TableData 34002533 = rimd;

    trigger OnRun()
    begin
        RegistrarCobrosDsPos.ProcesaNoLiquidados();//004+-
        //RegistraFactura();//001+
        RegistraFacturaVs2();//001+-

        /*// Solo para liquidar documentos masivos
        StarDate := 01012022D;
        
        SalesInvHeader.RESET;
        SalesInvHeader.SETFILTER("Posting Date",'%1..',StarDate);
        //SalesInvHeader.SETRANGE("No.",'VFR10-001725');
        SalesInvHeader.SETRANGE("Venta TPV",TRUE);
        IF SalesInvHeader.FINDSET THEN BEGIN
          REPEAT
            //SalesInvHeader2.RESET;
            SalesInvHeader2.GET(SalesInvHeader."No.");
            SalesInvHeader2.CALCFIELDS("Remaining Amount");
            //SalesInvHeader.CALCFIELDS("Remaining Amount");
            IF SalesInvHeader2."Remaining Amount" > 1 THEN
               RegistrarCobrosSCR2(SalesInvHeader."No.");
        
          UNTIL SalesInvHeader.NEXT=0;
          MESSAGE('Finalizado!');
        END;
        */

    end;

    var
        SH Record: 36;
        SSH: Record 110;
        SalesPostPrint_WMS: Codeunit 50113;
        SH2Record 36;
        SalesInvHeader Record: 112;
        SalesInvHeader2Record 112;
        Customer: Record 18;
        I: Integer;
        Registrar: Boolean;
        TipoBloqueo: Option " ",Ship,Invoice,All;
        CustomerNo: Code[20];
        SalesLine2Record 37;
        Item: Record 27;
        RegistrarVentasenLoteDsPOS: Codeunit 34002522;
        Text002: Label 'Registrada Correctamente';
        Numlogs: Integer;
        rCabLog Record: 34002533;
        Transfer_SIC: Codeunit 50110;
        StarDate: Date;
        Fecha: Date;
        SH_Record 36;
        SL_Record 37;
        CabVentasSIC Record: 50111;
        MediosdePagosSIC Record: 50113;
        Importe: Decimal;
        wFechaProceso: Date;
        contador: Integer;
        RegistrarCobrosDsPos: Codeunit 50116;

    procedure RegistraFactura()
    var
        LineasVentasSIC Record: 50112;
        SalesLine Record: 37;
        Text001: Label 'Please check the order amount and the amount in the intermediate table  | %1  | %2  | %3';
        propina: Decimal;
        Text002: Label 'Error en los medios de pagos  | %1  | %2  | %3';
    begin
        Transfer_SIC.ActualizarMediodepago();
        rCabLog.INIT;
        rCabLog.Fecha := WORKDATE;
        rCabLog."Hora Inicio" := FormatTime(TIME);
        rCabLog.INSERT(TRUE);
        Numlogs := rCabLog."No. Log";
        Fecha := 010323D;
        I := 0;
        SH.RESET;
        //SH.SETCURRENTKEY("Venta TPV","Posting Date");
        SH.SETRANGE("Document Type", SH."Document Type"::Order, SH."Document Type"::"Credit Memo");
        //SH.SETFILTER( "Posting Date",'%1..',Fecha);
        //SH.SETRANGE("No.",'VFR4-004128');
        //SH.SETCURRENTKEY("Actualizado WMS");
        //SH.SETFILTER("No.",'<>%1|%2|%3|%4|%5','VFR6-004089','VFR21-000004','VFR21-000005','VFR21-000006','VFR21-000002');
        SH.SETFILTER("No. Documento SIC", '<>%1', '');
        SH.SETRANGE("Venta TPV", TRUE);
        //SH.SETFILTER("Error Registro",'<>%1','');
        //SH.SETRANGE("Posting Date",310522D,010123D);//AMS Temporal
        propina := 0;
        contador := 0;
        IF SH.FINDSET THEN
            REPEAT
                //RegistrarVentasenLoteDsPOS.AsignarDimensiones(SH);
                Registrar := TRUE;
                IF wFechaProceso <> 0D THEN BEGIN
                    SH."Posting Date" := wFechaProceso;
                    SH.MODIFY;
                END;
                //Limina las lineas que no le correspondan al pedido
                SL_.RESET;
                SL_.SETRANGE("Document No.", SH."No.");
                SL_.SETRANGE("Document Type", SH."Document Type");
                SL_.SETRANGE("Location Code", SH."Location Code");
                SL_.CALCSUMS("Amount Including VAT");
                IF SL_.FINDSET(TRUE, FALSE) THEN BEGIN
                    REPEAT
                        LineasVentasSIC.RESET;
                        LineasVentasSIC.SETRANGE("No. documento", SH."No.");
                        LineasVentasSIC.SETRANGE("No. linea", SL_."Line No.");
                        LineasVentasSIC.SETRANGE(codproducto, SL_."No.");
                        IF NOT LineasVentasSIC.FINDFIRST THEN BEGIN
                            //SL_.DELETE; //001+- // Se comenta para que no borre datos de las tablas intermedias.
                            Registrar := FALSE;
                        END;
                    UNTIL SL_.NEXT = 0;
                END;

                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SH."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                SalesLine.CALCSUMS("Amount Including VAT");
                SalesLine.CALCSUMS(Amount);

                CLEAR(Importe);
                Importe := 0;
                MediosdePagosSIC.RESET;
                //MediosdePagosSIC.SETCURRENTKEY("Location Code","No. documento SIC");
                MediosdePagosSIC.SETRANGE("No. documento", SH."No.");//LDP-001+- Se filtra por No.
                MediosdePagosSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");
                IF SH."Document Type" = SH."Document Type"::Order THEN BEGIN
                    MediosdePagosSIC.SETRANGE("Tipo documento", 1);
                    /*ELSE
                      MediosdePagosSIC.SETRANGE("Tipo documento",2);*/
                    IF MediosdePagosSIC.FINDSET THEN BEGIN
                        REPEAT
                            Importe += MediosdePagosSIC.Importe;
                        UNTIL MediosdePagosSIC.NEXT = 0;
                    END;
                END;
                IF Importe < SalesLine."Amount Including VAT" THEN
                    Importe := 0;
                IF Importe = 0 THEN BEGIN
                    MediosdePagosSIC.RESET;
                    //MediosdePagosSIC.SETCURRENTKEY("Location Code","No. Serie Pos");
                    MediosdePagosSIC.SETRANGE("No. documento", SH."Posting No.");
                    IF SH."Document Type" = SH."Document Type"::Order THEN BEGIN
                        MediosdePagosSIC.SETRANGE("Tipo documento", 1);
                        /*ELSE
                          MediosdePagosSIC.SETRANGE("Tipo documento",2);*/
                        IF MediosdePagosSIC.FINDSET THEN BEGIN
                            REPEAT
                                Importe += MediosdePagosSIC.Importe;
                            UNTIL MediosdePagosSIC.NEXT = 0;
                        END;
                    END;
                END;


                LineasVentasSIC.RESET;
                LineasVentasSIC.SETRANGE("No. documento", SH."No.");
                LineasVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");//LDP-001+-
                IF SH."Document Type" = SH."Document Type"::"Credit Memo" THEN BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 2);
                END ELSE BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 1);
                END;
                LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");
                LineasVentasSIC.CALCSUMS(Importe);

                propina := LineasVentasSIC."Importe ITBIS Incluido" * 0.1;
                IF SH."Posting No." = '' THEN BEGIN
                    SH."Posting No." := SH."No.";
                    SH.MODIFY;
                END;

                //***************************************************************************
                //          Validacion del montode la cabecera
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SH."No.");
                CabVentasSIC.SETRANGE("Cod. Almacen", SH."Location Code");
                CabVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");//LDP-001+-

                LineasVentasSIC.RESET;
                LineasVentasSIC.SETRANGE("No. documento", SH."No.");
                LineasVentasSIC.SETRANGE("Location Code", SH."Location Code");
                LineasVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");//LDP-001+-

                IF SH."Document Type" = SH."Document Type"::"Credit Memo" THEN BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 2);
                    CabVentasSIC.SETRANGE("Tipo documento", 2);
                END ELSE BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 1);
                    CabVentasSIC.SETRANGE("Tipo documento", 1);
                END;
                LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");
                LineasVentasSIC.CALCSUMS(Importe);
                IF CabVentasSIC.FINDFIRST THEN;
                // Valido si las lineas estan completas
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SH."No.");
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                SalesLine.SETRANGE("Location Code", SH."Location Code");
                SalesLine.CALCSUMS("Amount Including VAT");
                IF ((CabVentasSIC.Monto) - SalesLine."Amount Including VAT") > 1 THEN BEGIN
                    //Transfer_SIC.TransferLineaActualizada3(SH."No.",SH."Document Type",SH."Location Code");
                    Registrar := FALSE;
                END;
                //****************************************************************************

                SalesLine.RESET;
                SalesLine.SETCURRENTKEY("Document No.");
                SalesLine.SETRANGE("Document No.", SH."No.");
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                //SalesLine.SETRANGE("Location Code",SH."Location Code");
                SalesLine.CALCSUMS("Amount Including VAT");
                IF ((Importe - SalesLine."Amount Including VAT") > 1) OR ((Importe - SalesLine."Amount Including VAT") < -1) AND (SH."Document Type" = SH."Document Type"::Order) THEN BEGIN
                    Registrar := FALSE;
                    SH_.RESET;
                    SH_.SETRANGE("No.", SH."No.");
                    IF SH_.FINDSET(TRUE, FALSE) THEN BEGIN
                        SH_."Error Registro" := 'El importe en el medio de pago es mayor al del documento';
                        SH_.MODIFY;
                    END;
                    CrearPago(SH."No.", SH."Posting No.", SH."Location Code");
                END;

                //////////////////
                CLEAR(Importe);
                Importe := 0;
                MediosdePagosSIC.RESET;
                //MediosdePagosSIC.SETCURRENTKEY("Location Code","No. Serie Pos");
                MediosdePagosSIC.SETRANGE("No. documento", SH."No.");//LDP-001+-
                MediosdePagosSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");
                //MediosdePagosSIC.SETRANGE("Fecha registro",SH."Posting Date");
                //MediosdePagosSIC.SETRANGE("Location Code",SH."Location Code");
                IF SH."Document Type" = SH."Document Type"::Order THEN BEGIN
                    MediosdePagosSIC.SETRANGE("Tipo documento", 1);
                    /*ELSE
                      MediosdePagosSIC.SETRANGE("Tipo documento",2);*/
                    IF MediosdePagosSIC.FINDSET THEN BEGIN
                        REPEAT
                            Importe += MediosdePagosSIC.Importe;
                        UNTIL MediosdePagosSIC.NEXT = 0;
                    END;
                END;
                IF (Importe - SalesLine."Amount Including VAT") > 1 THEN
                    Importe := 0;
                IF Importe = 0 THEN BEGIN
                    MediosdePagosSIC.RESET;
                    // MediosdePagosSIC.SETCURRENTKEY("Location Code","No. Serie Pos");
                    //MediosdePagosSIC.SETRANGE("No. documento",SH."Posting No.");//LDP-001+-
                    MediosdePagosSIC.SETRANGE("No. documento", SH."No.");//LDP-001+-
                    MediosdePagosSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");//LDP-001+-
                                                                                           //MediosdePagosSIC.SETRANGE("Fecha registro",SH."Posting Date");
                                                                                           //MediosdePagosSIC.SETRANGE("Location Code",SH."Location Code");
                    IF SH."Document Type" = SH."Document Type"::Order THEN BEGIN
                        MediosdePagosSIC.SETRANGE("Tipo documento", 1);
                        /*ELSE
                          MediosdePagosSIC.SETRANGE("Tipo documento",2);*/
                        IF MediosdePagosSIC.FINDSET THEN BEGIN
                            REPEAT
                                Importe += MediosdePagosSIC.Importe;
                            UNTIL MediosdePagosSIC.NEXT = 0;
                        END;
                    END;
                END;

                IF ((Importe - SalesLine."Amount Including VAT") < 1) OR ((Importe - SalesLine."Amount Including VAT") < -1) AND (SH."Document Type" = SH."Document Type"::Order) THEN BEGIN
                    Registrar := TRUE;
                    //              SH_.RESET;
                    //              SH_.SETRANGE("No.",SH."No.");
                    //              SH_.SETRANGE("Document Type",SH."Document Type");
                    //              IF SH_.FINDSET(TRUE,FALSE) THEN BEGIN
                    //                SH_."Error Registro":= '';
                    //                SH_.MODIFY;
                    //
                    //              END;
                END;
                //////////////////
                // Si el usuario esta bloqueado lo desbloquea
                CLEAR(CustomerNo);
                IF Customer.GET(SH."Sell-to Customer No.") THEN;
                IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                    TipoBloqueo := Customer.Blocked;
                    CustomerNo := SH."Sell-to Customer No.";
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer.MODIFY;
                END;
                //
                //
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SH."No.");
                CabVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");//LDP-001+-
                CabVentasSIC.SETRANGE("Cod. Almacen", SH."Location Code");
                CabVentasSIC.SETRANGE(Fecha, SH."Posting Date");
                CabVentasSIC.SETRANGE("Tipo documento", 1);
                IF (CabVentasSIC.FINDFIRST) AND (SH."Document Type" <> SH."Document Type"::"Credit Memo") THEN BEGIN
                    IF ((CabVentasSIC.Monto - SalesLine."Amount Including VAT") > 1) OR ((CabVentasSIC.Monto - SalesLine."Amount Including VAT") < -1) THEN BEGIN
                        Registrar := FALSE;
                        SH_.RESET;
                        SH_.SETRANGE("No.", SH."No.");
                        SH_.SETRANGE("Document Type", SH."Document Type");
                        IF SH_.FINDSET(TRUE, FALSE) THEN BEGIN
                            SH_."Error Registro" := 'Error favor verificar el monto de las lineas';
                            SH_.MODIFY;
                        END;
                    END;
                END;

                IF (LineasAEnviar) AND (Registrar) THEN BEGIN
                    SH."Error Registro" := '';
                    SH.VALIDATE(Status, SH.Status::Released);
                    SH.VALIDATE(Ship, TRUE);
                    SH.VALIDATE(Invoice, TRUE);
                    IF SH.MODIFY(FALSE) THEN;
                    COMMIT;
                    IF NOT SalesPostPrint_WMS.RUN(SH) THEN BEGIN
                        SH2.RESET;

                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN //JPG PARA EVISTAR ERROR DE CABECERA YA MODIFICADA
                                                                            //SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT,1,100);//005+-//
                            SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT, 1, 350);//005+-
                            IF SH2.MODIFY THEN;

                            //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,FALSE,COPYSTR(GETLASTERRORTEXT,1,100),Numlogs);
                        END;
                    END
                    ELSE BEGIN
                        I += 1;
                        SH2.RESET;
                        //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,FALSE,'El documento fue instertado correctamente Documento No_ '+SH."No.",Numlogs);
                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN
                            SH2."Error Registro" := '';
                            IF SH2.MODIFY THEN;
                        END;
                    END;
                END ELSE BEGIN
                    IF SH."Error Registro" <> '' THEN BEGIN // si ya tiene factura eliminar log error
                        SalesInvHeader.RESET;
                        SalesInvHeader.SETRANGE("Order No.", SH."No.");
                        SalesInvHeader.SETRANGE("No. Documento SIC", SH."No. Documento SIC");//LDP-001+-
                        IF SalesInvHeader.FINDFIRST THEN BEGIN
                            SH."Error Registro" := '';
                            IF SH.MODIFY THEN;
                            //COMMIT;
                        END;
                    END;
                END;

                // Le coloca el estado anterior al usuario
                IF Customer.GET(CustomerNo) THEN BEGIN
                    Customer.Blocked := TipoBloqueo;
                    Customer.MODIFY;
                END;
                contador := contador + 1;
            //
            UNTIL (SH.NEXT = 0) /*OR (contador > 100)*/; //OR (I >= 10);

        // rCabLog."Fecha Fin" := WORKDATE;
        // rCabLog."Hora Fin"  := FormatTime(TIME);
        // rCabLog.MODIFY(FALSE);

        rCabLog."Fecha Fin" := WORKDATE;
        rCabLog."Hora Fin" := FormatTime(TIME);
        rCabLog.MODIFY(FALSE);

    end;

    procedure RegistraFacturaManual()
    var
        LineasVentasSIC Record: 50112;
        SalesLine Record: 37;
        Text001_: Label 'Please check the order amount and the amount in the intermediate table  | %1  | %2  | %3';
        propina: Decimal;
        Text002_: Label 'Error en los medios de pagos  | %1  | %2  | %3';
        rCabLog Record: 34002533;
        CduPOS: Codeunit 34002502;
        recTPV Record: 34002501;
        Seleccion: Integer;
        PagFecha: Page34002559;
        Text000: Label 'Registrar Facturas en su Fecha.,Solicitar Nueva Fecha de Registro.';
        Text001: Label 'Se procederá a Registrar y Liquidar todas las ventas de Tienda\¿Desea Continuar?';
        Text002: Label 'Proceso Terminado';
        Error001: Label 'Cancelado a Petición del Usuario';
        Error002: Label 'Proceso Sólo Disponible en Servidor Central';
        Error003: Label 'La fecha de registro no puede ser inferior a la fecha actual';
    begin

        IF GUIALLOWED THEN BEGIN

            wFechaProceso := 0D;
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

        //VerificarDocumento();
        //RegistraFactura();//001+- //LDP+-  //12/01/2023
        RegistraFacturaVs2();//002+ ////Nueva version de funcion registrar pedidos dspos
        RegistrarCobrosDsPos.ProcesaNoLiquidados();//004+-
    end;

    local procedure LineasAEnviar(): Boolean
    var
        SL_Record 37;
    begin
        SL_.RESET;
        SL_.SETRANGE("Document Type", SH."Document Type");
        SL_.SETRANGE("Document No.", SH."No.");
        IF SH."Document Type" = SH."Document Type"::Order THEN
            SL_.SETFILTER("Qty. to Ship", '<>%1', 0);
        IF NOT SL_.FINDFIRST THEN BEGIN
            //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,FALSE,'Error: no se encontraron lineas a enviar ',Numlogs);
            EXIT(FALSE);
        END
        ELSE
            EXIT(TRUE);
    end;

    procedure RegistraNotaCR()
    var
        LineasVentasSIC Record: 50112;
        SalesLine Record: 37;
        Text001: Label 'Please check the order amount and the amount in the intermediate table  | %1  | %2  | %3';
        propina: Decimal;
        Text002: Label 'Error en los medios de pagos  | %1  | %2  | %3';
    begin
        I := 0;
        SH.RESET;
        SH.SETRANGE("Document Type", SH."Document Type"::"Credit Memo");
        //SH.SETFILTER("No.",'=%1','VNC01-1010000001');
        //SH.SETCURRENTKEY("Actualizado WMS");
        SH.SETRANGE("Venta TPV", TRUE);
        SH.SETRANGE("Posting Date", 053122D, 010123D);//AMS Temporal
        propina := 0;

        propina := 0;
        // rCabLog.INIT;
        // rCabLog.Fecha          := WORKDATE;
        // rCabLog."Hora Inicio"  := FormatTime(TIME);
        // rCabLog.INSERT(TRUE);
        // Numlogs := rCabLog."No. Log";

        IF SH.FINDSET THEN
            REPEAT
                Registrar := TRUE;
                SH.SetHideValidationDialog(TRUE);
                // IF SH.Origen = SH.Origen::"Punto de Venta" THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SH."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                SalesLine.CALCSUMS("Amount Including VAT");
                SalesLine.CALCSUMS(Amount);

                LineasVentasSIC.RESET;
                LineasVentasSIC.SETRANGE("No. documento", SH."No.");
                IF SH."Document Type" = SH."Document Type"::"Credit Memo" THEN BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 2);
                END ELSE BEGIN
                    LineasVentasSIC.SETRANGE("Tipo documento", 1);
                END;
                LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");
                LineasVentasSIC.CALCSUMS(Importe);

                propina := LineasVentasSIC."Importe ITBIS Incluido" * 0.1;

                //        IF  COPYSTR(SH."No. Comprobante Fiscal",1,3) = 'B14' THEN BEGIN
                //            IF ABS(ROUND(ROUND(SalesLine.Amount,0.04,'<'),1,'=') - ROUND(ROUND((LineasVentasSIC.Importe ),0.01,'>'),1,'=')) > 1.5 THEN BEGIN
                //              //ERROR(Text001 ,FORMAT(ROUND(ROUND(SalesLine."Amount Including VAT",0.04,'<'),1,'=') ),FORMAT(ROUND(ROUND(LineasVentasSIC."Importe ITBIS Incluido",0.01,'>'),1,'=')),SH."No.");
                //              SH."Error Registro":=STRSUBSTNO(Text001 ,FORMAT(ROUND(ROUND(SalesLine.Amount,0.04,'<'),1,'=') ),FORMAT(ROUND(ROUND(LineasVentasSIC.Importe,0.01,'>'),1,'=')),SH."No.");
                //              SH.MODIFY;
                //              Registrar := FALSE;
                //            END;
                //        END ELSE BEGIN
                //            IF ABS(ROUND(ROUND(SalesLine."Amount Including VAT",0.04,'<'),1,'=') - ROUND(ROUND((LineasVentasSIC."Importe ITBIS Incluido" ),0.01,'>'),1,'=')) > 1.5 THEN BEGIN
                //              //ERROR(Text001 ,FORMAT(ROUND(ROUND(SalesLine."Amount Including VAT",0.04,'<'),1,'=') ),FORMAT(ROUND(ROUND(LineasVentasSIC."Importe ITBIS Incluido",0.01,'>'),1,'=')),SH."No.");
                //              SH."Error Registro":=STRSUBSTNO(Text001 ,FORMAT(ROUND(ROUND(SalesLine."Amount Including VAT",0.04,'<'),1,'=') ),FORMAT(ROUND(ROUND(LineasVentasSIC."Importe ITBIS Incluido",0.01,'>'),1,'=')),SH."No.");
                //              SH.MODIFY;
                //              Registrar := FALSE;
                //            END;
                //        END;

                // Si el usuario esta bloqueado lo desbloquea
                CLEAR(CustomerNo);
                IF Customer.GET(SH."Sell-to Customer No.") THEN;
                IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                    TipoBloqueo := Customer.Blocked;
                    CustomerNo := SH."Sell-to Customer No.";
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer.MODIFY;
                END;
                //
                //        SalesLine2.RESET;
                //        SalesLine2.SETRANGE("Document No.",SH."No.");
                //        SalesLine2.SETRANGE(Type,SalesLine2.Type::Item);
                //        IF SalesLine2.FINDSET THEN BEGIN
                //          REPEAT
                //          IF Item.GET(SalesLine2."No.") THEN;
                //          IF Item."Prevent Negative Inventory" <> Item."Prevent Negative Inventory"::No THEN BEGIN
                //            Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                //            Item.MODIFY;
                //          END;
                //          UNTIL SalesLine2.NEXT=0;
                //        END;

                IF (Registrar) THEN BEGIN
                    SH.VALIDATE(Status, SH.Status::Released);
                    //SH.VALIDATE(Ship,FALSE);
                    //SH.VALIDATE(Invoice,FALSE);
                    SH.MODIFY();
                    COMMIT;
                    IF NOT SalesPostPrint_WMS.RUN(SH) THEN BEGIN
                        SH2.RESET;

                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN //JPG PARA EVISTAR ERROR DE CABECERA YA MODIFICADA
                                                                            //SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT,1,100);//005+-
                            SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT, 1, 350);//005+-
                                                                                      //MESSAGE(FORMAT(COPYSTR(GETLASTERRORTEXT,1,130)));
                            IF SH2.MODIFY THEN;
                        END;
                    END
                    ELSE BEGIN
                        I += 1;
                        SH2.RESET;
                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN
                            SH2."Error Registro" := STRSUBSTNO(Text002, FORMAT(ROUND(ROUND(SalesLine."Amount Including VAT", 0.04, '<'), 1, '=')), FORMAT(ROUND(ROUND(LineasVentasSIC."Importe ITBIS Incluido", 1.01, '>'), 1, '=')), SH."No.");
                            IF SH2.MODIFY THEN;
                        END;
                    END;
                END ELSE BEGIN
                    //      IF SH."Error Registro" <> '' THEN BEGIN // si ya tiene factura eliminar log error
                    //        SalesInvHeader.RESET;
                    //        SalesInvHeader.SETRANGE("Order No.",SH."No.");
                    //        IF SalesInvHeader.FINDFIRST THEN
                    //          BEGIN
                    //            SH."Error Registro" := '';
                    //            IF SH.MODIFY THEN;
                    //            //COMMIT;
                    //        END;
                    //      END;
                END;

                // Le coloca el estado anterior al usuario
                IF Customer.GET(CustomerNo) THEN BEGIN
                    Customer.Blocked := TipoBloqueo;
                    Customer.MODIFY;
                END;
            //
            //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,FALSE,STRSUBSTNO(Text002,SH."No. Fiscal TPV"),Numlogs);
            UNTIL (SH.NEXT = 0); //OR (I >= 10);
        // rCabLog."Fecha Fin" := WORKDATE;
        // rCabLog."Hora Fin"  := FormatTime(TIME);
        // rCabLog.MODIFY(FALSE);
    end;

    procedure Numlog(numL: Integer)
    begin
        Numlogs := numL;
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

    procedure RegistrarCobrosSCR2(DocNum: Code[20])
    var
        GenJnlLine Record: 81;
        GenJnlLine2Record 81;
        GenJnlPostLine: Codeunit 12;
        OldCustLedgEntry Record: 21;
        NoLin: Integer;
        dImporte: Integer;
        ImporteNeto: Integer;
        MediosdePagoMG Record: 50113;
        ConfMediosdepagos Record: 50110;
        SalesInvoiceLine Record: 113;
        Msg001: Label 'Liq. pago Doc. %1';
        Bancostienda Record: 34002504;
        SIH Record: 112;
        SIH2Record 112;
        SIL Record: 113;
    begin

        NoLin := 0;

        dImporte := 0;
        ImporteNeto := 0;

        SIH2.RESET;
        SIH2.GET(DocNum);
        SIH2.CALCFIELDS("Remaining Amount");


        SIH.RESET;
        SIH.SETRANGE("No.", DocNum);
        IF (SIH.FINDFIRST) AND (SIH2."Remaining Amount" > 1) THEN;
        // Cajaxsucursal.SETRANGE(Caja,SalesInvHeader."Shortcut Dimension 1 Code");
        // IF Cajaxsucursal.FINDFIRST THEN

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento");
        MediosdePagoMG.SETRANGE("Tipo documento", 1, 2);
        MediosdePagoMG.SETFILTER("No. documento", '%1|%2', SIH."Order No.", SIH."Pre-Assigned No.");
        MediosdePagoMG.SETFILTER("Cod. medio de pago", '<>%1&<>%2', '', '99');

        IF SIH."Venta TPV" = TRUE THEN BEGIN
            IF MediosdePagoMG.FINDSET THEN
                REPEAT
                    NoLin += 1000;

                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    IF ConfMediosdepagos.Credito THEN
                        EXIT;

                    SIL.RESET;
                    SIL.SETRANGE("Document No.", SIH."No.");
                    SIL.CALCSUMS("Amount Including VAT");

                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SIH.Tienda);
                    IF Bancostienda.FINDFIRST THEN;

                    Bancostienda.TESTFIELD("Cod. Banco");

                    //ConfMediosdepagos.TESTFIELD("Account No.");
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
                    GenJnlLine."Document No." := SIH."No.";
                    GenJnlLine."Posting Date" := SIH."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SIH."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    //GenJnlLine.VALIDATE("Bal. Account No.",Conceptos.Codigo);
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SIH."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE("Credit Amount", MediosdePagoMG.Importe);
                    //GenJnlLine.VALIDATE("Credit Amount",SalesInvoiceLine."Amount Including VAT");
                    //MESSAGE('%1',dImporte);
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SIH."No.");
                    //GenJnlLine.VALIDATE("Dimension Set ID" ,SIH."Dimension Set ID");
                    GenJnlLine."Salespers./Purch. Code" := SIH."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SIH."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SIH."Shortcut Dimension 2 Code");


                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SIH."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, FALSE);
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Open := TRUE;
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;

                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                UNTIL MediosdePagoMG.NEXT = 0;
        END;
    end;

    procedure CrearPago(NumDoc: Code[20]; NumRDoc: Code[20]; LCode: Code[20])
    var
        CabVentasSIC Record: 50111;
        LineasVentasSIC Record: 50112;
        MPSIC Record: 50113;
        MPSIC2Record 50113;
        MPSIC3Record 50113;
        SalesHeader Record: 36;
        NumSIC: Code[20];
        MPSIC4Record 50113;
        Import: Decimal;
    begin


        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", NumDoc);
        IF SalesHeader.FINDFIRST THEN;
        SalesHeader.CALCFIELDS("Amount Including VAT");
        CabVentasSIC.RESET;
        CabVentasSIC.SETRANGE("No. documento", NumDoc);
        CabVentasSIC.SETRANGE(Fecha, SalesHeader."Posting Date");



        IF CabVentasSIC.FINDFIRST THEN BEGIN
            NumSIC := CONVERTSTR(CabVentasSIC."No. documento", '-', ',');
            LineasVentasSIC.RESET;
            LineasVentasSIC.SETRANGE("No. documento", CabVentasSIC."No. documento");
            LineasVentasSIC.SETRANGE("No. documento SIC", CabVentasSIC."No. documento SIC");
            //LineasVentasSIC.SETRANGE("Location Code",LCode);
            LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");

            CLEAR(Import);
            MPSIC3.RESET;
            //MPSIC3.SETCURRENTKEY("No. documento SIC","No. Serie Pos");
            MPSIC3.SETRANGE("No. documento SIC", SalesHeader."No. Documento SIC");
            MPSIC3.SETRANGE("No. documento", SalesHeader."Posting No.");
            MPSIC3.CALCSUMS(Importe);
            Import := MPSIC3.Importe;
            //MPSIC3.DELETEALL(TRUE);
            IF MPSIC3.FINDSET THEN BEGIN
                REPEAT
                    IF CabVentasSIC.Monto <> Import THEN
                        //MPSIC3.DELETE;//001+- // Se comenta para que no borre datos de las tablas intermedias.
                        Registrar := FALSE //001+- Si importes difieren no se registre.
                UNTIL MPSIC3.NEXT = 0;
            END ELSE BEGIN

                MPSIC4.RESET;
                //MPSIC3.SETCURRENTKEY("No. documento SIC","No. Serie Pos");
                MPSIC4.SETRANGE("No. documento", SalesHeader."No.");
                MPSIC4.CALCSUMS(Importe);
                //MPSIC3.DELETEALL(TRUE);//001+- // Se comenta para que no borre datos de las tablas intermedias.
                IF MPSIC4.FINDSET AND (CabVentasSIC.Monto <> MPSIC4.Importe) THEN BEGIN
                    REPEAT
                    //MPSIC4.DELETE;//001+- // Se comenta para que no borre datos de las tablas intermedias.
                    UNTIL MPSIC4.NEXT = 0;
                END;
            END;


            //IF ((CabVentasSIC.Monto - LineasVentasSIC."Importe ITBIS Incluido") >= -1) AND ( (CabVentasSIC.Monto - LineasVentasSIC."Importe ITBIS Incluido") <= 1) THEN
            IF (CabVentasSIC.Monto <> MPSIC3.Importe) THEN BEGIN
                MPSIC.RESET;
                MPSIC.SETRANGE("No. documento SIC", SalesHeader."No. Documento SIC");
                MPSIC.SETRANGE("No. documento Pos", SalesHeader."Posting No.");
                IF NOT MPSIC.FINDFIRST THEN BEGIN
                    MPSIC2.INIT;
                    MPSIC2."Tipo documento" := 1;
                    MPSIC2."No. documento" := NumDoc;
                    //MPSIC2."Location Code":=LCode;
                    MPSIC2."No. documento Pos" := NumRDoc;
                    MPSIC2.Importe := CabVentasSIC.Monto;
                    MPSIC2."Cod. medio de pago" := '2';
                    MPSIC2."No. documento Pos" := SELECTSTR(2, NumSIC);
                    MPSIC2."No. linea" := '1';
                    MPSIC2."Fecha registro" := CabVentasSIC.Fecha;
                    MPSIC2."No. documento SIC" := SalesHeader."No. Documento SIC";
                    IF NOT MPSIC2.INSERT(TRUE) THEN BEGIN
                        /*MPSIC.RESET;
                        MPSIC.SETCURRENTKEY("No. Serie Pos");
                        MPSIC.SETRANGE("No. documento",SELECTSTR(2,NumSIC)+'-1');
                        IF MPSIC.FINDFIRST THEN
                          BEGIN
                            MPSIC2.INIT;
                            MPSIC2."Tipo documento":=1;
                            MPSIC2."No. documento":= NumRDoc;
                            MPSIC2."Location Code":=LCode;
                            MPSIC2."No. Serie Pos":=NumRDoc;
                            MPSIC2.Importe:= CabVentasSIC.Monto;
                            MPSIC2."Cod. medio de pago":='2';
                            MPSIC2."No. documento Pos":=SELECTSTR(2,NumSIC);
                            MPSIC2."No. linea":='1';
                            MPSIC2."Fecha registro":=CabVentasSIC.Fecha;
                            IF MPSIC2.INSERT THEN;
                        END;*/
                    END;
                END;



            END;
        END;

    end;

    procedure RegistraFacturaVs2()
    var
        LineasVentasSIC Record: 50112;
        Text001: Label 'Please check the order amount and the amount in the intermediate table  | %1  | %2  | %3';
        SL_Record 37;
        propina: Decimal;
        Text002: Label 'Error en los medios de pagos  | %1  | %2  | %3';
        MediosdePagosSIC Record: 50113;
        SH_Record 36;
        Error001: Label 'Cant. líneas no permitidas para registro';
        Error002: Label 'Montos en tablas no coinciden';
        Error003: Label 'Imp. med. pagos no coincide con cabecera';
        Error004: Label 'Imp. cab. SIC no coincide con imp. líneas';
        Error005: Label 'Imp. en "Med. Pagos SIC" no debe ser 0';
        ImporteLinSIC: Decimal;
        ImporteMPSIC: Decimal;
        ImporteSalesLine: Decimal;
        Text003: Label 'El documento fue instertado correctamente Documento No. ';
        Error006: Label 'No Existe "No. Documento" = %1, en tabla intermedia "Cab. Ventas SIC';
        ConfigEmpresa Record: 56001;
        MediosdePagoSIC Record: 50113;
        SalesLine Record: 37;
        CantidadLin: Integer;
        SalesInvoiceHeader Record: 112;
        SalesCrMemoHeader Record: 114;
        Error007: Label '''%1, = %2, existe en Historico';
    begin
        //002+ ////Nueva version de funcion registrar pedidos dspos
        ConfigEmpresa.GET;
        rCabLog.RESET;
        rCabLog.INIT;
        rCabLog.Fecha := WORKDATE;
        rCabLog."Hora Inicio" := FormatTime(TIME);
        rCabLog.INSERT(TRUE);
        Numlogs := rCabLog."No. Log";
        I := 0;

        SH.RESET;
        SH.SETCURRENTKEY("Document Type", "No. Documento SIC", "Venta TPV");
        SH.SETRANGE("Document Type", SH."Document Type"::Order, SH."Document Type"::"Credit Memo");
        SH.SETFILTER("No. Documento SIC", '<>%1', '');//002+-
        SH.SETRANGE("Venta TPV", TRUE);
        //SH.SETRANGE("No.",'VFR5-007205');

        IF SH.FINDSET() THEN
            REPEAT
                CabVentasSIC.RESET;
                LineasVentasSIC.RESET;
                MediosdePagoSIC.RESET;
                CLEAR(ImporteLinSIC);
                CLEAR(ImporteMPSIC);
                CLEAR(ImporteSalesLine);
                ImporteLinSIC := 0;
                ImporteMPSIC := 0;
                Registrar := TRUE;

                IF wFechaProceso <> 0D THEN BEGIN
                    SH."Posting Date" := wFechaProceso;
                    SH.MODIFY;
                END;

                // Valida si cantidad lineas es permitida para registro.//09-01-2024 //LDP+-
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SH."No.");
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                CantidadLin := SalesLine.COUNT;

                /*
                ParametrosLocxPaís.RESET;
                ParametrosLocxPaís.SETRANGE("País",'GT');
                IF CantidadLin >  ParametrosLocxPaís."Cantidad Lin. por factura" THEN BEGIN
                */

                //LDP+ No cuentan con esta configuración activa, se comenta //15/01/2024
                /*
                IF CantidadLin > ConfigEmpresa."Cantidad Lin. por factura" THEN BEGIN
                  Registrar:=FALSE;
                  SH."Error Registro" := Error001;
                  SH.MODIFY;
                END;
                *///LDP+ No cuentan con esta configuración activa //15/01/2024

                // Valida si cantidad lineas es permitida para registro.//09-01-2024 //LDP+-

                // Si el usuario esta bloqueado lo desbloquea
                CLEAR(CustomerNo);
                IF Customer.GET(SH."Sell-to Customer No.") THEN;
                IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                    TipoBloqueo := Customer.Blocked;
                    CustomerNo := SH."Sell-to Customer No.";
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer.MODIFY;
                END;
                //Si el usuario esta bloqueado lo desbloquea

                //Se valida el monto de tablas cabecera, medios de pago, Lineas ventas sic y Lines de venta
                CabVentasSIC.SETRANGE("No. documento", SH."No.");
                CabVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");
                IF NOT CabVentasSIC.FINDFIRST THEN BEGIN
                    Registrar := FALSE;
                    SH."Error Registro" := STRSUBSTNO(Error006, SH."No.");
                    SH.MODIFY;
                END;

                IF Registrar = TRUE THEN BEGIN
                    LineasVentasSIC.SETRANGE("No. documento", SH."No.");
                    LineasVentasSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");
                    IF LineasVentasSIC.FINDSET THEN
                        REPEAT
                            ImporteLinSIC += LineasVentasSIC."Importe ITBIS Incluido";
                        UNTIL LineasVentasSIC.NEXT = 0;

                    MediosdePagoSIC.SETRANGE("No. documento", SH."No.");
                    MediosdePagoSIC.SETRANGE("No. documento SIC", SH."No. Documento SIC");
                    IF MediosdePagoSIC.FINDSET THEN
                        REPEAT
                            ImporteMPSIC += MediosdePagoSIC.Importe;
                        UNTIL MediosdePagoSIC.NEXT = 0;

                    SalesLine.RESET();
                    SalesLine.SETRANGE("Document Type", SH."Document Type");
                    SalesLine.SETRANGE("Document No.", SH."No.");
                    SalesLine.CALCSUMS("Amount Including VAT");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            ImporteSalesLine += SalesLine."Amount Including VAT";
                        UNTIL SalesLine.NEXT = 0;

                    //IF ImporteMPSIC = 0 THEN //002+-
                    IF (ImporteMPSIC = 0) AND (CabVentasSIC.Monto <> 0) THEN//002+-
                      BEGIN
                        Registrar := FALSE;
                        SH."Error Registro" := Error005;
                        SH.MODIFY;
                    END ELSE
                        IF (((ImporteMPSIC - ImporteSalesLine) < -1)) OR (((ImporteMPSIC - ImporteSalesLine) > 1)) THEN BEGIN
                            Registrar := FALSE;
                            SH."Error Registro" := Error003;
                            SH.MODIFY;
                        END ELSE
                            IF (((CabVentasSIC.Monto - ImporteSalesLine) < -1)) OR (((CabVentasSIC.Monto - ImporteSalesLine) > 1)) THEN BEGIN
                                Registrar := FALSE;
                                SH."Error Registro" := Error004;
                                SH.MODIFY;
                            END ELSE
                                IF (((ImporteLinSIC - ImporteSalesLine) < -1) OR ((ImporteLinSIC - ImporteSalesLine) > 1)) OR
                                  (((ImporteMPSIC - ImporteSalesLine) < -1) OR ((ImporteMPSIC - ImporteSalesLine) > 1)) THEN BEGIN
                                    Registrar := FALSE;
                                    SH."Error Registro" := Error002;
                                    SH.MODIFY;
                                END;
                END;

                //LDP+ Si existe SIC en historico no registrar //15/01/2024
                IF (SH."Document Type" = SH."Document Type"::Order) OR (SH."Document Type" = SH."Document Type"::Invoice) THEN BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETCURRENTKEY("No. Documento SIC");
                    SalesInvoiceHeader.SETRANGE("No. Documento SIC", SH."No. Documento SIC");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        Registrar := FALSE;
                        SH."Error Registro" := STRSUBSTNO(Error007, SalesInvoiceHeader.FIELDCAPTION("No. Documento SIC"), SH."No. Documento SIC");
                        SH.MODIFY;
                    END ELSE
                        IF (SH."Document Type" = SH."Document Type"::"Credit Memo") OR (SH."Document Type" = SH."Document Type"::"Return Order") THEN BEGIN
                            SalesCrMemoHeader.RESET;
                            SalesCrMemoHeader.SETCURRENTKEY("No. Documento SIC");
                            SalesCrMemoHeader.SETRANGE("No. Documento SIC", SH."No. Documento SIC");
                            IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                                Registrar := FALSE;
                                SH."Error Registro" := STRSUBSTNO(Error007, SalesCrMemoHeader.FIELDCAPTION("No. Documento SIC"), SH."No. Documento SIC");
                                SH.MODIFY;
                            END;
                        END;
                END;
                //LDP- Si existe SIC en historico no registrar //15/01/2024

                //Se valida el monto de tablas cabecera, medios de pago, Lineas ventas sic y Lines de venta.

                IF (LineasAEnviar) AND (Registrar) THEN BEGIN
                    SH."Error Registro" := '';
                    SH.VALIDATE(Status, SH.Status::Released);
                    SH.VALIDATE(Ship, TRUE);
                    SH.VALIDATE(Invoice, TRUE);
                    //003+
                    IF SH."Categoria Pedido Venta" = '' THEN BEGIN
                        SH."Categoria Pedido Venta" := ConfigEmpresa."Categoria Pedido - P";
                    END;
                    //003-
                    SH.MODIFY(TRUE);
                    COMMIT;
                    IF NOT SalesPostPrint_WMS.RUN(SH) THEN BEGIN
                        SH2.RESET;
                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN
                            //SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT,1,42);///005+-
                            SH2."Error Registro" := COPYSTR(GETLASTERRORTEXT, 1, 350);//005+-
                            IF SH2.MODIFY THEN;
                            //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,TRUE,COPYSTR(GETLASTERRORTEXT,1,100),Numlogs);
                        END;
                    END
                    ELSE BEGIN
                        I += 1;
                        SH2.RESET;
                        //RegistrarVentasenLoteDsPOS.InsertarDetalleSIC(SH,0,FALSE,Text003+SH."No.",Numlogs);//LDP-001+-//004+
                        IF SH2.GET(SH."Document Type", SH."No.") THEN BEGIN
                            SH2."Error Registro" := '';
                            IF SH2.MODIFY THEN;
                        END;
                    END;
                END;

                // Le coloca el estado anterior al usuario
                IF Customer.GET(CustomerNo) THEN BEGIN
                    Customer.Blocked := TipoBloqueo;
                    Customer.MODIFY;
                END;
            //Le coloca el estado anterior al usuario

            UNTIL SH.NEXT = 0;

        rCabLog."Fecha Fin" := WORKDATE;
        rCabLog."Hora Fin" := FormatTime(TIME);
        rCabLog.MODIFY(FALSE);

        //002- //Nueva version de funcion registrar pedidos dspos //LDP+- //12-01-2024+-

    end;
}

