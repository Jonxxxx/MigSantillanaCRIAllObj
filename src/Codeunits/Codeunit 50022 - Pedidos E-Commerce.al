codeunit 50022 "Pedidos E-Commerce"
{
    // YFC     : Yefrecis Francisco Cruz
    // SSM     : Sebastian Soto Matos
    // LDP     : Luis Jose De La Cruz
    // ------------------------------------------------------------------------
    // No.         Firma     Fecha            Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC      02/12/2020       Modificaciones solicitadas por Mariela/AGustin, En la CodeUnit 52504 realice la validacion de los tipos
    // 002         YFC      07/01/2021       SANTINAV-1940 Ajustes portal E-Commerce
    // 003         YFC      4/2/2021         SANTINAV-2089 Agregar informacion en Estadistica Ventas (EXCEL)
    // 004         YFC      17/02/2021       SANTINAV-2130 mejoras en desarrollo para E-Commerce
    // 005         YFC      08/03/2021       SANTINAV-2236 tiquetes tienda online
    // 006         YFC      21/03/2022       SANTINAV-3030 Error cola facturacion electronica
    // 007         SSM      21-Sep-2022      SANTINAV-3721 - Colocar categoria de pedidos
    // 008         LDP      10-02-2023       SANTINAV-4272 Orden de tienda linea sin sincronizar


    trigger OnRun()
    begin
        CreaFacturasyNCr;
    end;

    var
        SalespersonPurchaser: Record 13;
        OfertaIncluida: Boolean;
        ConfSantillana: Record 56001;
        Identificacion: Code[20];
        RNC_Cedula: Text[25];
        rContacto: Record 5050;
        Length: Integer;
        ValidarError: Boolean;
        Error01: Label 'La cédula no tiene el formato correspondiente a ninguno de los tipo de identificacion: fisica, juridica, DIMEX y NITE';
        NotificarError: Codeunit 50300;
        ConfEmpresa: Record 56001;
        Error02: Label 'Error en la Cola de  Pedidos E-Commerce';
        PrimerValor: Code[1];

    procedure CreaFacturasyNCr()
    var
        CabVtaSFA: Record 50100;
        CabVtaSFA2: Record 50100;
        LinVtaSFA: Record 50101;
        CabVentaOut: Record 36;
        LinVentaOut: Record 37;
        LinVtaSFO: Record 50101;
        SIH: Record 112;
        Location: Record 14;
        Comments: Record 44;
        ReleaseSalesDoc: Codeunit 414;
        Contador: Integer;
        TotContador: Integer;
        Ventana: Dialog;
        ContFact: Integer;
        ContNCr: Integer;
        NoMov: Integer;
        NoReg: Integer;
        Txt001: Label 'Processing sales    #1########## @2@@@@@@@@@@@@@';
        Txt002: Label 'There are a total of %1 %2 and %3 %4';
        Txt003: Label 'Sales Invoice';
        Txt004: Label 'Sales Credito memo';
        TieneLineas: Boolean;
        Cust: Record 18;
        MailManagement: Codeunit 9520;
    begin
        IF GUIALLOWED THEN
            Ventana.OPEN(Txt001);

        ConfSantillana.GET;
        ConfSantillana.TESTFIELD("No. Serie Ped. E-Commerce");
        ConfSantillana.TESTFIELD("No. Serie Fact. E-Commerce");
        ConfSantillana.TESTFIELD("Cliente Contado E-Commerce");
        ConfSantillana.TESTFIELD("Almacen E-Commerce");
        ConfSantillana.TESTFIELD("Categoria Pedido - E"); //007+-
                                                          //ConfSantillana.TESTFIELD("No. Serie Consumidor");
                                                          //ConfSantillana.TESTFIELD("No. Serie Credito Fiscal");
                                                          //ConfSantillana.TESTFIELD("No. Serie Gubernamental");
                                                          //ConfSantillana.TESTFIELD("Cod. Producto Cargo Envio");

        CabVtaSFA.RESET;
        CabVtaSFA.SETRANGE(Procesado, FALSE);
        CabVtaSFA.SETRANGE(Error, FALSE);  //004-YFC

        IF CabVtaSFA.FINDSET(TRUE, FALSE) THEN
            REPEAT
                TotContador := CabVtaSFA.COUNT;

                IF GUIALLOWED THEN BEGIN
                    Contador := Contador + 1;
                    Ventana.UPDATE(1, CabVtaSFA."No. documento");
                    Ventana.UPDATE(2, ROUND(Contador / TotContador * 10000, 1));
                END;

                CLEAR(CabVentaOut);
                CASE CabVtaSFA."Tipo Documento" OF
                    0:
                        BEGIN
                            CLEAR(RNC_Cedula);  //  001-YFC
                            RNC_Cedula := COPYSTR(((DELCHR(CabVtaSFA."RNC/Cedula", '=', '-'))), 1, 25); //  001-YFC

                            // ++ 004-YFC
                            ValidarError := FALSE;
                            IF CabVtaSFA."Tipo Comprobante" <> CabVtaSFA."Tipo Comprobante"::Consumidor THEN BEGIN
                                ConfEmpresa.GET;
                                Length := STRLEN(RNC_Cedula);
                                PrimerValor := COPYSTR(RNC_Cedula, 1, 1);
                                IF (Length < 9) OR (Length > 12) OR NOT (PrimerValor IN ['1', '2', '3', '4', '5', '6', '7', '8', '9']) THEN BEGIN
                                    ValidarError := TRUE;
                                    NotificarError.SendEmail(ConfEmpresa."Email GD Local", Error02, Error01 + ' Pedido: ' + CabVtaSFA."No. documento" + 'Cedula: ' + RNC_Cedula);
                                    CabVtaSFA.Error := TRUE;
                                    CabVtaSFA.MODIFY;
                                END;
                            END;
                            // -- 004-YFC

                            // ++ 006
                            IF CabVtaSFA."E-Mail" <> '' THEN
                                MailManagement.CheckValidEmailAddresses(CabVtaSFA."E-Mail");
                            // -- 006

                            IF NOT ValidarError THEN   // ++ 004-YFC
                             BEGIN // 004-YFC

                                CabVentaOut."Document Type" := CabVentaOut."Document Type"::Order;
                                CabVentaOut.VALIDATE("No. Series", ConfSantillana."No. Serie Ped. E-Commerce");
                                CabVentaOut.VALIDATE("Posting No. Series", ConfSantillana."No. Serie Fact. E-Commerce");
                                CabVentaOut.INSERT(TRUE);
                                ContFact += 1;
                                IF CabVtaSFA."Tipo Comprobante" = CabVtaSFA."Tipo Comprobante"::Consumidor THEN
                                    CabVentaOut."Tipo Doc Electronico" := CabVentaOut."Tipo Doc Electronico"::Tiquete;
                                IF CabVtaSFA."Tipo Comprobante" = CabVtaSFA."Tipo Comprobante"::"Credito Fiscal" THEN BEGIN
                                    CabVentaOut."Tipo Doc Electronico" := CabVentaOut."Tipo Doc Electronico"::Factura;
                                    CabVentaOut.VALIDATE("E-Mail-FE", CabVtaSFA."E-Mail");
                                    CabVentaOut.VALIDATE("VAT Registration No.", RNC_Cedula); //  001-YFC
                                                                                              //CabVentaOut.VALIDATE("VAT Registration No.",CabVtaSFA."RNC/Cedula");   //  001-YFC

                                END;


                                //CabVentaOut.VALIDATE("Posting Date",CabVtaSFA."Fecha registro");
                                CabVentaOut.VALIDATE("Posting Date", WORKDATE);
                                CabVentaOut.VALIDATE("Sell-to Customer No.", ConfSantillana."Cliente Contado E-Commerce");
                                CabVentaOut.VALIDATE("Location Code", ConfSantillana."Almacen E-Commerce");

                                IF CabVtaSFA.Nombre <> '' THEN BEGIN
                                    CabVentaOut."Sell-to Customer Name" := CabVtaSFA.Nombre;
                                    CabVentaOut."Bill-to Name" := CabVtaSFA.Nombre;
                                    CabVentaOut."VAT Registration No." := RNC_Cedula;  //  001-YFC
                                                                                       // CabVentaOut."VAT Registration No." := CabVtaSFA."RNC/Cedula";  //  001-YFC
                                END;




                                CabVentaOut."Order Date" := CabVtaSFA."Fecha registro";
                                CabVentaOut."Shipment Date" := CabVtaSFA."Fecha registro";
                                CabVentaOut."Document Date" := CabVtaSFA."Fecha registro";
                                CabVentaOut."Cod. Cupon" := CabVtaSFA."Cod. Cupon";
                                CabVentaOut."E-Mail-FE" := CabVtaSFA."E-Mail";

                                IF CabVtaSFA."Tipo Comprobante" = CabVtaSFA."Tipo Comprobante"::Consumidor THEN BEGIN
                                    Cust.GET(ConfSantillana."Cliente Contado E-Commerce");
                                    CabVentaOut."VAT Registration No." := Cust."VAT Registration No.";
                                    CabVentaOut.VALIDATE("E-Mail-FE", Cust."E-Mail");
                                END;


                                CabVentaOut."External Document No." := CabVtaSFA."No. documento";
                                CabVentaOut.Origen := CabVentaOut.Origen::"E-Commerce";
                                CabVentaOut."Cod. Cupon" := CabVtaSFA."Cod. Cupon";
                                IF CabVtaSFA."Cod. Divisa" = '1' THEN BEGIN
                                    CabVentaOut.VALIDATE("Currency Code", 'USD');
                                    CabVentaOut."Currency Factor" := 1 / CabVtaSFA."Tasa de cambio";
                                END;


                                IF (CabVtaSFA."Cod. Direccion de envio" <> '') AND (CabVtaSFA."Cod. Direccion de envio" <> ConfSantillana."Cliente Contado E-Commerce") THEN
                                    CabVentaOut.VALIDATE("Ship-to Code", CabVtaSFA."Cod. Direccion de envio");


                                // IF (CabVtaSFA."Comentario Svr Cte" <> '') OR (CabVtaSFA."Comentario CC" <> '' ) OR (CabVtaSFA."Comentario Alm" <> '') THEN
                                IF (CabVtaSFA."Comentario CC" <> '') OR (CabVtaSFA."Comentario Alm" <> '') THEN    // 003-YFC

                                   BEGIN
                                    Comments.RESET;
                                    Comments.SETRANGE("Document Type", CabVentaOut."Document Type");
                                    Comments.SETRANGE("No.", CabVentaOut."No.");
                                    Comments.SETRANGE("Document Line No.", 0);
                                    Comments.SETRANGE("Line No.", 0);
                                    IF NOT Comments.FINDLAST THEN
                                        CLEAR(Comments);

                                    // ++ 003-YFC
                                    /*
                                    IF CabVtaSFA."Comentario Svr Cte" <> '' THEN
                                       BEGIN
                                         Comments."Document Type"     := CabVentaOut."Document Type";
                                         Comments."No."               := CabVentaOut."No.";
                                         Comments."Document Line No." := 0;
                                         Comments."Line No."          += 1000;
                                         Comments.Date                := CabVentaOut."Posting Date";
                                         Comments.Comment             := COPYSTR('Servicio al Cte.: ' + CabVtaSFA."Comentario Svr Cte",1,80);
                                         Comments.INSERT;
                                       END;
                                    */
                                    // -- 003-YFC

                                    IF CabVtaSFA."Comentario CC" <> '' THEN BEGIN
                                        Comments."Document Type" := CabVentaOut."Document Type";
                                        Comments."No." := CabVentaOut."No.";
                                        Comments."Document Line No." := 0;
                                        Comments."Line No." += 1000;
                                        Comments.Date := CabVentaOut."Posting Date";
                                        Comments.Comment := COPYSTR('Cuentas por Cobrar:' + CabVtaSFA."Comentario CC", 1, 80);
                                        Comments.INSERT;
                                    END;

                                    IF CabVtaSFA."Comentario Alm" <> '' THEN BEGIN
                                        Comments."Document Type" := CabVentaOut."Document Type";
                                        Comments."No." := CabVentaOut."No.";
                                        Comments."Document Line No." := 0;
                                        Comments."Line No." += 1000;
                                        Comments.Date := CabVentaOut."Posting Date";
                                        Comments.Comment := COPYSTR('Almacen: ' + CabVtaSFA."Comentario Alm", 1, 80);
                                        Comments.INSERT;
                                    END;
                                END;
                            END;
                        END;
                END; // -- 004-YFC

                IF NOT ValidarError THEN   // ++ 004-YFC
                 BEGIN // 004-YFC

                    CabVentaOut."Tipo de Venta" := CabVentaOut."Tipo de Venta"::Factura;
                    IF CabVtaSFA."Tipo Comprobante" = CabVtaSFA."Tipo Comprobante"::"Credito Fiscal" THEN BEGIN
                        CabVentaOut."Tipo Doc Electronico" := CabVentaOut."Tipo Doc Electronico"::Factura;
                        CabVentaOut.VALIDATE("E-Mail-FE", CabVtaSFA."E-Mail");
                        CabVentaOut.VALIDATE("VAT Registration No.", RNC_Cedula); // 001-YFC
                                                                                  //CabVentaOut.VALIDATE("VAT Registration No.",CabVtaSFA."RNC/Cedula"); // 001-YFC
                    END;

                    // ++ 005-YFC
                    /*
                    //Tipo Identificacion - Santillana CR
                    Identificacion := DELCHR(CabVentaOut."VAT Registration No.",'=', '-');
                    IF STRLEN(Identificacion) = 10 THEN
                      CabVentaOut."Tipo Doc Electronico" := CabVentaOut."Tipo Doc Electronico"::Factura; // 001-YFC (no compilaba la CU habia yy)
                    */
                    // -- 005-YFC

                    CabVentaOut."No. Telefono" := COPYSTR(CabVtaSFA."No. Telefono", 1, 30); //LDP-008 (Se limita la longitud del texto que se inserta a la tabla Sales Header)

                    // ++ 004-YFC
                    CabVentaOut."Ship-to Address" := COPYSTR(CabVtaSFA."Direccion 1", 1, 50);
                    CabVentaOut."Ship-to Address 2" := COPYSTR(CabVtaSFA."Direccion 2", 1, 50);

                    //CabVentaOut."Ship-to Address" := COPYSTR(CabVtaSFA."Comentario Alm",1,50);
                    // CabVentaOut."Ship-to Address 2" := COPYSTR(CabVtaSFA."Comentario Alm",51,100);  // 002-YFC en el tercer parametro va un 50 no un 100, porque es la cantidad que guardara
                    //CabVentaOut."Ship-to Address 2" := COPYSTR(CabVtaSFA."Comentario Alm",51,50);     // 002-YFC
                    // -- 004-YFC

                    // ++ 002-YFC
                    IF CabVtaSFA."Metodo de Envio Ecommerce" <> '' THEN BEGIN
                        IF CabVtaSFA."Metodo de Envio Ecommerce" = 'TERRESTRE' THEN
                            CabVentaOut."Metodo de Envio E-Commerce" := CabVentaOut."Metodo de Envio E-Commerce"::Terrestre
                        ELSE
                            CabVentaOut."Metodo de Envio E-Commerce" := CabVentaOut."Metodo de Envio E-Commerce"::Recogida;
                    END;

                    // -- 002-YFC

                    // ++ 003-YFC
                    IF rContacto.GET(COPYSTR(CabVtaSFA."Comentario Svr Cte", 1, 20)) THEN
                        CabVentaOut.VALIDATE("Cod. Colegio", CabVtaSFA."Comentario Svr Cte");
                    // -- 003-YFC

                    CabVentaOut.VALIDATE("Categoria Pedido Venta", ConfSantillana."Categoria Pedido - E"); //007+-

                    CabVentaOut.MODIFY;


                    //jpg validr si hay una oferta para no lanzar automatico
                    CLEAR(OfertaIncluida);

                    TieneLineas := FALSE;
                    LinVtaSFA.RESET;
                    LinVtaSFA.SETRANGE("No. documento", CabVtaSFA."No. documento");
                    IF LinVtaSFA.FINDSET THEN
                        REPEAT
                            TieneLineas := TRUE;
                            LinVentaOut."Document Type" := CabVentaOut."Document Type";
                            LinVentaOut."Document No." := CabVentaOut."No.";
                            LinVentaOut."Line No." := LinVtaSFA."No. Linea";
                            LinVentaOut.VALIDATE("Sell-to Customer No.", CabVentaOut."Sell-to Customer No.");
                            LinVentaOut.Type := LinVentaOut.Type::Item;
                            LinVentaOut.VALIDATE("No.", LinVtaSFA."Cod. producto");

                            LinVentaOut.INSERT(TRUE);

                            IF LinVtaSFA.Cantidad = 0 THEN
                                LinVentaOut.VALIDATE(Quantity, 1)
                            ELSE
                                LinVentaOut.VALIDATE(Quantity, LinVtaSFA.Cantidad);

                            IF LinVtaSFA.Oferta THEN BEGIN
                                LinVentaOut.VALIDATE("Unit Price", 0);
                                //para saber que hay una linea oferta
                                // LinVentaOut.VALIDATE("Promocion/Oferta",LinVentaOut."Promocion/Oferta"::Oferta);
                                OfertaIncluida := TRUE;
                            END;

                            IF LinVentaOut."Unit Price" = 0 THEN
                                LinVentaOut.VALIDATE("Line Discount %", 0);

                            LinVentaOut.VALIDATE("Line Discount Amount", 0);
                            LinVentaOut.VALIDATE("Unit Price", LinVtaSFA."Precio de venta");
                            LinVentaOut.VALIDATE("Line Discount Amount", LinVtaSFA."Importe descuento");
                            LinVentaOut.VALIDATE("Line Discount %", LinVentaOut."Line Discount %");
                            LinVentaOut.MODIFY;
                        UNTIL LinVtaSFA.NEXT = 0;
                    //Cargo por Transporte
                    IF CabVtaSFA."Importe Delivery" <> 0 THEN BEGIN
                        // ++ 004-YFC
                        CabVentaOut."Sell-to Address" := COPYSTR(CabVtaSFA."Direccion 1", 1, 50);
                        CabVentaOut."Sell-to Address 2" := COPYSTR(CabVtaSFA."Direccion 2", 1, 50); // 002-YFC

                        //CabVentaOut."Sell-to Address" := COPYSTR(CabVtaSFA."Comentario Alm",1,50);
                        // CabVentaOut."Sell-to Address 2" := COPYSTR(CabVtaSFA."Comentario Alm",51,80); // 002-YFC
                        //CabVentaOut."Sell-to Address 2" := COPYSTR(CabVtaSFA."Comentario Alm",51,50); // 002-YFC

                        // -- 004-YFC

                        LinVentaOut."Document Type" := CabVentaOut."Document Type";
                        LinVentaOut."Document No." := CabVentaOut."No.";
                        LinVentaOut."Line No." := LinVtaSFA."No. Linea" + 10000;
                        LinVentaOut.VALIDATE("Sell-to Customer No.", CabVentaOut."Sell-to Customer No.");
                        LinVentaOut.Type := LinVentaOut.Type::Item;
                        LinVentaOut.VALIDATE("No.", ConfSantillana."Cod. Producto Cargo Envio");
                        LinVentaOut.VALIDATE("Line Discount Amount", 0);
                        LinVentaOut.INSERT(TRUE);

                        LinVentaOut.VALIDATE(Quantity, 1);


                        LinVentaOut.VALIDATE("Unit Price", CabVtaSFA."Importe Delivery");
                        LinVentaOut.VALIDATE("Line Discount Amount", 0);
                        //para saber que hay una linea oferta
                        // LinVentaOut.VALIDATE("Promocion/Oferta",LinVentaOut."Promocion/Oferta"::Oferta)
                        LinVentaOut.VALIDATE("Line Discount %", LinVentaOut."Line Discount %");
                        LinVentaOut.MODIFY;
                    END;

                    IF CabVtaSFA2.GET(CabVtaSFA."No. documento", ConfSantillana."Cliente Contado E-Commerce") THEN BEGIN
                        CabVtaSFA2.Procesado := TRUE;
                        CabVtaSFA2."No. documento NAV" := CabVentaOut."No.";
                        CabVtaSFA2.MODIFY;

                    END;
                    NoReg += 1;
                    CabVentaOut.VALIDATE("Posting No. Series", ConfSantillana."No. Serie Fact. E-Commerce");
                    CODEUNIT.RUN(CODEUNIT::"Release Sales Document", CabVentaOut);
                    //CabVentaOut.VALIDATE(Status,CabVentaOut.Status::Released);
                    //CabVentaOut.MODIFY;
                END; // -- 004-YFC
            UNTIL CabVtaSFA.NEXT = 0;

        IF GUIALLOWED THEN
            Ventana.CLOSE;

    end;

    local procedure ValidaClienteProductosControlados(_SalesHeader: Record 36): Boolean
    var
        Error101: Label 'Expiration date of the Control drug No. is expired in the Customer.';
        Error102: Label 'You must fill out the Drug Control No. in the Client in order to choose a Controlled product.';
        ShiptoAddress: Record 222;
        Item: Record 27;
        SalesLine: Record 37;
        Customer: Record 18;
        Valido: Boolean;
    begin
        /*
          Valido := TRUE;
      SalesLine.RESET;
      SalesLine.SETRANGE("Document Type",_SalesHeader."Document Type");
      SalesLine.SETRANGE("Document No.",_SalesHeader."No.");
      IF SalesLine.FINDSET THEN
        REPEAT
          IF Item.GET(SalesLine."No.") THEN
            BEGIN
              IF Item."Sub-Linea Negocio"  THEN BEGIN
                //jpg control de droga por direccion envio
                 IF _SalesHeader."Ship-to Code" <> '' THEN
                   BEGIN
                     IF ShiptoAddress.GET(_SalesHeader."Sell-to Customer No.",_SalesHeader."Ship-to Code") THEN
                       BEGIN
                          IF ShiptoAddress."No. control de droga" = '' THEN BEGIN
                              Valido := FALSE;
                          END;
                          IF ShiptoAddress."Fecha Venc. control de droga" < TODAY THEN BEGIN
                              Valido := FALSE;

                          END;
                         Valido := EVALUATE(SalesLine."Nivel Educativo", ShiptoAddress."No. control de droga");
                       END;
                   END
                 ELSE
                 BEGIN
                    Customer.RESET;
                    Customer.GET(_SalesHeader."Sell-to Customer No.");
                    IF Customer."Inventario en Consignacion Act" = '' THEN BEGIN
                      Valido := FALSE;
                      // MESSAGE('Requiere productos controlado');
                      //Item.TESTFIELD("Producto Controlado",TRUE);
                          //ERROR(ERROR01,Description);
                    END;
                    IF Customer."Fecha Creacion" < TODAY THEN BEGIN
                      Valido := FALSE;
                    END;
                    Valido := EVALUATE(SalesLine."Nivel Educativo", Customer."Inventario en Consignacion Act");
                  END;
                END;
          END;
      UNTIL SalesLine.NEXT = 0;
         */

    end;
}

