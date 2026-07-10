codeunit 50110 Transfer_SIC
{
    // SSM     : Sebastian Soto Matos
    // ------------------------------------------------------------------------
    // No.         Firma     Fecha            Descripcion
    // ------------------------------------------------------------------------
    // 001         SSM      21-Sep-2022      SANTINAV-3721 - Colocar categoria de pedidos
    // 002         YFC      22/05/2023       SANTINAV-4457 - No se genera documento electronico para ventas POS
    // 003         LDP      22/09/2023       Mejoras a integracion DS-POs SIC
    // 004         LDP      02/05/2024       SANTINAV-5740: Error Cola de Proyecto Transfer SIC
    // 005         LDP      24/02/2024       Control para que no se transfieran documentos sin medios de pagos en tablas sic.
    // 006         LDP      08/08/2024       SANTINAV-6837: Facturas pendientes de liquidar
    // 007         LDP      19/07/2025       SANTINAV-7819: Problemas con la Cola de Proyectos Transfer SIC
    // 008         LDP      12/08/2025       SANTINAV-8823: Mapeo del correo Email FE

    Permissions = TableData 112 = rimd;

    trigger OnRun()
    var
        PrueSIH Record: 112;
        FE_nav: Codeunit 52504;
        intentos: Integer;
        enviados: Integer;
    begin
        /*IF GUIALLOWED THEN
         Ventana.OPEN(Text001);*/
        // //    //ActivarTransferido();
        TransferCabecera(); //LDP+- //26/02/2024
                            //CambiaNoBorrador;
                            //TransferLineaActualizada2()
                            //ActializarFecha();
                            //TransferLineaActualizada2();

        //ActualizarMediodepago();
        //CorregirDocumeto;
        //EliminarDocumento;
        /*
        IF GUIALLOWED THEN
            Ventana.CLOSE;*/
        //InsertLineaPropina('VF-000036',3);
        //RegistraPedidosVtaSIC_BC.RegistraFactura();

        // ++ 002-YFC
        /*
        PrueSIH.GET('VFR6-005784');
        PrueSIH."Tipo Doc Electronico" := PrueSIH."Tipo Doc Electronico"::Tiquete;
        PrueSIH.MODIFY;
        */
        //YFC
        /*
        PrueSIH.RESET;
        PrueSIH.SETCURRENTKEY("Sell-to Customer No.");
        PrueSIH.SETRANGE("Sell-to Customer No.",'S023755');
        //PrueSIH.SETRANGE("No.",'VFR22-000012');
        //PrueSIH.SETRANGE("Tipo Doc Electronico",PrueSIH."Tipo Doc Electronico"::Factura);
        PrueSIH.SETRANGE("Tipo Doc Electronico",PrueSIH."Tipo Doc Electronico"::Tiquete);
        PrueSIH.SETRANGE("Venta TPV",TRUE);
        PrueSIH.SETRANGE("Posting Date",010122D,052223D);
        PrueSIH.SETFILTER("No. Documento SIC",'<>%1','');
        //PrueSIH.SETFILTER(Consecutivo,'<>%1','');
        PrueSIH.SETFILTER(Estado,'<>%1','aceptado');
        //MESSAGE(FORMAT(PrueSIH.COUNT));
        
        IF PrueSIH.FINDSET THEN
          REPEAT
            intentos += 1;
            //PrueSIH."Tipo Doc Electronico" := PrueSIH."Tipo Doc Electronico"::Tiquete;
           // PrueSIH.MODIFY;
        
              //MESSAGE(PrueSIH."No.");
              PrueSIH.Consecutivo := '';
              PrueSIH.MODIFY;
        
              FE_nav.TiqueteElectronico_vCentral(PrueSIH."No.");
              //COMMIT;
             IF PrueSIH.Estado = 'aceptado' THEN
               enviados += 1;
          //UNTIL PrueSIH.NEXT = 0;
          //UNTIL  (intentos = 5000) OR (enviados = 1 );
          //UNTIL  (intentos = 1000) OR (PrueSIH.Estado = 'aceptado' );
          UNTIL  (intentos = 4000) OR (PrueSIH.NEXT = 0);
        //MESSAGE('finalizado');
        MESSAGE(FORMAT(intentos)+':intentos');
        MESSAGE(FORMAT(enviados)+':firmados');
        // -- 002-YFC
        */
        //YFC

        RecalclularImporteLineas();//007+-

    end;

    var
        CabVentasSIC Record: 50111;
        CabVentasSIC_2Record 50111;
        LineasVentasSIC Record: 50112;
        LineasVentasSIC_2Record 50112;
        LineasVentasSIC_3Record 50112;
        MediosdePagoSIC Record: 50113;
        SalesHeader Record: 36;
        SalesHeader2Record 36;
        SH Record: 36;
        SalesLine Record: 37;
        SalesLine2Record 37;
        SalesLine4Record 37;
        GenJnlPostLine: Codeunit 12;
        GenJnlLine Record: 81;
        PaymentMethod Record: 289;
        SalesInvoiceHeader Record: 112;
        SalesInvoiceLine Record: 113;
        Item: Record 27;
        EquiClienteFromHotel Record: 50006;
        ConvertImporte: Decimal;
        ConverDimension: Code[10];
        DimensionSetEntry Record: 480;
        FechaVencimiento: Date;
        NCF: Code[19];
        NCFR: Code[19];
        ValidarCabecera: Boolean;
        ValidarCabecera_GR: Boolean;
        ValidarLineas: Boolean;
        ValidarMediosPago: Boolean;
        ValidacionesErrores: Codeunit 50111;
        Customer: Record 18;
        NoEmpleadoAfiliado: Code[20];
        TipoBloqueo: Option " ",Ship,Invoice,All;
        IUM_Record 5404;
        UnitofMeasure Record: 204;
        Contador: Integer;
        TotContador: Integer;
        Ventana: Dialog;
        ContadorPrueba: Integer;
        findline: Boolean;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        GLAccount Record: 15;
        ConfigEmpresa Record: 50000;
        codproducto: Code[20];
        NegativeInt: Option Default,No,Yes;
        Turno: Integer;
        Nos: Label 'VNR14-000027|VNR14-000027|VNR14-000027|VNR14-000028|VNR14-000028|VNR15-000026|VNR15-000027|VNR15-000027|VNR15-000027|VNR15-000028|VNR15-000028|VNR18-000015|VNR19-000015|VNR19-000016|VNR19-000016|VNR20-000023|VNR20-000024|VNR6-000016|VNR6-000017|VNR7-000016|VNR7-000017|VNR8-000028|VNR8-000028|VNR8-000028|VNR8-000029|VNR8-000030';
        Itembloq: Boolean;
        Insertar: Boolean;
        ConfigCajaElectronica Record: 50114;
        RegistraPedidosVtaSIC_BC: Codeunit 50112;
        ConfDSPoS Record: 56001;
        GenLedSetup Record: 98;
        Cajeros Record: 34002505;
        Contact: Record 5050;
        MediPagoSicExiste: Boolean;
        MedPagoSic Record: 50113;

    local procedure TransferCabecera()
    var
        ConvertFecha: Date;
        ConvertTasaCambio: Decimal;
        ConvertFecha1: Date;
        MPSIC_Record 50113;
        ConfMedPagICG_Record 50110;
        ConfigCajaElectronica Record: 50114;
        MPSIC_2Record 50113;
    begin
        IF GUIALLOWED THEN BEGIN
            ConfDSPoS.GET;
            ConfDSPoS.TESTFIELD("Categoria Pedido - P"); //001+-
        END;
        //CabVentasSIC.LOCKTABLE;//SANTINAV-7819+-
        CabVentasSIC.RESET;
        CabVentasSIC_2.RESET;
        IF ConfigEmpresa.GET THEN;

        CabVentasSIC.SETCURRENTKEY(Transferido);  //JERM-SIC
        CabVentasSIC.SETRANGE(Transferido, FALSE);//JERM-SIC LDP
        CabVentasSIC.SETRANGE(ErroresLineas, FALSE);//JERM-SIC
                                                    //CabVentasSIC.SETRANGE("Tipo documento", 2);
                                                    //CabVentasSIC.SETRANGE("No. documento",'VFR18-005540');//JERM-SIC PREUBA ,'VNR10-000020'
                                                    //CabVentasSIC.SETFILTER("No. documento",'=%1','003027');//JERM-SIC
                                                    //CabVentasSIC.SETRANGE(Fecha,DMY2DATE(4,8,2021),DMY2DATE(4,8,2021));
                                                    // MESSAGE(FORMAT(CabVentasSIC.COUNT));
                                                    //IF CabVentasSIC.FINDSET THEN IF CabVentasSIC.FIND('-') THEN
        TotContador := CabVentasSIC.COUNT;
        Contador := 0;//003+-
        Ventana.OPEN(Text001);//003+-
        CabVentasSIC.LOCKTABLE;
        IF CabVentasSIC.FINDSET THEN
            REPEAT
                IF TotContador = 0 THEN TotContador := 1;
                IF GUIALLOWED THEN BEGIN
                    Contador := Contador + 1;
                    Ventana.UPDATE(1, CabVentasSIC."No. documento");
                    Ventana.UPDATE(2, ROUND(Contador / TotContador * 10000, 1));
                    //Ventana.UPDATE(3,'PROCESANDO CABECERAS Y LINEAS');
                END;
                findline := FALSE;
                MediPagoSicExiste := FALSE;//005+-
                CabVentasSIC_2.GET(CabVentasSIC."Tipo documento", CabVentasSIC."No. documento", CabVentasSIC.Caja, CabVentasSIC."No. documento SIC");
                ContadorPrueba += 1;
                ValidarCabecera_GR := VerificaVtasDuplicadas(CabVentasSIC."No. documento", CabVentasSIC."Tipo documento");//LDP+-
                                                                                                                          ///ValidarCabecera_GR := FALSE;
                IF ValidarCabecera_GR THEN BEGIN
                    CabVentasSIC_2.GET(CabVentasSIC."Tipo documento", CabVentasSIC."No. documento", CabVentasSIC.Caja, CabVentasSIC."No. documento SIC");
                    CabVentasSIC_2.Transferido := TRUE;
                    CabVentasSIC_2.MODIFY(TRUE);
                END;
                // IF NOT ValidarCabecera THEN
                //   BEGIN
                CLEAR(TipoBloqueo);
                CLEAR(NCF);
                CLEAR(NCFR);
                //Validar si hay campos vacios o errores en el registro
                ValidarCabecera := FALSE;
                IF CabVentasSIC.Origen = CabVentasSIC.Origen::"Punto de Venta" THEN
                    ValidarCabecera := ValidacionesErrores.ValidacionesCabeceraSIC(CabVentasSIC_2);
                //ValidarCabecera := FALSE;
                // Validar si hay lineas para la cabeceras
                LineasVentasSIC.RESET;
                LineasVentasSIC.SETRANGE("Tipo documento", CabVentasSIC."Tipo documento");
                LineasVentasSIC.SETRANGE("No. documento", CabVentasSIC."No. documento");
                LineasVentasSIC.SETRANGE("Location Code", CabVentasSIC."Cod. Almacen");
                LineasVentasSIC.SETRANGE("No. documento SIC", CabVentasSIC."No. documento SIC");//003+-
                                                                                                //MESSAGE(FORMAT(LineasVentasSIC.COUNT))
                                                                                                //26/02/2024 //LDP+
                IF LineasVentasSIC.FINDSET THEN BEGIN
                    IF LineasVentasSIC.COUNT > 0 THEN
                        findline := TRUE;
                END;
                //26/02/2024 //LDP+

                //26/02/2024 //LDP+
                //IF LineasVentasSIC.FINDSET THEN ;
                //IF  LineasVentasSIC.COUNT > 0 THEN
                //findline := TRUE;
                //26/02/2024 //LDP-

                LineasVentasSIC.RESET;
                LineasVentasSIC.SETRANGE("No. documento", CabVentasSIC."No. documento");
                LineasVentasSIC.SETRANGE("Tipo documento", CabVentasSIC."Tipo documento");
                LineasVentasSIC.SETRANGE("Location Code", CabVentasSIC."Cod. Almacen");
                LineasVentasSIC.CALCSUMS(Importe);
                LineasVentasSIC.CALCSUMS("Importe descuento");
                LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");

                //005+
                MedPagoSic.RESET;
                MedPagoSic.SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
                MedPagoSic.SETRANGE("Tipo documento", CabVentasSIC."Tipo documento");
                MedPagoSic.SETRANGE("No. documento", CabVentasSIC."No. documento");
                MedPagoSic.SETRANGE("No. documento SIC", CabVentasSIC."No. documento SIC");
                IF MedPagoSic.FINDSET THEN
                    MediPagoSicExiste := TRUE;
                //005-

                //
                //        IF LineasVentasSIC."Importe descuento" > LineasVentasSIC."Importe ITBIS Incluido" THEN BEGIN
                //          CabVentasSIC.ErroresLineas:=TRUE;
                //          CabVentasSIC.MODIFY;
                //          findline := FALSE;
                //        END;

                //IF (NOT ValidarCabecera) AND (NOT ValidarCabecera_GR) AND (findline) THEN
                IF (NOT ValidarCabecera) AND (NOT ValidarCabecera_GR) AND (findline) AND (MediPagoSicExiste) THEN //005+-
                  BEGIN //INICIO

                    //Actualiza la configuracion del cliente de acuerdo al tipo de comprobante que llega desde SICs
                    //IF Customer.GET(CabVentasSIC."Cod. Cliente") THEN BEGIN
                    //END;

                    IF Customer.GET(CabVentasSIC."Cod. Cliente") THEN;
                    IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                        TipoBloqueo := Customer.Blocked;
                        Customer.Blocked := Customer.Blocked::" ";
                        Customer.MODIFY;
                    END;
                    //
                    /*
                    ConfigCajaElectronica.RESET;
                    ConfigCajaElectronica.SETCURRENTKEY("Caja ID",Sucursal);
                    ConfigCajaElectronica.SETRANGE("Caja ID",CabVentasSIC.Caja);
                    ConfigCajaElectronica.SETRANGE( Sucursal,CabVentasSIC.Tienda);
                    IF NOT ConfigCajaElectronica.FINDFIRST THEN
                      EXIT;
                    */
                    //003+
                    ConfigCajaElectronica.RESET;
                    ConfigCajaElectronica.SETCURRENTKEY("Tienda ID", "Caja ID", Sucursal);
                    ConfigCajaElectronica.SETRANGE("Caja ID", CabVentasSIC.Caja);
                    ConfigCajaElectronica.SETRANGE("Tienda ID", CabVentasSIC.Tienda);
                    IF NOT ConfigCajaElectronica.FINDFIRST THEN
                        EXIT;
                    //003-

                    SalesHeader.INIT;
                    CASE CabVentasSIC."Tipo documento" OF
                        1:
                            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Order);
                        2:
                            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    END;
                    //IF CabVentasSIC.Origen = CabVentasSIC.Origen::"From Hotel" THEN

                    SalesHeader."No." := CabVentasSIC."No. documento"; //003+-
                    IF CabVentasSIC."Tipo documento" = 1 THEN
                        SalesHeader."Tipo Doc Electronico" := SalesHeader."Tipo Doc Electronico"::Tiquete; //002-YFC

                    //003+- A comentar
                    /*
                    CASE CabVentasSIC."Tipo documento" OF
                      1:
                        BEGIN
                          //SalesHeader."No." := ConfigCajaElectronica."Serie Factura" +'-'+ CabVentasSIC."No. documento";
                          SalesHeader."No.":=CabVentasSIC."No. documento";
                          SalesHeader."Tipo Doc Electronico" := SalesHeader."Tipo Doc Electronico"::Tiquete; //002-YFC
                        END;
                      2:
                          //SalesHeader."No." := ConfigCajaElectronica."Serie Nota de credito" +'-'+ CabVentasSIC."No. documento";
                          SalesHeader."No.":=CabVentasSIC."No. documento";
                    END;
                    */
                    //003+- A comentar


                    //        IF CabVentasSIC.Origen = CabVentasSIC.Origen::"From Hotel" THEN BEGIN
                    //            SalesHeader.Origen := SalesHeader.Origen::"From Hotel";
                    //        END ELSE BEGIN
                    //            SalesHeader.Origen := SalesHeader.Origen::"Punto de Venta";
                    //        END;

                    IF SalesHeader.INSERT(TRUE) THEN;//JERM-SIC
                    BEGIN

                        SalesHeader.SetHideValidationDialog(TRUE);
                        //SalesHeader.VALIDATE("Customer Price Group",EquiClienteFromHotel."Codigo NCF");

                        //        IF CabVentasSIC.Origen = CabVentasSIC.Origen::"From Hotel" THEN
                        //            SalesHeader.VALIDATE("Sell-to Customer No.",CabVentasSIC."Cod. Cliente")
                        //        ELSE
                        SalesHeader.VALIDATE("Sell-to Customer No.", CabVentasSIC."Cod. Cliente");
                        //SalesHeader.VALIDATE("Sell-to Customer No.",Customer."No.");//003+-
                        // Colocar el cliente con el bloqueo que tenia
                        IF TipoBloqueo <> TipoBloqueo::" " THEN BEGIN
                            Customer.Blocked := TipoBloqueo;
                            Customer.MODIFY;
                        END;

                        //IF (CabVentasSIC."Cod. Cliente" = 'CTE-000001') AND (CabVentasSIC."Nombre Cliente" <> '')THEN
                        //SalesHeader."Sell-to Customer Name" := CabVentasSIC."Nombre Cliente";
                        //003+-
                        IF STRLEN(CabVentasSIC."Nombre Cliente") = 0 THEN
                            SalesHeader."Sell-to Customer Name" := Customer.Name
                        ELSE
                            SalesHeader."Sell-to Customer Name" := CabVentasSIC."Nombre Cliente";
                        //003--
                        //003+ Para que no se altere este dato en la tabla intermedia
                        /*
                         IF CabVentasSIC.Origen = CabVentasSIC.Origen::"From Hotel" THEN BEGIN
                            CabVentasSIC."Cod. Moneda":='2';
                         END ELSE BEGIN
                            CabVentasSIC."Cod. Moneda":='1';
                         END;
                         */
                        //003-
                        CASE CabVentasSIC."Cod. Moneda" OF
                            '1':
                                SalesHeader.VALIDATE("Currency Code", ''); //Moneda Local
                            '2':
                                SalesHeader.VALIDATE("Currency Code", 'USD');
                            '3':
                                SalesHeader.VALIDATE("Currency Code", 'EUR');
                        END;

                        EVALUATE(ConvertTasaCambio, FORMAT(CabVentasSIC."Tasa de cambio"));
                        SalesHeader.VALIDATE("Currency Factor", (1 / ConvertTasaCambio));
                        ConvertFecha := CabVentasSIC.Fecha;//ConvertFechaFunct(CabVentasSIC.Fecha);      /////////////////////////PRUEBA NC///////
                        SalesHeader.VALIDATE("Posting Date", ConvertFecha);
                        NCF := CabVentasSIC."No. comprobante";//COPYSTR(CabVentasSIC."No. comprobante",9,19);
                        NCFR := CabVentasSIC."NCF Afectado";//COPYSTR(CabVentasSIC."NCF Afectado",9,19);
                        IF CabVentasSIC."Tipo documento" = 2 THEN BEGIN
                            SalesHeader."No. Comprobante Fiscal Rel." := NCFR;
                            SalesHeader."No. Comprobante Fiscal" := NCF;
                            SalesHeader."Tipo Doc. Ref NC" := SalesHeader."Tipo Doc. Ref NC"::"Tiquete Electronico";
                        END;

                        //SalesHeader.Origen:=CabVentasSIC.Origen;
                        SalesHeader.VALIDATE("No. Documento SIC", CabVentasSIC."No. documento SIC");
                        SalesHeader."ID Cajero" := ConfigCajaElectronica."Tienda ID";
                        //SalesHeader.VALIDATE(Tienda, ConfigCajaElectronica."Tienda ID");
                        SalesHeader.VALIDATE(Tienda, CabVentasSIC.Tienda);//003+-
                        SalesHeader.VALIDATE(TPV, ConfigCajaElectronica.TPV);
                        SalesHeader.VALIDATE("Venta TPV", TRUE);
                        SalesHeader."No. Comprobante Fiscal" := NCF;//003+- 12-10-2023

                        /*
                        //003+
                        Cajeros.RESET;
                        Cajeros.SETCURRENTKEY(Tienda,"Cod. Cajero SIC");
                        Cajeros.SETRANGE(Tienda,CabVentasSIC.Tienda);
                        Cajeros.SETRANGE("Cod. Cajero SIC",CabVentasSIC."Cod. Cajero");
                        Cajeros.SETRANGE(Tipo,Cajeros.Tipo::Cajero);
                        IF Cajeros.FINDSET THEN
                         SalesHeader.VALIDATE("ID Cajero",Cajeros.ID);
                        //003-
                        */

                        SalesHeader.VALIDATE("Registrado TPV", TRUE);
                        SalesHeader.VALIDATE("Replicado POS", TRUE);
                        SalesHeader.VALIDATE("No. Fiscal TPV", CabVentasSIC."No. documento");
                        EVALUATE(Turno, CabVentasSIC.Turno);
                        SalesHeader.VALIDATE(Turno, Turno);
                        SalesHeader.VALIDATE("Hora creacion", CabVentasSIC.Hora);
                        SalesHeader.VALIDATE(Clave, CabVentasSIC.Clave);
                        SalesHeader.VALIDATE(Consecutivo, CabVentasSIC.Consecutivo);
                        SalesHeader.VALIDATE("Numero Referencia FE", CabVentasSIC.Consecutivo);
                        SalesHeader.VALIDATE("Prices Including VAT", TRUE);//003+-
                                                                           //SalesHeader.VALIDATE("Tipo pedido",SalesHeader."Tipo pedido"::TPV);
                        SalesHeader."Tipo de Venta" := SalesHeader."Tipo de Venta"::Factura;//003+-

                        //003+ 05/10/2023
                        /*
                        IF STRLEN(CabVentasSIC.Colegio) = 4 THEN
                          SalesHeader.VALIDATE("Cod. Colegio",'0'+CabVentasSIC.Colegio)
                        ELSE
                          SalesHeader.VALIDATE("Cod. Colegio",CabVentasSIC.Colegio);
                        */
                        //003-

                        //003+
                        Contact.RESET;
                        //Contact.SETCURRENTKEY("Colegio SIC");
                        //Contact.SETRANGE("Colegio SIC",CabVentasSIC.Colegio);//01-09-2023 //LDP+-
                        Contact.SETRANGE("No.", CabVentasSIC.Colegio);//01-09-2023 //LDP+-
                        IF Contact.FINDFIRST THEN
                            SalesHeader.VALIDATE("Cod. Colegio", Contact."No.");

                        //003-

                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Document No.", ConfigCajaElectronica."Serie Factura" + '-' + CabVentasSIC."NCF Afectado");
                        SalesInvoiceLine.CALCSUMS(Amount);
                        SalesInvoiceLine.CALCSUMS("Amount Including VAT");

                        LineasVentasSIC.RESET;
                        LineasVentasSIC.SETRANGE("No. documento", CabVentasSIC."No. documento");
                        LineasVentasSIC.SETRANGE("Tipo documento", CabVentasSIC."Tipo documento");
                        LineasVentasSIC.SETRANGE("Location Code", CabVentasSIC."Cod. Almacen");
                        LineasVentasSIC.CALCSUMS(Importe);
                        LineasVentasSIC.CALCSUMS("Importe descuento");
                        LineasVentasSIC.CALCSUMS("Importe ITBIS Incluido");


                        IF SalesInvoiceLine.Amount = LineasVentasSIC.Importe THEN
                            SalesHeader."Codigo Referencia" := SalesHeader."Codigo Referencia"::"Devolucion Total"
                        ELSE
                            SalesHeader."Codigo Referencia" := SalesHeader."Codigo Referencia"::"Devolucion Parcial";

                        //SalesHeader."Sincronizado con errores" := TRUE;
                        IF (SalesHeader."VAT Registration No." <> CabVentasSIC.RNC) AND (CabVentasSIC.RNC <> '') THEN
                            //SalesHeader.VALIDATE("VAT Registration No.", CabVentasSIC.RNC);
                            SalesHeader."VAT Registration No." := CabVentasSIC.RNC;//003+-
                        SalesHeader."Source counter" := CabVentasSIC."Source Counter";

                        SalesHeader.VALIDATE("Posting No.", SalesHeader."No.");//003+- A revisar.

                        //003+
                        /*
                        CASE CabVentasSIC."Tipo documento" OF
                          1:
                              BEGIN
                                SalesHeader."Posting No.":= ConfigCajaElectronica."No. Serie Registro Factura Pos" +'-'+ CabVentasSIC.Consecutivo;//006+-
                                SalesHeader."No. Fiscal TPV" := ConfigCajaElectronica."No. Serie Registro Factura Pos" +'-'+ CabVentasSIC.Consecutivo;//006+-
                              END ELSE
                              BEGIN
                                SalesHeader."Posting No.":= ConfigCajaElectronica."No. Serie Registro Nota C." +'-'+ CabVentasSIC.Consecutivo;//006
                                SalesHeader."No. Fiscal TPV" := ConfigCajaElectronica."No. Serie Nota Credito Pos" +'-'+ CabVentasSIC.Consecutivo;//006+-
                              END
                        END;
                        */
                        //003-

                        CASE CabVentasSIC."Tipo documento" OF
                            //1:
                            //SalesHeader."No. Doc Historico" := ConfigCajaElectronica."Serie Factura" +'-'+ CabVentasSIC."No. documento";
                            2:
                                BEGIN
                                    SalesHeader."No. Doc Historico" := ConfigCajaElectronica."Serie Factura" + '-' + CabVentasSIC."NCF Afectado";
                                    SalesHeader."Anula a Documento" := ConfigCajaElectronica."Serie Factura" + '-' + CabVentasSIC."NCF Afectado"; //26/02/2024 //LDP+-
                                END;

                        END;
                        SalesHeader."Posting No." := SalesHeader."No.";
                        //SalesHeader."Shipping No." := SalesHeader."No.";
                        SalesHeader.VALIDATE("Location Code", CabVentasSIC."Cod. Almacen");
                        //SalesHeader.VALIDATE("Nombre Empleado Cte.",COPYSTR(CabVentasSIC."Nombre asegurado",1,50)); //50003
                        //SalesHeader.VALIDATE("No. Autorizacion Seguro",CabVentasSIC."No. orden");//50005 GRN Dejar asi para el seguro
                        NoEmpleadoAfiliado := CabVentasSIC."No. poliza";
                        //SalesHeader.VALIDATE("No. Empleado/Afiliado",NoEmpleadoAfiliado);//50002
                        SalesHeader.VALIDATE("Cod. Cajero", CabVentasSIC."Cod. Cajero");//003+- A revisar
                        SalesHeader.VALIDATE(SalesHeader."Cod. Supervisor", CabVentasSIC."Cod. supervisor");//003+- A revisar
                        ConvertFecha1 := CabVentasSIC."Fecha Venc. NCF";//ConvertFechaFunct(CabVentasSIC."Fecha Venc. NCF"); ////////////////////////////prueba
                        SalesHeader.VALIDATE("Fecha vencimiento NCF", ConvertFecha1);
                        SalesHeader."External Document No." := CabVentasSIC."No. documento";

                        //003+- A comentar
                        /*
                        MPSIC_.RESET;
                        MPSIC_.SETRANGE("No. documento",CabVentasSIC."No. documento");
                        MPSIC_.SETRANGE("Tipo documento",CabVentasSIC."Tipo documento");
                        IF MPSIC_.FINDSET THEN BEGIN
                          REPEAT
                            MPSIC_2.RESET;
                            //MPSIC_2.SETCURRENTKEY("No. documento Pos","No. linea","Tipo documento");
                            MPSIC_2.SETRANGE("No. documento",MPSIC_."No. documento");
                            MPSIC_2.SETRANGE("Tipo documento",MPSIC_."Tipo documento");
                            MPSIC_2.SETRANGE("No. linea",MPSIC_."No. linea");
                            IF MPSIC_2.FINDFIRST THEN BEGIN
                              MPSIC_.VALIDATE("No. documento Pos",SalesHeader."No.");
                              MPSIC_.MODIFY;
                            END;
                          UNTIL MPSIC_.NEXT=0;
                        END;
                        */
                        //003+- A comentar


                        //AMS - Para actualizar la forma de pago
                        MPSIC_.RESET;
                        //MPSIC_.TESTFIELD(MPSIC_."Cod. medio de pago");//003+-
                        MPSIC_.SETRANGE("No. documento", CabVentasSIC."No. documento");
                        MPSIC_.SETRANGE("No. documento SIC", CabVentasSIC."No. documento SIC");//003+-
                        IF MPSIC_.FINDFIRST THEN BEGIN
                            IF ConfMedPagICG_.GET(MPSIC_."Cod. medio de pago") THEN BEGIN
                                IF ConfMedPagICG_."Cod. med. pago" <> '' THEN BEGIN
                                    SalesHeader.VALIDATE("Payment Method Code", ConfMedPagICG_."Cod. Forma Pago");
                                END;
                            END;
                        END;
                        SalesHeader."Shipping No." := '';
                        SalesHeader."Ship-to Name" := CabVentasSIC."Nombre Cliente";//003+-
                        SalesHeader."Bill-to Name" := CabVentasSIC."Nombre Cliente";//003+-
                        SalesHeader.VALIDATE("E-Mail", CabVentasSIC."Correo Electronico");//003+-
                        SalesHeader.VALIDATE("E-Mail-FE", CabVentasSIC."Correo Electronico");//008+-
                                                                                             //SalesHeader.VALIDATE("Sell-to Phone",CabVentasSIC."No. Telefono");//003+-
                                                                                             //SalesHeader.VALIDATE("Ship-to Phone",CabVentasSIC."No. Telefono");//003+-
                                                                                             //SalesHeader.VALIDATE("Categoria Pedido Venta",ConfDSPoS."Categoria Pedido - P"); //001+-
                        SalesHeader."Categoria Pedido Venta" := ConfDSPoS."Categoria Pedido - P";

                        //Colocar medio de pago como transferido //003+
                        //006+
                        /*
                        MPSIC_.RESET;
                        MPSIC_.SETCURRENTKEY("Tipo documento","No. documento","No. documento SIC");
                        MPSIC_.SETRANGE("Tipo documento",CabVentasSIC."Tipo documento");
                        MPSIC_.SETRANGE("No. documento",CabVentasSIC."No. documento");
                        MPSIC_.SETRANGE("No. documento SIC",CabVentasSIC."No. documento SIC");
                        IF MPSIC_.FINDSET THEN BEGIN
                           REPEAT
                            MPSIC_.Transferido := TRUE;
                            MPSIC_.MODIFY(TRUE);
                           UNTIL MPSIC_.NEXT = 0;
                          END;
                        //Colocar como transferido - //003-
                        */
                        //006-
                        SalesHeader.MODIFY(TRUE);

                        //Colocarlo como transferido
                        /*
                        CabVentasSIC.Transferido :=TRUE;
                        CabVentasSIC.MODIFY;
                        */
                        CabVentasSIC_2.LOCKTABLE;
                        CabVentasSIC_2.GET(CabVentasSIC."Tipo documento", CabVentasSIC."No. documento", CabVentasSIC.Caja, CabVentasSIC."No. documento SIC");
                        CabVentasSIC_2.Transferido := TRUE;
                        CabVentasSIC_2.MODIFY(TRUE);


                        //TransferLineaActualizada(CabVentasSIC."No. documento",CabVentasSIC."Tipo documento",CabVentasSIC."Cod. Cliente",SalesHeader."No.",CabVentasSIC."Cod. Almacen");//JERM-SIC Se envian a crear las lineas de la cabecera actual
                        TransferLineaActualizada(CabVentasSIC."No. documento", CabVentasSIC."Tipo documento", CabVentasSIC."Cod. Cliente", SalesHeader."No.", CabVentasSIC."Cod. Almacen", CabVentasSIC."No. documento SIC");//002+-
                                                                                                                                                                                                                             //003+- Colocar documento estado Lanzado
                        SalesHeader.Status := SalesHeader.Status::Released;
                        SalesHeader.MODIFY(TRUE);
                        //003+- Colocar documento estado Lanzado

                        //COMMIT; //SANTINAV-7819+-
                    END;
                END;   //FIN

            UNTIL CabVentasSIC.NEXT = 0;
        COMMIT;

    end;

    local procedure TransferLineaActualizada(NumDoc: Code[20]; tipodoc: Integer; codcliente: Code[20]; SLCode: Code[20]; Lcode: Code[20]; NoDocSic: Code[40])
    var
        ConvertLinea: Integer;
        ConvertCantidad: Decimal;
        ConvertImporte2: Decimal;
        ConvertPrecio: Decimal;
    begin
        GenLedSetup.GET;//004+-  //02/05/2024

        IF ConfigEmpresa.GET THEN;
        LineasVentasSIC.RESET;
        LineasVentasSIC.SETCURRENTKEY("No. documento", "No. linea");
        LineasVentasSIC.SETRANGE("No. documento", NumDoc);
        LineasVentasSIC.SETRANGE("Location Code", Lcode);
        LineasVentasSIC.SETRANGE(Transferido, FALSE);
        LineasVentasSIC.SETRANGE("No. documento SIC", NoDocSic); //003+ Se agrega No. Doc Sic a filtro.
        //LinVentasIcg.SETFILTER(Errores,'=%1','');
        IF LineasVentasSIC.FINDSET THEN
            REPEAT
                /*IF GUIALLOWED THEN
                  BEGIN
                   Contador := Contador + 1;
                   Ventana.UPDATE(1,LineasVentasSIC."No. documento");
                   Ventana.UPDATE(2,ROUND(Contador / TotContador * 10000,1));
                   //Ventana.UPDATE(3,'PROCESANDO CABECERAS Y LINEAS');
                  END;*/
                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                Insertar := TRUE;
                IF NOT Item.GET(codproducto) THEN BEGIN
                    Insertar := FALSE;
                    SalesHeader."Error Registro" := 'No existe el Cod. Producto en Tabla de Productos.';//003+- Para indcar que no existe el producto en BC.
                    SalesHeader.MODIFY;
                END;
                IF Insertar THEN BEGIN
                    SalesLine.INIT;
                    CASE tipodoc OF
                        1:
                            SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                        2:
                            SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                    END;

                    SalesLine.SetHideValidationDialog(TRUE);
                    SalesLine.VALIDATE("Document No.", SLCode);
                    EVALUATE(ConvertLinea, FORMAT(LineasVentasSIC."No. linea"));
                    SalesLine.VALIDATE("Line No.", ConvertLinea);
                    SalesLine.Quantity := 0;
                    //    IF LineasVentasSIC.Origen = LineasVentasSIC.Origen::"From Hotel" THEN BEGIN
                    //      IF LineasVentasSIC.Importe <> 0 THEN BEGIN
                    //        SalesLine.VALIDATE(Type,SalesLine.Type::"G/L Account");
                    //        SalesLine.VALIDATE("No.", ConfigEmpresa.CuentaFromHotel);
                    //        SalesLine.VALIDATE("Shortcut Dimension 1 Code",ConfigEmpresa."Dimension FromHotel");
                    //        SalesLine.VALIDATE("Shortcut Dimension 2 Code",StrposDimension(LineasVentasSIC.Descripcion));
                    //        EVALUATE(ConvertCantidad,FORMAT(ABS(LineasVentasSIC.Cantidad)));
                    //        SalesLine.VALIDATE(Quantity,ConvertCantidad);
                    //        SalesLine.IDRESERVA := LineasVentasSIC.IDRESERVA;
                    //        SalesLine.LOCALIZADOR:= LineasVentasSIC.LOCALIZADOR;
                    //        SalesLine.FECHAENTRADA:= LineasVentasSIC.FECHAENTRADA;
                    //        SalesLine.FECHASALIDA:= LineasVentasSIC.FECHASALIDA;
                    //        SalesLine.CAPTIONHABITACION:= LineasVentasSIC.CAPTIONHABITACION;
                    //      END;
                    //      SalesLine.Description := LineasVentasSIC.Descripcion;
                    //      LineasVentasSIC.VALIDATE("Unidad de medida",'UD');
                    //    END ELSE BEGIN
                    SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                    IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                    EVALUATE(codproducto, LineasVentasSIC.codproducto);
                    IF Item.GET(codproducto) THEN;

                    IF Item.Blocked = TRUE THEN BEGIN
                        NegativeInt := Item."Prevent Negative Inventory";
                        Itembloq := Item.Blocked;
                        Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                        Item.Blocked := FALSE;
                        Item.MODIFY;
                    END;



                    LineasVentasSIC.VALIDATE("Unidad de medida", 'UD');
                    IF (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                        LineasVentasSIC.VALIDATE("Unidad de medida", Item."Base Unit of Measure");


                    SalesLine.VALIDATE("No.", codproducto);
                    SalesLine.VALIDATE("Location Code", LineasVentasSIC."Location Code");
                    EVALUATE(ConvertCantidad, FORMAT(ABS(LineasVentasSIC.Cantidad)));
                    SalesLine.VALIDATE(Quantity, ConvertCantidad);
                    //SalesLine.VALIDATE("Line Discount Amount",LineasVentasSIC."Importe descuento");




                    //    END;



                    //    SalesLine.Origen:=LineasVentasSIC.Origen;

                    //IF (LineasVentasSIC.ITBIS = 0) AND (LineasVentasSIC.Origen = LineasVentasSIC.Origen::"Punto de Venta") THEN
                    // SalesLine.VALIDATE("VAT Prod. Posting Group", 'BIENEXTO');

                    IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN
                        /*
                        EVALUATE(ConvertPrecio,FORMAT((LineasVentasSIC.Importe/LineasVentasSIC.Cantidad)) );
                        SalesLine.VALIDATE("Unit Price",ABS(ConvertPrecio));
                        SalesLine.VALIDATE(Amount,ABS(LineasVentasSIC.Importe));
                        EVALUATE(ConvertImporte2,FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                        SalesLine.VALIDATE("Line Discount Amount",ABS(LineasVentasSIC."Importe descuento"));
                        */
                        //003+
                        EVALUATE(ConvertPrecio, FORMAT((LineasVentasSIC."Importe ITBIS Incluido" / LineasVentasSIC.Cantidad) + (LineasVentasSIC."Importe descuento") / (LineasVentasSIC.Cantidad)));
                        //SalesLine.VALIDATE("Unit Price",ROUND((ABS(ConvertPrecio)),GenLedSetup."Unit-Amount Rounding Precision"));//004+
                        SalesLine.VALIDATE("Unit Price", ROUND((ABS(ConvertPrecio)), GenLedSetup."Amount Rounding Precision"));//004+
                        EVALUATE(ConvertImporte2, FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                        //SalesLine.VALIDATE("Line Discount Amount",ROUND((ABS(LineasVentasSIC."Importe descuento")),GenLedSetup."Unit-Amount Rounding Precision"));
                        SalesLine.VALIDATE("Line Discount Amount", ROUND((ABS(LineasVentasSIC."Importe descuento")), GenLedSetup."Amount Rounding Precision"));//004+-
                                                                                                                                                               //003-

                    END;

                    SalesLine.VALIDATE(SIC, TRUE);
                    //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");


                    IF SalesLine.INSERT(TRUE) THEN;
                    COMMIT;



                    IF Item.GET(codproducto) THEN BEGIN
                        Item."Prevent Negative Inventory" := NegativeInt;
                        Item.Blocked := Itembloq;
                        Item.MODIFY;
                    END;
                END;
                //Colocarlo como transferido
                LineasVentasSIC_2.RESET;
                LineasVentasSIC_2.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                LineasVentasSIC_2.SETRANGE("No. linea", LineasVentasSIC."No. linea");
                IF LineasVentasSIC_2.FINDFIRST THEN BEGIN
                    LineasVentasSIC_2.Transferido := TRUE;
                    LineasVentasSIC_2.MODIFY(TRUE);
                END;

            UNTIL LineasVentasSIC.NEXT = 0;
        //InsertLineaPropina(NumDoc,tipodoc);

        //        SalesHeader2.RESET;
        //        SalesHeader2.SETRANGE("No.",SLCode);
        //
        //        IF SalesHeader2.FINDFIRST THEN BEGIN
        //          SalesHeader2.VALIDATE(Status,SalesHeader2.Status::Released);
        //          SalesHeader2.MODIFY;
        //        END;

    end;

    local procedure VerificaVtasDuplicadas(NoDoc: Code[20]; TipoDoc: Integer): Boolean
    var
        SH Record: 36;
        SalesShipmentHeader: Record 110;
        Txt001: Label 'Deleting Ticket    #1########## @2@@@@@@@@@@@@@\Deleting Ticket    #3########## @4@@@@@@@@@@@@@\Compressing NCr    #5########## @6@@@@@@@@@@@@@\Deleting NCr    #7########## @8@@@@@@@@@@@@@';
        DocumentoExiste: Boolean;
    begin
        DocumentoExiste := FALSE;

        SalesHeader.RESET;

        CASE TipoDoc OF // JERM-SIC
            1:
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            2:
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
        END; // JERM-SIC

        SalesHeader.SETRANGE("No.", NoDoc);
        IF SalesHeader.FINDFIRST THEN
            DocumentoExiste := TRUE
        ELSE BEGIN
            IF TipoDoc = 1 THEN BEGIN
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETCURRENTKEY("Order No.");
                SalesShipmentHeader.SETRANGE("Order No.", NoDoc);
                IF SalesShipmentHeader.FINDFIRST THEN
                    DocumentoExiste := TRUE
                ELSE
                    IF SalesShipmentHeader.GET(NoDoc) THEN
                        DocumentoExiste := TRUE;
            END;
        END;
        EXIT(DocumentoExiste);
    end;

    local procedure ConvertFechaFunct(Fecha_: Text): Date
    var
        Ano: Integer;
        Mes: Integer;
        Dia: Integer;
        Anotxt: Text[4];
        Mestxt: Text[2];
        Diatxt: Text[2];
    begin
        /*ConvertFechaFunctPP(Fecha_);
        EXIT;
        */
        /*
          Anotxt := COPYSTR(Fecha_,1,4);
          EVALUATE(Ano, Anotxt);
          Mestxt := COPYSTR(Fecha_, 6,2);
          EVALUATE(Mes,Mestxt );
          Diatxt := COPYSTR(Fecha_, 9,2);
          EVALUATE(Dia, Diatxt );
          */

        IF STRPOS(Fecha_, 'ABCDEFGHIJKLMNOPQRSTUVWXYX') <> 0 THEN BEGIN
            EXIT(ConvertFechaFunctPP(Fecha_));
        END;

        Anotxt := COPYSTR(Fecha_, 7, 4);
        EVALUATE(Ano, Anotxt);
        Mestxt := COPYSTR(Fecha_, 4, 2);
        EVALUATE(Mes, Mestxt);
        Diatxt := COPYSTR(Fecha_, 1, 2);
        EVALUATE(Dia, Diatxt);

        EXIT(DMY2DATE(Dia, Mes, Ano));

    end;

    local procedure ConvertFechaFunctPP(Fecha_: Text): Date
    var
        Ano: Integer;
        Mes: Integer;
        Dia: Integer;
        Anotxt: Text[4];
        Mestxt: Text[2];
        Diatxt: Text[2];
    begin

        //Anotxt := '2019';
        Anotxt := COPYSTR(Fecha_, 8, 4);
        EVALUATE(Ano, Anotxt);
        CASE COPYSTR(Fecha_, 1, 3) OF
            'Mar':
                Mestxt := '03';
            'Apr':
                Mestxt := '04';
            'May':
                Mestxt := '05';
            //'Jan': Mestxt := '06';
            'Nov':
                Mestxt := '11';
            'Jun':
                Mestxt := '06';
            'Jul':
                Mestxt := '07';
            'Ago':
                Mestxt := '08';
            'Sep':
                Mestxt := '09';
            'Oct':
                Mestxt := '10';
            'Nov':
                Mestxt := '11';
            'Dec':
                Mestxt := '12';
            'Dic':
                Mestxt := '12';
        END;
        EVALUATE(Mes, Mestxt);
        Diatxt := COPYSTR(Fecha_, 5, 2);
        EVALUATE(Dia, Diatxt);
        EXIT(DMY2DATE(Dia, Mes, Ano));
    end;

    local procedure TransferLineaActualizada2()
    var
        ConvertLinea: Integer;
        ConvertCantidad: Decimal;
        ConvertImporte2: Decimal;
        ConvertPrecio: Decimal;
        Totales: Integer;
    begin
        // IF GUIALLOWED THEN
        //   Ventana.OPEN(Text001);

        LineasVentasSIC.RESET;
        LineasVentasSIC.SETCURRENTKEY(Transferido);
        LineasVentasSIC.SETFILTER("No. documento", '=%1', '003570');//JERM-SIC
        LineasVentasSIC.SETRANGE("Location Code", 'CANAL3_05');
        LineasVentasSIC.SETRANGE(Transferido, FALSE);
        //LineasVentasSIC.SETFILTER(Errores,'=%1','');
        //LineasVentasSIC.SETRANGE(Fecha,DMY2DATE(1,8,2019),DMY2DATE(30,8,2019));
        //LinVentasIcg.SETRANGE("Caja",'BV01-21111');
        TotContador := LineasVentasSIC.COUNT;
        IF LineasVentasSIC.FINDSET THEN
            REPEAT

                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                Insertar := TRUE;
                IF NOT Item.GET(codproducto) THEN
                    Insertar := FALSE;
                IF Insertar THEN BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("No.", "Document Type");
                    CabVentasSIC.RESET;
                    CabVentasSIC.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                    CabVentasSIC.SETRANGE("Cod. Almacen", LineasVentasSIC."Location Code");
                    IF CabVentasSIC.FINDFIRST THEN;
                    //SalesHeader.SETRANGE("No.",LineasVentasSIC."No. documento");
                    ConfigCajaElectronica.RESET;
                    ConfigCajaElectronica.SETCURRENTKEY("Caja ID", Sucursal);
                    ConfigCajaElectronica.SETRANGE("Caja ID", CabVentasSIC.Caja);
                    ConfigCajaElectronica.SETRANGE(Sucursal, CabVentasSIC.Tienda);
                    IF NOT ConfigCajaElectronica.FINDFIRST THEN
                        EXIT;

                    CASE LineasVentasSIC."Tipo documento" OF
                        1:
                            SalesHeader.SETRANGE("No.", ConfigCajaElectronica."Serie Factura" + '-' + CabVentasSIC."No. documento");
                        2:
                            SalesHeader.SETRANGE("No.", ConfigCajaElectronica."Serie Nota de credito" + '-' + CabVentasSIC."No. documento");
                    END;
                    IF LineasVentasSIC."Tipo documento" = 2 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    END ELSE BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    END;
                    IF LineasVentasSIC."Tipo documento" = 3 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);

                    END;

                    Totales := SalesHeader.COUNT;
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        findline := FALSE;

                        SalesLine2.RESET;
                        SalesLine2.SETRANGE("Document No.", LineasVentasSIC."No. documento");
                        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine2.SETRANGE("Line No.", LineasVentasSIC."No. linea");
                        SalesLine2.SETRANGE("No.", LineasVentasSIC.codproducto);
                        IF SalesLine2.COUNT > 0 THEN
                            findline := TRUE;

                        IF CabVentasSIC.FINDSET THEN BEGIN
                            IF (findline = FALSE) THEN BEGIN

                                CASE CabVentasSIC."Tipo documento" OF
                                    1:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                                    2:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                                    3:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Invoice);
                                END;

                                SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                                SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                                EVALUATE(ConvertLinea, FORMAT(LineasVentasSIC."No. linea"));
                                SalesLine.VALIDATE("Line No.", ConvertLinea);
                                SalesLine.Quantity := 0;
                                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                                IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                                IF Item.GET(codproducto) THEN;

                                IF Item.Blocked = TRUE THEN BEGIN
                                    NegativeInt := Item."Prevent Negative Inventory";
                                    Itembloq := Item.Blocked;
                                    Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                                    Item.Blocked := FALSE;
                                    Item.MODIFY;
                                END;

                                LineasVentasSIC.VALIDATE("Unidad de medida", 'UD');
                                IF (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                                    LineasVentasSIC.VALIDATE("Unidad de medida", Item."Base Unit of Measure");


                                SalesLine.VALIDATE("No.", codproducto);
                                SalesLine.VALIDATE("Location Code", LineasVentasSIC."Location Code");
                                EVALUATE(ConvertCantidad, FORMAT(ABS(LineasVentasSIC.Cantidad)));
                                SalesLine.VALIDATE(Quantity, ConvertCantidad);
                                //SalesLine.VALIDATE("Line Discount Amount",LineasVentasSIC."Importe descuento");




                                //                      END;



                                //                      SalesLine.Origen:=LineasVentasSIC.Origen;
                                //                      IF (LineasVentasSIC.ITBIS = 0) AND (LineasVentasSIC.Origen = LineasVentasSIC.Origen::"Punto de Venta") THEN
                                //                        SalesLine.VALIDATE("VAT Prod. Posting Group", 'BIENEXTO');



                                IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN
                                    /*
                                    EVALUATE(ConvertPrecio,FORMAT(LineasVentasSIC.Importe / LineasVentasSIC.Cantidad) );
                                    SalesLine.VALIDATE("Unit Price",ABS(ConvertPrecio));
                                    SalesLine.VALIDATE(Amount,ABS(LineasVentasSIC.Importe));
                                    EVALUATE(ConvertImporte2,FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                    SalesLine.VALIDATE("Line Discount Amount",ABS(LineasVentasSIC."Importe descuento"));
                                    */
                                    //003+
                                    EVALUATE(ConvertPrecio, FORMAT((LineasVentasSIC."Importe ITBIS Incluido" / LineasVentasSIC.Cantidad) + (LineasVentasSIC."Importe descuento") / (LineasVentasSIC.Cantidad)));
                                    //SalesLine.VALIDATE("Unit Price",ROUND((ABS(ConvertPrecio)),GenLedSetup."Unit-Amount Rounding Precision"));//004+
                                    SalesLine.VALIDATE("Unit Price", ROUND((ABS(ConvertPrecio)), GenLedSetup."Amount Rounding Precision"));//004+
                                    EVALUATE(ConvertImporte2, FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                    //SalesLine.VALIDATE("Line Discount Amount",ROUND((ABS(LineasVentasSIC."Importe descuento")),GenLedSetup."Unit-Amount Rounding Precision"));
                                    SalesLine.VALIDATE("Line Discount Amount", ROUND((ABS(LineasVentasSIC."Importe descuento")), GenLedSetup."Amount Rounding Precision"));//004+-
                                                                                                                                                                           //003-
                                END;

                                SalesLine.VALIDATE(SIC, TRUE);
                                //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");

                                IF SalesLine.INSERT(TRUE) THEN;
                                COMMIT;


                                IF Item.GET(codproducto) THEN BEGIN
                                    Item."Prevent Negative Inventory" := NegativeInt;
                                    Item.Blocked := Itembloq;
                                    Item.MODIFY;
                                END;
                                //Colocarlo como transferido
                                LineasVentasSIC_2.RESET;
                                LineasVentasSIC_2.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                                LineasVentasSIC_2.SETRANGE("No. linea", LineasVentasSIC."No. linea");
                                IF LineasVentasSIC_2.FINDFIRST THEN BEGIN
                                    LineasVentasSIC_2.Transferido := TRUE;
                                    IF LineasVentasSIC_2.MODIFY(TRUE) THEN;
                                END;

                            END ELSE BEGIN
                                LineasVentasSIC.Transferido := TRUE;
                                IF LineasVentasSIC.MODIFY(TRUE) THEN;
                            END;
                        END;
                    END;
                END;
                COMMIT;
            UNTIL LineasVentasSIC.NEXT = 0;

    end;

    local procedure StrposDimension(Descripcion: Text[100]): Code[20]
    var
        String: Text;
        SubStr: Text;
        Pos: Integer;
        EquiaConeptosFromHote Record: 50007;
    begin


        // String := Descripcion;
        // SubStr := Concepto;
        // Pos := STRPOS(String, SubStr);
        //MESSAGE( FORMAT(Pos));
        // EquiaConeptosFromHote.RESET;
        // IF EquiaConeptosFromHote.FINDSET THEN BEGIN
        //  REPEAT
        //        String := Descripcion;
        //        SubStr := EquiaConeptosFromHote.Conceptos;
        //        Pos := STRPOS(String, SubStr);
        //        IF Pos > 0 THEN
        //          EXIT(EquiaConeptosFromHote."Valor Dimension BC");
        //  UNTIL EquiaConeptosFromHote.NEXT=0;
        // END;
    end;

    procedure InsertLineaPropina(NoDoc: Code[20]; Doctype: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order")
    var
        NoLinea: Integer;
        SalesLine Record: 37;
        SalesLine2Record 37;
        SalesLine3Record 37;
        Monto: Decimal;
        Propina: Decimal;
        SL Record: 36;
    begin

        IF ConfigEmpresa.GET THEN;

        SL.RESET;
        //SL.SETRANGE("Posting Date",DMY2DATE(1,8,2021));
        //SL.SETRANGE(Origen,SL.Origen::"From Hotel");
        SL.SETRANGE("No.", NoDoc);
        SL.SETRANGE("Document Type", Doctype);
        IF SL.FINDSET THEN BEGIN
            REPEAT
                NoDoc := SL."No.";

                SalesLine4.RESET;
                SalesLine4.SETRANGE("Document No.", NoDoc);
                SalesLine4.SETRANGE("Document Type", Doctype);
                SalesLine4.SETRANGE(Type, SalesLine4.Type::"G/L Account");
                //        SalesLine4.SETRANGE(Origen,SalesLine4.Origen::"Punto de Venta");
                IF SalesLine4.FINDFIRST THEN BEGIN
                    SalesLine4.DELETE(TRUE);
                END;

                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", NoDoc);
                SalesLine.SETRANGE("Document Type", Doctype);
                //SalesLine.SETRANGE(Origen,SalesLine.Origen::"From Hotel");

                IF SalesLine.FINDLAST THEN
                    NoLinea := SalesLine."Line No." + 1;

                SalesLine3.RESET;
                SalesLine3.SETRANGE("Document No.", NoDoc);
                SalesLine3.SETFILTER("Shortcut Dimension 2 Code", '<>%1', 'OPER_08');
                SalesLine3.SETRANGE("Document Type", Doctype);
                SalesLine3.CALCSUMS(Amount);

                Monto := SalesLine3.Amount;
                Propina := Monto * 0.1;
            // IF SalesLine.Origen= SalesLine.Origen::"From Hotel" THEN BEGIN

            //                SalesLine2.INIT;
            //
            //
            //                SalesLine2."Document No.":=NoDoc;
            //                SalesLine2."Document Type":=SalesLine."Document Type";
            //
            //
            //
            //                //IF Salesline2.INSERT(TRUE) THEN BEGIN
            //                  SalesLine2."Line No." := NoLinea;
            //                  SalesLine2.Type:= SalesLine2.Type::"G/L Account";
            //                  SalesLine2.VALIDATE("No.", ConfigEmpresa."Cuenta Propina");
            //                  SalesLine2.VALIDATE(Quantity,1);
            //                  SalesLine2.VALIDATE("Unit Price",Propina);
            //                  SalesLine2."VAT Prod. Posting Group":= ConfigEmpresa."Grupo Reg. IVA Propina";
            //                  SalesLine2."Shortcut Dimension 2 Code":= SalesLine."Shortcut Dimension 2 Code";
            //
            //
            //                  SalesLine2.INSERT(TRUE);

            //END;
            UNTIL SL.NEXT = 0;
        END;

        //END;
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        FindPos: Integer;
    begin
        FindPos := STRPOS(String, FindWhat);
        WHILE FindPos > 0 DO BEGIN
            NewString += DELSTR(String, FindPos) + ReplaceWith;
            String := COPYSTR(String, FindPos + STRLEN(FindWhat));
            FindPos := STRPOS(String, FindWhat);
        END;
        NewString += String;
    end;

    local procedure EliminarDocumento()
    var
        SH Record: 36;
        SH2Record 36;
        SL Record: 37;
        EquivalenciaClienteFromHotel2Record 50006;
    begin


        SH.RESET;
        SH.SETRANGE("Venta TPV", TRUE);
        SH.SETRANGE("Registrado TPV", TRUE);
        //SH.SETFILTER("No.",'%1|%2','101010000065','101010000025');//JERM-SIC
        SH.SETFILTER("No. Documento SIC", '=%1', '');
        SH.SETRANGE("Document Type", SH."Document Type"::Order);
        IF SH.FINDSET THEN BEGIN
            REPEAT
                //    SH2.RESET;
                //    SH.SETCURRENTKEY("No.","Document Type");
                //    SH2.SETRANGE("No.",SH."No.");
                //    SH2.SETRANGE("Document Type",SH."Document Type");
                //    IF SH2.FINDFIRST THEN BEGIN
                // //          EquivalenciaClienteFromHotel2.RESET;
                // //          EquivalenciaClienteFromHotel2.SETRANGE("Codigo NCF",SH."Location Code");
                // //          EquivalenciaClienteFromHotel2.SETRANGE(Tipo,EquivalenciaClienteFromHotel2.Tipo::DimResturante);
                // //          IF  EquivalenciaClienteFromHotel2.FINDFIRST THEN;
                // //      SH2.VALIDATE("Shortcut Dimension 2 Code",EquivalenciaClienteFromHotel2."Tipo NCF");
                //      SH2.VALIDATE("Posting No.",'');
                //      SH2.MODIFY(TRUE);
                //    END;

                SL.RESET;
                SL.SETRANGE("Document No.", SH."No.");
                SL.SETRANGE("Document Type", SH."Document Type");
                SL.SETRANGE("Location Code", SH."Location Code");
                IF SL.FINDSET THEN BEGIN
                    SL.DELETEALL(TRUE);
                END;

                SH.DELETE(TRUE);
            UNTIL SH.NEXT = 0;
        END;
    end;

    local procedure ActivarTransferido()
    begin
        CabVentasSIC.RESET;
        CabVentasSIC.SETFILTER("No. documento", '%1|%2', '101010000065', '101010000025');
        IF CabVentasSIC.FINDSET THEN BEGIN
            REPEAT
                CabVentasSIC.VALIDATE(Transferido, FALSE);

            UNTIL CabVentasSIC.NEXT = 0;
        END;

        LineasVentasSIC.RESET;
        LineasVentasSIC.SETFILTER("No. documento", '%1|%2', '101010000065', '101010000025');
        IF LineasVentasSIC.FINDSET THEN BEGIN
            REPEAT
                LineasVentasSIC.VALIDATE(Transferido, FALSE);
            UNTIL LineasVentasSIC.NEXT = 0;
        END;
    end;

    procedure ActualizarMediodepago()
    var
        MPSIC_Record 50113;
        ConfMedPagICG_Record 50110;
        SL Record: 36;
        SIH Record: 112;
    begin


        SL.RESET;
        SL.SETFILTER("Payment Method Code", '=%1', '');
        SL.SETFILTER("Document Type", '%1|%2', SL."Document Type"::Order, SL."Document Type"::"Credit Memo");
        SL.SETRANGE("Venta TPV", TRUE);
        IF SL.FINDSET THEN BEGIN
            REPEAT
                //AMS - Para actualizar la forma de pago
                MPSIC_.RESET;
                SalesHeader.RESET;
                SalesHeader.SETCURRENTKEY("No.", "Document Type");
                SalesHeader.SETRANGE("No.", SL."No.");
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                IF SalesHeader.FINDFIRST THEN
                    MPSIC_.SETRANGE("No. documento", SL."No. Doc Historico")
                ELSE
                    MPSIC_.SETRANGE("No. documento", SL."No.");

                IF MPSIC_.FINDFIRST THEN BEGIN
                    IF ConfMedPagICG_.GET(MPSIC_."Cod. medio de pago") THEN BEGIN
                        IF ConfMedPagICG_."Cod. med. pago" <> '' THEN BEGIN
                            //                        SalesHeader.RESET;
                            //                        SalesHeader.SETCURRENTKEY("No.","Document Type");
                            //                        SalesHeader.SETRANGE("No.",SL."No.");
                            //                        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
                            SL.VALIDATE("Payment Method Code", ConfMedPagICG_."Cod. Forma Pago");
                            SL.MODIFY(TRUE);
                        END;
                    END;

                END ELSE BEGIN
                    SIH.RESET;
                    SIH.SETRANGE("No. Documento SIC", SalesHeader."No. Comprobante Fiscal Rel.");
                    SIH.SETRANGE("Location Code", SalesHeader."Location Code");
                    IF SIH.FINDFIRST THEN
                        MPSIC_.SETRANGE("No. documento", SIH."No. Documento SIC")
                    ELSE
                        MPSIC_.SETRANGE("No. documento", SL."No.");

                    IF MPSIC_.FINDFIRST THEN BEGIN
                        IF ConfMedPagICG_.GET(MPSIC_."Cod. medio de pago") THEN BEGIN
                            IF ConfMedPagICG_."Cod. med. pago" <> '' THEN BEGIN
                                SL.VALIDATE("Payment Method Code", ConfMedPagICG_."Cod. Forma Pago");
                                SL.MODIFY(TRUE);
                            END;
                        END;

                    END;
                    //SalesHeader.VALIDATE("Payment Method Code",SIH."Payment Method Code");

                    //                        SalesHeader.RESET;
                    //                        SalesHeader.SETCURRENTKEY("No.","Document Type");
                    //                        SalesHeader.SETRANGE("No.",SL."No.");
                    //                        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
                    //SL.VALIDATE("Payment Method Code",'CREDITO');
                    //SL.MODIFY(TRUE);
                END;
            UNTIL SL.NEXT = 0;
        END;
    end;

    local procedure CorregirDocumeto()
    begin


        SalesLine.RESET;
        //SalesLine.SETRANGE(Origen,SalesLine.Origen::"Punto de Venta");

        IF SalesLine.FINDSET THEN BEGIN
            REPEAT

                SalesLine2.RESET;
                SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
                SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
                SalesLine2.SETRANGE(Type, SalesLine2.Type::"G/L Account");
                IF NOT SalesLine2.FINDFIRST THEN BEGIN
                    InsertLineaPropina(SalesLine."Document No.", SalesLine."Document Type");
                END;

            UNTIL SalesLine.NEXT = 0;
        END;
    end;

    local procedure ActializarFecha()
    var
        Fecha: Date;
    begin


        Fecha := 120122D;
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Venta TPV", TRUE);
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.SETFILTER("No.", 'VNR13-000017');
        IF SalesHeader.FINDSET THEN BEGIN
            REPEAT
                /*CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SalesHeader."No. Documento SIC");
                CabVentasSIC.SETRANGE("Tipo documento",2);
                CabVentasSIC.SETRANGE("Cod. Almacen",SalesHeader."Location Code");
                IF CabVentasSIC.FINDFIRST THEN BEGIN*/

                SalesHeader2.RESET;
                SalesHeader2.SETRANGE("No.", SalesHeader."No.");
                //      SalesHeader2.SETRANGE("Document Type",SalesHeader2."Document Type"::"Credit Memo");
                //      SalesHeader2.SETRANGE("Location Code",CabVentasSIC."Cod. Almacen");
                SalesHeader2.SETRANGE("Venta TPV", TRUE);
                IF SalesHeader2.FINDSET(TRUE, FALSE) THEN;
                SalesHeader2.SetHideValidationDialog(TRUE);
                SalesHeader2.VALIDATE("Posting Date", Fecha);
                SalesHeader2.VALIDATE("Order Date", Fecha);
                SalesHeader2.VALIDATE(Status, SalesHeader2.Status::Open);
                SalesHeader2.VALIDATE("Shipment Date", Fecha);
                SalesHeader2.MODIFY(TRUE);
            /* END;*/
            //    SalesLine.RESET;
            //    SalesLine.SETRANGE("Document No.",SalesHeader."No.");
            //    SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
            //    IF SalesLine.FINDSET THEN BEGIN
            //      REPEAT
            //        SalesLine.VALIDATE("Posting Date",CabVentasSIC.Fecha);
            //        SalesLine.MODIFY(TRUE);
            //      UNTIL SalesLine.NEXT=0;
            //    END;

            UNTIL SalesHeader.NEXT = 0;
        END;

    end;

    procedure CambiaNoBorrador()
    var
        MovCont Record: 17;
        MovCont_Out Record: 17;
        MovITBIS Record: 254;
        MovProd Record: 32;
        ValueEntry Record: 5802;
        MovCte Record: 21;
        MovCteDet Record: 379;
        MovContout Record: 17;
        MovITBISout Record: 254;
        MovProdout Record: 32;
        ValueEntryout Record: 5802;
        MovCteout Record: 21;
        MovCteDetout Record: 379;
        SIH Record: 112;
        SIL Record: 113;
        SIL_Out Record: 113;
        SIH_out Record: 112;
        Fecha: Date;
        SIH_outNo: Code[20];
        SIH_outOrderNo: Code[20];
        CabVentasSIC Record: 50112;
        BankALE Record: 271;
        BankALE_Out Record: 271;
        SH_Record 36;
        SL Record: 37;
        SL_Out Record: 37;
        SH_out Record: 36;
    begin
        SH_.RESET;
        SH_.SETRANGE("No.", 'VNR9-000087');
        SH_.SETRANGE("Document Type", SH_."Document Type"::"Credit Memo");
        IF SH_.FINDFIRST THEN;
        /*
       CabVentasSIC.RESET;
       CabVentasSIC.SETRANGE("No. documento",SH_."No. Documento SIC");
       CabVentasSIC.SETRANGE("Cod. Almacen",SH_."Location Code");
       CabVentasSIC.SETRANGE(Clave,SH_."Transaction Id");

       IF CabVentasSIC.FINDFIRST THEN ;

       ConfigCajaElectronica.RESET;
       ConfigCajaElectronica.SETCURRENTKEY("Caja ID",Sucursal);
       ConfigCajaElectronica.SETRANGE("Caja ID",CabVentasSIC.Caja);
       ConfigCajaElectronica.SETRANGE( Sucursal,CabVentasSIC.Tienda);
       IF ConfigCajaElectronica.FINDFIRST THEN;
       */
        // SIH_outOrderNo:= ConfigCajaElectronica."No. Serie Pedido"+'-'+CabVentasSIC."No. documento";
        // SIH_outNo:=ConfigCajaElectronica."Serie Factura"+'-'+CabVentasSIC."No. documento";
        SIH_outOrderNo := 'VNR9-000100';
        SIH_outNo := 'VNR9-000100';

        SH_out.TRANSFERFIELDS(SH_);
        SH_out."No." := SIH_outOrderNo;
        //SH_out."Order No.":=SIH_outOrderNo;
        SH_out."No. Comprobante Fiscal" := SIH_outNo;
        //SH_out."No. Fiscal TPV":=SIH_outNo;
        SH_out."Posting No." := SIH_outNo;
        SH_out."Posting Description" := ReplaceString(SH_out."Posting Description", SH_."No.", SIH_outOrderNo);
        SH_out."External Document No." := SIH_outOrderNo;
        SH_out.INSERT;

        SL.SETRANGE("Document No.", SH_."No.");
        SL.FINDSET;
        REPEAT
            SL_Out.TRANSFERFIELDS(SL);
            SL_Out."Document No." := SIH_outOrderNo;
            //SL_Out."Order No.":=SIH_outOrderNo;
            SL_Out.INSERT;
        UNTIL SL.NEXT = 0;

        /*
        LogTran.RESET;
        LogTran.SETRANGE("Process Code",SH_."No.");
        IF LogTran.FINDSET THEN BEGIN
          REPEAT
            LogTranOut.GET(LogTran."Process Code");
            LogTranOut."Process Code":=SIH_outOrderNo;
            LogTranOut.MODIFY;
          UNTIL LogTran.NEXT=0;
        END;
        */

        SL.SETRANGE("Document No.", SH_."No.");
        SL.FINDSET(TRUE, FALSE);
        REPEAT
            SL.DELETE;
        UNTIL SL.NEXT = 0;

        SH_.DELETE;

    end;

    procedure TransferLineaActualizada3(DocNum: Code[20]; Doctype: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocLocation: Code[20])
    var
        ConvertLinea: Integer;
        ConvertCantidad: Decimal;
        ConvertImporte2: Decimal;
        ConvertPrecio: Decimal;
        Totales: Integer;
    begin
        // IF GUIALLOWED THEN
        //   Ventana.OPEN(Text001);
        GenLedSetup.GET;//003+-
        LineasVentasSIC.RESET;
        LineasVentasSIC.SETCURRENTKEY(Transferido, "No. documento", "Location Code");
        LineasVentasSIC.SETFILTER("No. documento", '=%1', DocNum);//JERM-SIC
        LineasVentasSIC.SETRANGE("Location Code", DocLocation);
        //LineasVentasSIC.SETRANGE(Transferido, FALSE);
        //LineasVentasSIC.SETFILTER(Errores,'=%1','');
        //LineasVentasSIC.SETRANGE(Fecha,DMY2DATE(1,8,2019),DMY2DATE(30,8,2019));
        //LinVentasIcg.SETRANGE("Caja",'BV01-21111');
        TotContador := LineasVentasSIC.COUNT;
        IF LineasVentasSIC.FINDSET THEN
            REPEAT

                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                Insertar := TRUE;
                IF NOT Item.GET(codproducto) THEN
                    Insertar := FALSE;
                IF Insertar THEN BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("No.", "Document Type");
                    CabVentasSIC.RESET;
                    CabVentasSIC.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                    CabVentasSIC.SETRANGE("Cod. Almacen", LineasVentasSIC."Location Code");
                    IF CabVentasSIC.FINDFIRST THEN;
                    //SalesHeader.SETRANGE("No.",LineasVentasSIC."No. documento");
                    ConfigCajaElectronica.RESET;
                    ConfigCajaElectronica.SETCURRENTKEY("Caja ID", Sucursal);
                    ConfigCajaElectronica.SETRANGE("Caja ID", CabVentasSIC.Caja);
                    ConfigCajaElectronica.SETRANGE(Sucursal, CabVentasSIC.Tienda);
                    IF NOT ConfigCajaElectronica.FINDFIRST THEN
                        EXIT;

                    CASE LineasVentasSIC."Tipo documento" OF
                        1:
                            SalesHeader.SETRANGE("No.", LineasVentasSIC."No. documento");
                        2:
                            SalesHeader.SETRANGE("No.", LineasVentasSIC."No. documento");
                    END;
                    IF LineasVentasSIC."Tipo documento" = 2 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    END ELSE BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    END;
                    IF LineasVentasSIC."Tipo documento" = 3 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);

                    END;

                    Totales := SalesHeader.COUNT;
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        findline := FALSE;
                        IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                            SalesHeader.VALIDATE(Status, SalesHeader.Status::Open);
                            SalesHeader.MODIFY;
                        END;

                        SalesLine2.RESET;
                        SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine2.SETRANGE("Location Code", SalesHeader."Location Code");
                        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine2.SETRANGE("Line No.", LineasVentasSIC."No. linea");
                        SalesLine2.SETRANGE("No.", LineasVentasSIC.codproducto);
                        IF SalesLine2.COUNT > 0 THEN
                            findline := TRUE;

                        IF CabVentasSIC.FINDSET THEN BEGIN
                            IF (findline = FALSE) THEN BEGIN

                                CASE CabVentasSIC."Tipo documento" OF
                                    1:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                                    2:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                                    3:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Invoice);
                                END;

                                SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                                SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                                EVALUATE(ConvertLinea, FORMAT(LineasVentasSIC."No. linea"));
                                SalesLine.VALIDATE("Line No.", ConvertLinea);
                                SalesLine.Quantity := 0;
                                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                                IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                                IF Item.GET(codproducto) THEN;

                                IF Item.Blocked = TRUE THEN BEGIN
                                    NegativeInt := Item."Prevent Negative Inventory";
                                    Itembloq := Item.Blocked;
                                    Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                                    Item.Blocked := FALSE;
                                    Item.MODIFY;
                                END;

                                LineasVentasSIC.VALIDATE("Unidad de medida", 'UD');
                                IF (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                                    LineasVentasSIC.VALIDATE("Unidad de medida", Item."Base Unit of Measure");


                                SalesLine.VALIDATE("No.", codproducto);
                                SalesLine.VALIDATE("Location Code", DocLocation);
                                EVALUATE(ConvertCantidad, FORMAT(ABS(LineasVentasSIC.Cantidad)));
                                SalesLine.VALIDATE(Quantity, ConvertCantidad);
                                //SalesLine.VALIDATE("Cod. Cupon",LineasVentasSIC.Cupon);
                                //SalesLine.VALIDATE("Line Discount Amount",LineasVentasSIC."Importe descuento");




                                //                      END;



                                //                      SalesLine.Origen:=LineasVentasSIC.Origen;
                                //                      IF (LineasVentasSIC.ITBIS = 0) AND (LineasVentasSIC.Origen = LineasVentasSIC.Origen::"Punto de Venta") THEN
                                //                        SalesLine.VALIDATE("VAT Prod. Posting Group", 'BIENEXTO');



                                IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN
                                    /*
                                      EVALUATE(ConvertPrecio,FORMAT(LineasVentasSIC.Importe / LineasVentasSIC.Cantidad) );

                                    SalesLine.VALIDATE("Unit Price",ABS(ConvertPrecio));
                                    SalesLine.VALIDATE(Amount,ABS(LineasVentasSIC.Importe));
                                    EVALUATE(ConvertImporte2,FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                    SalesLine.VALIDATE("Line Discount Amount",ABS(LineasVentasSIC."Importe descuento"));
                                    */
                                    //003+
                                    EVALUATE(ConvertPrecio, FORMAT((LineasVentasSIC."Importe ITBIS Incluido" / LineasVentasSIC.Cantidad) + (LineasVentasSIC."Importe descuento") / (LineasVentasSIC.Cantidad)));
                                    //SalesLine.VALIDATE("Unit Price",ROUND((ABS(ConvertPrecio)),GenLedSetup."Unit-Amount Rounding Precision"));//004+
                                    SalesLine.VALIDATE("Unit Price", ROUND((ABS(ConvertPrecio)), GenLedSetup."Amount Rounding Precision"));//004+
                                    EVALUATE(ConvertImporte2, FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                    //SalesLine.VALIDATE("Line Discount Amount",ROUND((ABS(LineasVentasSIC."Importe descuento")),GenLedSetup."Unit-Amount Rounding Precision"));
                                    SalesLine.VALIDATE("Line Discount Amount", ROUND((ABS(LineasVentasSIC."Importe descuento")), GenLedSetup."Amount Rounding Precision"));//0004+-
                                                                                                                                                                           //003-
                                END;

                                //SalesLine.VALIDATE(SIC,TRUE);
                                //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");

                                IF SalesLine.INSERT(TRUE) THEN;
                                COMMIT;


                                IF Item.GET(codproducto) THEN BEGIN
                                    Item."Prevent Negative Inventory" := NegativeInt;
                                    Item.Blocked := Itembloq;
                                    Item.MODIFY;
                                END;
                                //Colocarlo como transferido
                                LineasVentasSIC_2.RESET;
                                LineasVentasSIC_2.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                                LineasVentasSIC_2.SETRANGE("No. linea", LineasVentasSIC."No. linea");
                                IF LineasVentasSIC_2.FINDFIRST THEN BEGIN
                                    LineasVentasSIC_2.Transferido := TRUE;
                                    IF LineasVentasSIC_2.MODIFY(TRUE) THEN;
                                END;

                            END ELSE BEGIN
                                LineasVentasSIC.Transferido := TRUE;
                                IF LineasVentasSIC.MODIFY(TRUE) THEN;
                            END;
                        END;
                    END;
                END;
                COMMIT;
            UNTIL LineasVentasSIC.NEXT = 0;

    end;

    procedure RecalclularImporteLineas()
    var
        SalesLine Record: 37;
        ImporteLinSIC: Decimal;
        ImporteMPSIC: Decimal;
        ImporteSalesLine: Decimal;
        RecCabVentasSIC Record: 50111;
        RecLineasVentasSIC Record: 50112;
        RecMediosdePagoSIC Record: 50113;
        RecSalesHeader Record: 36;
        Transfer_SIC: Codeunit 50110;
        SalesLine_Record 37;
        DocType: Integer;
        Error002: Label 'Montos en tablas no coinciden';
        Error003: Label 'Imp. med. pagos no coincide con cabecera';
        Error004: Label 'Imp. cab. SIC no coincide con imp. líneas';
    begin
        //007+
        RecSalesHeader.RESET;
        RecSalesHeader.SETRANGE("Venta TPV", TRUE);
        RecSalesHeader.SETRANGE(RecSalesHeader."Document Type", RecSalesHeader."Document Type"::Order, RecSalesHeader."Document Type"::"Credit Memo");
        RecSalesHeader.SETFILTER("No. Documento SIC", '<>1%', '');
        RecSalesHeader.SETFILTER("Error Registro", '=%1|%2|%3', Error002, Error003, Error004);
        //RecSalesHeader.SETFILTER("No.",'=%1','VFR17-003226');
        IF RecSalesHeader.FINDSET THEN BEGIN
            REPEAT
                RecSalesHeader.Status := RecSalesHeader.Status::Open;
                RecSalesHeader.MODIFY;
                DocType := 0;

                ImporteLinSIC := 0;
                ImporteMPSIC := 0;
                ImporteSalesLine := 0;

                IF RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::Order THEN
                    DocType := 1
                ELSE
                    IF RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::"Credit Memo" THEN
                        DocType := 2;

                RecCabVentasSIC.RESET;
                RecCabVentasSIC.SETRANGE("Tipo documento", DocType);
                RecCabVentasSIC.SETRANGE("No. documento", RecSalesHeader."No.");
                RecCabVentasSIC.SETRANGE("No. documento SIC", RecSalesHeader."No. Documento SIC");
                IF RecCabVentasSIC.FINDFIRST THEN;

                RecLineasVentasSIC.RESET;
                RecLineasVentasSIC.SETRANGE("No. documento", RecSalesHeader."No.");
                RecLineasVentasSIC.SETRANGE("No. documento SIC", RecSalesHeader."No. Documento SIC");
                IF RecLineasVentasSIC.FINDSET THEN
                    REPEAT
                        ImporteLinSIC += RecLineasVentasSIC."Importe ITBIS Incluido";
                    UNTIL RecLineasVentasSIC.NEXT = 0;

                RecMediosdePagoSIC.RESET;
                RecMediosdePagoSIC.SETRANGE("No. documento", RecSalesHeader."No.");
                RecMediosdePagoSIC.SETRANGE("No. documento SIC", RecSalesHeader."No. Documento SIC");
                IF RecMediosdePagoSIC.FINDSET THEN
                    REPEAT
                        ImporteMPSIC += RecMediosdePagoSIC.Importe;
                    UNTIL RecMediosdePagoSIC.NEXT = 0;

                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", RecSalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", RecSalesHeader."No.");
                SalesLine.CALCSUMS("Amount Including VAT");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        ImporteSalesLine += SalesLine."Amount Including VAT";
                    UNTIL SalesLine.NEXT = 0;

                IF ((((ImporteLinSIC - ImporteSalesLine) < -1) OR ((ImporteLinSIC - ImporteSalesLine) > 1)) OR
                  (((ImporteMPSIC - ImporteSalesLine) < -1) OR ((ImporteMPSIC - ImporteSalesLine) > 1))) OR //AND (ImporteSalesLine = 0)
                  (((RecCabVentasSIC.Monto - ImporteSalesLine) < -1) OR ((RecCabVentasSIC.Monto - ImporteSalesLine) > 1)) THEN BEGIN
                    SalesLine_.RESET();
                    SalesLine_.SETRANGE("Document Type", RecSalesHeader."Document Type");
                    SalesLine_.SETRANGE("Document No.", RecSalesHeader."No.");
                    IF SalesLine_.FINDSET THEN
                        REPEAT
                            SalesLine_.DELETE;
                        UNTIL SalesLine_.NEXT = 0;

                    RecalcularLineas(RecCabVentasSIC."No. documento", RecCabVentasSIC."Tipo documento", RecSalesHeader."Sell-to Customer No.", RecSalesHeader."No.", RecCabVentasSIC."Cod. Almacen", RecCabVentasSIC."No. documento SIC");
                    RecSalesHeader."Error Registro" := '';
                    RecSalesHeader.MODIFY;
                END;
            UNTIL RecSalesHeader.NEXT = 0;
            RecSalesHeader.Status := RecSalesHeader.Status::Released;
            RecSalesHeader.MODIFY;
            COMMIT;
        END;
        //007-
    end;

    procedure RecalcularLineas(NumDoc: Code[20]; tipodoc: Integer; codcliente: Code[20]; SLCode: Code[20]; Lcode: Code[20]; NoDocSic: Code[20])
    var
        ConvertLinea: Integer;
        ConvertCantidad: Decimal;
        ConvertImporte2: Decimal;
        ConvertPrecio: Decimal;
        CantLineas: Integer;
        NoLinea: Integer;
        _CabVentasSIC Record: 50112;
        SalesLine_Record 37;
        _SalesHeader Record: 36;
        LineasVentasSIC_Record 50113;
        ConfSantillana Record: 56001;
        NoNextLinea: Integer;
        SalesHeader_Record 36;
        GLAccount_Record 15;
        CantTotalProducto: Integer;
        ImporteIVAIncTotal: Decimal;
        ImporteTotal: Decimal;
        ImpIVAIncTotalCuenta: Decimal;
        ImpTotalCuenta: Decimal;
        PrecioUnitTotal: Decimal;
        ConvertCantidad_: Decimal;
        ConvertPrecio_: Decimal;
        I: Integer;
        ConvertFechaSalesLine: Date;
        LinVentasSicMod Record: 50113;
    begin
        GenLedSetup.GET;

        IF ConfigEmpresa.GET THEN;
        LineasVentasSIC.RESET;
        LineasVentasSIC.SETCURRENTKEY("No. documento", "No. linea");
        LineasVentasSIC.SETRANGE("No. documento", NumDoc);
        LineasVentasSIC.SETRANGE("Location Code", Lcode);
        //LineasVentasSIC.SETRANGE(Transferido,FALSE);
        LineasVentasSIC.SETRANGE("No. documento SIC", NoDocSic); //003+ Se agrega No. Doc Sic a filtro.
        //LinVentasIcg.SETFILTER(Errores,'=%1','');
        IF LineasVentasSIC.FINDSET THEN
            REPEAT
                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                Insertar := TRUE;
                IF NOT Item.GET(codproducto) THEN BEGIN
                    Insertar := FALSE;
                    SalesHeader."Error Registro" := 'No existe el Cod. Producto en Tabla de Productos.';//003+- Para indcar que no existe el producto en BC.
                    SalesHeader.MODIFY;
                END;
                IF Insertar THEN BEGIN
                    SalesLine.INIT;
                    CASE tipodoc OF
                        1:
                            SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                        2:
                            SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                    END;

                    SalesLine.SetHideValidationDialog(TRUE);
                    SalesLine.VALIDATE("Document No.", SLCode);
                    EVALUATE(ConvertLinea, FORMAT(LineasVentasSIC."No. linea"));
                    SalesLine.VALIDATE("Line No.", ConvertLinea);
                    SalesLine.Quantity := 0;

                    SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                    IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                    EVALUATE(codproducto, LineasVentasSIC.codproducto);
                    IF Item.GET(codproducto) THEN;

                    IF Item.Blocked = TRUE THEN BEGIN
                        NegativeInt := Item."Prevent Negative Inventory";
                        Itembloq := Item.Blocked;
                        Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                        Item.Blocked := FALSE;
                        Item.MODIFY;
                    END;

                    LineasVentasSIC.VALIDATE("Unidad de medida", 'UD');
                    IF (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                        LineasVentasSIC.VALIDATE("Unidad de medida", Item."Base Unit of Measure");

                    SalesLine.VALIDATE("No.", codproducto);
                    SalesLine.VALIDATE("Location Code", LineasVentasSIC."Location Code");
                    EVALUATE(ConvertCantidad, FORMAT(ABS(LineasVentasSIC.Cantidad)));
                    SalesLine.VALIDATE(Quantity, ConvertCantidad);


                    IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN

                        //003+
                        EVALUATE(ConvertPrecio, FORMAT((LineasVentasSIC."Importe ITBIS Incluido" / LineasVentasSIC.Cantidad) + (LineasVentasSIC."Importe descuento") / (LineasVentasSIC.Cantidad)));
                        //SalesLine.VALIDATE("Unit Price",ROUND((ABS(ConvertPrecio)),GenLedSetup."Unit-Amount Rounding Precision"));//004+
                        SalesLine.VALIDATE("Unit Price", ROUND((ABS(ConvertPrecio)), GenLedSetup."Amount Rounding Precision"));//004+
                        EVALUATE(ConvertImporte2, FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                        //SalesLine.VALIDATE("Line Discount Amount",ROUND((ABS(LineasVentasSIC."Importe descuento")),GenLedSetup."Unit-Amount Rounding Precision"));
                        SalesLine.VALIDATE("Line Discount Amount", ROUND((ABS(LineasVentasSIC."Importe descuento")), GenLedSetup."Amount Rounding Precision"));//004+-
                                                                                                                                                               //003-

                    END;

                    SalesLine.VALIDATE(SIC, TRUE);
                    //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");

                    IF SalesLine.INSERT(TRUE) THEN;
                    COMMIT;
                    IF Item.GET(codproducto) THEN BEGIN
                        Item."Prevent Negative Inventory" := NegativeInt;
                        Item.Blocked := Itembloq;
                        Item.MODIFY;
                    END;
                END;
                //Colocarlo como transferido
                LineasVentasSIC_2.RESET;
                LineasVentasSIC_2.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                LineasVentasSIC_2.SETRANGE("No. linea", LineasVentasSIC."No. linea");
                IF LineasVentasSIC_2.FINDFIRST THEN BEGIN
                    LineasVentasSIC_2.Transferido := TRUE;
                    LineasVentasSIC_2.MODIFY(TRUE);
                END;

            UNTIL LineasVentasSIC.NEXT = 0;
    end;
}

