codeunit 52504 "Facturacion  Electronica NAV"
{
    // #217374, RRT, 09.09.2019: Tiquete electronico firmado en central. Nuevas funciones.
    // 
    // --------------------------------------
    // YFC : Yefrecis Cruz
    // --------------------------------------
    // No.  Firma  Fecha        Descripcion
    // --------------------------------------
    // 001   YFC                FE
    // 002   YFC                SANTINAV-1653
    // 003   YFC  25/11/2020    SANTINAV-1864
    // 004   YFC  02/12/2020    Ajustes E-Commerce
    // 005   YFC  12/03/2021    SANTINAV-2235: Problemas facturación electronica
    // 006   YFC  25/03/2021    SANTINAV-2263: error cola proyecto FE electronica
    // 007   YFC  01/03/2022    SANTINAV-3030: Error cola facturación electronica
    // 008   YFC  19/07/2022    SANTINAV-2745: Desarrollo para ajustes en facturación de Compartir
    // 009   YFC  20/02/2023    SANTINAV-3932: Ajuste facturación electronica CR
    // 010   YFC  13/03/2023    SANTINAV-3030: Error cola facturación electronica
    // 011   LDP  07/06/2023    SANTINAV-4694: Error al enviar correos de facturas electronicas
    // 012   LDP  01/05/2025    SANTINAV-7881: Error Cola de Proyecto Facturación Electronica
    // 013   LDP  07-07-2025    SANTINAV-8101: Actualización a Versión 4.4 de Facturación Electrónica
    // 014   LDP  10/06/2025    SANTINAV-8659: Problemas en el envío de Notas de Crédito Electrónicas (rechazadas)
    // 015   LDP  06/10/2025    SANTINAV-8654: Error al ejecutar proceso ŽEnviar Factura Electrónica de Compra
    // 016   LDP  11/03/2025    SANTINAV-7900|SANTINAV-8697: Problema con código QR en facturas electrónicas ã Costa Rica
    // 017   LDP  26/12/2025    SANTINAV-8876: Error Factura VFR-116287
    // 018   LDP  03/12/2026    SANTINAV-8976: Error Cola Proyecto - Facturacion Electronica NAV
    // 019   LDP  15/02/2026    SANTINAV-9021: Error envio Facturacion Electronica Costa Rica
    // 020   LDP  12/06/2026    SANTINAV-9297: Error en datos para Facturación Electronica

    Permissions = TableData 112 = rimd,
                  TableData 114 = rimd,
                  TableData 52501 = rimd,
                  TableData 52502 = rimd;
    SingleInstance = false;

    trigger OnRun()
    var
        SalesInvoiceHeader: Record 112;
        QRCodeInput: Text;
        TempBlob: Record 99008535;
    begin
        //
        //   SH.GET(SH."Document Type"::Invoice,'VF-000126') ;
        //   SH."Posting No." :='99999';
        //  SH.MODIFY;
        //LogFacturaElectronica(0,'VFR-063969',CURRENTDATETIME,'50608111800310114588000100001010000000171188888888','00100001010000000171','rechazado','Confirmación: OK Estado: rechazado',GetValueByNameWithType(0,'DIRECTORIOTEMP_NAV',0));
        // FacturaElectronica('VFR-091704');
        //TiqueteElectronica('VFR1-067849');
        //Dspos.Imprimir('TIENDA_20','VFR1-067849');
        ///GetValueByNameWithType(0,'DIRECTORIOTEMP_NAV',0);
        //ComprobarDocumentosMicrosoft.Dynamics.Nav.MX.BarcodeProviders.IBarcodeProvider.'Microsoft.Dynamics.Nav.MX, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'ElectronicoLOG;
        //CreateQrCodeFe();//018+
        ComprobarDocumentosElectronicoLOG;
        //MESSAGE(FORMAT(CREATEDATETIME(03132023D, 0T)));
        //NotaCreditoElectronica('VNR-047872');
        /*
        SalesInvoiceHeader.GET('VFRE-002874');
          //QR Code
            QRCodeInput    :='https://www.google.com.do/';
            CreateQRCode(QRCodeInput,TempBlob);
            SalesInvoiceHeader."QR Code FE" := TempBlob.Blob;
          //QR Code
           SalesInvoiceHeader.MODIFY;
        */
        /*
          ConfigEmpresa.GET;
          //QR Code
            QRCodeInput    :='https://www.google.com.do/';
            CreateQRCode(QRCodeInput,TempBlob);
            ConfigEmpresa."QR Code FE" := TempBlob.Blob;
          //QR Code
           ConfigEmpresa.MODIFY;
        */

    end;

    var
        SH: Record 36;
        Dspos: Codeunit 34002503;
        Text001: Label '%1  Santillana';
        Text002: Label ' %1  Santillana  %2';
        TextBody: Label '<<p><strong>Estimado (a)</strong> <strong> %1 </strong> <br />Adjunto al correo encontrará su Factura Electrónica en formato PDF y XML. Para garantizar la seguridad y confidencialidad de sus datos, esta dirección de e-mail será utilizada únicamente para enviar la información solicitada, por lo tanto, le agradecemos no responder los correos enviados, ni utilizar esta vía de comunicación para realizar consultas personales referentes a su %2 .</p>

    <p><br />Si presenta algún inconveniente por favor comunicarse al correo electrónico: galvarez@santillana.com con la señorita Grettel Alvarez de Facturación. <br />Gracias <br /><strong>Santillana S.A. </strong></p>>';
        TextBody2: Label '<p>Estimado (a) %1 </p>

    <p>Le informamos que su %2 número<strong> %3 </strong> ha sido %4 por la administración tributaria.</p>

    <p>Se adjunta el documento de respuesta enviado por la administración tributaria.</p>';
        VATProdPostGroup: Record 324;
        MontoImpuesto: Decimal;
        TotalGravado: Decimal;
        TotalE Record: 27mal;
        TotalImpuesto: Decimal;
        TotalVentaNeta: Decimal;
        Item: Record 27;
        wVieneDePos: Boolean;
        wTienda Record: 27
        wClavePos: Text;
        wConsecutivoPos: Text;
        Item2Record: Record 27;
        Error01: Label 'El producto %1 debe tener valor en el campo CABYS';
        HttpWebRequestMgt: Codeunit 1297;
        ConfigEmpresa: Record 56001;
        CategoriaPedidoVenta: Record 52503;
        MontoTotalImpuesto: Decimal;
        ImpAsumFabrica: Boolean;
        TotalNoSujetoIVA: Decimal;
        ImpuestoNeto: Decimal;
        CatalogoCaByS: Record 50026;
        TotalServGravado: Decimal;
        TotalMercGravado: Decimal;
        TotalServExento: Decimal;
        TotalMercExento: Decimal;
        TempImpuestoBkp: Record 50027;
        PaymentTerms: Record 3;
        CatParamFEDGT: Record 50030;
        PaymentMethod: Record 289;
        Error02: Label 'La cuenta %1 debe tener valor en el campo CABYS';
        FunSant: Codeunit 56000;
        IsExento: Boolean;

    procedure FacturaElectronica(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
        xmlFactura: DotNet XmlDocument;
        xmlFacturaFirmado: DotNet XmlDocument;
        xmlFacturaRespuesta: DotNet XmlDocument;
        SIH: Record 112;
        ReportFE: Report "52543;
        QRCodeInput: Text;
        TempBlob: Record 99008535;
        DirectorioTemp: Text[100];
        ConfSant: Record 56001;
    begin
        // HttpWebRequestMgt.AddSecurityProtocolTls12();

        ConfSant.GET;
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0) + GetValueByName(0, 'ARCHIVO_FE', 0) + '.xml';
        IF SIH.GET(NoDocumento) THEN
            //CreaXmlFactura(NoDocumento,DirectorioTemp);   // YFC
            //IF SIH."No." = 'VFR-117032' THEN//9021+ //9021
            //CreaXmlFacturaV4_4_Compartir(NoDocumento,DirectorioTemp);

            CreaXmlFacturaV4_4(NoDocumento, DirectorioTemp); //013+-

        xmlFactura := xmlFactura.XmlDocument();
        xmlFactura.Load(DirectorioTemp);

        //Pendiente
        LogFacturaElectronica(0, SIH."No.", CURRENTDATETIME, SIH.Clave, SIH.Consecutivo, SIH.Estado, SIH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0), SIH."E-Mail-FE", SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_FE', 0), 1);
        //Pendiente


        iProcesa := iProcesa.Procesa();


        iProcesa.EnviaFactura(xmlFactura, ConfSant."Es Prueba",
                            GetValueByName(0, 'CERTIFICADO', 0),
                            GetValueByName(0, 'CERTIFICADO_PIN', 0),
                            GetValueByName(0, 'API', 0),
                            GetValueByName(0, 'PASS', 0),
                            GetValueByNameWithType(0, 'DIRECTORIOTEMP', 0),
                            GetValueByName(0, 'ARCHIVO_FE', 0));

        //SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                                    ConfSant."Es Prueba",
                                    GetValueByName(0, 'API', 0),
                                    GetValueByName(0, 'PASS', 0),
                                    GetValueByNameWithType(0, 'DIRECTORIOTEMP', 0),
                                    GetValueByName(0, 'ARCHIVO_FE', 0));

        SIH.Consecutivo := iProcesa.txtConsecutivo;
        SIH.Clave := iProcesa.txtClave;
        SIH.Estado := iProcesa.estadoFactura;
        SIH.Mensaje := iProcesa.mensajeRespuesta;
        SIH."Fecha Doc Electronico" := CURRENTDATETIME;

        // MIGRACION COSTA RICA - YFC
        /*
          //QR Code
            QRCodeInput    :='https://www.google.com.do/';
            CreateQRCode(QRCodeInput,TempBlob);
            SIH."QR Code FE" := TempBlob.Blob;
          //QR Code
        */
        /*ConfigEmpresa.GET; // YFC
        ConfigEmpresa.CALCFIELDS("QR Code FE"); // YFC
        SIH."QR Code FE" := ConfigEmpresa."QR Code FE"; // YFC*/
        //011+
        CreaQRFE(SIH."No.");
        //011-
        SIH.MODIFY;

        SIH.RESET;
        SIH.SETRANGE("No.", SIH."No.");
        IF SIH.FINDFIRST THEN BEGIN
            ReportFE.SETTABLEVIEW(SIH);
            ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0) + 'FE-' + iProcesa.txtClave + '.pdf');
        END;
        //Completado
        LogFacturaElectronica(0, SIH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta,
        GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0), SIH."E-Mail-FE", SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_FE', 0), 2);
        //Completado

        //MESSAGE('Factura Generada con exito');

    end;

    procedure CreaXmlFactura(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
        SIH: Record 112;
        SIL: Record 113;
        Cust: Record 18;
        TotalDescuento: Decimal;
        TotalVenta: Decimal;
        Muestra: Decimal;
        TotalMuestra: Decimal;
        ContarLineas: Integer;
        View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
        Amount: Decimal;
        PrecioUnidad: Decimal;
        MontoImpuesto: Decimal;
    begin


        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('FacturaElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');

        // ++ prueba-YFc
        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
        //XmlDomMgnt.AddAttribute(XmlNode,'xsi:schemaLocation','https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/facturaElectronica.xsd');
        // -- prueba-YFc

        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica');  //YFC
        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://www.hacienda.go.cr/ATV/ComprobanteElectronico/docs/esquemas/2016/v4.3/FacturaElectronica_V4.3');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/facturaElectronica');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");
        // nivel 1
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '01'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', '513710', '', XmlNode1); // YFC
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);    // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3); //YFC

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);     //YFC no lo ven en el archivo
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', SIH."Bill-to Name", '', XmlNode2);  // YFC

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN BEGIN
            // XmlDomMgnt.AddElement(XmlNode1,'Identificacion','','',XmlNode2);
            ///  XmlDomMgnt.AddElement(XmlNode2,'Tipo','03','',XmlNode3);
            //     XmlDomMgnt.AddElement(XmlNode2,'Numero','','',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', SIH."VAT Registration No.", '', XmlNode2);
        END
        ELSE BEGIN
            // --009-YFC
            IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                // ++ 004-YFC
                IF ConfSant."Cliente Contado E-Commerce" = Cust."No." THEN BEGIN

                    IF STRLEN(SIH."VAT Registration No.") = 9 THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '01', '', XmlNode3);

                    IF STRLEN(SIH."VAT Registration No.") = 10 THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '02', '', XmlNode3);

                    IF (STRLEN(SIH."VAT Registration No.") = 11) OR (STRLEN(SIH."VAT Registration No.") = 12) THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '03', '', XmlNode3);

                    XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
                END
                ELSE BEGIN
                    // -- 004-YFC
                    XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
                END
            END;
        END; //009-YFC

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', '', '', XmlNode2);
        /*
        XmlDomMgnt.AddElement(XmlNode1,'Ubicacion','','',XmlNode2);
          XmlDomMgnt.AddElement(XmlNode2,'Provincia',GetValueByName(0,'PROVINCIA',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Canton',GetValueByName(0,'CANTON',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Distrito',GetValueByName(0,'DISTRITO',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Barrio',GetValueByName(0,'BARRIO',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'OtrasSenas',GetValueByName(0,'OTRASSENAS',0),'',XmlNode3); //YFC
         */
        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);     //  YFC
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);   //  YFC
        IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', SIH."E-Mail-FE", '', XmlNode2)   //YFC
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        //XmlDomMgnt.AddElement(XmlNode,'PlazoCredito',GetValueByRelation(5,SIH."Payment Terms Code",0),'',XmlNode1);

        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, 'EFECTIVO', 0), '', XmlNode1)
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        CategoriaPedidoVenta.GET(SIH."Categoria Pedido Venta"); //008-YFC

        //LINEAS
        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            SIL.SETRANGE(Compartir, SIL.Compartir::" ");

        IF SIL.FINDSET THEN
            REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    // SIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(SIL."Line No."/10000),'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(SIL."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, SIL."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',SIL."No.",'',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                // IF SIL.Type = SIL.Type::Item THEN
                //  XmlDomMgnt.AddElement(XmlNode3,'Tipo','01','',XmlNode4)
                //  ELSE
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF SIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(SIL."Unit Price", 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(SIL."Unit Price" * SIL.Quantity, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(SIL."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF SIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SIL.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(SIL.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                IF SIL.Amount <> SIL."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);  //YFC
                    MontoImpuesto := SIL."Amount Including VAT" - SIL.Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                    TotalImpuesto += MontoImpuesto;
                    //message(FORMAT(MontoImpuesto,0,'<Precision,5:5><Standard Format,9>'));
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(SIL."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
                                                                                                                                                                  //Sumar
                TotalDescuento += SIL."Line Discount Amount";
                TotalVenta += SIL."Unit Price" * SIL.Quantity;
                // TotalImpuesto +=  MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    //TotalExento += SIL.Amount   // YFC
                    TotalExento += SIL."Unit Price" * SIL.Quantity
                ELSE
                    // TotalGravado +=  SIL.Amount // YFC
                    TotalGravado += SIL."Unit Price" * SIL.Quantity;


            UNTIL SIL.NEXT <= 0;

        //CreaXmlTiquete_vCentral2(SIH."No.");

        //*********************************************************
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
            View_SalesInvoiceLine.SETRANGE(Document_No, SIH."No.");
            View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesInvoiceLine.SETFILTER(Compartir, '<>%1', View_SalesInvoiceLine.Compartir::" ");
            View_SalesInvoiceLine.OPEN;
            //lrSIL.SETFILTER(Amount,'<>0');
            //IF lrSIL.FINDSET THEN
            WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity;
                    SIL."Amount Including VAT" := View_SalesInvoiceLine.Sum_Amount;
                    TotalMuestra += View_SalesInvoiceLine.Sum_Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // ++ 003-YFC
                /*CLEAR(Item2);
                IF  Item2.GET(SIL."No.") THEN;
                IF Item2.CABYS <> '' THEN
                  XmlDomMgnt.AddElement(XmlNode2,'Codigo',Item2.CABYS,'',XmlNode3)
                ELSE
                  ERROR(Error01,SIL."No.");*/
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',lrSIL."No.",'',XmlNode3);
                // -- 003-YFC

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Libro CABYS", '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Aulas CABYS", '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Servicio CABYS", '', XmlNode3);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //RRT
                ImporteDescuento := View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        ImporteDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));

                Amount := View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount;

                PrecioUnidad := SIL."Unit Price";
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_Quantity > 0 THEN;
                //PrecioUnidad := Amount / View_SalesInvoiceLine.Sum_Quantity;
                // PrecioUnidad := View_SalesInvoiceLine.Sum_Unit_Price / View_SalesInvoiceLine.Sum_Quantity; //008-YFC
                PrecioUnidad := (View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity; //008-YFC
                                                                                                                                                          //...

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(Amount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(ImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF SIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                MontoImpuesto := 0;
                IF View_SalesInvoiceLine.Sum_Amount <> View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);  //YFC
                    MontoImpuesto := View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC

                //Sumar


                TotalDescuento += View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                TotalVenta += View_SalesInvoiceLine.Sum_Amount;
                TotalImpuesto += MontoImpuesto;

                IF View_SalesInvoiceLine.Sum_Amount = View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN
                    //TotalExento += SIL.Amount   // YFC
                    TotalExento += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount
                ELSE
                    // TotalGravado +=  SIL.Amount // YFC
                    TotalGravado += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount;

                //UNTIL lrSIL.NEXT <=0 ;
            END;

            View_SalesInvoiceLine.CLOSE;
        END; //008-YFC
             //*********************************************************

        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);    // YFC

        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(SIH."Amount Including VAT" / SIH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        // XmlDomMgnt.AddElement(XmlNode1,'TotalMercExonerada','0,00000','',XmlNode2);     // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);   // YFC
                                                                                                                                      // XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0,00000','',XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        TotalVentaNeta := (TotalGravado + TotalExento) - TotalDescuento;
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(SIH."Amount Including VAT" - TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); //YFC
                                                                                                                                        // message(FORMAT(TotalImpuesto,0,'<Precision,5:5><Standard Format,9>'));
        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // ++ Informacion Referencia YFC
        IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '08', '', XmlNode2);
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '10', '', XmlNode2);
            END;
            XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH."Numero Referencia FE", '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode2);
            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye Comprobante', '', XmlNode2);
                    END;
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula documento de referencia', '', XmlNode2);
                    END;
            END;

            //XmlDomMgnt.AddElement(XmlNode1,'Razon','','',XmlNode2);   //no es obligatorio
        END;
        // -- Informacion Referencia
        /*
        // --  YFC
          XmlDomMgnt.AddElement(XmlNode,'Normativa','','',XmlNode1);
            XmlDomMgnt.AddElement(XmlNode1,'NumeroResolucion','DGT-R-48-2016','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1,'FechaResolucion','07-10-2016 08:00:00','',XmlNode2);
        */
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure FacturaElectronicaExportacion(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
        xmlFactura: DotNet XmlDocument;
        xmlFacturaFirmado: DotNet XmlDocument;
        xmlFacturaRespuesta: DotNet XmlDocument;
        SIH: Record 112;
        ReportFE: Report "52543;
                      QRCodeInput: Text;
        TempBlob: Record 99008535;
        DirectorioTemp: Text[100];
        ConfSant: Record 56001;
    begin
        ConfSant.GET;
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0) + GetValueByName(0, 'ARCHIVO_FE', 0) + '.xml';
        IF SIH.GET(NoDocumento) THEN
            //CreaXmlFacturaExportacion(NoDocumento,DirectorioTemp);   //YFC
            CreaXmlFacturaExportacionV4_4(NoDocumento, DirectorioTemp); //013+-

        xmlFactura := xmlFactura.XmlDocument();
        xmlFactura.Load(DirectorioTemp);

        //Pendiente
        LogFacturaElectronica(0, SIH."No.", CURRENTDATETIME, SIH.Clave, SIH.Consecutivo, SIH.Estado, SIH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0), SIH."E-Mail-FE", SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_FE', 0), 1);
        //Pendiente


        iProcesa := iProcesa.Procesa();


        iProcesa.EnviaFactura(xmlFactura, ConfSant."Es Prueba",
              GetValueByName(0, 'CERTIFICADO', 0),
              GetValueByName(0, 'CERTIFICADO_PIN', 0),
              GetValueByName(0, 'API', 0),
              GetValueByName(0, 'PASS', 0),
              GetValueByNameWithType(0, 'DIRECTORIOTEMP', 0),
              GetValueByName(0, 'ARCHIVO_FE', 0));

        //SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', 0),
                      GetValueByName(0, 'ARCHIVO_FE', 0));

        SIH.Consecutivo := iProcesa.txtConsecutivo;
        SIH.Clave := iProcesa.txtClave;
        SIH.Estado := iProcesa.estadoFactura;
        SIH.Mensaje := iProcesa.mensajeRespuesta;
        SIH."Fecha Doc Electronico" := CURRENTDATETIME;

        // MIGRACION COSTA RICA - YFC
        /*
          //QR Code
            QRCodeInput    :='https://www.google.com.do/';
            CreateQRCode(QRCodeInput,TempBlob);
            SIH."QR Code FE" := TempBlob.Blob;
          //QR Code
          */
        /*ConfigEmpresa.GET; // YFC
        ConfigEmpresa.CALCFIELDS("QR Code FE"); // YFC
         SIH."QR Code FE" := ConfigEmpresa."QR Code FE"; // YFC
         */
        //011+
        CreaQRFE(SIH."No.");
        //011-
        SIH.MODIFY;



        SIH.RESET;
        SIH.SETRANGE("No.", SIH."No.");
        IF SIH.FINDFIRST THEN BEGIN
            ReportFE.SETTABLEVIEW(SIH);
            ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0) + 'FE-' + iProcesa.txtClave + '.pdf');
        END;
        //Completado
        LogFacturaElectronica(0, SIH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta,
        GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 0), SIH."E-Mail-FE", SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_FE', 0), 2);
        //Completado

        //MESSAGE('Factura Generada con exito');

    end;

    procedure CreaXmlFacturaExportacion(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
        SIH: Record 112;
        SIL: Record 113;
        Cust: Record 18;
        TotalDescuento: Decimal;
        TotalVenta: Decimal;
        Muestra: Decimal;
        TotalMuestra: Decimal;
        ContarLineas: Integer;
    begin


        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('FacturaElectronicaExportacion');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/facturaElectronicaExportacion');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");
        // nivel 1
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '09'), '', XmlNode1); // 9 es de comprobante exportacion
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', '513710', '', XmlNode1); // YFC
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);    // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);
        //  XmlDomMgnt.AddElement(XmlNode1,'NombreComercial','','',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3); //YFC

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);     //YFC no lo ven en el archivo
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', SIH."Bill-to Name", '', XmlNode2);  // YFC

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', SIH."VAT Registration No.", '', XmlNode2)
        ELSE BEGIN
            // --009-YFC
            IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
            END
        END; //009-YFC

        //  XmlDomMgnt.AddElement(XmlNode1,'NombreComercial','','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'IdentificacionExtranjero','','',XmlNode2);     //Identificar
        //XmlDomMgnt.AddElement(XmlNode1,'OtrasSenasExtranjero','','',XmlNode2);         //Identificar
        /*
        XmlDomMgnt.AddElement(XmlNode1,'Ubicacion','','',XmlNode2);
          XmlDomMgnt.AddElement(XmlNode2,'Provincia',GetValueByName(0,'PROVINCIA',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Canton',GetValueByName(0,'CANTON',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Distrito',GetValueByName(0,'DISTRITO',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Barrio',GetValueByName(0,'BARRIO',0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'OtrasSenas',GetValueByName(0,'OTRASSENAS',0),'',XmlNode3); //YFC
         */
        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);     //  YFC
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);   //  YFC
        IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', SIH."E-Mail-FE", '', XmlNode2)   //YFC
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        //XmlDomMgnt.AddElement(XmlNode,'PlazoCredito',GetValueByRelation(5,SIH."Payment Terms Code",0),'',XmlNode1);

        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, 'EFECTIVO', 0), '', XmlNode1)
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);
        //LINEAS
        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        //SIL.SETFILTER(Amount,'<>0');
        IF SIL.FINDSET THEN
            REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    // SIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(SIL."Line No."/10000),'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);
                IF Item.GET(SIL."No.") THEN;
                IF Item."Tariff No." <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'PartidaArancelaria', FORMAT(Item."Tariff No."), '', XmlNode3);   //Identificar

                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(SIL."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, SIL."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',SIL."No.",'',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);

                // IF SIL.Type = SIL.Type::Item THEN
                //  XmlDomMgnt.AddElement(XmlNode3,'Tipo','01','',XmlNode4)
                //  ELSE


                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF SIL.Type = SIL.Type::"G/L Account" THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'Otros', '', XmlNode3)
                ELSE BEGIN
                    IF SIL."Unit of Measure Code" = '' THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                    ELSE
                        XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);
                END;
                /*
                      IF SIL."Unit of Measure Code" = '' THEN
                        XmlDomMgnt.AddElement(XmlNode2,'UnidadMedida','PZ','',XmlNode3)
                      ELSE
                        BEGIN
                          IF SIL.Type = SIL.Type::"G/L Account" THEN
                            XmlDomMgnt.AddElement(XmlNode2,'UnidadMedida','Otros','',XmlNode3)
                          ELSE
                            XmlDomMgnt.AddElement(XmlNode2,'UnidadMedida',GetValueByRelation(3,SIL."Unit of Measure Code",0),'',XmlNode3);
                        END;
                */
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(SIL."Unit Price", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);//3:3
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(SIL."Unit Price" * SIL.Quantity, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(SIL."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF SIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT((SIL."Unit Price" * SIL.Quantity) - SIL."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'SubTotal',FORMAT(SIL.Amount,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'BaseImponible',FORMAT(SIL.Amount,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3);

                IF SIL.Amount <> SIL."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);  //YFC
                    MontoImpuesto := SIL."Amount Including VAT" - SIL.Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                END;

                //ImpuestoNeto
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(SIL."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
                                                                                                                                                                  /*
                                                                                                                                                                       XmlDomMgnt.AddElement(XmlNode2,'OtrosCargos','','',XmlNode3);    //YFC   Identificar
                                                                                                                                                                      XmlDomMgnt.AddElement(XmlNode3,'TipoDocumento','','',XmlNode4);    //YFC
                                                                                                                                                                      XmlDomMgnt.AddElement(XmlNode3,'Detalle','','',XmlNode4);    //YFC
                                                                                                                                                                      XmlDomMgnt.AddElement(XmlNode3,'Porcentaje','','',XmlNode4);    //YFC
                                                                                                                                                                      XmlDomMgnt.AddElement(XmlNode3,'MontoCargo','','',XmlNode4);    //YFC
                                                                                                                                                                 */

                //Sumar
                TotalDescuento += SIL."Line Discount Amount";
                TotalVenta += SIL."Unit Price" * SIL.Quantity;
                TotalImpuesto += MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    //TotalExento += SIL.Amount   // YFC
                    TotalExento += SIL."Unit Price" * SIL.Quantity
                ELSE
                    // TotalGravado +=  SIL.Amount // YFC
                    TotalGravado += SIL."Unit Price" * SIL.Quantity;


            UNTIL SIL.NEXT <= 0;
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);    // YFC

        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(SIH."Amount Including VAT" / SIH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        // XmlDomMgnt.AddElement(XmlNode1,'TotalMercExonerada','0,00000','',XmlNode2);     // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);   // YFC
                                                                                                                                      // XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0,00000','',XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        TotalVentaNeta := (TotalGravado + TotalExento) - TotalDescuento;
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); //YFC
                                                                                                                                        // XmlDomMgnt.AddElement(XmlNode1,'TotalOtrosCargos',FORMAT(TotalImpuesto,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); //YFC  Identificar

        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // ++ Informacion Referencia YFC
        IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '08', '', XmlNode2);
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '10', '', XmlNode2);
            END;
            XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH."Numero Referencia FE", '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode2);
            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye Comprobante', '', XmlNode2);
                    END;
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula documento de referencia', '', XmlNode2);
                    END;
            END;

            //XmlDomMgnt.AddElement(XmlNode1,'Razon','','',XmlNode2);   //no es obligatorio
        END;
        // -- Informacion Referencia
        /*
        // --  YFC
          XmlDomMgnt.AddElement(XmlNode,'Normativa','','',XmlNode1);
            XmlDomMgnt.AddElement(XmlNode1,'NumeroResolucion','DGT-R-48-2016','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1,'FechaResolucion','07-10-2016 08:00:00','',XmlNode2);
        */
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure NotaCreditoElectronica(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
        xmlNotaCredito: DotNet XmlDocument;
        xmlNotaCreditoFirmado: DotNet XmlDocument;
        xmlNotaCreditoRespuesta: DotNet XmlDocument;
        CMH: Record 114;
        ReportFE: Report "52544;
                      ReportFE_Pos: Report "34002531;
                      DirectorioTemp: Text[100];
        ConfSant: Record 56001;
    begin
        ConfSant.GET;
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1) + GetValueByName(0, 'ARCHIVO_NC', 0) + '.xml';
        IF CMH.GET(NoDocumento) THEN
            //#+217374
            //CreaXmlNotaCredito(NoDocumento,DirectorioTemp);
            //013-
            /*
            IF NOT wVieneDePos THEN
              CreaXmlNotaCredito(NoDocumento,DirectorioTemp)
            ELSE
              CreaXmlNotaCreditoPos(NoDocumento,DirectorioTemp);
            //#-217374
            */
            //01
            //014+
            //014+
            IF NOT ValidaVerisionFEV4_4(NoDocumento) THEN
                CreaXmlNotaCredito(NoDocumento, DirectorioTemp)
            ELSE
                //014-
                CreaXmlNotaCreditoV4_4(NoDocumento, DirectorioTemp);//012+- //Aquí envalúa las condiciones si es de POS o no.


        xmlNotaCredito := xmlNotaCredito.XmlDocument();
        xmlNotaCredito.Load(DirectorioTemp);

        //Pendiente
        LogFacturaElectronica(1, CMH."No.", CURRENTDATETIME, CMH.Clave, CMH.Consecutivo, CMH.Estado, CMH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1), CMH."E-Mail-FE", CMH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_NC', 0), 1);
        //Pendiente


        iProcesa := iProcesa.Procesa();

        iProcesa.EnviaFactura(xmlNotaCredito, ConfSant."Es Prueba",
             GetValueByName(0, 'CERTIFICADO', 0),
             GetValueByName(0, 'CERTIFICADO_PIN', 0),
             GetValueByName(0, 'API', 0),
             GetValueByName(0, 'PASS', 0),
             GetValueByNameWithType(0, 'DIRECTORIOTEMP', 1),
             GetValueByName(0, 'ARCHIVO_NC', 0));
        //MESSAGE(FORMAT(iProcesa.estadoFactura));
        //SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', 1),
                      GetValueByName(0, 'ARCHIVO_NC', 0));

        CMH.Consecutivo := iProcesa.txtConsecutivo;
        CMH.Clave := iProcesa.txtClave;
        CMH.Estado := iProcesa.estadoFactura;
        CMH.Mensaje := iProcesa.mensajeRespuesta;
        CMH."Fecha Doc Electronico" := CURRENTDATETIME;
        //011+
        CreaQRFE(CMH."No.");
        //011-
        CMH.MODIFY;

        CMH.RESET;
        CMH.SETRANGE("No.", CMH."No.");
        IF CMH.FINDFIRST THEN BEGIN
            //+#217374
            //ReportFE.SETTABLEVIEW(CMH);
            //ReportFE.SAVEASPDF(GetValueByNameWithType(0,'DIRECTORIOTEMP_NAV',1)+'NC-'+iProcesa.txtClave+'.pdf');
            IF wVieneDePos THEN BEGIN
                ReportFE_Pos.SETTABLEVIEW(CMH);
                ReportFE_Pos.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1) + 'NC-' + iProcesa.txtClave + '.pdf');
            END
            ELSE BEGIN
                ReportFE.SETTABLEVIEW(CMH);
                ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1) + 'NC-' + iProcesa.txtClave + '.pdf');
            END;
            //-#217374

        END;

        LogFacturaElectronica(1, CMH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta,
        GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1), CMH."E-Mail-FE", CMH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_NC', 0), 2);
        // MESSAGE('Consecutivo:' + iProcesa.txtConsecutivo);
        // MESSAGE('Clave: ' + iProcesa.txtClave);
        // MESSAGE('Estado: ' + iProcesa.estadoFactura);
        // MESSAGE('Mensaje: ' + iProcesa.mensajeRespuesta);
        // MESSAGE('Nota de Credito Electronica Generada con exito');

    end;

    procedure CreaXmlNotaCredito(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
        CMH: Record 114;
        CML: Record 115;
        Cust: Record 18;
        TotalDescuento: Decimal;
        TotalVenta: Decimal;
        SIH: Record 112;
        NumeroLinea: Integer;
        lClave: Text;
        View_SalesInvoiceLine: Query "50000;
                      ContarLineas: Integer;
        View_SalesCRMLine: Query "50001;
                      Amount: Decimal;
        PrecioUnidad: Decimal;
        ImporteDescuento: Decimal;
    begin

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('NotaCreditoElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xs','http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaCreditoElectronica');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/notaCreditoElectronica');

        CMH.GET(NoDocumento);
        CMH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(CMH."Bill-to Customer No.");
        // nivel 1
        //+#217374
        //... La clave y el consecutivo puede ser que vengan asignados desde DS-POS.
        //XmlDomMgnt.AddElement(XmlNode,'Clave',GetClave(CMH."Posting Date",Consecutivo,'03'),'',XmlNode1);
        IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
            lClave := wClavePos;
            Consecutivo := wConsecutivoPos;
        END
        ELSE
            lClave := GetClave(CMH."Posting Date", Consecutivo, '03');

        XmlDomMgnt.AddElement(XmlNode, 'Clave', lClave, '', XmlNode1);
        //-#217374

        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', '513710', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(CMH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', CMH."Bill-to Name", '', XmlNode2);

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', Cust."VAT Registration No.", '', XmlNode2)
        ELSE BEGIN
            // --009-YFC
            IF (Cust."VAT Registration No." <> '.') AND (Cust."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                // ++ 004-YFC
                IF ConfSant."Cliente Contado E-Commerce" = Cust."No." THEN BEGIN

                    IF STRLEN(CMH."VAT Registration No.") = 9 THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '01', '', XmlNode3);

                    IF STRLEN(CMH."VAT Registration No.") = 10 THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '02', '', XmlNode3);

                    IF (STRLEN(CMH."VAT Registration No.") = 11) OR (STRLEN(CMH."VAT Registration No.") = 12) THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '03', '', XmlNode3);

                    XmlDomMgnt.AddElement(XmlNode2, 'Numero', CMH."VAT Registration No.", '', XmlNode3);
                END
                ELSE BEGIN
                    // -- 004-YFC
                    XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode2, 'Numero', Cust."VAT Registration No.", '', XmlNode3);
                END;
            END;
        END; //009-YFC
        IF Cust."E-Mail" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', GetValueByRelation(5, CMH."Payment Terms Code", 0), '', XmlNode1);

        IF CMH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, 'EFECTIVO', 0), '', XmlNode1)
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, CMH."Payment Method Code", 0), '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        CategoriaPedidoVenta.GET(CMH."Categoria Pedido Venta"); //008-YFC

        //LINEAS
        CML.RESET;
        CML.SETRANGE("Document No.", CMH."No.");
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            CML.SETRANGE(Compartir, CML.Compartir::" ");
        CML.SETFILTER(Quantity, '<>0');
        //CML.SETFILTER(Amount,'<>0');
        IF CML.FINDSET THEN
            REPEAT

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);


                NumeroLinea += 1;
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(NumeroLinea), '', XmlNode3);

                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(CML."Line No."/10000),'',XmlNode3);

                // ++ 003-YFC
                IF CML.Type = CML.Type::Item THEN BEGIN
                    CLEAR(Item2);
                    Item2.GET(CML."No.");
                    IF Item2.CABYS <> '' THEN
                        XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                    ELSE
                        ERROR(Error01, CML."No.");
                END
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', '', '', XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);

                //   IF CML.Type = CML.Type::Item THEN
                //   XmlDomMgnt.AddElement(XmlNode3,'Tipo','01','',XmlNode4)
                //   ELSE
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', CML."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(CML.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF CML.Type = CML.Type::Item THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, CML."Unit of Measure Code", 0), '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'Otros', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', CML.Description, '', XmlNode3);
                //XmlDomMgnt.AddElement(XmlNode2,'PrecioUnitario',FORMAT(CML."Unit Price",0,'<Precision,3:3><Standard Format,9>'),'',XmlNode3); //009-YFC
                // XmlDomMgnt.AddElement(XmlNode2,'MontoTotal',FORMAT(CML."Unit Price" * CML.Quantity,0,'<Precision,3:3><Standard Format,9>'),'',XmlNode3); //009-YFC
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(CML."Unit Price", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); //009-YFC
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(CML."Unit Price" * CML.Quantity, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); //009-YFC
                                                                                                                                                               //---
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(CML."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF CML."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                //XmlDomMgnt.AddElement(XmlNode2,'MontoDescuento',FORMAT(CML."Line Discount Amount",0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'NaturalezaDescuento','Descuento al cliente','',XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'SubTotal',FORMAT(CML.Amount,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3); //009-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT((CML."Unit Price" * CML.Quantity) - CML."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); //009-YFC

                IF CML.Amount <> CML."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);
                    IF VATProdPostGroup.GET(CML."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(CML."VAT %"), '', XmlNode4);
                    MontoImpuesto := (CML."Amount Including VAT" - CML.Amount); // YFC

                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(CML."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //Sumar
                TotalDescuento += CML."Line Discount Amount";
                TotalVenta += CML."Unit Price" * CML.Quantity;
                TotalImpuesto += MontoImpuesto;

                IF CML."VAT %" = 0 THEN
                    TotalExento += CML."Unit Price" * CML.Quantity
                ELSE
                    TotalGravado += CML."Unit Price" * CML.Quantity;


            UNTIL CML.NEXT <= 0;



        //*********************************************************
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesCRMLine);
            //911-YFC
            View_SalesCRMLine.SETRANGE(Document_No, CMH."No.");
            View_SalesCRMLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesCRMLine.SETFILTER(Compartir, '<>%1', View_SalesCRMLine.Compartir::" ");
            View_SalesCRMLine.OPEN;
            //lrSIL.SETFILTER(Amount,'<>0');
            //IF lrSIL.FINDSET THEN
            WHILE View_SalesCRMLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);


                NumeroLinea += 1;
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(NumeroLinea), '', XmlNode3);

                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(CML."Line No."/10000),'',XmlNode3);

                // ++ 003-YFC
                //      IF CML.Type = CML.Type::Item THEN
                //        BEGIN
                //          CLEAR(Item2);
                //          Item2.GET(CML."No.");
                //          IF Item2.CABYS <> '' THEN
                //            XmlDomMgnt.AddElement(XmlNode2,'Codigo',Item2.CABYS,'',XmlNode3)
                //          ELSE
                //            ERROR(Error01,CML."No.");
                //       END
                //       ELSE
                //         XmlDomMgnt.AddElement(XmlNode2,'Codigo','','',XmlNode3);
                // -- 003-YFC

                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Libro CABYS", '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Aulas CABYS", '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Servicio CABYS", '', XmlNode3);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);

                //   IF CML.Type = CML.Type::Item THEN
                //   XmlDomMgnt.AddElement(XmlNode3,'Tipo','01','',XmlNode4)
                //   ELSE
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);

                //XmlDomMgnt.AddElement(XmlNode3,'Codigo',CML."No.",'',XmlNode4);
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesCRMLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF CML.Type = CML.Type::Item THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesCRMLine.Unit_of_Measure_Code, 0), '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'Otros', '', XmlNode3);

                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',CML.Description,'',XmlNode3);
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                Amount := View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount;
                //PrecioUnidad := View_SalesCRMLine.Sum_Unit_Price / View_SalesCRMLine.Sum_Quantity; //008-YFC
                PrecioUnidad := (View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount) / View_SalesCRMLine.Sum_Quantity; //008-YFC
                ImporteDescuento := View_SalesCRMLine.Sum_Line_Discount_Amount;
                IF CMH."Prices Including VAT" THEN
                    IF View_SalesCRMLine.Sum_VAT > 0 THEN
                        ImporteDescuento := ROUND(View_SalesCRMLine.Sum_Amount * (View_SalesCRMLine.Sum_Line_Discount / 100));

                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(Amount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                //---
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(ImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF View_SalesCRMLine.Sum_Line_Discount_Amount > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                //XmlDomMgnt.AddElement(XmlNode2,'MontoDescuento',FORMAT(CML."Line Discount Amount",0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'NaturalezaDescuento','Descuento al cliente','',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(View_SalesCRMLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                IF View_SalesCRMLine.Sum_Amount <> View_SalesCRMLine.Sum_Amount_Including_VAT THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);
                    IF VATProdPostGroup.GET(View_SalesCRMLine.VAT_Prod_Posting_Group) THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);
                    MontoImpuesto := (View_SalesCRMLine.Sum_Amount_Including_VAT - View_SalesCRMLine.Sum_Amount); // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesCRMLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //Sumar
                TotalDescuento += View_SalesCRMLine.Sum_Line_Discount_Amount;
                //TotalVenta  +=   View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity; //008-YFC
                TotalVenta += View_SalesCRMLine.Sum_Amount;
                TotalImpuesto += MontoImpuesto;

                IF View_SalesCRMLine.Sum_Amount = View_SalesCRMLine.Sum_Amount_Including_VAT THEN
                    TotalExento += View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount
                ELSE
                    TotalGravado += View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount;


                //      //Sumar
                //      lTotalDescuento +=  ImporteDescuento;
                //      lTotalVenta     +=  Amount;
                //      lTotalImpuesto  +=  MontoImpuesto;
                //
                //      IF View_SalesInvoiceLine.Sum_VAT = 0 THEN
                //        lTotalExento += lAmount
                //      ELSE
                //        lTotalGravado += lAmount;

                //UNTIL lrSIL.NEXT <=0 ;
            END;

            View_SalesCRMLine.CLOSE;
        END; //008-YFC
             //*********************************************************

        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);
        //--
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);    // YFC

        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', CMH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(CMH."Amount Including VAT" / CMH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        //--
        // OLd
        /*
           IF CMH."Currency Code" = '' THEN
           XmlDomMgnt.AddElement(XmlNode1,'CodigoMoneda','CRC','',XmlNode2)
           ELSE
             BEGIN
               XmlDomMgnt.AddElement(XmlNode,'CodigoTipoMoneda','CRC','',XmlNode1);
               XmlDomMgnt.AddElement(XmlNode1,'CodigoMoneda',CMH."Currency Code" ,'',XmlNode2);  // YFC
             END;

           IF CMH."Currency Factor" <>0 THEN
           XmlDomMgnt.AddElement(XmlNode1,'TipoCambio',FORMAT(CMH."Amount Including VAT"/ CMH."Currency Factor",9,'<Precision,5:5><Standard Format,9>'),'',XmlNode2)
           ELSE
           XmlDomMgnt.AddElement(XmlNode1,'TipoCambio','1.00000','',XmlNode2);


       */
        /*// OLD
           XmlDomMgnt.AddElement(XmlNode1,'TotalServGravados','0.00000','',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalServExentos','0.00000','',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasExentas',FORMAT(TotalVenta,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalGravado','0.00000','',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalExento',FORMAT(TotalVenta,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalVenta',FORMAT(TotalVenta,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalDescuentos',FORMAT(TotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalVentaNeta',FORMAT(TotalVenta-TotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalImpuesto','0.00000','',XmlNode2);
           XmlDomMgnt.AddElement(XmlNode1,'TotalComprobante',FORMAT(CMH."Amount Including VAT",0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        */

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        // XmlDomMgnt.AddElement(XmlNode1,'TotalMercExonerada','0,00000','',XmlNode2);     // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);   // YFC
                                                                                                                                      // XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0,00000','',XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        TotalVentaNeta := (TotalGravado + TotalExento) - TotalDescuento;
        //  XmlDomMgnt.AddElement(XmlNode1,'TotalVentaNeta',FORMAT(CMH."Amount Including VAT"-TotalImpuesto,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); 008-YFC
        //  XmlDomMgnt.AddElement(XmlNode1,'TotalImpuesto',FORMAT(TotalImpuesto,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); //YFC 008-YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(TotalVentaNeta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(CMH."Amount Including VAT" - CMH.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); //YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(CMH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);


        //Informacion Referencia
        // SIH.GET(CMH."Applies-to Doc. No.");
        SIH.GET(CMH."No. Doc Historico");

        XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
        //IF CMH."Tipo Doc. Ref NC"::) THEN //001
        //  ERROR('Debe Seleccionar un Tipo Doc. Ref NC ');

        CASE CMH."Tipo Doc. Ref NC" OF
            CMH."Tipo Doc. Ref NC"::"Factura Electronica":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '01', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Tiquete Electronico":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '04', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Sustituye Factura de Exportacion":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '12', '', XmlNode2);
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH.Consecutivo, '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmision', FORMAT(SIH."Fecha Doc Electronico", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'), '', XmlNode2);
        CASE CMH."Codigo Referencia" OF
            CMH."Codigo Referencia"::"Devolucion Total":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula Documento de Referencia', '', XmlNode2);
                END;
            CMH."Codigo Referencia"::"Devolucion Parcial":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '02', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye comprobante', '', XmlNode2);
                END;
        END;


        //    XmlDomMgnt.AddElement(XmlNode1,'Codigo','02','',XmlNode2);
        //    XmlDomMgnt.AddElement(XmlNode1,'Razon','Corrige texto documento de referencia','',XmlNode2);
        /*
         //Informacion Referecia
          XmlDomMgnt.AddElement(XmlNode,'Normativa','','',XmlNode1);
        
            XmlDomMgnt.AddElement(XmlNode1,'NumeroResolucion','DGT-R-48-2016','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1,'FechaResolucion','07-10-2016 08:00:00','',XmlNode2);
        */
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure TiqueteElectronica(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
        xmlFactura: DotNet XmlDocument;
        xmlFacturaFirmado: DotNet XmlDocument;
        xmlFacturaRespuesta: DotNet XmlDocument;
        SIH: Record 36;
        ReportFE: Report "34002519;
        DirectorioTemp: Text[100];
        ConfSant: Record 56001;
    begin
        ConfSant.GET;
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3) + GetValueByName(0, 'ARCHIVO_TE', 0) + '.xml';
        IF SIH.GET(SIH."Document Type"::Invoice, NoDocumento) THEN   //002-YFC
            CreaXmlTiquete(NoDocumento, DirectorioTemp);
        // SIH.GET(NoDocumento);   //002-YFC

        xmlFactura := xmlFactura.XmlDocument();
        xmlFactura.Load(DirectorioTemp);

        //Pendiente
        LogFacturaElectronica(3, SIH."No.", CURRENTDATETIME, SIH.Clave, SIH.Consecutivo, SIH.Estado, SIH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3), '', SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_TE', 0), 1);
        //Pendiente


        iProcesa := iProcesa.Procesa();


        iProcesa.EnviaFactura(xmlFactura, ConfSant."Es Prueba",
             GetValueByName(0, 'CERTIFICADO', 0),
             GetValueByName(0, 'CERTIFICADO_PIN', 0),
             GetValueByName(0, 'API', 0),
             GetValueByName(0, 'PASS', 0),
             GetValueByNameWithType(0, 'DIRECTORIOTEMP', 3),
             GetValueByName(0, 'ARCHIVO_TE', 0));

        SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', 3),
                      GetValueByName(0, 'ARCHIVO_TE', 0));

        SIH.Consecutivo := iProcesa.txtConsecutivo;
        SIH.Clave := iProcesa.txtClave;
        SIH.Estado := iProcesa.estadoFactura;
        SIH.Mensaje := iProcesa.mensajeRespuesta;
        SIH."Fecha Doc Electronico" := CURRENTDATETIME;
        SIH.MODIFY;

        SIH.RESET;
        SIH.SETRANGE("No.", SIH."No.");
        IF SIH.FINDFIRST THEN BEGIN
            ReportFE.SETTABLEVIEW(SIH);
            ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3) + 'TE-' + iProcesa.txtClave + '.pdf');
        END;

        LogFacturaElectronica(3, SIH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3), '',
        SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_TE', 0), 2);
        // MESSAGE('Consecutivo:' + iProcesa.txtConsecutivo);
        // MESSAGE('Clave: ' + iProcesa.txtClave);
        // MESSAGE('Estado: ' + iProcesa.estadoFactura);
        // MESSAGE('Mensaje: ' + iProcesa.mensajeRespuesta);
        // MESSAGE('Tiquete Generado con exito');
    end;

    procedure CreaXmlTiquete(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
        SIH: Record 36;
        SIL: Record 37;
        Cust: Record 18;
        TotalDescuento: Decimal;
        TotalVenta: Decimal;
    begin

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('TiqueteElectronico');
        XmlNode := XmlDoc.AppendChild(XmlNode);


        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/tiqueteElectronico');


        IF SIH.GET(SIH."Document Type"::Invoice, NoDocumento) THEN
            SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");
        // nivel 1
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '04'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        //XmlDomMgnt.AddElement(XmlNode,'Receptor','','',XmlNode1);

        // XmlDomMgnt.AddElement(XmlNode1,'Nombre',SIH."Bill-to Name",'',XmlNode2);
        // XmlDomMgnt.AddElement(XmlNode1,'Identificacion','','',XmlNode2);
        //      XmlDomMgnt.AddElement(XmlNode2,'Tipo',GetValueByName(2,FORMAT(Cust."Tax Identification Type"),0),'',XmlNode3);
        //    XmlDomMgnt.AddElement(XmlNode2,'Numero',Cust."VAT Registration No.",'',XmlNode3);
        //    XmlDomMgnt.AddElement(XmlNode2,'Numero','','',XmlNode3);

        // XmlDomMgnt.AddElement(XmlNode1,'CorreoElectronico',Cust."E-Mail",'',XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', GetValueByRelation(5, SIH."Payment Terms Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);
        //LINEAS
        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        //SIL.SETFILTER(Amount,'<>0');
        IF SIL.FINDSET THEN
            REPEAT

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);

                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(SIL."Line No." / 10000), '', XmlNode3);
                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(SIL."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, SIL."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo','','',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '01', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(SIL."Unit Price", 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(SIL."Unit Price" * SIL.Quantity, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoDescuento', FORMAT(SIL."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SIL.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                IF SIL.Amount <> SIL."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '', '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', '', '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', '', '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(SIL."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //Sumar
                TotalDescuento += SIL."Line Discount Amount";
                TotalVenta += SIL."Unit Price" * SIL.Quantity;

            UNTIL SIL.NEXT <= 0;
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CodigoMoneda', 'CRC', '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CodigoMoneda', SIH."Currency Code", '', XmlNode2);
        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TipoCambio', FORMAT(SIH."Amount Including VAT" / SIH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TipoCambio', '1.00000', '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Normativa', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'NumeroResolucion', 'DGT-R-48-2016', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaResolucion', '07-10-2016 08:00:00', '', XmlNode2);






        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);
    end;

    procedure GetClave(Fecha: Date; var Consecutivo: Text[20]; Tipo: Code[2]) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
        Seguridad: Integer;
        lStrValorRandom: Text[10];
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"

        Config.GET(Config.Tipo::Config, '', 'PAIS', Config."Tipo de Documento"::" ");
        Return += Config.Valor;

        Return += FORMAT(Fecha, 0, '<Closing><Day,2><Month,2><Year>');

        Config.GET(Config.Tipo::Config, '', 'EMISOR', Config."Tipo de Documento"::" ");
        Return += Config.Valor;

        Consecutivo := GetConsecutivo(Tipo);
        Return += Consecutivo;

        Config.GET(Config.Tipo::Config, '', 'SITUACION', Config."Tipo de Documento"::" ");
        IF wVieneDePos THEN //+#217374
            Return += '3'     //+#217374
        ELSE
            Return += Config.Valor;

        Config.GET(Config.Tipo::Config, '', 'CODIGOSEGURIDAD', Config."Tipo de Documento"::" ");
        EVALUATE(Seguridad, Config.Valor);

        //+#217374
        //Return += FORMAT(RANDOM(Seguridad));
        lStrValorRandom := FORMAT(RANDOM(Seguridad));
        lStrValorRandom := PADSTR('', 8 - STRLEN(lStrValorRandom), '0') + lStrValorRandom;
        Return += lStrValorRandom;
        //-#217374


        /*
        Config.GET(Config.Tipo::Config,'','NUMEROCAJA',Config."Tipo de Documento"::"");
        Return += Config.Valor;
        
        Config.GET(Config.Tipo::Config,'','TIPO',Config."Tipo de Documento"::"");
        Return += Config.Valor;
        
        
        Config.RESET;
        Config.SETRANGE(Tipo,Config.Tipo::Serie);
        Config.SETRANGE(Campo,'SERIE');
        IF Config.FINDFIRST THEN
        BEGIN
        NoSeriesMgt.InitSeries(Config.Relacion,Config.Relacion,TODAY,Num,Config.Relacion);
        Return += Num;
        END
        ELSE
         ERROR('Error de configuracion');
        
        */

    end;

    procedure GetConsecutivo(Tipo: Code[2]) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"
        //01. Factura Electrónica, 02. Nota de Débito, 03. Nota de Crédito, 04. Tiquete Electrónico,
        // 05. Confirmación de aceptación de documento electrónico, 06. Aceptación Parcial, 07. Rechazo de documento electrónico

        Config.GET(Config.Tipo::Config, '', 'SUCURSAL', Config."Tipo de Documento"::" ");
        Return += Config.Valor;

        Config.GET(Config.Tipo::Config, '', 'NUMEROCAJA', Config."Tipo de Documento"::" ");
        Return += Config.Valor;

        //Config.GET(Config.Tipo::Config,'','TIPO',Config."Tipo de Documento"::" ");
        //Return += Config.Valor;
        Return += Tipo;


        Config.RESET;
        Config.SETRANGE(Tipo, Config.Tipo::Serie);
        Config.SETRANGE(Campo, Tipo);
        IF Config.FINDFIRST THEN BEGIN

            NoSeriesMgt.InitSeries(Config.Relacion, Config.Relacion, TODAY, Num, Config.Relacion);
            //Num := NoSeriesMgt.GetNextNo(Config.Relacion,TODAY,TRUE);

            Return += Num;
        END
        ELSE
            ERROR('Error de configuracion')
    end;

    procedure GetValueByName(_Tipo: Integer; _Name: Text; _DocTipo: Integer) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"
        IF _Name <> '' THEN
            Config.GET(_Tipo, '', _Name, _DocTipo);
        Return += Config.Valor;
    end;

    procedure GetValueByNameWithType(_Tipo: Integer; _Name: Text; _DocTipo: Integer) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"
        _DocTipo += 1;
        IF _Name <> '' THEN
            Config.GET(_Tipo, '', _Name, _DocTipo);
        Return += Config.Valor;
    end;

    procedure GetValueByTypeName(_Tipo: Integer; _Name: Text; _DocTipo: Integer) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"
        IF _Name <> '' THEN
            Config.GET(_Tipo, '', _Name, _DocTipo);
        Return += Config.Valor;
    end;

    procedure GetValueByRelation(_Tipo: Integer; _Name: Text; _DocTipo: Integer) Return: Text
    var
        Config: Record 52501;
        Num: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin
        //Config
        //"Tipo","Relacion","Campo","Tipo de Documento"
        IF _Name <> '' THEN
            Config.GET(_Tipo, _Name, '', _DocTipo);
        Return += Config.Valor;
    end;

    procedure FormatDateTime(Fecha: Date; Hora: Time) TxtFecha: Text[50]
    var
        DT: DateTime;
        Convert: DotNet Convert;
    begin
        DT := CREATEDATETIME(Fecha, Hora);
        //DT       := Convert.ToDateTime(DT);
        //TxtFecha := FORMAT(DT,0,9);
        TxtFecha := FORMAT(DT, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>');
        //TxtFecha := COPYSTR(TxtFecha, 1, 19); // eliminamos el último carácter (Z): 2016-06-30T22:00:00Z --> 2016-06-30T22:00:00
    end;

    procedure FormatDate(Fecha: Date) TxtFecha: Text[50]
    begin
        TxtFecha := FORMAT(Fecha, 0, '<Year4>-<Month,2>-<Day,2>T00:00:00'); //2016-06-30T00:00:00
    end;

    procedure LogFacturaElectronica(Tipo: Integer; NoDocumento: Code[20]; Fecha: DateTime; Clave: Text[60]; Consecutivo: Text[20]; Estado: Text[30]; Mensaje: Text[200]; Directorio: Text[150]; Correo: Text[100]; Cliente: Text[100]; Archivo: Text[100]; EstadoInterfaz: Integer)
    var
        LogFE: Record 52502;
        FileManagment: Codeunit 419;
        TempBlob Record: 99008535" temporary;
        XmlFirmado: InStream;
        Text001: Label '%1  Santillana';
        Text002: Label ' %1  Santillana  %2';
        TextBody: Label '<p><strong>Estimado (a)</strong> <strong> %1 </strong> <br />Adjunto al correo encontrará su %2 en formato PDF y XML. Para garantizar la seguridad y confidencialidad de sus datos, esta dirección de e-mail será utilizada únicamente para enviar la información solicitada, por lo tanto, le agradecemos no responder los correos enviados, ni utilizar esta vía de comunicación para realizar consultas personales referentes a su %2 .</p>

    <p><br />Si presenta algún inconveniente por favor comunicarse al correo electrónico: msanchezv@santillana.com con la señorita Melissa Sanchez de Facturación. <br />Gracias <br /><strong>Santillana S.A. </strong></p>';
        TextBody2: Label '<p>Estimado (a) %1 </p>

    <p>Le informamos que su %2 número<strong> %3 </strong> ha sido %4 por la administración tributaria.</p>

    <p>Se adjunta el documento de respuesta enviado por la administración tributaria.</p>';
        XmlRespuesta: InStream;
    begin
        LogFE.INIT;
        LogFE."Tipo Documento" := Tipo;
        LogFE.NoDocumento := NoDocumento;
        LogFE."Fecha Doc" := Fecha;
        LogFE."Clave Doc" := Clave;
        LogFE."Consecutivo Doc" := Consecutivo;
        LogFE.Estado := Estado;
        LogFE.Mensaje := Mensaje;
        LogFE."Estado Interfaz" := EstadoInterfaz;
        LogFE.Usuario := USERID;

        IF EstadoInterfaz = 1 THEN BEGIN
            //SF
            CLEAR(TempBlob);
            FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '.xml');
            LogFE."Doc SF  XML" := TempBlob.Blob;
            //SF
            CLEAR(LogFE."Clave Doc");
            CLEAR(LogFE."Consecutivo Doc");
            CLEAR(LogFE.Estado);
            CLEAR(LogFE.Mensaje);

            IF NOT LogFE.INSERT THEN
                LogFE.MODIFY;

        END;


        IF EstadoInterfaz = 2 THEN BEGIN
            //SF
            CLEAR(TempBlob);
            FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '_01_SF.xml');
            LogFE."Doc SF  XML" := TempBlob.Blob;
            //SF

            //Firmado
            CLEAR(TempBlob);
            FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '_02_Firmado.xml');
            LogFE."Doc Firmado  XML" := TempBlob.Blob;
            //Firmado

            //Json Envio
            CLEAR(TempBlob);
            FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '_03_jsonEnvio.txt');
            LogFE."Doc Json envio  XML" := TempBlob.Blob;
            //Json Envio

            //Json Respuesta
            CLEAR(TempBlob);
            FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '_04_jsonRespuesta.txt');
            LogFE."Doc Json Respuesta  XML" := TempBlob.Blob;
            //json Respuesta

            //Respuesta
            CLEAR(TempBlob);
            IF EXISTS(Directorio + Archivo + '_05_RESP.xml') THEN BEGIN
                FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + Archivo + '_05_RESP.xml');
                LogFE."Doc Respuesta  XML" := TempBlob.Blob;
            END;
            IF NOT LogFE.INSERT THEN
                LogFE.MODIFY;




            //Respuesta
            IF Clave <> '' THEN
                //+#217374
                //IF  LogFE."Tipo Documento" IN [LogFE."Tipo Documento"::FE ,LogFE."Tipo Documento"::NC,LogFE."Tipo Documento"::ND] THEN
                IF LogFE."Tipo Documento" IN [LogFE."Tipo Documento"::FE, LogFE."Tipo Documento"::NC, LogFE."Tipo Documento"::ND, LogFE."Tipo Documento"::TE, LogFE."Tipo Documento"::FEC] THEN //015-
                                                                                                                                                                                                //-#217374
              BEGIN
                    //Pdf
                    CLEAR(TempBlob);
                    FileManagment.BLOBImportFromServerFile(TempBlob, Directorio + FORMAT(LogFE."Tipo Documento") + '-' + Clave + '.pdf');
                    LogFE."Doc Pdf Generado" := TempBlob.Blob;
                    //Pdf
                END;

            //Calculate Documents
            LogFE.CALCFIELDS("Doc Firmado  XML", "Doc Respuesta  XML");

            //Documents
            LogFE."Doc Firmado  XML".CREATEINSTREAM(XmlFirmado);
            LogFE."Doc Respuesta  XML".CREATEINSTREAM(XmlRespuesta);
            //Documents
            IF NOT LogFE.INSERT THEN
                LogFE.MODIFY;

            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
            //{011+- Se decomenta error correo solucionado.
            //SENT EMAIL

            //012+
            IF Correo <> '' THEN
                ValidaCorreoElect(Correo, NoDocumento);
            //012-
            IF Clave <> '' THEN
                IF (Correo <> '') AND (Estado = 'aceptado') THEN BEGIN
                    SendEmail(Correo, STRSUBSTNO(Text001, GetDocumentName(LogFE), LogFE."Consecutivo Doc"), STRSUBSTNO(TextBody, Cliente, GetDocumentName(LogFE))
                    , FORMAT(LogFE."Tipo Documento") + '-' + Clave + '.xml', Directorio + FORMAT(LogFE."Tipo Documento") + '-' + Clave + '.pdf', TRUE, XmlFirmado);

                    SendEmail(Correo, STRSUBSTNO(Text002, GetDocumentName(LogFE), LogFE.Estado), STRSUBSTNO(TextBody2, Cliente, GetDocumentName(LogFE), LogFE."Consecutivo Doc", LogFE.Estado)
                    , FORMAT(LogFE."Tipo Documento") + '-' + Clave + '.xml', Directorio + FORMAT(LogFE."Tipo Documento") + '-' + Clave + '.pdf', FALSE, XmlRespuesta);
                END;
            //SENT EMAIL
            //}011+- Se decomenta error correo solucionado.
            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
        END;
    end;

    procedure ComprobarDocumentoElectronico(NoDocument: Code[20]; Clave: Text[100]; Tipo: Integer)
    var
        iProcesa: DotNet Procesa;
        xmlFactura: DotNet XmlDocument;
        xmlFacturaFirmado: DotNet XmlDocument;
        xmlFacturaRespuesta: DotNet XmlDocument;
        SIH: Record 112;
        CMH: Record 114;
        ConfSant: Record 56001;
        PIH: Record 122;
    begin
        ConfSant.GET;
        //Comprobar el comprobante electronico
        // Clave := '50604101800310114588000100001010000000099188888888';
        iProcesa := iProcesa.Procesa();
        iProcesa.ConsultaComprobante(Clave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', Tipo),
                      GetValueByName(0, 'ARCHIVO_FE', 0));
        //Factura
        IF SIH.GET(NoDocument) THEN BEGIN
            SIH.Estado := iProcesa.estadoFactura;
            SIH.Mensaje := iProcesa.mensajeRespuesta;
            SIH."Fecha Doc Electronico" := CURRENTDATETIME;
            SIH.MODIFY;
        END;

        //Nota de Credito
        IF CMH.GET(NoDocument) THEN BEGIN
            CMH.Estado := iProcesa.estadoFactura;
            CMH.Mensaje := iProcesa.mensajeRespuesta;
            CMH."Fecha Doc Electronico" := CURRENTDATETIME;
            CMH.MODIFY;
        END;

        //Factura de Compra
        //013+
        IF PIH.GET(NoDocument) THEN BEGIN
            PIH.Estado := iProcesa.estadoFactura;
            PIH.Mensaje := iProcesa.mensajeRespuesta;
            PIH."Fecha Doc Electronico" := CURRENTDATETIME;
            PIH.MODIFY;
        END;
        //013+

        // MESSAGE('Comprobacion Generada con exito');
    end;

    procedure NotaCreditoElectronicaTipo(NoDocumento: Code[20]; Tipo: Code[2])
    var
        iProcesa: DotNet Procesa;
        xmlNotaCredito: DotNet XmlDocument;
        xmlNotaCreditoFirmado: DotNet XmlDocument;
        xmlNotaCreditoRespuesta: DotNet XmlDocument;
        CMH: Record 112;
        ReportFE: Report "52544;
                      DirectorioTemp: Text[100];
        ConfSant: Record 56001;
    begin
        ConfSant.GET;
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1) + GetValueByName(0, 'ARCHIVO_NC', 0) + '.xml';
        IF CMH.GET(NoDocumento) THEN
            CreaXmlNotaCreditoTipo(NoDocumento, DirectorioTemp, Tipo);

        xmlNotaCredito := xmlNotaCredito.XmlDocument();
        xmlNotaCredito.Load(DirectorioTemp);

        //Pendiente
        LogFacturaElectronica(1, CMH."No.", CURRENTDATETIME, CMH.Clave, CMH.Consecutivo, CMH.Estado, CMH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1), CMH."E-Mail-FE", CMH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_NC', 0), 1);
        //Pendiente


        iProcesa := iProcesa.Procesa();

        iProcesa.EnviaFactura(xmlNotaCredito,
             ConfSant."Es Prueba",
             GetValueByName(0, 'CERTIFICADO', 0),
             GetValueByName(0, 'CERTIFICADO_PIN', 0),
             GetValueByName(0, 'API', 0),
             GetValueByName(0, 'PASS', 0),
             GetValueByNameWithType(0, 'DIRECTORIOTEMP', 1),
             GetValueByName(0, 'ARCHIVO_NC', 0));



        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', 1),
                      GetValueByName(0, 'ARCHIVO_NC', 0));


        CMH.Consecutivo := iProcesa.txtConsecutivo;
        CMH.Clave := iProcesa.txtClave;
        CMH.Estado := iProcesa.estadoFactura;
        CMH.Mensaje := iProcesa.mensajeRespuesta;
        CMH."Fecha Doc Electronico" := CURRENTDATETIME;
        CMH.MODIFY;

        CMH.RESET;
        CMH.SETRANGE("No.", CMH."No.");
        IF CMH.FINDFIRST THEN BEGIN
            ReportFE.SETTABLEVIEW(CMH);
            ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1) + 'NC-' + iProcesa.txtClave + '.pdf');
        END;

        LogFacturaElectronica(1, CMH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 1), CMH."E-Mail-FE",
        CMH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_NC', 0), 2);
        // MESSAGE('Consecutivo:' + iProcesa.txtConsecutivo);
        // MESSAGE('Clave: ' + iProcesa.txtClave);
        // MESSAGE('Estado: ' + iProcesa.estadoFactura);
        // MESSAGE('Mensaje: ' + iProcesa.mensajeRespuesta);
        // MESSAGE('Nota de Credito Electronica Generada con exito');
    end;

    procedure CreaXmlNotaCreditoTipo(NoDocumento: Code[20]; DirectorioTemp: Text[100]; Tipo: Code[2])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
        CMH: Record 112;
        CML: Record 113;
        Cust: Record 18;
        TotalDescuento: Decimal;
        TotalVenta: Decimal;
        NumeroLinea: Integer;
    begin

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('NotaCreditoElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xs','http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaCreditoElectronica');


        CMH.GET(NoDocumento);
        CMH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(CMH."Bill-to Customer No.");
        // nivel 1
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(CMH."Posting Date", Consecutivo, '03'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(CMH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', CMH."Bill-to Name", '', XmlNode2);

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', Cust."VAT Registration No.", '', XmlNode2)
        ELSE BEGIN
            // --009-YFC
            XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2, 'Numero', Cust."VAT Registration No.", '', XmlNode3);
        END; //009-YFC

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', GetValueByRelation(5, CMH."Payment Terms Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, CMH."Payment Method Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);
        //LINEAS
        CML.RESET;
        CML.SETRANGE("Document No.", CMH."No.");
        CML.SETFILTER(Quantity, '<>0');
        //CML.SETFILTER(Amount,'<>0');
        IF CML.FINDSET THEN
            REPEAT

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);


                NumeroLinea += 1;
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(NumeroLinea), '', XmlNode3);

                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(CML."Line No."/10000),'',XmlNode3);
                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(CML."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, CML."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo','','',XmlNode3);
                // -- 003-YFC


                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '01', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', CML."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(CML.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, CML."Unit of Measure Code", 0), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', CML.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(CML."Unit Price", 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(CML."Unit Price" * CML.Quantity, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoDescuento', FORMAT(CML."Line Discount Amount", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(CML.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                IF CML.Amount <> CML."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '', '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', '', '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', '', '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(CML."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //Sumar
                TotalDescuento += CML."Line Discount Amount";
                TotalVenta += CML."Unit Price" * CML.Quantity;

            UNTIL CML.NEXT <= 0;
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        IF CMH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CodigoMoneda', 'CRC', '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CodigoMoneda', CMH."Currency Code", '', XmlNode2);
        IF CMH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TipoCambio', FORMAT(CMH."Amount Including VAT" / CMH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TipoCambio', '1.00000', '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalVenta, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(CMH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //Informacion Referencia
        //SIH.GET(CMH."Applies-to Doc. No.");

        XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '01', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Numero', CMH.Consecutivo, '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmision', FORMAT(CMH."Fecha Doc Electronico", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'), '', XmlNode2);
        //   XmlDomMgnt.AddElement(XmlNode1,'Codigo','01','',XmlNode2);
        //   XmlDomMgnt.AddElement(XmlNode1,'Razon','Anula Documento de Referencia','',XmlNode2);

        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '02', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Corrige texto documento de referencia', '', XmlNode2);



        //Informacion Referecia
        XmlDomMgnt.AddElement(XmlNode, 'Normativa', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'NumeroResolucion', 'DGT-R-48-2016', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaResolucion', '07-10-2016 08:00:00', '', XmlNode2);






        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);
    end;

    procedure MensajeElectronico(Tipo: Integer; NoDocumento: Code[20]; DirectorioTemp: Text[500])
    var
        iProcesa: DotNet Procesa;
        xmlDoc: DotNet XmlDocument;
        ConfSant: Record 56001;
    begin
        //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
        ConfSant.GET;
        // CreaXmlMensaje(NoDocumento,DirectorioTemp);
        xmlDoc := xmlDoc.XmlDocument();
        xmlDoc.Load(DirectorioTemp);

        iProcesa := iProcesa.Procesa();

        iProcesa.EnviaFactura(xmlDoc,
             ConfSant."Es Prueba",
             GetValueByName(0, 'CERTIFICADO', 0),
             GetValueByName(0, 'CERTIFICADO_PIN', 0),
             GetValueByName(0, 'API', 0),
             GetValueByName(0, 'PASS', 0),
             GetValueByNameWithType(0, 'DIRECTORIOTEMP', Tipo),
             GetValueByName(0, 'ARCHIVO_MJ', 0));


        // SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                      ConfSant."Es Prueba",
                      GetValueByName(0, 'API', 0),
                      GetValueByName(0, 'PASS', 0),
                      GetValueByNameWithType(0, 'DIRECTORIOTEMP', Tipo),
                      GetValueByName(0, 'ARCHIVO_MJ', 0));


        LogFacturaElectronica(Tipo, NoDocumento, CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', Tipo), '', '', GetValueByName(0, 'ARCHIVO_MJ', 0), 2);
        MESSAGE('Mensaje Generado con exito');
    end;

    procedure CreaXmlMensaje(Clave: Code[80]; NumeroCedulaEmisor: Text[12]; FechaEmisionDoc: Text[40]; Mensaje: Integer; DetalleMensaje: Text[150]; MontoTotalImpuesto: Text[30]; CodigoActividad: Text[6]; TotalFactura: Text[30]; NumeroCedulaReceptor: Text[12]; var NumConsecutivoReceptor: Text[20]; DirectorioTemp: Text[250])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        String: DotNet String;
        MyDT: DateTime;
        i: Integer;
        NS: ;
        ConfSant: Record 56001;
        xmlProcessingInst: DotNet XmlProcessingInstruction;
        Consecutivo: Text[20];
    begin

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;
        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('MensajeReceptor');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeReceptor');

        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/mensajeReceptor');      // YFC
        Mensaje += 1;
        IF Mensaje = 1 THEN
            NumConsecutivoReceptor := GetConsecutivo('05');

        IF Mensaje = 2 THEN
            NumConsecutivoReceptor := GetConsecutivo('06');

        IF Mensaje = 3 THEN
            NumConsecutivoReceptor := GetConsecutivo('07');

        XmlDomMgnt.AddElement(XmlNode, 'Clave', Clave, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroCedulaEmisor', NumeroCedulaEmisor, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmisionDoc', FechaEmisionDoc, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Mensaje', FORMAT(Mensaje), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'DetalleMensaje', DetalleMensaje, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'MontoTotalImpuesto', MontoTotalImpuesto, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', CodigoActividad, '', XmlNode1); // YFC
        XmlDomMgnt.AddElement(XmlNode, 'TotalFactura', TotalFactura, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroCedulaReceptor', NumeroCedulaReceptor, '', XmlNode1);

        //Tipos de Documentos
        //01-07
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivoReceptor', NumConsecutivoReceptor, '', XmlNode1);
        //Campos

        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);
    end;

    procedure UploadDocumentoElectronico(var Retorno: array[10] of Text)
    var
        FileManagetment: Codeunit 419;
        Directorio: Text;
        iProcesa: DotNet Procesa;
        xmlDoc: DotNet XmlDocument;
        XMLNode: DotNet XmlNode;
        XMLNodeList: DotNet XmlNodeList;
        i: Integer;
    begin

        Directorio := FileManagetment.UploadFileWithFilter('Recepcion de Documento Eletronico', '', 'XML Files (*.xml)|*.xml', '*.*');

        IF Directorio <> '' THEN BEGIN
            xmlDoc := xmlDoc.XmlDocument();
            xmlDoc.Load(Directorio);

            // ++ Buscar en el xml el CodigoActividad        YFC
            XMLNodeList := xmlDoc.GetElementsByTagName('CodigoActividad');

            FOR i := 0 TO XMLNodeList.Count - 1 DO BEGIN
                XMLNode := XMLNodeList.Item(i);
                Retorno[8] := XMLNode.InnerText;
            END;
            // --     YFC

            iProcesa := iProcesa.Procesa();
            iProcesa.CargaDatosXML_CR(xmlDoc);

            Retorno[1] := iProcesa.txtClave;
            //Retorno[2] := iProcesa.txtEmisorTipo;
            Retorno[2] := iProcesa.txtEmisorNumero;
            Retorno[3] := iProcesa.txtFecha;
            Retorno[4] := iProcesa.txtTotalImpuesto;
            Retorno[5] := iProcesa.txtTotalDocumento;
            Retorno[6] := iProcesa.txtReceptorNumero;
            // Retorno[7] := GetConsecutivo('05');




            Retorno[10] := Directorio;

        END;
    end;

    local procedure CreateQRCode(QRCodeInput: Text[95]; var TempBLOB Record: 99008535")
    var
        QRCodeFileName: Text[1024];
    begin
        CLEAR(TempBLOB);
        QRCodeFileName := GetQRCode(QRCodeInput);
        UploadFileBLOBImportandDeleteServerFile(TempBLOB, QRCodeFileName);
    end;

    procedure UploadFileBLOBImportandDeleteServerFile(var TempBlob Record: 99008535; FileName: Text[1024])
    var
        FileManagement: Codeunit 419;
    begin
        FileName := FileManagement.UploadFileSilent(FileName);
        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        DeleteServerFile(FileName);
    end;

    local procedure GetQRCode(QRCodeInput: Text[95]) QRCodeFileName: Text[1024]
    var
        EInvoiceObjectFactory: Codeunit 10147;
        IBarCodeProvider: DotNet IBarcodeProvider;
    begin
        EInvoiceObjectFactory.GetBarCodeProvider(IBarCodeProvider);
        QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    end;

    local procedure DeleteServerFile(ServerFileName: Text)
    begin
        IF ERASE(ServerFileName) THEN;
    end;

    procedure SendEmail(SendToAddress: Text[1024]; Subject: Text[200]; MessageBody: Text[1024]; FilePathEDoc: Text[1024]; PDFFilePath: Text[1024]; SendPDF: Boolean; XMLInstream: InStream)
    var
        SMTPMail: Codeunit 400;
        SendOK: Boolean;
        GLSetup: Record 98;
        CompanyInfo: Record 79;
        SMTP_ERROR: Label 'Error : %1';
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        IF GLSetup."Sim. Send" THEN
            EXIT;

        //+#217374
        IF wVieneDePos THEN
            EXIT;
        //-#217374

        //Subject := Convert.Ascii2Ansi(Subject);
        //Subject := Convert.Ansi2Ascii(Subject);


        SMTPMail.CreateMessage(CompanyInfo.Name, CompanyInfo."E-Mail", SendToAddress, Subject, MessageBody, TRUE);
        SMTPMail.AddAttachmentStream(XMLInstream, FilePathEDoc);

        IF SendPDF THEN
            SMTPMail.AddAttachment(PDFFilePath, '');   //fes mig adicione ''



        SendOK := SMTPMail.TrySend;

        IF SendPDF THEN
            DeleteServerFile(PDFFilePath);

        IF NOT SendOK THEN
           //ERROR(STRSUBSTNO(SMTP_ERROR,SMTPMail.GetLastSendMailErrorText));
           BEGIN
            ERROR(STRSUBSTNO(SMTP_ERROR, SMTPMail.GetLastSendMailErrorText + ' Correo: ' + SendToAddress)); //007-YFC
                                                                                                            //ERROR(STRSUBSTNO(SMTP_ERROR,SMTPMail.GetLastSendMailErrorText));
                                                                                                            /*
                                                                                                            // ++ 007-YFC
                                                                                                              ConfSant.GET;
                                                                                                              SMTPMail.CreateMessage(CompanyInfo.Name,CompanyInfo."E-Mail",ConfigEmpresa."Email GD Local",Subject,STRSUBSTNO(SMTP_ERROR,SMTPMail.GetLastSendMailErrorText + ' Correo: '+SendToAddress),TRUE);
                                                                                                              SMTPMail.AddAttachmentStream(XMLInstream,FilePathEDoc);

                                                                                                              IF SendPDF THEN
                                                                                                                  BEGIN
                                                                                                                    SMTPMail.AddAttachment(PDFFilePath,'');
                                                                                                                    DeleteServerFile(PDFFilePath);
                                                                                                                  END
                                                                                                           // -- 007-YFC
                                                                                                           */
        END;

    end;

    procedure GetDocumentName(var Log Record: 52502") DocumentName: Text
    begin
        CASE Log."Tipo Documento" OF
            Log."Tipo Documento"::FE:
                DocumentName := 'Factura Electronica';
            Log."Tipo Documento"::NC:
                DocumentName := 'Nota de Credito';
            Log."Tipo Documento"::ND:
                DocumentName := 'Nota de Debito';
            Log."Tipo Documento"::TE:
                DocumentName := 'Tiquete Electronico';
            //015+
            Log."Tipo Documento"::FEC:
                DocumentName := 'Factura Electronica de compra'
        //015-
        END
    end;

    procedure ComprobarDocumentoElectronicoLOG(Logs: Record 52502)
    var
        iProcesa: DotNet Procesa;
                      xmlFactura: DotNet XmlDocument;
                      xmlFacturaFirmado: DotNet XmlDocument;
                      xmlFacturaRespuesta: DotNet XmlDocument;
                      SIH: Record 112;
                      CMH: Record 114;
                      ConfSant: Record 56001;
                      SH: Record 36;
                      FileManagment: Codeunit 419;
                      TempBlob Record: 99008535" temporary;
        XmlFirmado: InStream;
                      XmlRespuesta: InStream;
                      ArchivoPDF: Text;
                      ReportFE: Report "52543;
                      ReportNC: Report "52544;
                      ReportFEC: Report "10121;
                      Log: Record 52502;
                      PIH: Record 122;
                      DPIExt: Record 50028;
    begin
        ConfSant.GET;
                      //Comprobar el comprobante electronico
                      // Clave := '50604101800310114588000100001010000000099188888888';
                      Log.GET(Logs."Tipo Documento", Logs.NoDocumento);
                      iProcesa := iProcesa.Procesa();
                      iProcesa.ConsultaComprobante(Log."Clave Doc",
                                    ConfSant."Es Prueba",
                                    GetValueByName(0, 'API', 0),
                                    GetValueByName(0, 'PASS', 0),
                                    GetValueByNameWithType(0, 'DIRECTORIOTEMP', Log."Tipo Documento"),
                                    GetValueByName(0, 'ARCHIVO_' + FORMAT(Log."Tipo Documento"), 0));


                      //Respuesta
                      CLEAR(TempBlob);
                      IF EXISTS(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', Log."Tipo Documento") + GetValueByName(0, 'ARCHIVO_' + FORMAT(Log."Tipo Documento"), 0) + '_05_RESP.xml') THEN BEGIN
            FileManagment.BLOBImportFromServerFile(TempBlob, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', Log."Tipo Documento") + GetValueByName(0, 'ARCHIVO_' + FORMAT(Log."Tipo Documento"), 0) + '_05_RESP.xml');
                      Log."Doc Respuesta  XML" := TempBlob.Blob;
                      Log.Estado := iProcesa.estadoFactura;
                      Log.Mensaje := iProcesa.mensajeRespuesta;
                      Log.MODIFY;
        END;

        //Respuesta

        ArchivoPDF := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', Log."Tipo Documento") + FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.pdf';
        // Factura
        IF SIH.GET(Log.NoDocumento) THEN BEGIN
            SIH.Estado := iProcesa.estadoFactura;
            SIH.Mensaje := iProcesa.mensajeRespuesta;
            SIH."Fecha Doc Electronico" := CURRENTDATETIME;
            SIH.MODIFY;


            //Calculate Documents
            Log.CALCFIELDS("Doc Firmado  XML", "Doc Respuesta  XML");

            //Documents
            Log."Doc Firmado  XML".CREATEINSTREAM(XmlFirmado);
            Log."Doc Respuesta  XML".CREATEINSTREAM(XmlRespuesta);
            //Documents

            //CREAR PDF
            IF NOT EXISTS(ArchivoPDF) THEN BEGIN
                SIH.RESET;
                SIH.SETRANGE("No.", SIH."No.");
                IF SIH.FINDFIRST THEN BEGIN
                    ReportFE.SETTABLEVIEW(SIH);
                    ReportFE.SAVEASPDF(ArchivoPDF);
                END;
            END;
            //CREAR PDF

            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
            //{011+- Se decomenta error correo solucionado.
            //SENT EMAIL
            IF SIH.Clave <> '' THEN
                IF (SIH."E-Mail-FE" <> '') AND (SIH.Estado = 'aceptado') THEN BEGIN
                    //012+
                    ValidaCorreoElect(SIH."E-Mail-FE", SIH."No.");
                    //012-
                    SendEmail(SIH."E-Mail-FE", STRSUBSTNO(Text001, GetDocumentName(Log), Log."Consecutivo Doc"), STRSUBSTNO(TextBody, SIH."Sell-to Customer Name", GetDocumentName(Log))
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, TRUE, XmlFirmado);

                    SendEmail(SIH."E-Mail-FE", STRSUBSTNO(Text002, GetDocumentName(Log), Log.Estado), STRSUBSTNO(TextBody2, SIH."Sell-to Customer Name", GetDocumentName(Log), Log."Consecutivo Doc", Log.Estado)
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, FALSE, XmlRespuesta);
                END;
            //SENT EMAIL
            //}011+- Se decomenta error correo solucionado.
            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
            COMMIT;
        END;

        //Nota de Credito
        IF CMH.GET(Log.NoDocumento) THEN BEGIN
            CMH.Estado := iProcesa.estadoFactura;
            CMH.Mensaje := iProcesa.mensajeRespuesta;
            CMH."Fecha Doc Electronico" := CURRENTDATETIME;
            CMH.MODIFY;
            // ++ 005-YFC
            //Calculate Documents
            Log.CALCFIELDS("Doc Firmado  XML", "Doc Respuesta  XML");

            //Documents
            Log."Doc Firmado  XML".CREATEINSTREAM(XmlFirmado);
            Log."Doc Respuesta  XML".CREATEINSTREAM(XmlRespuesta);
            //Documents

            // -- 005-YFC

            //CREAR PDF
            IF NOT EXISTS(ArchivoPDF) THEN BEGIN
                CMH.RESET;
                // CMH.SETRANGE("No.",SIH."No.");  // 006-YFC
                CMH.SETRANGE("No.", Log.NoDocumento);  // 006-YFC
                IF CMH.FINDFIRST THEN BEGIN
                    ReportNC.SETTABLEVIEW(CMH);
                    ReportNC.SAVEASPDF(ArchivoPDF);
                END;
            END;
            //CREAR PDF

            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
            //{011+- Se decomenta error correo solucionado.011+- Se decomenta error correo solucionado.
            //SENT EMAIL
            // IF SIH.Clave <>'' THEN    // 005-YFC

            //  IF (SIH."E-Mail-FE" <> '')  AND (SIH.Estado ='aceptado')  THEN   // 005-YFC
            IF CMH.Clave <> '' THEN    // 005-YFC

                IF (CMH."E-Mail-FE" <> '') AND (CMH.Estado = 'aceptado') THEN   // 005-YFC

              BEGIN
                    //012+
                    ValidaCorreoElect(CMH."E-Mail-FE", CMH."No.");
                    //012-
                    SendEmail(CMH."E-Mail-FE", STRSUBSTNO(Text001, GetDocumentName(Log), Log."Consecutivo Doc"), STRSUBSTNO(TextBody, CMH."Sell-to Customer Name", GetDocumentName(Log))
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, TRUE, XmlFirmado);

                    SendEmail(CMH."E-Mail-FE", STRSUBSTNO(Text002, GetDocumentName(Log), Log.Estado), STRSUBSTNO(TextBody2, CMH."Sell-to Customer Name", GetDocumentName(Log), Log."Consecutivo Doc", Log.Estado)
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, FALSE, XmlRespuesta);
                END;
            //SENT EMAIL
            //}011+- Se decomenta error correo solucionado.
            //LDP-011+- Se comenta Codigo de envio de correo por peticion Mariela hasta solventar caso correo.
            COMMIT;
        END;

        // Factura Compra //013+

        //014+
        IF PIH.GET(Log.NoDocumento) THEN BEGIN
            IF DPIExt.GET(Log.NoDocumento) THEN;
            DPIExt.Estado := iProcesa.estadoFactura;
            DPIExt.Mensaje := iProcesa.mensajeRespuesta;
            DPIExt."Fecha Doc Electronico" := CURRENTDATETIME;
            DPIExt.MODIFY;

            //Calculate Documents
            Log.CALCFIELDS("Doc Firmado  XML", "Doc Respuesta  XML");

            //Documents
            Log."Doc Firmado  XML".CREATEINSTREAM(XmlFirmado);
            Log."Doc Respuesta  XML".CREATEINSTREAM(XmlRespuesta);
            //Documents

            //CREAR PDF

            IF NOT EXISTS(ArchivoPDF) THEN BEGIN
                PIH.RESET;
                PIH.SETRANGE("No.", PIH."No.");
                IF PIH.FINDFIRST THEN BEGIN
                    ReportFEC.SETTABLEVIEW(PIH);
                    ReportFEC.SAVEASPDF(ArchivoPDF);
                END;
            END;

            //CREAR PDF

            //SENT EMAIL

            IF DPIExt.Clave <> '' THEN
                IF (DPIExt."E-Mail-FE" <> '') AND (DPIExt.Estado = 'aceptado') THEN BEGIN
                    SendEmail(DPIExt."E-Mail-FE", STRSUBSTNO(Text001, GetDocumentName(Log), Log."Consecutivo Doc"), STRSUBSTNO(TextBody, PIH."Buy-from Vendor Name", GetDocumentName(Log))
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, TRUE, XmlFirmado);

                    SendEmail(DPIExt."E-Mail-FE", STRSUBSTNO(Text002, GetDocumentName(Log), Log.Estado), STRSUBSTNO(TextBody2, PIH."Buy-from Vendor Name", GetDocumentName(Log), Log."Consecutivo Doc", Log.Estado)
                    , FORMAT(Log."Tipo Documento") + '-' + Log."Clave Doc" + '.xml', ArchivoPDF, FALSE, XmlRespuesta);
                END;

            //SENT EMAIL
            COMMIT;
        END;
        /*
          IF PIH.GET(Log.NoDocumento) THEN
           BEGIN
            PIH.Estado      := iProcesa.estadoFactura;
            PIH.Mensaje     := iProcesa.mensajeRespuesta;
            PIH."Fecha Doc Electronico"  := CURRENTDATETIME;
            PIH.MODIFY;
        
              //Calculate Documents
              Log.CALCFIELDS("Doc Firmado  XML","Doc Respuesta  XML");
        
              //Documents
              Log."Doc Firmado  XML".CREATEINSTREAM(XmlFirmado);
              Log."Doc Respuesta  XML".CREATEINSTREAM(XmlRespuesta);
              //Documents
        
             //CREAR PDF
        
              IF NOT EXISTS(ArchivoPDF) THEN
                 BEGIN
                    PIH.RESET;
                    PIH.SETRANGE("No.",PIH."No.");
                 IF PIH.FINDFIRST THEN
                    BEGIN
                      ReportFEC.SETTABLEVIEW(PIH);
                      ReportFEC.SAVEASPDF(ArchivoPDF);
                    END;
                 END;
        
              //CREAR PDF
        
              //SENT EMAIL
        
              IF PIH.Clave <>'' THEN
              IF (PIH."E-Mail-FE" <> '')  AND (PIH.Estado ='aceptado')  THEN
              BEGIN
                SendEmail(PIH."E-Mail-FE",STRSUBSTNO(Text001,GetDocumentName(Log),Log."Consecutivo Doc"),STRSUBSTNO(TextBody,PIH."Buy-from Vendor Name",GetDocumentName(Log))
                ,FORMAT(Log."Tipo Documento")+'-'+Log."Clave Doc"+'.xml',ArchivoPDF,TRUE,XmlFirmado);
        
                SendEmail(PIH."E-Mail-FE",STRSUBSTNO(Text002,GetDocumentName(Log),Log.Estado),STRSUBSTNO(TextBody2,PIH."Buy-from Vendor Name",GetDocumentName(Log),Log."Consecutivo Doc",Log.Estado)
                ,FORMAT(Log."Tipo Documento")+'-'+Log."Clave Doc"+'.xml',ArchivoPDF,FALSE,XmlRespuesta);
              END;
        
              //SENT EMAIL
             COMMIT;
            END;
            */
        // Factura Compra //013+

        //Tiquete
        IF SH.GET(SH."Document Type"::Invoice, Log.NoDocumento) THEN BEGIN
            SH.Estado := iProcesa.estadoFactura;
            SH.Mensaje := iProcesa.mensajeRespuesta;
            SH."Fecha Doc Electronico" := CURRENTDATETIME;
            IF SH.MODIFY THEN;
        END;

        Log.Estado := iProcesa.estadoFactura;
        Log.Mensaje := iProcesa.mensajeRespuesta;
        Log."Fecha Doc" := CURRENTDATETIME;
        IF Log.MODIFY THEN
            COMMIT;

    end;

    procedure ComprobarDocumentosElectronicoLOG()
    var
        Logs: Record 52502;
    begin

        Logs.RESET;
        Logs.SETCURRENTKEY(Estado);
        Logs.SETFILTER(Estado, ' %1|%2', '', 'procesando');
        //Logs.SETRANGE(NoDocumento,'VFR-100028');
        Logs.SETFILTER("Fecha Doc", '>%1', CREATEDATETIME(031323D, 0T)); //010-YFC PRUEBAS

        //Logs.SETRANGE("Fecha Doc",CREATEDATETIME(03132023D, 140357360T)); //010-YFC PRUEBAS
        //Logs.FINDFIRST;
        //MESSAGE(FORMAT(Logs.COUNT)+' '+ Logs.NoDocumento);
        //IF Logs.FINDFIRST THEN
        // ComprobarDocumentoElectronicoLOG(Logs);

        // ++ 010-YFC
        /*
        Logs.RESET;
        Logs.SETFILTER(Estado,' %1|%2','','procesando') ;
        */
        IF Logs.FINDSET(TRUE) THEN
            REPEAT
                ComprobarDocumentoElectronicoLOG(Logs);
            UNTIL Logs.NEXT <= 0;

        // -- 010-YFC

    end;

    procedure TiqueteElectronico_vCentral(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
                      xmlFactura: DotNet XmlDocument;
                      xmlFacturaFirmado: DotNet XmlDocument;
                      xmlFacturaRespuesta: DotNet XmlDocument;
                      SIH: Record 112;
                      ReportFE: Report "34002530;
                      DirectorioTemp: Text[100];
                      ConfSant: Record 56001;
                      QRCodeInput: Text;
                      TempBlob: Record 99008535;
    begin
        //+#217374

        ConfSant.GET;
                      //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
                      DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3) + GetValueByName(0, 'ARCHIVO_TE', 0) + '.xml';
                      SIH.GET(NoDocumento);

                      wVieneDePos := TRUE;
                      wTienda := SIH.Tienda;
                      wClavePos := SIH.Clave;
                      wConsecutivoPos := SIH.Consecutivo;

                      //CreaXmlTiquete_vCentral(NoDocumento,DirectorioTemp);
                      CreaXmlTiquete_vCentralV4_4(NoDocumento, DirectorioTemp); //013+-

                      xmlFactura := xmlFactura.XmlDocument();
                      xmlFactura.Load(DirectorioTemp);

                      //Pendiente
                      LogFacturaElectronica(3, SIH."No.", CURRENTDATETIME, SIH.Clave, SIH.Consecutivo, SIH.Estado, SIH.Mensaje, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3), '', SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_TE', 0), 1);
                      //Pendiente


                      iProcesa := iProcesa.Procesa();


                      iProcesa.EnviaFactura(xmlFactura, ConfSant."Es Prueba",
                              GetValueByName(0, 'CERTIFICADO', 0),
                              GetValueByName(0, 'CERTIFICADO_PIN', 0),
                              GetValueByName(0, 'API', 0),
                              GetValueByName(0, 'PASS', 0),
                              GetValueByNameWithType(0, 'DIRECTORIOTEMP', 3),
                              GetValueByName(0, 'ARCHIVO_TE', 0));
                      SLEEP(10000);
                      iProcesa.ConsultaComprobante(iProcesa.txtClave,
                                     ConfSant."Es Prueba",
                                     GetValueByName(0, 'API', 0),
                                     GetValueByName(0, 'PASS', 0),
                                     GetValueByNameWithType(0, 'DIRECTORIOTEMP', 3),
                                     GetValueByName(0, 'ARCHIVO_TE', 0));

                      SIH.Consecutivo := iProcesa.txtConsecutivo;
                      SIH.Clave := iProcesa.txtClave;
                      SIH.Estado := iProcesa.estadoFactura;
                      SIH.Mensaje := iProcesa.mensajeRespuesta;
                      SIH."Fecha Doc Electronico" := CURRENTDATETIME;

                      //MIGRACION COSTA RICA - YFC
                      /*
                      //+#217374
                      //... Incorporar
                      //QR Code
                      QRCodeInput    :='https://www.google.com.do/';
                      CreateQRCode(QRCodeInput,TempBlob);
                      SIH."QR Code FE" := TempBlob.Blob;
                      //QR Code
                      //-#217374
                      */
                      /*ConfigEmpresa.GET; // YFC
                      ConfigEmpresa.CALCFIELDS("QR Code FE"); // YFC
                      SIH."QR Code FE" := ConfigEmpresa."QR Code FE"; // YFC*/
                      //011+
                      CreaQRFE(SIH."No.");
                      //011-
                      SIH.MODIFY;

                      SIH.RESET;
                      SIH.SETRANGE("No.", SIH."No.");
                      IF SIH.FINDFIRST THEN BEGIN
            ReportFE.SETTABLEVIEW(SIH);
                      ReportFE.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3) + 'TE-' + iProcesa.txtClave + '.pdf');
        END;

        LogFacturaElectronica(3, SIH."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta, GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 3), '',
        SIH."Sell-to Customer Name", GetValueByName(0, 'ARCHIVO_TE', 0), 2);

        wVieneDePos := FALSE;
        wTienda := '';
        wClavePos := SIH.Clave;
        wConsecutivoPos := SIH.Consecutivo;

    end;

    procedure CreaXmlTiquete_vCentral(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      lString: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      lrSIH: Record 112;
                      lrSIL: Record 113;
                      lrCust: Record 18;
                      lTotalDescuento: Decimal;
                      lTotalVenta: Decimal;
                      lContarLineas: Integer;
                      lTotalMuestra: Decimal;
                      lClave: Text[60];
                      lPrecioUnidad: Decimal;
                      lAmount: Decimal;
                      lImporteDescuento: Decimal;
                      lTotalImpuesto: Decimal;
                      lMontoImpuesto: Decimal;
                      lTotalExento: Decimal;
                      lTotalGravado: Decimal;
                      View_SalesInvoiceLine: Query "50000;
                      ContarLineas: Integer;
                      TotalMuestra: Integer;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
    begin
        //+#217374

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('TiqueteElectronico');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/tiqueteElectronico');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');

        IF lrSIH.GET(NoDocumento) THEN
            lrSIH.CALCFIELDS(Amount, "Amount Including VAT");

        lrCust.GET(lrSIH."Bill-to Customer No.");
        // nivel 1

        IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
            lClave := wClavePos;
            Consecutivo := wConsecutivoPos;
        END
        ELSE
            lClave := GetClave(lrSIH."Posting Date", Consecutivo, '04');

        XmlDomMgnt.AddElement(XmlNode, 'Clave', lClave, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', '513710', '', XmlNode1); // YFC
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(lrSIH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);

        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', GetValueByRelation(5, lrSIH."Payment Terms Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, lrSIH."Payment Method Code", 0), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        CategoriaPedidoVenta.GET(lrSIH."Categoria Pedido Venta"); //008-YFC
        //LINEAS
        lrSIL.RESET;
        lrSIL.SETRANGE("Document No.", lrSIH."No.");
        lrSIL.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            lrSIL.SETRANGE(Compartir, lrSIL.Compartir::" ");
        IF lrSIL.FINDSET THEN
            REPEAT
                lContarLineas += 1; // para Enumerar Las Lineas
                IF (lrSIH."Tipo de Venta" = lrSIH."Tipo de Venta"::Muestras) AND (lrSIL.Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    lrSIL."Unit Price" := 0.01;
                    lrSIL.Amount := lrSIL."Unit Price" * lrSIL.Quantity;
                    lrSIL."Amount Including VAT" := lrSIL.Amount;
                    lTotalMuestra += lrSIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(lContarLineas), '', XmlNode3);

                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(lrSIL."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, lrSIL."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',lrSIL."No.",'',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', lrSIL."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(lrSIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF lrSIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, lrSIL."Unit of Measure Code", 0), '', XmlNode3);

                //RRT
                lImporteDescuento := lrSIL."Line Discount Amount";
                IF lrSIH."Prices Including VAT" THEN
                    IF lrSIL."VAT %" > 0 THEN
                        lImporteDescuento := ROUND(lrSIL.Amount * (lrSIL."Line Discount %" / 100));

                lAmount := lrSIL.Amount + lImporteDescuento;

                lPrecioUnidad := lrSIL."Unit Price";
                IF lrSIH."Prices Including VAT" THEN
                    IF lrSIL.Quantity > 0 THEN
                        lPrecioUnidad := lAmount / lrSIL.Quantity;
                //...

                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', lrSIL.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(lPrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(lAmount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(lImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF lrSIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(lrSIL.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(lrSIL.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                lMontoImpuesto := 0;
                IF lrSIL.Amount <> lrSIL."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(lrSIL."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(lrSIL."VAT %"), '', XmlNode4);  //YFC
                    lMontoImpuesto := lrSIL."Amount Including VAT" - lrSIL.Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(lMontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(lrSIL."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC

                //Sumar
                lTotalDescuento += lImporteDescuento;
                lTotalVenta += lAmount;
                lTotalImpuesto += lMontoImpuesto;

                IF lrSIL."VAT %" = 0 THEN
                    lTotalExento += lAmount
                ELSE
                    lTotalGravado += lAmount;

            UNTIL lrSIL.NEXT <= 0;

        //CreaXmlTiquete_vCentral2(lrSIH."No.");

        //*********************************************************
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
            View_SalesInvoiceLine.SETRANGE(Document_No, lrSIH."No.");
            View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesInvoiceLine.SETFILTER(Compartir, '<>%1', View_SalesInvoiceLine.Compartir::" ");
            View_SalesInvoiceLine.OPEN;
            //lrSIL.SETFILTER(Amount,'<>0');
            //IF lrSIL.FINDSET THEN
            WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (lrSIH."Tipo de Venta" = lrSIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    lrSIL."Unit Price" := 0.01;
                    lrSIL.Amount := View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity;
                    lrSIL."Amount Including VAT" := View_SalesInvoiceLine.Sum_Amount;
                    TotalMuestra += View_SalesInvoiceLine.Sum_Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // ++ 003-YFC
                /*CLEAR(Item2);
                IF  Item2.GET(SIL."No.") THEN;
                IF Item2.CABYS <> '' THEN
                  XmlDomMgnt.AddElement(XmlNode2,'Codigo',Item2.CABYS,'',XmlNode3)
                ELSE
                  ERROR(Error01,SIL."No.");*/
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',lrSIL."No.",'',XmlNode3);
                // -- 003-YFC
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Libro CABYS", '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Aulas CABYS", '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Servicio CABYS", '', XmlNode3);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //RRT
                ImporteDescuento := View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                IF lrSIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        ImporteDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));

                Amount := View_SalesInvoiceLine.Sum_Amount + ImporteDescuento;

                PrecioUnidad := lrSIL."Unit Price";
                IF lrSIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_Quantity > 0 THEN
                        PrecioUnidad := Amount / View_SalesInvoiceLine.Sum_Quantity;

                //...

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(Amount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(ImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF lrSIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                MontoImpuesto := 0;
                IF View_SalesInvoiceLine.Sum_Amount <> View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(lrSIL."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(View_SalesInvoiceLine.Sum_VAT), '', XmlNode4);  //YFC
                    MontoImpuesto := View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC

                //      //Sumar
                //      lTotalDescuento +=  ImporteDescuento;
                //      lTotalVenta     +=  Amount;
                //      lTotalImpuesto  +=  MontoImpuesto;
                //
                //      IF View_SalesInvoiceLine.Sum_VAT = 0 THEN
                //        lTotalExento += lAmount
                //      ELSE
                //        lTotalGravado += lAmount;

                //UNTIL lrSIL.NEXT <=0 ;
            END;

            View_SalesInvoiceLine.CLOSE;
        END; //008-YFC
             //*********************************************************

        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);    // YFC

        IF lrSIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', lrSIH."Currency Code", '', XmlNode3);

        IF lrSIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(lrSIH."Amount Including VAT" / lrSIH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(lTotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(lTotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(lTotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(lTotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(lTotalGravado + lTotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(lTotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(lTotalGravado + lTotalExento - lTotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(lTotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); //YFC

        IF lrSIH."Tipo de Venta" = lrSIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(lTotalVenta - lTotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(lrSIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure TiqueteElectronicoNCR_vCentral(NoDocumento: Code[20])
    var
        lrSCMH: Record 114;
        lrSIH: Record 112;
        lModif: Boolean;
    begin
        //+#217374
        lrSCMH.GET(NoDocumento);

        wVieneDePos := TRUE;
        wTienda := lrSCMH.Tienda;
        wClavePos := lrSCMH.Clave;
        wConsecutivoPos := lrSCMH.Consecutivo;
        NotaCreditoElectronica(NoDocumento);
        wVieneDePos := FALSE;
        wTienda := '';
        wClavePos := '';
        wConsecutivoPos := '';
    end;

    procedure Formatea(pValor: Code[5]; pLongitud: Integer): Code[5]
    var
        lResult: Code[5];
        lLongValor: Integer;
        lConta: Integer;
    begin
        //+#217374
        lResult := pValor;
        lLongValor := STRLEN(pValor);
        FOR lConta := lLongValor + 1 TO pLongitud DO
            lResult := '0' + lResult;

        EXIT(lResult);
    end;

    procedure Parametros(pVieneDePos: Boolean; pTienda: Code[20])
    begin
        //+#217374
        wVieneDePos := pVieneDePos;
        wTienda := pTienda;
    end;

    procedure CreaXmlNotaCreditoPos(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      CMH: Record 114;
                      CML: Record 115;
                      Cust: Record 18;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      SIH: Record 112;
                      NumeroLinea: Integer;
                      lClave: Text;
                      lImporteDescuento: Decimal;
                      lPrecioUnidad: Decimal;
                      lAmount: Decimal;
                      View_SalesCRMLine: Query "50001;
                      ContarLineas: Integer;
    begin

        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');

        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('NotaCreditoElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xs','http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        //XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/notaCreditoElectronica');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/notaCreditoElectronica');

        CMH.GET(NoDocumento);
        CMH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(CMH."Bill-to Customer No.");
        // nivel 1

        //+#217374
        //... La clave y el consecutivo puede ser que vengan asignados desde DS-POS.
        //XmlDomMgnt.AddElement(XmlNode,'Clave',GetClave(CMH."Posting Date",Consecutivo,'03'),'',XmlNode1);
        IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
            lClave := wClavePos;
            Consecutivo := wConsecutivoPos;
        END
        ELSE
            lClave := GetClave(CMH."Posting Date", Consecutivo, '03');

        XmlDomMgnt.AddElement(XmlNode, 'Clave', lClave, '', XmlNode1);
        //-#217374

        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividad', '513710', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(CMH."Posting Date", TIME), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        // nivel 2
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        //nivel 3
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Barrio', GetValueByName(0, 'BARRIO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', CMH."Bill-to Name", '', XmlNode2);

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', Cust."VAT Registration No.", '', XmlNode2)
        ELSE BEGIN
            // --009-YFC
            IF (Cust."VAT Registration No." <> '.') AND (Cust."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', Cust."VAT Registration No.", '', XmlNode3);
            END;
        END; //009-YFC

        IF Cust."E-Mail" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', GetValueByRelation(5, CMH."Payment Terms Code", 0), '', XmlNode1);

        IF CMH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, 'EFECTIVO', 0), '', XmlNode1)
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'MedioPago', GetValueByRelation(4, CMH."Payment Method Code", 0), '', XmlNode1);

        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        CategoriaPedidoVenta.GET(CMH."Categoria Pedido Venta"); //008-YFC
        //LINEAS
        CML.RESET;
        CML.SETRANGE("Document No.", CMH."No.");

        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            CML.SETRANGE(Compartir, CML.Compartir::" ");
        CML.SETFILTER(Quantity, '<>0');
        //CML.SETFILTER(Amount,'<>0');
        IF CML.FINDSET THEN
            REPEAT

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);

                NumeroLinea += 1;
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(NumeroLinea), '', XmlNode3);

                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(CML."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, CML."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',CML."No.",'',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', CML."No.", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(CML.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF CML.Type = CML.Type::Item THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, CML."Unit of Measure Code", 0), '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'Otros', '', XmlNode3);

                //RRT
                lImporteDescuento := CML."Line Discount Amount";
                IF CMH."Prices Including VAT" THEN
                    IF CML."VAT %" > 0 THEN
                        lImporteDescuento := ROUND(CML.Amount * (CML."Line Discount %" / 100));

                lAmount := CML.Amount + lImporteDescuento;

                lPrecioUnidad := CML."Unit Price";
                IF CMH."Prices Including VAT" THEN
                    IF CML.Quantity > 0 THEN
                        lPrecioUnidad := lAmount / CML.Quantity;
                //...


                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', CML.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(lPrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(lAmount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                //---
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(lImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF lImporteDescuento > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(CML.Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                //RRT
                MontoImpuesto := 0;
                //RRT

                IF CML.Amount <> CML."Amount Including VAT" THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);
                    IF VATProdPostGroup.GET(CML."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(CML."VAT %"), '', XmlNode4);
                    MontoImpuesto := (CML."Amount Including VAT" - CML.Amount); // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(CML."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                //Sumar
                TotalDescuento += lImporteDescuento;
                TotalImpuesto += MontoImpuesto;

                IF CML."VAT %" = 0 THEN
                    TotalExento += lAmount
                ELSE
                    TotalGravado += lAmount;


            UNTIL CML.NEXT <= 0;



        //*********************************************************
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesCRMLine);
            View_SalesCRMLine.SETRANGE(Document_No, CMH."No.");
            View_SalesCRMLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesCRMLine.SETFILTER(Compartir, '<>%1', View_SalesCRMLine.Compartir::" ");
            View_SalesCRMLine.OPEN;
            //lrSIL.SETFILTER(Amount,'<>0');
            //IF lrSIL.FINDSET THEN
            WHILE View_SalesCRMLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);


                NumeroLinea += 1;
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(NumeroLinea), '', XmlNode3);

                // XmlDomMgnt.AddElement(XmlNode2,'NumeroLinea',FORMAT(CML."Line No."/10000),'',XmlNode3);

                // ++ 003-YFC
                /*IF CML.Type = CML.Type::Item THEN
                  BEGIN
                    CLEAR(Item2);
                    Item2.GET(CML."No.");
                    IF Item2.CABYS <> '' THEN
                      XmlDomMgnt.AddElement(XmlNode2,'Codigo',Item2.CABYS,'',XmlNode3)
                    ELSE
                      ERROR(Error01,CML."No.");
                 END
                 ELSE
                   XmlDomMgnt.AddElement(XmlNode2,'Codigo','','',XmlNode3);*/

                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Libro CABYS", '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Aulas CABYS", '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Codigo', ConfSant."Codigo Servicio CABYS", '', XmlNode3);
                        END;
                END;
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);

                //   IF CML.Type = CML.Type::Item THEN
                //   XmlDomMgnt.AddElement(XmlNode3,'Tipo','01','',XmlNode4)
                //   ELSE
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);

                //XmlDomMgnt.AddElement(XmlNode3,'Codigo',CML."No.",'',XmlNode4);
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesCRMLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF CML.Type = CML.Type::Item THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesCRMLine.Unit_of_Measure_Code, 0), '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'Otros', '', XmlNode3);

                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',CML.Description,'',XmlNode3);
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(View_SalesCRMLine.Sum_Unit_Price, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                //---
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(View_SalesCRMLine.Sum_Line_Discount_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF CML."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                //XmlDomMgnt.AddElement(XmlNode2,'MontoDescuento',FORMAT(CML."Line Discount Amount",0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3);
                // XmlDomMgnt.AddElement(XmlNode2,'NaturalezaDescuento','Descuento al cliente','',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(View_SalesCRMLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                IF View_SalesCRMLine.Sum_Amount <> View_SalesCRMLine.Sum_Amount_Including_VAT THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);
                    IF VATProdPostGroup.GET(CML."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(View_SalesCRMLine.Sum_VAT), '', XmlNode4);
                    MontoImpuesto := (View_SalesCRMLine.Sum_Amount_Including_VAT - View_SalesCRMLine.Sum_Amount); // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesCRMLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //Sumar
                TotalDescuento += View_SalesCRMLine.Sum_Line_Discount_Amount;
                TotalVenta += View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity;
                TotalImpuesto += MontoImpuesto;

                IF View_SalesCRMLine.Sum_VAT = 0 THEN
                    TotalExento += View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity
                ELSE
                    TotalGravado += View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity;


                //      //Sumar
                //      lTotalDescuento +=  ImporteDescuento;
                //      lTotalVenta     +=  Amount;
                //      lTotalImpuesto  +=  MontoImpuesto;
                //
                //      IF View_SalesInvoiceLine.Sum_VAT = 0 THEN
                //        lTotalExento += lAmount
                //      ELSE
                //        lTotalGravado += lAmount;

                //UNTIL lrSIL.NEXT <=0 ;
            END;

            View_SalesCRMLine.CLOSE;
        END; //008-YFC
             //*********************************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);
        //--
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);    // YFC

        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', CMH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(CMH."Amount Including VAT" / CMH."Currency Factor", 9, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', '0.00000', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        TotalVentaNeta := (TotalGravado + TotalExento) - TotalDescuento;
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT(TotalGravado + TotalExento - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2); //YFC
        XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(CMH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);


        //Informacion Referencia
        SIH.GET(CMH."No. Doc Historico");

        XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
        // TESTFIELD(CMH."Tipo Doc. Ref NC"); //001
        CASE CMH."Tipo Doc. Ref NC" OF
            CMH."Tipo Doc. Ref NC"::"Factura Electronica":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '01', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Tiquete Electronico":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '04', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Sustituye Factura de Exportacion":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDoc', '12', '', XmlNode2);
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH.Consecutivo, '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmision', FORMAT(SIH."Fecha Doc Electronico", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'), '', XmlNode2);
        CASE CMH."Codigo Referencia" OF
            CMH."Codigo Referencia"::"Devolucion Total":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula Documento de Referencia', '', XmlNode2);
                END;
            CMH."Codigo Referencia"::"Devolucion Parcial":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '02', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye comprobante', '', XmlNode2);
                END;
        END;


        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure CreaXmlTiquete_vCentral2(DocNum: Code[20])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      lString: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      lrSIH: Record 112;
                      lrSIL: Record 113;
                      lrCust: Record 18;
                      lTotalDescuento: Decimal;
                      lTotalVenta: Decimal;
                      lContarLineas: Integer;
                      lTotalMuestra: Decimal;
                      lClave: Text[60];
                      lPrecioUnidad: Decimal;
                      lAmount: Decimal;
                      lImporteDescuento: Decimal;
                      lTotalImpuesto: Decimal;
                      lMontoImpuesto: Decimal;
                      lTotalExento: Decimal;
                      lTotalGravado: Decimal;
                      View_SalesInvoiceLine: Query "50000;
    begin
        //+#217374
        /*
        ConfSant.GET;
        
        XmlDoc := XmlDoc.XmlDocument;
        
        xmlProcessingInst:= XmlDoc.CreateProcessingInstruction('xml','version="1.0" encoding="UTF-8"');
        
                    XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
                    XmlNode := XmlDoc.CreateElement('TiqueteElectronico');
                    XmlNode := XmlDoc.AppendChild(XmlNode);
        
        XmlDomMgnt.AddAttribute(XmlNode,'xmlns','https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.3/tiqueteElectronico');
        XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
        XmlDomMgnt.AddAttribute(XmlNode,'xmlns:xsd','http://www.w3.org/2001/XMLSchema');
        
        IF lrSIH.GET(NoDocumento) THEN
          lrSIH.CALCFIELDS(Amount,"Amount Including VAT");
        
        lrCust.GET(lrSIH."Bill-to Customer No.");
        // nivel 1
        
        IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
          lClave := wClavePos;
          Consecutivo := wConsecutivoPos;
        END
        ELSE
          lClave  := GetClave(lrSIH."Posting Date",Consecutivo,'04');
        
        XmlDomMgnt.AddElement(XmlNode,'Clave',lClave,'',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'CodigoActividad','513710','',XmlNode1); // YFC
        XmlDomMgnt.AddElement(XmlNode,'NumeroConsecutivo',Consecutivo,'',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'FechaEmision',FormatDateTime(lrSIH."Posting Date",TIME),'',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'Emisor','','',XmlNode1);
        
          // nivel 2
          XmlDomMgnt.AddElement(XmlNode1,'Nombre',GetValueByName(0,'EMISOR_NOMBRE',0),'',XmlNode2);
          XmlDomMgnt.AddElement(XmlNode1,'Identificacion','','',XmlNode2);
           //nivel 3
            XmlDomMgnt.AddElement(XmlNode2,'Tipo',GetValueByName(0,'EMISOR_TIPO',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'Numero',GetValueByName(0,'EMISOR_NUMERO',0),'',XmlNode3);
        
          XmlDomMgnt.AddElement(XmlNode1,'Ubicacion','','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2,'Provincia',GetValueByName(0,'PROVINCIA',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'Canton',GetValueByName(0,'CANTON',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'Distrito',GetValueByName(0,'DISTRITO',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'Barrio',GetValueByName(0,'BARRIO',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'OtrasSenas',GetValueByName(0,'OTRASSENAS',0),'',XmlNode3);
        
          XmlDomMgnt.AddElement(XmlNode1,'Telefono','','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2,'CodigoPais',GetValueByName(0,'PAIS',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'NumTelefono',GetValueByName(0,'EMISOR_TELEFONO',0),'',XmlNode3);
        
          XmlDomMgnt.AddElement(XmlNode1,'CorreoElectronico',GetValueByName(0,'EMISOR_CORREO',0),'',XmlNode2);
        
        XmlDomMgnt.AddElement(XmlNode,'CondicionVenta','01','',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'PlazoCredito',GetValueByRelation(5,lrSIH."Payment Terms Code",0),'',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'MedioPago',GetValueByRelation(4,lrSIH."Payment Method Code",0),'',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode,'DetalleServicio','','',XmlNode1);
        
        
        //LINEAS
        lrSIL.RESET;
        lrSIL.SETRANGE("Document No.",lrSIH."No.");
        lrSIL.SETFILTER(Quantity,'<>0');
        
        */

        IF lrSIH.GET(DocNum) THEN
            lrSIH.CALCFIELDS(Amount, "Amount Including VAT");

                      CategoriaPedidoVenta.GET(lrSIH."Categoria Pedido Venta"); //008-YFC

                      IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
                      View_SalesInvoiceLine.SETRANGE(Document_No, DocNum);
                      View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
                      View_SalesInvoiceLine.OPEN;
                      //lrSIL.SETFILTER(Amount,'<>0');
                      //IF lrSIL.FINDSET THEN
                      WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                lContarLineas += 1; // para Enumerar Las Lineas
                      IF (lrSIH."Tipo de Venta" = lrSIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    lrSIL."Unit Price" := 0.01;
                      lrSIL.Amount := View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity;
                      lrSIL."Amount Including VAT" := View_SalesInvoiceLine.Sum_Amount;
                      lTotalMuestra += View_SalesInvoiceLine.Sum_Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(lContarLineas), '', XmlNode3);

                // ++ 003-YFC
                CLEAR(Item2);
                Item2.GET(lrSIL."No.");
                IF Item2.CABYS <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Codigo', Item2.CABYS, '', XmlNode3)
                ELSE
                    ERROR(Error01, lrSIL."No.");
                // XmlDomMgnt.AddElement(XmlNode2,'Codigo',lrSIL."No.",'',XmlNode3);
                // -- 003-YFC

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //RRT
                lImporteDescuento := View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                IF lrSIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        lImporteDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));

                lAmount := View_SalesInvoiceLine.Sum_Amount + lImporteDescuento;

                lPrecioUnidad := lrSIL."Unit Price";
                IF lrSIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_Quantity > 0 THEN
                        lPrecioUnidad := lAmount / View_SalesInvoiceLine.Sum_Quantity; //008-YFC
                                                                                       //PrecioUnidad := (View_SalesInvoiceLine.Sum_Amount +View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity; //008-YFC
                                                                                       //...

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(lPrecioUnidad, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(lAmount, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(lImporteDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                IF lrSIL."Line Discount Amount" > 0 THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Descuento al cliente', '', XmlNode4)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', 'Sin Descuento', '', XmlNode4);

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(View_SalesInvoiceLine.Sum_Amount, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                lMontoImpuesto := 0;
                IF View_SalesInvoiceLine.Sum_Amount <> View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Codigo', '01', '', XmlNode4);  //YFC
                    IF VATProdPostGroup.GET(lrSIL."VAT Prod. Posting Group") THEN;
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifa', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(View_SalesInvoiceLine.Sum_VAT), '', XmlNode4);  //YFC
                    lMontoImpuesto := View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount; // YFC
                    XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(lMontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);   //YFC
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC

                //Sumar
                lTotalDescuento += lImporteDescuento;
                lTotalVenta += lAmount;
                lTotalImpuesto += lMontoImpuesto;

                IF View_SalesInvoiceLine.Sum_VAT = 0 THEN
                    lTotalExento += lAmount
                ELSE
                    lTotalGravado += lAmount;

                //UNTIL lrSIL.NEXT <=0 ;
            END;

            View_SalesInvoiceLine.CLOSE;
        END; //008-YFC

        /*XmlDomMgnt.AddElement(XmlNode,'ResumenFactura','','',XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1,'CodigoTipoMoneda','','',XmlNode2);    // YFC
        
        IF lrSIH."Currency Code" = '' THEN
          XmlDomMgnt.AddElement(XmlNode2,'CodigoMoneda','CRC','',XmlNode3)
        ELSE
          XmlDomMgnt.AddElement(XmlNode2,'CodigoMoneda',lrSIH."Currency Code" ,'',XmlNode3);
        
        IF lrSIH."Currency Factor" <>0 THEN
          XmlDomMgnt.AddElement(XmlNode2,'TipoCambio',FORMAT(lrSIH."Amount Including VAT"/ lrSIH."Currency Factor",9,'<Precision,5:5><Standard Format,9>'),'',XmlNode3)
        ELSE
          XmlDomMgnt.AddElement(XmlNode2,'TipoCambio','1.00000','',XmlNode3);
        
        XmlDomMgnt.AddElement(XmlNode1,'TotalServGravados','0.00000','',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1,'TotalServExentos','0.00000','',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas',FORMAT(lTotalGravado,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasExentas',FORMAT(lTotalExento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1,'TotalGravado',FORMAT(lTotalGravado,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1,'TotalExento',FORMAT(lTotalExento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);   // YFC
        XmlDomMgnt.AddElement(XmlNode1,'TotalVenta',FORMAT(lTotalGravado+lTotalExento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); // YFC
        XmlDomMgnt.AddElement(XmlNode1,'TotalDescuentos',FORMAT(lTotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1,'TotalVentaNeta',FORMAT(lTotalGravado+lTotalExento-lTotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        
        XmlDomMgnt.AddElement(XmlNode1,'TotalImpuesto',FORMAT(lTotalImpuesto,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2); //YFC
        
        IF lrSIH."Tipo de Venta" = lrSIH."Tipo de Venta"::Muestras THEN
          XmlDomMgnt.AddElement(XmlNode1,'TotalComprobante',FORMAT(lTotalVenta-lTotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2)
        ELSE
          XmlDomMgnt.AddElement(XmlNode1,'TotalComprobante',FORMAT(lrSIH."Amount Including VAT",0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        
        IF  XmlDoc.HasChildNodes  THEN
          XmlDoc.Save(DirectorioTemp);
          */

    end;

    local procedure ValidaCorreoElect(Correo: Text[120]; NoDocumento: Text[20])
    var
        PosArroba: Integer;
        PosUltimoPunto: Integer;
        i: Integer;
        Caracter: Char;
        CaracteresPermitidos2: Text;
        ParteLocal: Text;
        ParteDominio: Text;
        CaracteresPermitidos: Label 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-+';
        Error001: Label '<%1: El campo correo electrónico no puede estar vacío>';
        Error002: Label '%1: El correo no puede exceder los 250 caracteres';
        Error003: Label '%1: El correo electrónico debe contener el símbolo @';
        Error004: Label '%1: Solo se permite un símbolo @ en el correo electrónico';
        Error005: Label '%1: La parte antes del @ no puede estar vacía';
        Error006: Label '%1: El correo no puede comenzar con el carácter "%2';
        Error007: Label '%1: El correo no puede terminar con el carácter "%2';
        Error008: Label '%1: Carácter no permitido "%2" en la parte local del correo';
        Error009: Label '%1: No se permiten puntos consecutivos en el correo';
        Error010: Label '%1: La parte después del @ no puede estar vacía';
        Error011: Label '%1: El dominio debe contener al menos un punto (.)';
        Error012: Label '%1: El dominio no puede comenzar con "%2"';
        Error013: Label '<%1: El dominio no puede terminar con "%2">';
        Error014: Label '<%1: El dominio es demasiado corto>';
        Error015: Label '<%1: La extensión del dominio debe tener al menos 2 caracteres (ej: .com, .net)>';
        CaracteresPermitidosLocal: Text[1024];
        CaracteresPermitidosDominio: Text[1024];
    begin
        // Inicializar caracteres permitidos
        //CaracteresPermitidos := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-+';

        // Verificar si el correo está vacío
        IF Correo = '' THEN
            ERROR(Error001, NoDocumento);

        // Validar longitud máxima
        IF STRLEN(Correo) > 250 THEN
            ERROR(Error002, NoDocumento);

        // Buscar la posición del símbolo @
        PosArroba := STRPOS(Correo, '@');

        // Validar que haya exactamente una @
        IF PosArroba = 0 THEN
            ERROR(Error003, NoDocumento);

        IF STRPOS(COPYSTR(Correo, PosArroba + 1), '@') > 0 THEN
            ERROR(Error004, NoDocumento);

        // Separar parte local y dominio
        ParteLocal := COPYSTR(Correo, 1, PosArroba - 1);
        ParteDominio := COPYSTR(Correo, PosArroba + 1);

        // Validar parte local
        IF ParteLocal = '' THEN
            ERROR(Error005, NoDocumento);

        // Validar que el primer carácter no sea especial
        IF ParteLocal[1] IN ['.', '-', '_', '+'] THEN
            ERROR(Error006, NoDocumento, ParteLocal[1]);

        // Validar que el último carácter no sea especial
        IF ParteLocal[STRLEN(ParteLocal)] IN ['.', '-', '_', '+'] THEN
            ERROR(Error007, NoDocumento, ParteLocal[STRLEN(ParteLocal)]);

        // Validar caracteres en la parte local
        FOR i := 1 TO STRLEN(ParteLocal) DO BEGIN
            Caracter := ParteLocal[i];
            IF STRPOS(CaracteresPermitidos, FORMAT(Caracter)) = 0 THEN
                ERROR(Error008, NoDocumento, Caracter);

            // Validar puntos consecutivos
            /*IF (i > 1) AND (ParteLocal[i] = '.') AND (ParteLocal[i-1] = '.') THEN
                ERROR('Documento %1: No se permiten puntos consecutivos en el correo', NoDocumento);*/
        END;

        // Validar dominio
        IF ParteDominio = '' THEN
            ERROR(Error010, NoDocumento);

        PosUltimoPunto := STRPOS(ParteDominio, '.');

        // Validar que haya al menos un punto en el dominio
        IF PosUltimoPunto = 0 THEN
            ERROR(Error011, NoDocumento);

        // Validar que el dominio no empiece con punto o guión
        IF ParteDominio[1] IN ['.', '-'] THEN
            ERROR(Error012, NoDocumento, ParteDominio[1]);

        // Validar que el dominio no termine con punto o guión
        IF ParteDominio[STRLEN(ParteDominio)] IN ['.', '-'] THEN
            ERROR(Error013, NoDocumento, ParteDominio[STRLEN(ParteDominio)]);

        // Validar longitud mínima del dominio
        IF STRLEN(ParteDominio) < 3 THEN
            ERROR(Error014, NoDocumento);

        // Validar extensión del dominio (última parte después del punto)
        IF STRLEN(COPYSTR(ParteDominio, PosUltimoPunto + 1)) < 2 THEN
            ERROR(Error015, NoDocumento);

    end;

    local procedure CreateQrCodeFe()
    var
        QRCodeInput: Text;
        TempBlob: Record 99008535;
        SalesInvoiceHeader: Record 112;
    begin

        //IF SalesInvoiceHeader.GET('VFR-091749') THEN;
        //QR Code
        QRCodeInput := SalesInvoiceHeader."No.";
        CreateQRCode(QRCodeInput, TempBlob);
        SalesInvoiceHeader."QR Code FE" := TempBlob.Blob;
        //QR Code
        SalesInvoiceHeader.MODIFY;
    end;

    procedure CreaXmlTiquete_vCentralV4_4(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      SIH: Record 112;
                      SIL: Record 113;
                      Cust: Record 18;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      ImpLinEmisorFabrica: Decimal;
                      lClave: Text[60];
                      lPrecioUnidad: Decimal;
                      lAmount: Decimal;
                      lImporteDescuento: Decimal;
                      lTotalImpuesto: Decimal;
                      lMontoImpuesto: Decimal;
                      lTotalExento: Decimal;
                      lTotalGravado: Decimal;
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
    begin
        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('TiqueteElectronico');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        // Add required namespaces
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/tiqueteElectronico');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");

        IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
            lClave := wClavePos;
            Consecutivo := wConsecutivoPos;
        END ELSE
            lClave := GetClave(SIH."Posting Date", Consecutivo, '04');

        // Level 1 - Document Identification
        XmlDomMgnt.AddElement(XmlNode, 'Clave', lClave/*GetClave(SIH."Posting Date",Consecutivo,'04')*/, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', '221101'/*GetValueByName(0,'PROVEEDORSISTEMAS',0)*/, '', XmlNode1); // Campo obligatorio según versión 4.4
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1); // Campo obligatorio
        //XmlDomMgnt.AddElement(XmlNode,'CodigoActividadReceptor','513710','',XmlNode1); (4=Inexistente según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);

        // Emitter Information
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        //XmlDomMgnt.AddElement(XmlNode1,'NombreComercial','No cuenta con Nombre','',XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio',GetValueByName(0,'BARRIO',0),'',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        /*// Receiver Information
        XmlDomMgnt.AddElement(XmlNode,'Receptor','','',XmlNode1);
          XmlDomMgnt.AddElement(XmlNode1,'Nombre',SIH."Bill-to Name",'',XmlNode2);
        
          // Identificación del receptor según versión 4.4
          IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode1,'Identificacion','','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2,'Tipo',GetValueByName(2,FORMAT(Cust."Tax Identification Type"),0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'Numero',SIH."VAT Registration No.",'',XmlNode3);
          END;
        
          XmlDomMgnt.AddElement(XmlNode1,'NombreComercial',Cust."Name 2",'',XmlNode2); // Campo opcional
        
          XmlDomMgnt.AddElement(XmlNode1,'Telefono','','',XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2,'CodigoPais',GetValueByName(0,'PAIS',0),'',XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2,'NumTelefono',GetValueByName(0,'EMISOR_TELEFONO',0),'',XmlNode3);
        
          IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1,'CorreoElectronico',SIH."E-Mail-FE",'',XmlNode2)
          ELSE
            XmlDomMgnt.AddElement(XmlNode1,'CorreoElectronico',Cust."E-Mail",'',XmlNode2);
        */

        IF SIH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(SIH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        // Process lines
        CategoriaPedidoVenta.GET(SIH."Categoria Pedido Venta"); //008-YFC

        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            SIL.SETRANGE(Compartir, SIL.Compartir::" ");
        IF SIL.FINDSET THEN BEGIN
            REPEAT
                ContarLineas += 1;

                // Handle samples with zero amount
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(Item2);
                IF Item2.GET(SIL."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN
                        ERROR(Error01, SIL."No.");
                    XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', Item2.CABYS, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                END ELSE
                    ERROR(Error01, SIL."No.");

                // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF SIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := SIL."Unit Price";
                MontoTotal := ROUND(SIL."Unit Price" * SIL.Quantity);
                MontoDescuento := ROUND(SIL."Line Discount Amount");
                SubTotal := ROUND(SIL.Amount);
                BaseImponible := ROUND(SIL.Amount);
                MontoImpuesto := ROUND(SIL."Amount Including VAT" - SIL.Amount);
                MontoTotalLinea := ROUND(SIL."Amount Including VAT");
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;

                // Obtener el registro del catálogo CABYS para el ítem actual//013+
                CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(Item2.CABYS) THEN BEGIN
                    CASE CatalogoCaByS."Tipo CABYS" OF
                        CatalogoCaByS."Tipo CABYS"::Servicio:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalServExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalServGravado += MontoTotal;
                            END;
                        CatalogoCaByS."Tipo CABYS"::Mercancía:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalMercExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalMercGravado += MontoTotal;
                            END;
                    END;
                END;
                // Obtener el registro del catálogo CABYS para el ítem actual//013-
                //Totales Factura+

                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);

                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF SIL."Line Discount Amount" > 0 THEN BEGIN
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); // Campo obligatorio según versión 4.4

                //MontoImpuesto:=0;
                // Impuestos (obligatorio según versión 4.4)XmlDomMgnt.AddElement(XmlNode3,'Codigo',ConfSant."Tipo Impuesto FE",'',XmlNode4);
                //IF SIL.Amount <> SIL."Amount Including VAT" THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN BEGIN
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); // Cambiado a CodigoTarifaIVA según versión 4.4
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00'/*FORMAT(MontoImpuesto,0,'<Precision,5:5><Standard Format,9>')*/, '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;
                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                //Para el desgloce del impusto+
                //IF lrSIL.Amount <> lrSIL."Amount Including VAT" THEN BEGIN
                // Obtener Codigo y CodigoTarifaIVA
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

            UNTIL SIL.NEXT = 0;
        END;

        //****************************************************************************++FACTURACION COMPARTIR++****************************************************************

        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
            View_SalesInvoiceLine.SETRANGE(Document_No, SIH."No.");
            View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesInvoiceLine.SETFILTER(Compartir, '<>%1', View_SalesInvoiceLine.Compartir::" ");
            View_SalesInvoiceLine.OPEN;
            WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := ROUND(View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity);
                    SIL."Amount Including VAT" := ROUND(View_SalesInvoiceLine.Sum_Amount);
                    TotalMuestra += ROUND(View_SalesInvoiceLine.Sum_Amount);
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Libro CABYS", '', XmlNode3);//013+-
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Aulas CABYS", '', XmlNode3);//013+-
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Servicio CABYS", '', XmlNode3);//013+-
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := ROUND((View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity); //008-YFC
                MontoTotal := ROUND(View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));
                SubTotal := ROUND(View_SalesInvoiceLine.Sum_Amount);
                BaseImponible := ROUND(View_SalesInvoiceLine.Sum_Amount);
                MontoImpuesto := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount);
                MontoTotalLinea := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT);
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;
                // Obtener el código CABYS según el tipo Compartir
                CatalogoCaByS.RESET;
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        CatalogoCaByS.GET(ConfSant."Codigo Libro CABYS");
                    View_SalesInvoiceLine.Compartir::Aulas:
                        CatalogoCaByS.GET(ConfSant."Codigo Aulas CABYS");
                    View_SalesInvoiceLine.Compartir::Servicios:
                        CatalogoCaByS.GET(ConfSant."Codigo Servicio CABYS");
                END;

                // Calcular monto total de la línea
                // Actualizar totales según tipo CABYS e impuesto
                CASE CatalogoCaByS."Tipo CABYS" OF
                    CatalogoCaByS."Tipo CABYS"::Servicio:
                        IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                            TotalServExento += MontoTotal
                        ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                            TotalServGravado += MontoTotal;
                    CatalogoCaByS."Tipo CABYS"::Mercancía:
                        IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                            TotalMercExento += MontoTotal
                        ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                            TotalMercGravado += MontoTotal;
                END;

                IF VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;
                IF View_SalesInvoiceLine.Sum_Amount = View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN
                    TotalExento += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount
                ELSE
                    TotalGravado += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                //Totales Factura-

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF MontoDescuento > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                //MontoImpuesto := 0;
                //IF View_SalesInvoiceLine.Sum_Amount <> View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);  //YFC
                IF VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;
                XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC//012+-CodigoTarifaIVA
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);  //YFC
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode3, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00'/*FORMAT(MontoImpuesto,0,'<Precision,5:5><Standard Format,9>')*/, '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END; //ELSE

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                //Para el desgloce del impusto+
                //IF lrSIL.Amount <> lrSIL."Amount Including VAT" THEN BEGIN
                // Obtener Codigo y CodigoTarifaIVA
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
            END;
            View_SalesInvoiceLine.CLOSE;
        END; //008-YFC


        //****************************************************************************--FACTURACION COMPARTIR--****************************************************************

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / SIH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        // Tax summary (obligatorio si hay impuestos según versión 4.4)

        //**************TotalDesgloseImpuesto Nodo+ //012+*********************

        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;

        //**************TotalDesgloseImpuesto Nodo+ //012-********************
        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        // Payment method (nodo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //*******************************INFORMACON DE REFERENCIA************************************ //OPCIONAL 4.4

        /*IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
          XmlDomMgnt.AddElement(XmlNode,'InformacionReferencia','','',XmlNode1);
        
          CASE SIH."Tipo Doc. Ref." OF
            SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
              XmlDomMgnt.AddElement(XmlNode1,'TipoDocIR','08','',XmlNode2); // Cambiado a TipoDocIR según versión 4.4
            SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
              XmlDomMgnt.AddElement(XmlNode1,'TipoDocIR','10','',XmlNode2); // Cambiado a TipoDocIR según versión 4.4
          END;
        
          XmlDomMgnt.AddElement(XmlNode1,'Numero',SIH."Numero Referencia FE",'',XmlNode2);
          XmlDomMgnt.AddElement(XmlNode1,'FechaEmisionIR',FormatDateTime(SIH."Posting Date",TIME),'',XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4
        
          CASE SIH."Tipo Doc. Ref." OF
            SIH."Tipo Doc. Ref."::"Comprobante por Contingencia": BEGIN
              XmlDomMgnt.AddElement(XmlNode1,'Codigo','05','',XmlNode2);
              XmlDomMgnt.AddElement(XmlNode1,'Razon','Sustituye Comprobante','',XmlNode2);
            END;
            SIH."Tipo Doc. Ref."::"Sustituye Comprobante": BEGIN
              XmlDomMgnt.AddElement(XmlNode1,'Codigo','01','',XmlNode2);
              XmlDomMgnt.AddElement(XmlNode1,'Razon','Anula documento de referencia','',XmlNode2);
            END;
          END;
        END;
        */
        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure CreaXmlFacturaV4_4(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      SIH: Record 112;
                      SIL: Record 113;
                      Cust: Record 18;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      RecTipoDescuentosDGT: Record 50025;
                      ImpLinEmisorFabrica: Decimal;
                      lrSIL: Record 113;
                      TempImpuestoBkp: Record 50027;
                      vCodigo: Code[2];
                      vCodigoTarifaIVA: Code[2];
                      Ceros: Code[10];
                      VatRegNo: Code[20];
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
                      PaymentTerms: Record 3;
                      CatParamFEDGT: Record 50030;
                      PaymentMethod: Record 289;
                      Error03: Label 'The CABYS Code for Exempt Services is not configured. You must configure "Exempt Service CABYS Code" in order to issue the receipt.';
        Error04: Label 'The CABYS Code for Taxable Services is not configured. You must configure "Taxable Service CABYS Code" in order to issue the receipt.';
        CabysToUse: Code[20];
    begin
        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('FacturaElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        // Add required namespaces
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/facturaElectronica');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");

        // Level 1 - Identificacion del documento
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '01'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', '221101'/*GetValueByName(0,'PROVEEDORSISTEMAS',0)*/, '', XmlNode1); // Campo obligatorio según versión 4.4
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1); // Campo obligatorio
        IF Cust."Cod. Actividad Cliente" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', Cust."Cod. Actividad Cliente", '', XmlNode1) // Campo obligatorio
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', '221101', '', XmlNode1); // Campo condicional (1=obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);

        // Informacion del emisor
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        //XmlDomMgnt.AddElement(XmlNode1,'NombreComercial','No cuenta con Nombre','',XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio','','',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Informacion del receptor
        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', SIH."Bill-to Name", '', XmlNode2);

        // Identificación del receptor según versión 4.4
        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN
            XmlDomMgnt.AddElement(XmlNode1, 'IdentificacionExtranjero', SIH."VAT Registration No.", '', XmlNode2)
        ELSE BEGIN
            // --009-YFC
            // Identificación del receptor según versión 4.4
            IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                /*VatRegNo := SIH."VAT Registration No.";
                  IF STRLEN(VatRegNo) < 12 THEN BEGIN
                        VatRegNo := COPYSTR('000000000000' + VatRegNo, STRLEN(VatRegNo) + 1, 12);
                        XmlDomMgnt.AddElement(XmlNode2,'Numero',VatRegNo,'',XmlNode3);
                    END ELSE*/
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
            END;
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', Cust."Name 2", '', XmlNode2); // Campo opcional

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', SIH."E-Mail-FE", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2);

        // Document Conditions
        IF SIH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(SIH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        // Process lines
        CategoriaPedidoVenta.GET(SIH."Categoria Pedido Venta"); //008-YFC

        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            SIL.SETRANGE(Compartir, SIL.Compartir::" ");
        IF SIL.FINDSET THEN //BEGIN
            REPEAT
                ContarLineas += 1;

                //Pedido muestra
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(Item2);
                IF Item2.GET(SIL."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN
                        ERROR(Error01, SIL."No.");
                    XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', Item2.CABYS, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                END ELSE
                    ERROR(Error01, SIL."No.");

                // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF SIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);
                //Totales+
                //Totales Lineas+
                PrecioUnitario := SIL."Unit Price";
                MontoTotal := ROUND(SIL."Unit Price" * SIL.Quantity);
                MontoDescuento := ROUND(SIL."Line Discount Amount");
                SubTotal := ROUND(SIL.Amount);
                BaseImponible := ROUND(SIL.Amount);
                MontoImpuesto := ROUND(SIL."Amount Including VAT" - SIL.Amount);
                MontoTotalLinea := ROUND(SIL."Amount Including VAT");
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;

                // Obtener el registro del catálogo CABYS para el ítem actual//013+
                CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(Item2.CABYS) THEN BEGIN
                    CASE CatalogoCaByS."Tipo CABYS" OF
                        CatalogoCaByS."Tipo CABYS"::Servicio:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalServExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalServGravado += MontoTotal;
                            END;
                        CatalogoCaByS."Tipo CABYS"::Mercancía:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalMercExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalMercGravado += MontoTotal;
                            END;
                    END;
                END;
                // Obtener el registro del catálogo CABYS para el ítem actual//013-
                //Totales Factura+
                //Totales-

                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3); // Campo obligatorio según versión 4.4
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                // Descuentos (obligatorio si hay descuento según versión 4.4)
                IF SIL."Line Discount Amount" > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); // Campo obligatorio según versión 4.4

                // Impuestos (obligatorio según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN BEGIN
                    //IF (VATProdPostGroup."Codigo Tarifa FE" = '01') OR (VATProdPostGroup."Codigo Tarifa FE" = '07') THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); // Cambiado a CodigoTarifaIVA según versión 4.4
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00', '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;
                ///************************IMPUESTO ASUMIDO POR FABRICA*********************

                //Para el desgloce del impusto+
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

            UNTIL SIL.NEXT = 0;

        //******************************************************FACTURACION COMPARTIR+++++++++++++++++
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
            View_SalesInvoiceLine.SETRANGE(Document_No, SIH."No.");
            View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesInvoiceLine.SETFILTER(Compartir, '<>%1', View_SalesInvoiceLine.Compartir::" ");
            View_SalesInvoiceLine.OPEN;
            WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity;
                    SIL."Amount Including VAT" := View_SalesInvoiceLine.Sum_Amount;
                    TotalMuestra += View_SalesInvoiceLine.Sum_Amount;
                END;

                //9021+
                IsExento := (ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0.01) = ROUND(View_SalesInvoiceLine.Sum_Amount, 0.01));
                //9021-

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                //019+
                /*
                CASE View_SalesInvoiceLine.Compartir OF
                  View_SalesInvoiceLine.Compartir::Libros :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Libro CABYS",'',XmlNode3);//013+-
                    END;
                  View_SalesInvoiceLine.Compartir::Aulas :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Aulas CABYS",'',XmlNode3);//013+-
                    END;
                  View_SalesInvoiceLine.Compartir::Servicios :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Servicio CABYS",'',XmlNode3);//013+-
                    END;
                  END;
                  */

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            IF IsExento THEN BEGIN
                                IF ConfSant."Codigo Libro CABYS" = '' THEN
                                    ERROR(Error03);
                                CabysToUse := ConfSant."Codigo Libro CABYS";
                                /*END ELSE BEGIN
                                  IF ConfSant."Codigo Libro CABYS Gravado" = '' THEN
                                    ERROR(Error04);
                                  CabysToUse := ConfSant."Codigo Libro CABYS";
                                END;*/
                            END;

                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);
                        END;

                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            CabysToUse := ConfSant."Codigo Aulas CABYS";
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);//012+-
                        END;

                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            IF IsExento THEN BEGIN
                                IF ConfSant."Codigo Servicio CABYS Exento" = '' THEN
                                    ERROR(Error03);
                                CabysToUse := ConfSant."Codigo Servicio CABYS Exento";
                            END ELSE BEGIN
                                IF ConfSant."Codigo Servicio CABYS" = '' THEN
                                    ERROR(Error04);
                                CabysToUse := ConfSant."Codigo Servicio CABYS";
                            END;

                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);
                        END;
                END;
                //019-

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //Totales+
                //Totales Lineas+
                //PrecioUnitario  := ROUND((View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity); //008-YFC ////020+-
                //PrecioUnitario  := (View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity; //017+//SANTINAV-8876//LDP+- ////020+-
                //MontoTotal      := ROUND(View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                PrecioUnitario := ROUND((View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity, 0.00001);//020+-
                MontoTotal := ROUND(View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount, 0.01);////020+-
                MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));
                SubTotal := ROUND(View_SalesInvoiceLine.Sum_Amount);
                BaseImponible := ROUND(View_SalesInvoiceLine.Sum_Amount);
                MontoImpuesto := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount);
                MontoTotalLinea := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT);
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;
                //019+
                // Obtener el código CABYS según el tipo Compartir
                /*CatalogoCaByS.RESET;
                CASE View_SalesInvoiceLine.Compartir OF
                  View_SalesInvoiceLine.Compartir::Libros:
                    CatalogoCaByS.GET(ConfSant."Codigo Libro CABYS");
                  View_SalesInvoiceLine.Compartir::Aulas:
                    CatalogoCaByS.GET(ConfSant."Codigo Aulas CABYS");
                  View_SalesInvoiceLine.Compartir::Servicios:
                    CatalogoCaByS.GET(ConfSant."Codigo Servicio CABYS");
                END;
        
                // Calcular monto total de la línea
                // Actualizar totales según tipo CABYS e impuesto
                CASE CatalogoCaByS."Tipo CABYS" OF
                  CatalogoCaByS."Tipo CABYS"::Servicio:
                    IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                      TotalServExento += MontoTotal
                    ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                      TotalServGravado += MontoTotal;
                  CatalogoCaByS."Tipo CABYS"::Mercancía:
                    IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                      TotalMercExento += MontoTotal
                    ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                      TotalMercGravado += MontoTotal;
                END;*/
                CatalogoCaByS.GET(CabysToUse);

                CASE CatalogoCaByS."Tipo CABYS" OF
                    CatalogoCaByS."Tipo CABYS"::Servicio:
                        IF IsExento THEN
                            TotalServExento += MontoTotal
                        ELSE
                            TotalServGravado += MontoTotal;

                    CatalogoCaByS."Tipo CABYS"::Mercancía:
                        IF IsExento THEN
                            TotalMercExento += MontoTotal
                        ELSE
                            TotalMercGravado += MontoTotal;
                END;
                //019-
                //019+
                /*
                IF  VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;
                IF View_SalesInvoiceLine.Sum_Amount = View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN
                  TotalExento += View_SalesInvoiceLine.Sum_Amount+ View_SalesInvoiceLine.Sum_Line_Discount_Amount
                ELSE
                  TotalGravado += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                */
                IF VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;

                IF IsExento THEN
                    TotalExento := TotalServExento + TotalMercExento
                ELSE
                    TotalGravado := TotalServGravado + TotalMercGravado;
                //019-
                //Totales Factura-
                //Totales+

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF MontoDescuento > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode3, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                //Para el desgloce del impusto+
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
            END;
            View_SalesInvoiceLine.CLOSE;
        END;
        //008-YFC
        //******************************************************FACTURACION COMPARTIR*************************************************

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / SIH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // Tax summary (obligatorio si hay impuestos según versión 4.4)
        //**************TotalDesgloseImpuestoo Nodo+ //012+*********************

        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;
        //**************TotalDesgloseImpuesto Nodo+ //012-********************

        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // Payment method (nodo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //*******************************INFORMACON DE REFERENCIA************************************
        IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '08', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '10', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
            END;

            XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH."Numero Referencia FE", '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye Comprobante', '', XmlNode2);
                    END;
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula documento de referencia', '', XmlNode2);
                    END;
            END;
        END;

        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure CreaXmlNotaCreditoV4_4(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      Cust: Record 18;
                      CMH: Record 114;
                      CML: Record 115;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesCRMLine: Query "50001;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      RecTipoDescuentosDGT: Record 50025;
                      ImpLinEmisorFabrica: Decimal;
                      lClave: Text[60];
                      SIH: Record 112;
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
                      PaymentTerms: Record 3;
                      CatParamFEDGT: Record 50030;
                      PaymentMethod: Record 289;
    begin
        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;

    XmlDoc := XmlDoc.XmlDocument;

    xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
    XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
    XmlNode := XmlDoc.CreateElement('NotaCreditoElectronica');
    XmlNode := XmlDoc.AppendChild(XmlNode);

    // Add required namespaces
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/notaCreditoElectronica');

    CMH.GET(NoDocumento);
    CMH.CALCFIELDS(Amount, "Amount Including VAT");
    Cust.GET(CMH."Bill-to Customer No.");

    IF wVieneDePos AND (wClavePos <> '') AND (wConsecutivoPos <> '') THEN BEGIN
            lClave := wClavePos;
    Consecutivo := wConsecutivoPos;
        END ELSE
            lClave := GetClave(CMH."Posting Date", Consecutivo, '03');

        // Level 1 - Document Identification
        XmlDomMgnt.AddElement(XmlNode, 'Clave', lClave, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', '221101', '', XmlNode1); // Campo obligatorio según versión 4.4
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1); // Campo obligatorio
        IF Cust."Cod. Actividad Cliente" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', Cust."Cod. Actividad Cliente", '', XmlNode1) // Campo obligatorio
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', '221101', '', XmlNode1); // Campo condicional (1=obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(CMH."Posting Date", TIME), '', XmlNode1);

        // Emitter Information
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio','','',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Receiver Information
        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', CMH."Bill-to Name", '', XmlNode2);
        // ++ 009-YFC
        //IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Identificacion extranjero" THEN
        // XmlDomMgnt.AddElement(XmlNode1,'IdentificacionExtranjero',Cust."VAT Registration No.",'',XmlNode2)
        // ELSE
        //BEGIN
        // --009-YFC
        IF (Cust."VAT Registration No." <> '.') AND (Cust."VAT Registration No." <> '') THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
            // ++ 004-YFC
            IF ConfSant."Cliente Contado E-Commerce" = Cust."No." THEN BEGIN

                IF STRLEN(CMH."VAT Registration No.") = 9 THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '01', '', XmlNode3);

                IF STRLEN(CMH."VAT Registration No.") = 10 THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '02', '', XmlNode3);

                IF (STRLEN(CMH."VAT Registration No.") = 11) OR (STRLEN(CMH."VAT Registration No.") = 12) THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'Tipo', '03', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', CMH."VAT Registration No.", '', XmlNode3);
            END ELSE BEGIN
                // -- 004-YFC
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', Cust."VAT Registration No.", '', XmlNode3);
            END;
        END;
        // END; //009-YFC
        // --009-YFC
        // Identificación del receptor según versión 4.4
        /*IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
          XmlDomMgnt.AddElement(XmlNode1,'Identificacion','','',XmlNode2);
          XmlDomMgnt.AddElement(XmlNode2,'Tipo',GetValueByName(2,FORMAT(Cust."Tax Identification Type"),0),'',XmlNode3);
          XmlDomMgnt.AddElement(XmlNode2,'Numero',SIH."VAT Registration No.",'',XmlNode3);
        END;
    END;
    XmlDomMgnt.AddElement(XmlNode1,'NombreComercial',Cust."Name 2",'',XmlNode2); // Campo opcional

    XmlDomMgnt.AddElement(XmlNode1,'Telefono','','',XmlNode2);
      XmlDomMgnt.AddElement(XmlNode2,'CodigoPais',GetValueByName(0,'PAIS',0),'',XmlNode3);
      XmlDomMgnt.AddElement(XmlNode2,'NumTelefono',GetValueByName(0,'EMISOR_TELEFONO',0),'',XmlNode3);
    */
        IF CMH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', CMH."E-Mail-FE", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Document Conditions
        IF CMH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(CMH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        // Process lines
        CategoriaPedidoVenta.GET(CMH."Categoria Pedido Venta"); //008-YFC

        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        CML.RESET;
        CML.SETRANGE("Document No.", CMH."No.");
        CML.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            CML.SETRANGE(Compartir, CML.Compartir::" ");
        IF CML.FINDSET THEN //BEGIN
            REPEAT
                ContarLineas += 1;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(Item2);
                IF Item2.GET(CML."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN
                        ERROR(Error01, CML."No.");
                    XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', Item2.CABYS, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                END ELSE
                    ERROR(Error01, CML."No.");

                // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', CML."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(CML.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF CML."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, CML."Unit of Measure Code", 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := CML."Unit Price";
                MontoTotal := ROUND(CML."Unit Price" * CML.Quantity);
                MontoDescuento := ROUND(CML."Line Discount Amount");
                SubTotal := ROUND(CML.Amount);
                BaseImponible := ROUND(CML.Amount);
                MontoImpuesto := ROUND(CML."Amount Including VAT" - CML.Amount);
                MontoTotalLinea := ROUND(CML."Amount Including VAT");
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                IF CML."VAT %" = 0 THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;

                // Obtener el registro del catálogo CABYS para el ítem actual//013+
                CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(Item2.CABYS) THEN BEGIN
                    //MontoTotal := ROUND(PIL."Direct Unit Cost" * PIL.Quantity);
                    CASE CatalogoCaByS."Tipo CABYS" OF
                        CatalogoCaByS."Tipo CABYS"::Servicio:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalServExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalServGravado += MontoTotal;
                            END;
                        CatalogoCaByS."Tipo CABYS"::Mercancía:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalMercExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalMercGravado += MontoTotal;
                            END;
                    END;
                END;
                // Obtener el registro del catálogo CABYS para el ítem actual//013-
                //Totales Factura-

                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', CML.Description, '', XmlNode3); // Campo obligatorio según versión 4.4
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF CML."Line Discount Amount" > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); // Campo obligatorio según versión 4.4

                // Impuestos (obligatorio según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(CML."VAT Prod. Posting Group") THEN BEGIN
                    //IF (VATProdPostGroup."Codigo Tarifa FE" = '01') OR (VATProdPostGroup."Codigo Tarifa FE" = '07') THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); // Cambiado a CodigoTarifaIVA según versión 4.4
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(CML."VAT %"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00'/*FORMAT(MontoImpuesto,0,'<Precision,5:5><Standard Format,9>')*/, '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                //Para el desgloce del impusto+

                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

            UNTIL CML.NEXT = 0;

        //******************************************************FACTURACION COMPARTIR*****************************************************
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesCRMLine);
            View_SalesCRMLine.SETRANGE(Document_No, CMH."No.");
            View_SalesCRMLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesCRMLine.SETFILTER(Compartir, '<>%1', View_SalesCRMLine.Compartir::" ");
            View_SalesCRMLine.OPEN;
            WHILE View_SalesCRMLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (CMH."Tipo de Venta" = CMH."Tipo de Venta"::Muestras) AND (View_SalesCRMLine.Sum_Amount = 0) THEN BEGIN
                    // lrCML.Quantity :=1;
                    CML."Unit Price" := 0.01;
                    CML.Amount := View_SalesCRMLine.Sum_Unit_Price * View_SalesCRMLine.Sum_Quantity;
                    CML."Amount Including VAT" := View_SalesCRMLine.Sum_Amount;
                    TotalMuestra += View_SalesCRMLine.Sum_Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Libro CABYS", '', XmlNode3);//013+-
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Aulas CABYS", '', XmlNode3);//013+-
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', ConfSant."Codigo Servicio CABYS", '', XmlNode3);//013+-
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesCRMLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesCRMLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesCRMLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := ROUND((View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount) / View_SalesCRMLine.Sum_Quantity); //008-YFC
                MontoTotal := ROUND(View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount);
                MontoDescuento := ROUND(View_SalesCRMLine.Sum_Line_Discount_Amount);
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesCRMLine.Sum_VAT > 0 THEN
                        MontoDescuento := ROUND(View_SalesCRMLine.Sum_Amount * (View_SalesCRMLine.Sum_Line_Discount / 100));
                SubTotal := ROUND(View_SalesCRMLine.Sum_Amount);
                BaseImponible := ROUND(View_SalesCRMLine.Sum_Amount);
                MontoImpuesto := ROUND(View_SalesCRMLine.Sum_Amount_Including_VAT - View_SalesCRMLine.Sum_Amount);
                MontoTotalLinea := ROUND(View_SalesCRMLine.Sum_Amount_Including_VAT);
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;
                // Obtener el código CABYS según el tipo Compartir
                CatalogoCaByS.RESET;
                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        CatalogoCaByS.GET(ConfSant."Codigo Libro CABYS");
                    View_SalesCRMLine.Compartir::Aulas:
                        CatalogoCaByS.GET(ConfSant."Codigo Aulas CABYS");
                    View_SalesCRMLine.Compartir::Servicios:
                        CatalogoCaByS.GET(ConfSant."Codigo Servicio CABYS");
                END;

                // Calcular monto total de la línea
                // Actualizar totales según tipo CABYS e impuesto
                CASE CatalogoCaByS."Tipo CABYS" OF
                    CatalogoCaByS."Tipo CABYS"::Servicio:
                        IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                            TotalServExento += MontoTotal
                        ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                            TotalServGravado += MontoTotal;
                    CatalogoCaByS."Tipo CABYS"::Mercancía:
                        IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                            TotalMercExento += MontoTotal
                        ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                            TotalMercGravado += MontoTotal;
                END;

                IF VATProdPostGroup.GET(View_SalesCRMLine.VAT_Prod_Posting_Group) THEN;
                IF View_SalesCRMLine.Sum_Amount = View_SalesCRMLine.Sum_Amount_Including_VAT THEN
                    TotalExento += View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount
                ELSE
                    TotalGravado += View_SalesCRMLine.Sum_Amount + View_SalesCRMLine.Sum_Line_Discount_Amount;
                //Totales Factura-

                CASE View_SalesCRMLine.Compartir OF
                    View_SalesCRMLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesCRMLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrCML.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF MontoDescuento > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                //MontoImpuesto := 0;
                //IF View_SalesCRMLine.Sum_Amount <> View_SalesCRMLine.Sum_Amount_Including_VAT THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3); //YFC
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(View_SalesCRMLine.VAT_Prod_Posting_Group) THEN;
                XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); //YFC//012+-CodigoTarifaIVA
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);  //YFC
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode3, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00'/*FORMAT(MontoImpuesto,0,'<Precision,5:5><Standard Format,9>')*/, '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;
                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                //Para el desgloce del impusto+

                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
            END;
            View_SalesCRMLine.CLOSE;
        END; //008-YFC
             //******************************************************FACTURACION COMPARTIR*************************************************

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF CMH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', CMH."Currency Code", '', XmlNode3);

        IF CMH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / CMH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalImpuesto',FORMAT(MontoTotalImpuesto,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalVentaNeta',FORMAT((TotalGravado+TotalExento)-TotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2);

        // Tax summary (obligatorio si hay impuestos según versión 4.4)
        //**************TotalDesgloseImpuestoo Nodo+ //012+*********************

        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;
        //**************TotalDesgloseImpuesto Nodo+ //012-********************

        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto/*MontoTotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        // Payment method (nodo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF CMH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', GetValueByRelation(4, CMH."Payment Method Code", 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(CMH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        IF CMH."Tipo de Venta" = CMH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(CMH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //*******************************INFORMACON DE REFERENCIA************************************

        SIH.GET(CMH."No. Doc Historico");

        //IF CMH."Tipo Doc. Ref NC" <> CMH."Tipo Doc. Ref NC"::" " THEN BEGIN
        XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);

        CASE CMH."Tipo Doc. Ref NC" OF
            CMH."Tipo Doc. Ref NC"::"Factura Electronica":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '01', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Tiquete Electronico":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '04', '', XmlNode2);
            CMH."Tipo Doc. Ref NC"::"Sustituye Factura de Exportacion":
                XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '12', '', XmlNode2);
        END;
        XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH.Clave/*SIH.Consecutivo*/, '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FORMAT(SIH."Fecha Doc Electronico", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'), '', XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4

        CASE CMH."Codigo Referencia" OF
            CMH."Codigo Referencia"::"Devolucion Total":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula Documento de Referencia', '', XmlNode2);
                END;
            CMH."Codigo Referencia"::"Devolucion Parcial":
                BEGIN
                    XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '02', '', XmlNode2);
                    XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye comprobante', '', XmlNode2);
                END;
        END;
        //END;
        //END;

        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure CreaXmlFacturaExportacionV4_4(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      SIH: Record 112;
                      SIL: Record 113;
                      Cust: Record 18;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      RecTipoDescuentosDGT: Record 50025;
                      ImpLinEmisorFabrica: Decimal;
                      Numero: Code[30];
                      lrMontoTotal: Decimal;
                      lrDescuento: Decimal;
                      lrSubTotal: Decimal;
                      VatRegNo: Code[20];
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
                      PaymentTerms: Record 3;
                      CatParamFEDGT: Record 50030;
                      PaymentMethod: Record 289;
                      MontoImpuestoVat: Decimal;
    begin
        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;
        //GenLedSetup.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('FacturaElectronicaExportacion');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        // Add required namespaces
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/facturaElectronicaExportacion');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");

        // Level 1 - Document Identification
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '09'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', GetValueByName(0, 'PROVEEDORSISTEMAS', 0), '', XmlNode1); // Campo obligatorio según versión 4.4
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1);
        //XmlDomMgnt.AddElement(XmlNode,'CodigoActividadEmisor','5811.0','',XmlNode1); // Campo obligatorio
        //XmlDomMgnt.AddElement(XmlNode,'CodigoActividadReceptor','513710','',XmlNode1); (4=Inexistente según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);

        // Emitter Information
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio','','',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Receiver Information
        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', SIH."Bill-to Name", '', XmlNode2);

        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN BEGIN
            //XmlDomMgnt.AddElement(XmlNode1,'IdentificacionExtranjero',SIH."VAT Registration No.",'',XmlNode2)
            XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
        END ELSE BEGIN
            // --009-YFC
            // Identificación del receptor según versión 4.4
            IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                /*VatRegNo := SIH."VAT Registration No.";
                  IF STRLEN(VatRegNo) < 12 THEN BEGIN
                        VatRegNo := COPYSTR('000000000000' + VatRegNo, STRLEN(VatRegNo) + 1, 12);
                        XmlDomMgnt.AddElement(XmlNode2,'Numero',VatRegNo,'',XmlNode3);
                    END ELSE*/
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
            END;
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', Cust."Name 2", '', XmlNode2); // Campo opcional

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', SIH."E-Mail-FE", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2);

        // Document Conditions
        IF SIH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(SIH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio;

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        // Process lines
        //CategoriaPedidoVenta.GET(SIH."Categoria Pedido Venta"); //008-YFC

        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        IF SIL.FINDSET THEN BEGIN
            REPEAT
                ContarLineas += 1;

                // Handle samples with zero amount
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);
                IF Item.GET(SIL."No.") THEN;

                IF Item."Tariff No." <> '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'PartidaArancelaria', FORMAT(Item."Tariff No."), '', XmlNode3);   //Identificar
                                                                                                                      // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(Item2);
                IF Item2.GET(SIL."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN
                        ERROR(Error01, SIL."No.");
                    XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', Item2.CABYS, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                END ELSE
                    ERROR(Error01, SIL."No.");

                // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF SIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := SIL."Unit Price";
                MontoTotal := ROUND(SIL."Unit Price" * SIL.Quantity);
                MontoDescuento := ROUND(SIL."Line Discount Amount");
                SubTotal := ROUND(SIL.Amount);
                BaseImponible := ROUND(SIL.Amount);
                MontoImpuesto := ROUND(SIL."Amount Including VAT" - SIL.Amount);
                MontoTotalLinea := ROUND(SIL."Amount Including VAT");
                //Totales Lineas-

                /*//Totales Lineas+
                PrecioUnitario  := SIL."Unit Price";
                MontoTotal      := ROUND((SIL."Unit Price" * SIL.Quantity),GenLedSetup."Unit-Amount Rounding Precision");
                MontoDescuento  := ROUND(SIL."Line Discount %"*(MontoTotal),GenLedSetup."Unit-Amount Rounding Precision");
                SubTotal        := ROUND((MontoTotal-MontoDescuento),GenLedSetup."Unit-Amount Rounding Precision");
                BaseImponible   := ROUND(SubTotal,GenLedSetup."Unit-Amount Rounding Precision");
                MontoImpuesto   := ROUND((SIL."VAT %" * SubTotal),GenLedSetup."Unit-Amount Rounding Precision");
                MontoTotalLinea := ROUND(SubTotal + MontoImpuesto,GenLedSetup."Unit-Amount Rounding Precision");
                //Totales Lineas-*/

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;

                // Obtener el registro del catálogo CABYS para el ítem actual//012+
                CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(Item2.CABYS) THEN BEGIN
                    CASE CatalogoCaByS."Tipo CABYS" OF
                        CatalogoCaByS."Tipo CABYS"::Servicio:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalServExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalServGravado += MontoTotal;
                            END;
                        CatalogoCaByS."Tipo CABYS"::Mercancía:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalMercExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalMercGravado += MontoTotal;
                            END;
                    END;
                END;
                // Obtener el registro del catálogo CABYS para el ítem actual//012-
                //Totales Factura+


                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3); // Campo obligatorio según versión 4.4
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF SIL."Line Discount Amount" > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                lrSubTotal := ROUND(lrMontoTotal - lrDescuento);
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                //XmlDomMgnt.AddElement(XmlNode2,'BaseImponible',FORMAT(SIL.Amount,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode3); // Campo Inexistente según versión 4.4

                // Impuestos (obligatorio según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN BEGIN
                    //IF (VATProdPostGroup."Codigo Tarifa FE" = '01') OR (VATProdPostGroup."Codigo Tarifa FE" = '07') THEN
                    IF VATProdPostGroup."Codigo Tarifa FE" = '' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', '10', '', XmlNode4)
                    ELSE // Cambiado a CodigoTarifaIVA según versión 4.4
                        XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);
                MontoImpuesto := ROUND(SIL."Amount Including VAT" - SIL.Amount);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                TotalImpuesto += MontoImpuesto;

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL SIL.NEXT = 0;
        END;

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / SIH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);


        // Tax summary (obligatorio si hay impuestos según versión 4.4)
        //**************TotalDesgloseImpuestoo Nodo+ //012+*********************

        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;

        //**************TotalDesgloseImpuesto Nodo+ //012-********************
        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto/*MontoTotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-


        // Payment method (nodo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //*******************************INFORMACON DE REFERENCIA************************************
        IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '08', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '10', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
            END;

            XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH."Numero Referencia FE", '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye Comprobante', '', XmlNode2);
                    END;
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula documento de referencia', '', XmlNode2);
                    END;
            END;
        END;

        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    procedure FacturaElectronicaCompra(NoDocumento: Code[20])
    var
        iProcesa: DotNet Procesa;
                      xmlFactura: DotNet XmlDocument;
                      xmlFacturaFirmado: DotNet XmlDocument;
                      xmlFacturaRespuesta: DotNet XmlDocument;
                      PIH: Record 122;
                      ReportFE: Report "52543;
                      QRCodeInput: Text;
                      TempBlob: Record 99008535;
                      DirectorioTemp: Text[100];
                      ConfSant: Record 56001;
                      DSNPurchInvExt: Record 50028;
                      ReportFEC: Report "10121;
    begin
        // HttpWebRequestMgt.AddSecurityProtocolTls12();

        ConfSant.GET;
                      //Cuando se procesa la factura, se firma el XML y se envía a Hacienda
                      DirectorioTemp := GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 7) + GetValueByName(0, 'ARCHIVO_FEC', 0) + '.xml';
                      IF PIH.GET(NoDocumento) THEN
            CreaXmlFacturaCompraV4_4(NoDocumento, DirectorioTemp); //013+-
                                                                   //CreaXmlFacturaV4_4_VI(NoDocumento,DirectorioTemp); //013+-
                      xmlFactura := xmlFactura.XmlDocument();
                      xmlFactura.Load(DirectorioTemp);

                      //015+
                      IF NOT DSNPurchInvExt.GET(NoDocumento) THEN BEGIN
            DSNPurchInvExt.INIT;
                      DSNPurchInvExt."No." := NoDocumento;
                      DSNPurchInvExt."Buy-from Vendor No." := PIH."Buy-from Vendor No.";
                      DSNPurchInvExt."Buy-from Vendor Name" := PIH."Buy-from Vendor Name";
                      DSNPurchInvExt."E-Mail-FE" := PIH."E-Mail-FE";
                      DSNPurchInvExt.INSERT;
        END;

        //Pendiente
        LogFacturaElectronica(7, DSNPurchInvExt."No.", CURRENTDATETIME, DSNPurchInvExt.Clave, DSNPurchInvExt.Consecutivo, DSNPurchInvExt.Estado, DSNPurchInvExt.Mensaje,
        GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 7), DSNPurchInvExt."E-Mail-FE", DSNPurchInvExt."Buy-from Vendor Name", GetValueByName(0, 'ARCHIVO_FEC', 0), 1);
        //Pendiente

        /*//Pendiente
        LogFacturaElectronica(7,PIH."No.",CURRENTDATETIME,PIH.Clave,PIH.Consecutivo,PIH.Estado,PIH.Mensaje,
        GetValueByNameWithType(0,'DIRECTORIOTEMP_NAV',7),PIH."E-Mail-FE",PIH."Buy-from Vendor Name",GetValueByName(0,'ARCHIVO_FEC',0),1);
        //Pendiente*/
        //015-


        iProcesa := iProcesa.Procesa();


        iProcesa.EnviaFactura(xmlFactura, ConfSant."Es Prueba",
                            GetValueByName(0, 'CERTIFICADO', 0),
                            GetValueByName(0, 'CERTIFICADO_PIN', 0),
                            GetValueByName(0, 'API', 0),
                            GetValueByName(0, 'PASS', 0),
                            GetValueByNameWithType(0, 'DIRECTORIOTEMP', 7),
                            GetValueByName(0, 'ARCHIVO_FEC', 0));

        //SLEEP(10000);
        iProcesa.ConsultaComprobante(iProcesa.txtClave,
                                     ConfSant."Es Prueba",
                                     GetValueByName(0, 'API', 0),
                                     GetValueByName(0, 'PASS', 0),
                                     GetValueByNameWithType(0, 'DIRECTORIOTEMP', 7),
                                     GetValueByName(0, 'ARCHIVO_FEC', 0));

        //015+
        DSNPurchInvExt.Consecutivo := iProcesa.txtConsecutivo;
        DSNPurchInvExt.Clave := iProcesa.txtClave;
        DSNPurchInvExt.Estado := iProcesa.estadoFactura;
        DSNPurchInvExt.Mensaje := iProcesa.mensajeRespuesta;
        DSNPurchInvExt."Fecha Doc Electronico" := CURRENTDATETIME;

        DSNPurchInvExt."E-Mail-FE" := PIH."E-Mail-FE";
        DSNPurchInvExt."Codigo Referencia" := PIH."Codigo Referencia";
        DSNPurchInvExt."Tipo Doc Electronico" := PIH."Tipo Doc Electronico";
        DSNPurchInvExt."Tipo Doc. Ref." := PIH."Tipo Doc. Ref.";
        DSNPurchInvExt."Numero Referencia FE" := PIH."Numero Referencia FE";
        DSNPurchInvExt."Tipo Doc. Ref NC" := PIH."Tipo Doc. Ref NC";
        DSNPurchInvExt."Codigo Referencia" := PIH."Codigo Referencia";
        DSNPurchInvExt.MODIFY;
        //PIH.MODIFY;//014+-

        /*PIH.Consecutivo := iProcesa.txtConsecutivo;
        PIH.Clave       := iProcesa.txtClave;
        PIH.Estado      := iProcesa.estadoFactura;
        PIH.Mensaje     := iProcesa.mensajeRespuesta;
        PIH."Fecha Doc Electronico"  := CURRENTDATETIME;*/
        //015-

        //QR Code
        /*
         QRCodeInput    :=SIH."No.";
         CreateQRCode(QRCodeInput,TempBlob);
         SIH."QR Code FE" := TempBlob.Blob;
         */
        //QR Code
        //011-
        // PIH.MODIFY;//015+-

        PIH.RESET;
        PIH.SETRANGE("No.", PIH."No.");
        IF PIH.FINDFIRST THEN BEGIN
            ReportFEC.SETTABLEVIEW(PIH);
            ReportFEC.SAVEASPDF(GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 7) + 'FEC-' + iProcesa.txtClave + '.pdf');
        END; //Comentado porque NoDocumento hay reportes Parametros esto aun
             //015+

        LogFacturaElectronica(7, DSNPurchInvExt."No.", CURRENTDATETIME, iProcesa.txtClave, iProcesa.txtConsecutivo, iProcesa.estadoFactura, iProcesa.mensajeRespuesta,
        GetValueByNameWithType(0, 'DIRECTORIOTEMP_NAV', 7), DSNPurchInvExt."E-Mail-FE", DSNPurchInvExt."Buy-from Vendor Name", GetValueByName(0, 'ARCHIVO_FEC', 0), 2);
        /*//Completado
        LogFacturaElectronica(7,PIH."No.",CURRENTDATETIME,iProcesa.txtClave,iProcesa.txtConsecutivo,iProcesa.estadoFactura,iProcesa.mensajeRespuesta,
        GetValueByNameWithType(0,'DIRECTORIOTEMP_NAV',7),PIH."E-Mail-FE",PIH."Buy-from Vendor Name",GetValueByName(0,'ARCHIVO_FEC',0),2);
        //Completado*/
        //015-

        //MESSAGE('Factura Generada con exito');

    end;

    procedure CreaXmlFacturaCompraV4_4(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      PIH: Record 122;
                      PIL: Record 123;
                      Vendor: Record 23;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      ImpLinEmisorFabrica: Decimal;
                      lrSIL: Record 123;
                      TempImpuestoBkp: Record 50027;
                      vCodigo: Code[2];
                      vCodigoTarifaIVA: Code[2];
                      TextSinGuiones: Code[100];
                      Pos: Integer;
                      VatRegNo: Code[20];
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
                      GLAccount: Record 15;
                      CodCaByS: Code[13];
                      Error01: ;
                      TipoCaByS: Option Servicio,Producto;
                      PaymentTerms: Record 3;
                      CatParamFEDGT: Record 50030;
                      PaymentMethod: Record 289;
    begin

        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;

    XmlDoc := XmlDoc.XmlDocument;

    xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
    XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
    XmlNode := XmlDoc.CreateElement('FacturaElectronicaCompra');
    XmlNode := XmlDoc.AppendChild(XmlNode);

    // Add required namespaces
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
    XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/facturaElectronicaCompra');

    PIH.GET(NoDocumento);
    PIH.CALCFIELDS(Amount, "Amount Including VAT");
    Vendor.GET(PIH."Buy-from Vendor No.");

    // Level 1 - Document Identification
    XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(PIH."Posting Date", Consecutivo, '08'), '', XmlNode1);
    XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', GetValueByName(0, 'PROVEEDORSISTEMAS', 0)/*'513710'*//*GetValueByName(0,'PROVEEDORSISTEMAS',0)*/, '', XmlNode1); // Campo obligatorio según versión 4.4
    IF Vendor."Cod. Actividad Proveedor" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', Vendor."Cod. Actividad Proveedor", '', XmlNode1) // Campo obligatorio
        ELSE BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', '221101', '', XmlNode1);
        END;
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1); // Campo condicional (1=obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(PIH."Posting Date", TIME), '', XmlNode1);
        // EMISOR Information+
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', PIH."Buy-from Vendor Name", '', XmlNode2);

        TextSinGuiones := PIH."VAT Registration No.";
        Pos := STRPOS(TextSinGuiones, '-');
        WHILE Pos > 0 DO BEGIN
            TextSinGuiones := DELSTR(TextSinGuiones, Pos, 1);
            Pos := STRPOS(TextSinGuiones, '-');
        END;
        // Identificación del receptor según versión 4.4
        IF (PIH."VAT Registration No." <> '.') AND (PIH."VAT Registration No." <> '') THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Vendor."Tax Identification Type"), 0), '', XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2, 'Numero', TextSinGuiones, '', XmlNode3);
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', Vendor.Name, '', XmlNode2); // Campo opcional

        //Vendor."Tax Identification Type"::"No contribuyente":
        XmlDomMgnt.AddElement(XmlNode1, 'OtrasSenasExtranjero', Vendor.Address, '', XmlNode2);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        IF PIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', PIH."E-Mail-FE", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Vendor."E-Mail", '', XmlNode2);
        // EMISOR Information-

        // Receptor - SANTILLANA
        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio','','',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Document Conditions
        /*IF GetValueByName(2,FORMAT(Vendor."Tax Identification Type"),0) = '06' THEN
          XmlDomMgnt.AddElement(XmlNode,'CondicionVenta','13','',XmlNode1) // Campo obligatorio
         ELSE
          XmlDomMgnt.AddElement(XmlNode,'CondicionVenta','01','',XmlNode1); // Campo obligatorio
        */

        IF PIH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(PIH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        PIL.RESET;
        PIL.SETRANGE("Document No.", PIH."No.");
        PIL.SETFILTER(Quantity, '<>0');
        IF PIL.FINDSET THEN //BEGIN
            REPEAT
                ContarLineas += 1;
                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(CodCaByS);
                CLEAR(Item2);
                IF Item2.GET(PIL."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN BEGIN
                        ERROR(Error01, PIL."No.")
                    END ELSE BEGIN
                        CodCaByS := Item2.CABYS;
                        TipoCaByS := TipoCaByS::Producto;
                    END;
                END ELSE
                    IF GLAccount.GET(PIL."No.") THEN BEGIN
                        IF GLAccount.CABYS = '' THEN BEGIN
                            ERROR(Error02, PIL."No.")
                        END ELSE BEGIN
                            CodCaByS := GLAccount.CABYS;
                            TipoCaByS := TipoCaByS::Servicio
                        END
                    END;
                //END;

                //ERROR(Error01,PIL."No.");
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CodCaByS/*Item2.CABYS*/, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                                                                                                       // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', PIL."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(PIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF PIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'St', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, PIL."Unit of Measure Code", 0), '', XmlNode3);

                //Totales Lineas+
                PrecioUnitario := PIL."Direct Unit Cost";
                MontoTotal := ROUND(PIL."Direct Unit Cost" * PIL.Quantity);
                MontoDescuento := ROUND(PIL."Line Discount Amount");
                SubTotal := ROUND(PIL.Amount);
                BaseImponible := ROUND(PIL.Amount);
                MontoImpuesto := ROUND(PIL."Amount Including VAT" - PIL.Amount);
                MontoTotalLinea := ROUND(PIL."Amount Including VAT");
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;
                /*IF PIL."VAT %" = 0 THEN
                  TotalExento   += MontoTotal
                ELSE
                  TotalGravado  += MontoTotal; */

                // Obtener el registro del catálogo CABYS para el ítem actual//012+
                /*CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(CodCaByS) THEN BEGIN
                    //MontoTotal := ROUND(PIL."Direct Unit Cost" * PIL.Quantity);
                    CASE CatalogoCaByS."Tipo CABYS" OF
                      CatalogoCaByS."Tipo CABYS"::Servicio:
                        CASE CatalogoCaByS."Tipo Impuesto" OF
                          CatalogoCaByS."Tipo Impuesto"::Exento:
                            TotalServExento += MontoTotal;
                          CatalogoCaByS."Tipo Impuesto"::Gravado:
                            TotalServGravado += MontoTotal;
                        END;
                      CatalogoCaByS."Tipo CABYS"::Mercancía:
                        CASE CatalogoCaByS."Tipo Impuesto" OF
                          CatalogoCaByS."Tipo Impuesto"::Exento:
                            TotalMercExento += MontoTotal;
                          CatalogoCaByS."Tipo Impuesto"::Gravado:
                            TotalMercGravado += MontoTotal;
                        END;
                    END;
                END;*/

                //
                CASE TipoCaByS OF
                    TipoCaByS::Servicio:
                        BEGIN
                            IF PIL."VAT %" = 0 THEN
                                TotalServExento += MontoTotal
                            ELSE
                                TotalServGravado += MontoTotal;
                        END;
                    TipoCaByS::Producto:
                        BEGIN
                            IF PIL."VAT %" = 0 THEN
                                TotalMercExento += MontoTotal
                            ELSE
                                TotalMercGravado += MontoTotal;
                        END;
                END;
                //

                //Pruebas+
                IF (PIL."VAT %" = 0) THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;
                //Pruebas-
                // Obtener el registro del catálogo CABYS para el ítem actual//012-
                //Totales Factura-

                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', PIL.Description, '', XmlNode3); // Campo obligatorio según versión 4.4
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF PIL."Line Discount Amount" > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); // Campo obligatorio según versión 4.4

                // Impuestos (obligatorio según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4); // 01 = IVA
                IF VATProdPostGroup.GET(PIL."VAT Prod. Posting Group") THEN BEGIN
                    //IF (VATProdPostGroup."Codigo Tarifa FE" = '01') OR (VATProdPostGroup."Codigo Tarifa FE" = '07') THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); // Cambiado a CodigoTarifaIVA según versión 4.4
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(PIL."VAT %"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;

                //Para el desgloce del imuesto -
                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL PIL.NEXT = 0;

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF PIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', PIH."Currency Code", '', XmlNode3);

        IF PIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / PIH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);


        // Tax summary (obligatorio si hay impuestos según versión 4.4)
        //**************TotalDesgloseImpuestoo Nodo+ //012+*********************
        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;
        //**************TotalDesgloseImpuesto Nodo+ //012-********************

        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto/*MontoTotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-

        // Payment method (nodo obligatorio según versión 4.4)
        PaymentMethod.RESET;
        IF PaymentMethod.GET(PIH."Payment Method Code") THEN;
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF PIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', PaymentMethod."Cod. Forma de Pago DGT-FE"/*GetValueByRelation(4,PIH."Payment Method Code",0)*/, '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(PIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        //IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
        //XmlDomMgnt.AddElement(XmlNode1,'TotalComprobante',FORMAT(TotalVenta-TotalDescuento,0,'<Precision,5:5><Standard Format,9>'),'',XmlNode2)
        //ELSE
        XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(PIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //*******************************INFORMACON DE REFERENCIA************************************
        // Asignación de TipoDocIR y Código según el tipo de referencia

        XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
        IF PIH."Tipo Doc. Ref." <> PIH."Tipo Doc. Ref."::" " THEN BEGIN

            CASE PIH."Tipo Doc. Ref." OF
                PIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '08', '', XmlNode2); // Documento emitido en contingencia
                        XmlDomMgnt.AddElement(XmlNode1, 'Numero', Consecutivo, '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(PIH."Posting Date", TIME), '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);    // Contingencia
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye comprobante de contingencia', '', XmlNode2);
                    END;

                PIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '05', '', XmlNode2); // Factura de compra electrónica (FEC)
                        XmlDomMgnt.AddElement(XmlNode1, 'Numero', Consecutivo, '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(PIH."Posting Date", TIME), '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '16', '', XmlNode2);    // Anula documento de referencia
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye documento de compra', '', XmlNode2);
                    END;

                PIH."Tipo Doc. Ref."::"Comprobante de Proveedor No Domiciliado":
                    //Vendor."Tax Identification Type"::"No contribuyente":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '16', '', XmlNode2); // Factura de compra electrónica (FEC)
                        XmlDomMgnt.AddElement(XmlNode1, 'Numero', Consecutivo, '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(PIH."Posting Date", TIME), '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '11', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Proveedor No Domiciliado', '', XmlNode2);
                    END;
            END;
            // Agrega siempre el número y la fecha de referencia

        END; /*ELSE BEGIN
            //Pruebas+
            {XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '08', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'Numero', '00200001080000000006', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', '2023-08-11T03:03:34', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye comprobante de prueba', '', XmlNode2);}
            XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '16', '', XmlNode2); // Factura de compra electrónica (FEC)
            XmlDomMgnt.AddElement(XmlNode1, 'Numero', Consecutivo{PIH."Numero Referencia FE"}, '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(PIH."Posting Date", TIME), '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '11', '', XmlNode2);    // Anula documento de referencia
            XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Proveedor No Domiciliado', '', XmlNode2);
             //Pruebas-
          END;*/
             /*IF PIH."Tipo Doc. Ref." <> PIH."Tipo Doc. Ref."::" " THEN BEGIN
               XmlDomMgnt.AddElement(XmlNode,'InformacionReferencia','','',XmlNode1);

               CASE PIH."Tipo Doc. Ref." OF
                 PIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                   XmlDomMgnt.AddElement(XmlNode1,'TipoDocIR','08','',XmlNode2); // Cambiado a TipoDocIR según versión 4.4
                 PIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                   XmlDomMgnt.AddElement(XmlNode1,'TipoDocIR','10','',XmlNode2); // Cambiado a TipoDocIR según versión 4.4
               END;

               XmlDomMgnt.AddElement(XmlNode1,'Numero',PIH."Numero Referencia FE",'',XmlNode2);
               XmlDomMgnt.AddElement(XmlNode1,'FechaEmisionIR',FormatDateTime(PIH."Posting Date",TIME),'',XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4

               CASE PIH."Tipo Doc. Ref." OF
                 PIH."Tipo Doc. Ref."::"Comprobante por Contingencia": BEGIN
                   XmlDomMgnt.AddElement(XmlNode1,'Codigo','05','',XmlNode2);
                   XmlDomMgnt.AddElement(XmlNode1,'Razon','Sustituye Comprobante','',XmlNode2);
                 END;
                 PIH."Tipo Doc. Ref."::"Sustituye Comprobante": BEGIN
                   XmlDomMgnt.AddElement(XmlNode1,'Codigo','01','',XmlNode2);
                   XmlDomMgnt.AddElement(XmlNode1,'Razon','Anula documento de referencia','',XmlNode2);
                 END;
               END;
               XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);
             */




        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;

    local procedure ValidaVerisionFEV4_4(NoDocumento: Code[20]): Boolean
    var
        SalesCrMemoHeader: Record 114;
        SalesInvoiceHeader: Record 112;
        FechaRegSIH: Date;
        Version4_4: Boolean;
    begin
        //013+
        Version4_4 := FALSE;
        SalesCrMemoHeader.RESET;
        SalesInvoiceHeader.RESET;

        IF SalesCrMemoHeader.GET(NoDocumento) THEN BEGIN
            IF SalesInvoiceHeader.GET(SalesCrMemoHeader."No. Doc Historico") THEN BEGIN
                IF SalesInvoiceHeader."Posting Date" >= 090125D THEN
                    Version4_4 := TRUE;
            END;
        END;

        EXIT(Version4_4);
        //013-
    end;

    procedure CreaQRFE(No: Code[20])
    var
        CompanyInformation: Record 79;
        TempBlob: Record 99008535;
        QRCodeInput: Text[1024];
        QRCodeFileName: Text[1024];
        SIH: Record 112;
        SCrMH: Record 114;
    begin
        //016+
        CompanyInformation.GET;

        IF SIH.GET(No) THEN BEGIN
            QRCodeInput := SIH."No.";
            CLEAR(TempBlob);
            CLEAR(QRCodeFileName);
            QRCodeFileName := FunSant.GetQRCodeV2(QRCodeInput);
            FunSant.UplFileBLOBImpndDelServerFileV2(TempBlob, QRCodeFileName);
            SIH."QR Code FE" := TempBlob.Blob;
            //SIH.MODIFY;
            IF NOT ISSERVICETIER THEN
                IF EXISTS(QRCodeFileName) THEN
                    ERASE(QRCodeFileName);
        END ELSE
            IF SCrMH.GET(No) THEN BEGIN
                QRCodeInput := SCrMH."No.";
                CLEAR(TempBlob);
                CLEAR(QRCodeFileName);
                QRCodeFileName := FunSant.GetQRCodeV2(QRCodeInput);
                FunSant.UplFileBLOBImpndDelServerFileV2(TempBlob, QRCodeFileName);
                SCrMH."QR Code FE" := TempBlob.Blob;
                //SCrMH.MODIFY;
                IF NOT ISSERVICETIER THEN
                    IF EXISTS(QRCodeFileName) THEN
                        ERASE(QRCodeFileName);
            END;
        //016-
    end;

    procedure CreaXmlFacturaV4_4_Compartir(NoDocumento: Code[20]; DirectorioTemp: Text[100])
    var
        XmlDomMgnt: Codeunit 6224;
        XmlNsMgr: DotNet XmlNamespaceManager;
                      XmlDoc: DotNet XmlDocument;
                      XmlNode: DotNet XmlNode;
                      XmlNode1: DotNet XmlNode;
                      XmlNode2: DotNet XmlNode;
                      XmlNode3: DotNet XmlNode;
                      XmlNode4: DotNet XmlNode;
                      XmlNode5: DotNet XmlNode;
                      XmlNode6: DotNet XmlNode;
                      XmlNode7: DotNet XmlNode;
                      XmlNode8: DotNet XmlNode;
                      String: DotNet String;
                      MyDT: DateTime;
                      i: Integer;
                      NS: ;
                      ConfSant: Record 56001;
                      xmlProcessingInst: DotNet XmlProcessingInstruction;
                      Consecutivo: Text[20];
                      SIH: Record 112;
                      SIL: Record 113;
                      Cust: Record 18;
                      TotalDescuento: Decimal;
                      TotalVenta: Decimal;
                      Muestra: Decimal;
                      TotalMuestra: Decimal;
                      ContarLineas: Integer;
                      View_SalesInvoiceLine: Query "50000;
                      ImporteDescuento: Decimal;
                      Amount: Decimal;
                      PrecioUnidad: Decimal;
                      MontoImpuesto: Decimal;
                      ImpuestoAsumidoEmisorFabrica: Decimal;
                      RecTipoDescuentosDGT: Record 50025;
                      ImpLinEmisorFabrica: Decimal;
                      lrSIL: Record 113;
                      TempImpuestoBkp: Record 50027;
                      vCodigo: Code[2];
                      vCodigoTarifaIVA: Code[2];
                      Ceros: Code[10];
                      VatRegNo: Code[20];
                      PrecioUnitario: Decimal;
                      MontoTotal: Decimal;
                      MontoDescuento: Decimal;
                      SubTotal: Decimal;
                      BaseImponible: Decimal;
                      MontoTotalLinea: Decimal;
                      PaymentTerms: Record 3;
                      CatParamFEDGT: Record 50030;
                      PaymentMethod: Record 289;
                      IsExento: Boolean;
                      CabysToUse: Code[20];
                      Error03: Label 'The CABYS Code for Exempt Services is not configured. You must configure "Exempt Service CABYS Code" in order to issue the receipt.';
        Error04: Label 'The CABYS Code for Taxable Services is not configured. You must configure "Taxable Service CABYS Code" in order to issue the receipt.';
    begin
        //*******************************CABECERA XML FACTURA************************************
        ConfSant.GET;

        XmlDoc := XmlDoc.XmlDocument;

        xmlProcessingInst := XmlDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"');
        XmlNode := XmlDoc.AppendChild(xmlProcessingInst);
        XmlNode := XmlDoc.CreateElement('FacturaElectronica');
        XmlNode := XmlDoc.AppendChild(XmlNode);

        // Add required namespaces
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        XmlDomMgnt.AddAttribute(XmlNode, 'xmlns', 'https://cdn.comprobanteselectronicos.go.cr/xml-schemas/v4.4/facturaElectronica');

        SIH.GET(NoDocumento);
        SIH.CALCFIELDS(Amount, "Amount Including VAT");
        Cust.GET(SIH."Bill-to Customer No.");

        // Level 1 - Identificacion del documento
        XmlDomMgnt.AddElement(XmlNode, 'Clave', GetClave(SIH."Posting Date", Consecutivo, '01'), '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'ProveedorSistemas', GetValueByName(0, 'PROVEEDORSISTEMAS', 0), '', XmlNode1); // Campo obligatorio según versión 4.4
        XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadEmisor', GetValueByName(0, 'CodigoActividadEmisor', 0), '', XmlNode1);
        //XmlDomMgnt.AddElement(XmlNode,'CodigoActividadEmisor','5811.0','',XmlNode1); // Campo obligatorio
        IF Cust."Cod. Actividad Cliente" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', Cust."Cod. Actividad Cliente", '', XmlNode1) // Campo obligatorio
        ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CodigoActividadReceptor', '221101', '', XmlNode1); // Campo condicional (1=obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode, 'NumeroConsecutivo', Consecutivo, '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode, 'FechaEmision', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode1);

        // Informacion del emisor
        XmlDomMgnt.AddElement(XmlNode, 'Emisor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', GetValueByName(0, 'EMISOR_NOMBRE', 0), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(0, 'EMISOR_TIPO', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Numero', GetValueByName(0, 'EMISOR_NUMERO', 0), '', XmlNode3);

        //XmlDomMgnt.AddElement(XmlNode1,'NombreComercial','No cuenta con Nombre','',XmlNode2); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'Ubicacion', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'Provincia', GetValueByName(0, 'PROVINCIA', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Canton', GetValueByName(0, 'CANTON', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'Distrito', GetValueByName(0, 'DISTRITO', 0), '', XmlNode3);
        //XmlDomMgnt.AddElement(XmlNode2,'Barrio','','',XmlNode3); // Campo opcional según versión 4.4
        XmlDomMgnt.AddElement(XmlNode2, 'OtrasSenas', GetValueByName(0, 'OTRASSENAS', 0), '', XmlNode3);

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        // CorreoElectronico ahora permite hasta 4 repeticiones (versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', GetValueByName(0, 'EMISOR_CORREO', 0), '', XmlNode2);

        // Informacion del receptor
        XmlDomMgnt.AddElement(XmlNode, 'Receptor', '', '', XmlNode1);
        XmlDomMgnt.AddElement(XmlNode1, 'Nombre', SIH."Bill-to Name", '', XmlNode2);

        // Identificación del receptor según versión 4.4
        // ++ 009-YFC
        IF Cust."Tax Identification Type" = Cust."Tax Identification Type"::"Extranjero No Domiciliado" THEN BEGIN
            //XmlDomMgnt.AddElement(XmlNode1,'IdentificacionExtranjero',SIH."VAT Registration No.",'',XmlNode2)
            XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
            XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
        END ELSE BEGIN
            // --009-YFC
            // Identificación del receptor según versión 4.4
            IF (SIH."VAT Registration No." <> '.') AND (SIH."VAT Registration No." <> '') THEN BEGIN
                XmlDomMgnt.AddElement(XmlNode1, 'Identificacion', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Tipo', GetValueByName(2, FORMAT(Cust."Tax Identification Type"), 0), '', XmlNode3);
                /*VatRegNo := SIH."VAT Registration No.";
                  IF STRLEN(VatRegNo) < 12 THEN BEGIN
                        VatRegNo := COPYSTR('000000000000' + VatRegNo, STRLEN(VatRegNo) + 1, 12);
                        XmlDomMgnt.AddElement(XmlNode2,'Numero',VatRegNo,'',XmlNode3);
                    END ELSE*/
                XmlDomMgnt.AddElement(XmlNode2, 'Numero', SIH."VAT Registration No.", '', XmlNode3);
            END;
        END;

        XmlDomMgnt.AddElement(XmlNode1, 'NombreComercial', Cust."Name 2", '', XmlNode2); // Campo opcional

        XmlDomMgnt.AddElement(XmlNode1, 'Telefono', '', '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode2, 'CodigoPais', GetValueByName(0, 'PAIS', 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'NumTelefono', GetValueByName(0, 'EMISOR_TELEFONO', 0), '', XmlNode3);

        IF SIH."E-Mail-FE" <> '' THEN
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', SIH."E-Mail-FE", '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'CorreoElectronico', Cust."E-Mail", '', XmlNode2);

        // Document Conditions
        IF SIH."Payment Terms Code" <> '' THEN BEGIN
            IF PaymentTerms.GET(SIH."Payment Terms Code") THEN;
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', PaymentTerms."Condicion Venta DGT", '', XmlNode1); // Campo obligatorio
            IF (PaymentTerms."Condicion Venta DGT" = '02') OR (PaymentTerms."Condicion Venta DGT" = '10') THEN
                XmlDomMgnt.AddElement(XmlNode, 'PlazoCredito', FORMAT(PaymentTerms."Plazo de tiempo"), '', XmlNode1);
        END ELSE
            XmlDomMgnt.AddElement(XmlNode, 'CondicionVenta', '01', '', XmlNode1); // Campo obligatorio

        //*******************************DETALLES DE SERVICIOS - LINEAS DE VENTA************************************
        // Cambiado a Detalle según versión 4.4 (puede ser servicio o mercancía)
        XmlDomMgnt.AddElement(XmlNode, 'DetalleServicio', '', '', XmlNode1);

        // Process lines
        CategoriaPedidoVenta.GET(SIH."Categoria Pedido Venta"); //008-YFC

        TotalServGravado := 0;
        TotalMercGravado := 0;
        TotalServExento := 0;
        TotalMercExento := 0;

        TempImpuestoBkp.RESET;
        TempImpuestoBkp.DELETEALL;

        SIL.RESET;
        SIL.SETRANGE("Document No.", SIH."No.");
        SIL.SETFILTER(Quantity, '<>0');
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
            SIL.SETRANGE(Compartir, SIL.Compartir::" ");
        IF SIL.FINDSET THEN //BEGIN
            REPEAT
                ContarLineas += 1;

                //Pedido muestra
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (SIL.Amount = 0) THEN BEGIN
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := SIL."Unit Price" * SIL.Quantity;
                    SIL."Amount Including VAT" := SIL.Amount;
                    TotalMuestra += SIL.Amount;
                END;

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);

                // Get CABYS code (campo obligatorio según versión 4.4)
                CLEAR(Item2);
                IF Item2.GET(SIL."No.") THEN BEGIN
                    IF Item2.CABYS = '' THEN
                        ERROR(Error01, SIL."No.");
                    XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', Item2.CABYS, '', XmlNode3); // Cambiado a CodigoCABYS según versión 4.4
                END ELSE
                    ERROR(Error01, SIL."No.");

                // Código comercial (condicional según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', SIL."No.", '', XmlNode4);

                // Quantity and unit
                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(SIL.Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);
                IF SIL."Unit of Measure Code" = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, SIL."Unit of Measure Code", 0), '', XmlNode3);
                //Totales+
                //Totales Lineas+
                PrecioUnitario := SIL."Unit Price";
                MontoTotal := ROUND(SIL."Unit Price" * SIL.Quantity);
                MontoDescuento := ROUND(SIL."Line Discount Amount");
                SubTotal := ROUND(SIL.Amount);
                BaseImponible := ROUND(SIL.Amount);
                MontoImpuesto := ROUND(SIL."Amount Including VAT" - SIL.Amount);
                MontoTotalLinea := ROUND(SIL."Amount Including VAT");
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                IF SIL."VAT %" = 0 THEN
                    TotalExento += MontoTotal
                ELSE
                    TotalGravado += MontoTotal;

                // Obtener el registro del catálogo CABYS para el ítem actual//012+
                CatalogoCaByS.RESET;
                IF CatalogoCaByS.GET(Item2.CABYS) THEN BEGIN
                    CASE CatalogoCaByS."Tipo CABYS" OF
                        CatalogoCaByS."Tipo CABYS"::Servicio:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalServExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalServGravado += MontoTotal;
                            END;
                        CatalogoCaByS."Tipo CABYS"::Mercancía:
                            CASE CatalogoCaByS."Tipo Impuesto" OF
                                CatalogoCaByS."Tipo Impuesto"::Exento:
                                    TotalMercExento += MontoTotal;
                                CatalogoCaByS."Tipo Impuesto"::Gravado:
                                    TotalMercGravado += MontoTotal;
                            END;
                    END;
                END;
                // Obtener el registro del catálogo CABYS para el ítem actual//012-
                //Totales Factura+
                //Totales-

                // Detalles de transaccion
                XmlDomMgnt.AddElement(XmlNode2, 'Detalle', SIL.Description, '', XmlNode3); // Campo obligatorio según versión 4.4
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                // Descuentos (obligatorio si hay descuento según versión 4.4)
                IF SIL."Line Discount Amount" > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                // Subtotal y impueto base
                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3); // Campo obligatorio según versión 4.4

                // Impuestos (obligatorio según versión 4.4)
                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                IF VATProdPostGroup.GET(SIL."VAT Prod. Posting Group") THEN BEGIN
                    //IF (VATProdPostGroup."Codigo Tarifa FE" = '01') OR (VATProdPostGroup."Codigo Tarifa FE" = '07') THEN
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4); // Cambiado a CodigoTarifaIVA según versión 4.4
                END;
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(SIL."VAT %"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************
                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00', '', XmlNode3);//OBS+
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;
                ///************************IMPUESTO ASUMIDO POR FABRICA*********************

                //Para el desgloce del impusto+
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(MontoTotalLinea, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

            UNTIL SIL.NEXT = 0;

        //******************************************************FACTURACION COMPARTIR+++++++++++++++++
        IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN //008-YFC
          BEGIN //008-YFC
            CLEAR(View_SalesInvoiceLine);
            View_SalesInvoiceLine.SETRANGE(Document_No, SIH."No.");
            View_SalesInvoiceLine.SETFILTER(Sum_Quantity, '<>0');
            View_SalesInvoiceLine.SETFILTER(Compartir, '<>%1', View_SalesInvoiceLine.Compartir::" ");
            View_SalesInvoiceLine.OPEN;
            WHILE View_SalesInvoiceLine.READ DO BEGIN
                //REPEAT
                ContarLineas += 1; // para Enumerar Las Lineas
                IF (SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras) AND (View_SalesInvoiceLine.Sum_Amount = 0) THEN BEGIN
                    // lrSIL.Quantity :=1;
                    SIL."Unit Price" := 0.01;
                    SIL.Amount := View_SalesInvoiceLine.Sum_Unit_Price * View_SalesInvoiceLine.Sum_Quantity;
                    SIL."Amount Including VAT" := View_SalesInvoiceLine.Sum_Amount;
                    TotalMuestra += View_SalesInvoiceLine.Sum_Amount;
                END;

                //9021+
                IsExento := (ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0.01) = ROUND(View_SalesInvoiceLine.Sum_Amount, 0.01));
                //9021-

                XmlDomMgnt.AddElement(XmlNode1, 'LineaDetalle', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'NumeroLinea', FORMAT(ContarLineas), '', XmlNode3);


                //9021+
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            IF IsExento THEN BEGIN
                                IF ConfSant."Codigo Libro CABYS" = '' THEN
                                    ERROR(Error03);
                                CabysToUse := ConfSant."Codigo Libro CABYS";
                            END ELSE BEGIN
                                //IF ConfSant."Codigo Libro CABYS Gravado" = '' THEN
                                //ERROR(Error04);
                                CabysToUse := ConfSant."Codigo Libro CABYS";
                            END;

                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);
                        END;

                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            CabysToUse := ConfSant."Codigo Aulas CABYS";
                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);//012+-
                        END;

                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            IF IsExento THEN BEGIN
                                //IF ConfSant."Codigo Servicio CABYS Exento" = '' THEN
                                //ERROR(Error03);
                                CabysToUse := '8431100000000';
                            END ELSE BEGIN
                                IF ConfSant."Codigo Servicio CABYS" = '' THEN
                                    ERROR(Error04);
                                CabysToUse := ConfSant."Codigo Servicio CABYS";
                            END;

                            XmlDomMgnt.AddElement(XmlNode2, 'CodigoCABYS', CabysToUse, '', XmlNode3);
                        END;
                END;
                /*CASE View_SalesInvoiceLine.Compartir OF
                  View_SalesInvoiceLine.Compartir::Libros :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Libro CABYS",'',XmlNode3);//012+-
                    END;
                  View_SalesInvoiceLine.Compartir::Aulas :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Aulas CABYS",'',XmlNode3);//012+-
                    END;
                  //9021+
                  View_SalesInvoiceLine.Compartir::Servicios:
                    BEGIN
                      IF IsExento THEN BEGIN
                        IF ConfSant."Codigo Servicio CABYS Exento" = '' THEN
                          ERROR(Error03);
                        CabysToUse := ConfSant."Codigo Servicio CABYS Exento";
                      END ELSE BEGIN
                        IF ConfSant."Codigo Servicio CABYS" = '' THEN
                          ERROR(Error04);
                        CabysToUse := ConfSant."Codigo Servicio CABYS";
                      END;

                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',CabysToUse,'',XmlNode3);
                    END;
                  END;
                  View_SalesInvoiceLine.Compartir::Servicios :
                    BEGIN
                      XmlDomMgnt.AddElement(XmlNode2,'CodigoCABYS',ConfSant."Codigo Servicio CABYS",'',XmlNode3);//012+-
                    END;
                  END;*/
                //9021-

                XmlDomMgnt.AddElement(XmlNode2, 'CodigoComercial', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Tipo', '04', '', XmlNode4);
                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Libro", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Aulas", '', XmlNode4);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Codigo Servicio", '', XmlNode4);
                        END;
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'Cantidad', FORMAT(View_SalesInvoiceLine.Sum_Quantity, 0, '<Precision,2:2><Standard Format,9>'), '', XmlNode3);

                IF View_SalesInvoiceLine.Unit_of_Measure_Code = '' THEN
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', 'PZ', '', XmlNode3)
                ELSE
                    XmlDomMgnt.AddElement(XmlNode2, 'UnidadMedida', GetValueByRelation(3, View_SalesInvoiceLine.Unit_of_Measure_Code, 0), '', XmlNode3);

                //Totales+
                //Totales Lineas+
                PrecioUnitario := ROUND((View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount) / View_SalesInvoiceLine.Sum_Quantity); //008-YFC
                MontoTotal := ROUND(View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Line_Discount_Amount);
                IF SIH."Prices Including VAT" THEN
                    IF View_SalesInvoiceLine.Sum_VAT > 0 THEN
                        MontoDescuento := ROUND(View_SalesInvoiceLine.Sum_Amount * (View_SalesInvoiceLine.Sum_Line_Discount / 100));
                SubTotal := ROUND(View_SalesInvoiceLine.Sum_Amount);
                BaseImponible := ROUND(View_SalesInvoiceLine.Sum_Amount);
                MontoImpuesto := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT - View_SalesInvoiceLine.Sum_Amount);
                MontoTotalLinea := ROUND(View_SalesInvoiceLine.Sum_Amount_Including_VAT);
                //Totales Lineas-

                //Totales Factura+
                TotalDescuento += MontoDescuento;
                TotalVenta += MontoTotal;
                TotalImpuesto += MontoImpuesto;

                // Obtener el código CABYS según el tipo Compartir
                //9021+
                CatalogoCaByS.GET(CabysToUse);

                CASE CatalogoCaByS."Tipo CABYS" OF
                    CatalogoCaByS."Tipo CABYS"::Servicio:
                        IF IsExento THEN
                            TotalServExento += MontoTotal
                        ELSE
                            TotalServGravado += MontoTotal;

                    CatalogoCaByS."Tipo CABYS"::Mercancía:
                        IF IsExento THEN
                            TotalMercExento += MontoTotal
                        ELSE
                            TotalMercGravado += MontoTotal;
                END;
                /*CatalogoCaByS.RESET;
                CASE View_SalesInvoiceLine.Compartir OF
                  View_SalesInvoiceLine.Compartir::Libros:
                    CatalogoCaByS.GET(ConfSant."Codigo Libro CABYS");
                  View_SalesInvoiceLine.Compartir::Aulas:
                    CatalogoCaByS.GET(ConfSant."Codigo Aulas CABYS");
                  View_SalesInvoiceLine.Compartir::Servicios:
                    CatalogoCaByS.GET(ConfSant."Codigo Servicio CABYS");
                END;
        
                // Calcular monto total de la línea
                // Actualizar totales según tipo CABYS e impuesto
                CASE CatalogoCaByS."Tipo CABYS" OF
                  CatalogoCaByS."Tipo CABYS"::Servicio:
                    IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                      TotalServExento += MontoTotal
                    ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                      TotalServGravado += MontoTotal;
                  CatalogoCaByS."Tipo CABYS"::Mercancía:
                    IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Exento THEN
                      TotalMercExento += MontoTotal
                    ELSE IF CatalogoCaByS."Tipo Impuesto" = CatalogoCaByS."Tipo Impuesto"::Gravado THEN
                      TotalMercGravado += MontoTotal;
                END;
        
        
                IF View_SalesInvoiceLine.Sum_Amount = View_SalesInvoiceLine.Sum_Amount_Including_VAT THEN
                  TotalExento += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount
                ELSE
                  TotalGravado += View_SalesInvoiceLine.Sum_Amount + View_SalesInvoiceLine.Sum_Line_Discount_Amount;
                //Totales Factura-
                */

                IF VATProdPostGroup.GET(View_SalesInvoiceLine.VAT_Prod_Posting_Group) THEN;

                IF IsExento THEN
                    TotalExento := TotalServExento + TotalMercExento
                ELSE
                    TotalGravado := TotalServGravado + TotalMercGravado;

                //9021-
                //Totales+

                CASE View_SalesInvoiceLine.Compartir OF
                    View_SalesInvoiceLine.Compartir::Libros:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Libros', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Aulas:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Aulas', '', XmlNode3);
                        END;
                    View_SalesInvoiceLine.Compartir::Servicios:
                        BEGIN
                            XmlDomMgnt.AddElement(XmlNode2, 'Detalle', 'Servicio', '', XmlNode3);
                        END;
                END;
                //XmlDomMgnt.AddElement(XmlNode2,'Detalle',lrSIL.Description,'',XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'PrecioUnitario', FORMAT(PrecioUnitario, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotal', FORMAT(MontoTotal, 0, '<Precision,3:3><Standard Format,9>'), '', XmlNode3);
                // Desceuntos (obligatorio si hay descuento según versión 4.4)
                IF MontoDescuento > 0 THEN BEGIN
                    //TipoDescuentosDGT.RESET;
                    //IF TipoDescuentosDGT.GET(ConfSant."Tipo Descuento FE") THEN;
                    CatParamFEDGT.RESET;
                    CatParamFEDGT.GET(CatParamFEDGT."Tipo Parametro"::Descuentos, ConfSant."Tipo Descuento FE");
                    XmlDomMgnt.AddElement(XmlNode2, 'Descuento', '', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode3, 'MontoDescuento', FORMAT(MontoDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode3, 'CodigoDescuento', CatParamFEDGT.Codigo, '', XmlNode4); //Campo obligatorio según versión 4.4
                    IF CatParamFEDGT.Codigo = '99' THEN
                        XmlDomMgnt.AddElement(XmlNode3, 'NaturalezaDescuento', CatParamFEDGT.Descripcion, '', XmlNode4);
                END;

                XmlDomMgnt.AddElement(XmlNode2, 'SubTotal', FORMAT(SubTotal, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'BaseImponible', FORMAT(BaseImponible, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

                XmlDomMgnt.AddElement(XmlNode2, 'Impuesto', '', '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode3, 'Codigo', ConfSant."Tipo Impuesto FE", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'CodigoTarifaIVA', VATProdPostGroup."Codigo Tarifa FE", '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Tarifa', FORMAT(VATProdPostGroup."_ ITBIS"), '', XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'Monto', FORMAT(MontoImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                IF CatParamFEDGT."Descuento Asumido Fabrica" THEN BEGIN
                    ImpLinEmisorFabrica := MontoImpuesto;
                    ImpuestoAsumidoEmisorFabrica += MontoImpuesto;
                    XmlDomMgnt.AddElement(XmlNode3, 'ImpuestoAsumidoEmisorFabrica', FORMAT(ImpLinEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode4);
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto - ImpLinEmisorFabrica), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END ELSE BEGIN
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoAsumidoEmisorFabrica', '0.00', '', XmlNode3);
                    XmlDomMgnt.AddElement(XmlNode2, 'ImpuestoNeto', FORMAT((MontoImpuesto), 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
                END;

                ///************************IMPUESTO ASUMIDO POR FABRICA**********************

                //Para el desgloce del impusto+
                IF VATProdPostGroup."Codigo Tarifa FE" <> '' THEN BEGIN
                    // Buscar si ya existe la combinación en la tabla temporal
                    TempImpuestoBkp.RESET;
                    TempImpuestoBkp.SETRANGE(Codigo, ConfSant."Tipo Impuesto FE");
                    TempImpuestoBkp.SETRANGE(TarifaIva, VATProdPostGroup."Codigo Tarifa FE");
                    IF NOT TempImpuestoBkp.FINDFIRST THEN BEGIN
                        TempImpuestoBkp.INIT;
                        TempImpuestoBkp.Codigo := ConfSant."Tipo Impuesto FE";
                        TempImpuestoBkp.TarifaIva := VATProdPostGroup."Codigo Tarifa FE";
                        TempImpuestoBkp.MontoTotalImp := MontoImpuesto;
                        TempImpuestoBkp.INSERT;
                    END ELSE BEGIN
                        TempImpuestoBkp.MontoTotalImp += MontoImpuesto;
                        TempImpuestoBkp.MODIFY;
                    END;
                END;
                //Para el desgloce del imuesto -

                XmlDomMgnt.AddElement(XmlNode2, 'MontoTotalLinea', FORMAT(View_SalesInvoiceLine.Sum_Amount_Including_VAT, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);    //YFC
            END;
            View_SalesInvoiceLine.CLOSE;
        END;
        //008-YFC
        //******************************************************FACTURACION COMPARTIR*************************************************

        //*******************************SUMMARY - RESUMEN DE FACTURA************************************
        XmlDomMgnt.AddElement(XmlNode, 'ResumenFactura', '', '', XmlNode1);

        // Currency (campo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'CodigoTipoMoneda', '', '', XmlNode2);
        IF SIH."Currency Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', 'CRC', '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'CodigoMoneda', SIH."Currency Code", '', XmlNode3);

        IF SIH."Currency Factor" <> 0 THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', FORMAT(1 / SIH."Currency Factor", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3)
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoCambio', '1.00000', '', XmlNode3);

        // Totals
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServGravados', FORMAT(TotalServGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalServExentos', FORMAT(TotalServExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalServNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasGravadas', FORMAT(TotalMercGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);//OBS+-
                                                                                                                                                    //XmlDomMgnt.AddElement(XmlNode1,'TotalMercanciasGravadas','0.00000','',XmlNode2);//OBS+-
        XmlDomMgnt.AddElement(XmlNode1, 'TotalMercanciasExentas', FORMAT(TotalMercExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalMercNoSujeta','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalGravado', FORMAT(TotalGravado, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalExento', FORMAT(TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalExonerado','0.00000','',XmlNode2);
        //XmlDomMgnt.AddElement(XmlNode1,'TotalNoSujeto','0.00000','',XmlNode2); // Nuevo campo según versión 4.4
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVenta', FORMAT(TotalGravado + TotalExento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalDescuentos', FORMAT(TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);
        XmlDomMgnt.AddElement(XmlNode1, 'TotalVentaNeta', FORMAT((TotalGravado + TotalExento) - TotalDescuento/*SIH."Amount Including VAT"-TotalImpuesto*/, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // Tax summary (obligatorio si hay impuestos según versión 4.4)
        //**************TotalDesgloseImpuestoo Nodo+ //012+*********************

        TempImpuestoBkp.RESET;
        IF TempImpuestoBkp.FINDSET THEN
            REPEAT
                XmlDomMgnt.AddElement(XmlNode1, 'TotalDesgloseImpuesto', '', '', XmlNode2);
                XmlDomMgnt.AddElement(XmlNode2, 'Codigo', TempImpuestoBkp.Codigo, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'CodigoTarifaIVA', TempImpuestoBkp.TarifaIva, '', XmlNode3);
                XmlDomMgnt.AddElement(XmlNode2, 'TotalMontoImpuesto', FORMAT(TempImpuestoBkp.MontoTotalImp, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);
            UNTIL TempImpuestoBkp.NEXT = 0;
        //**************TotalDesgloseImpuesto Nodo+ //012-********************

        IF TotalImpuesto > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpuesto', FORMAT(TotalImpuesto, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        IF ImpuestoAsumidoEmisorFabrica > 0 THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalImpAsumEmisorFabrica', FORMAT(ImpuestoAsumidoEmisorFabrica, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        // Payment method (nodo obligatorio según versión 4.4)
        XmlDomMgnt.AddElement(XmlNode1, 'MedioPago', '', '', XmlNode2);
        IF SIH."Payment Method Code" = '' THEN
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', '01', '', XmlNode3) // Efectivo por defecto
        ELSE
            XmlDomMgnt.AddElement(XmlNode2, 'TipoMedioPago', GetValueByRelation(4, SIH."Payment Method Code", 0), '', XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'TotalMedioPago', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode3);

        // Document total
        IF SIH."Tipo de Venta" = SIH."Tipo de Venta"::Muestras THEN
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(TotalVenta - TotalDescuento, 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2)
        ELSE
            XmlDomMgnt.AddElement(XmlNode1, 'TotalComprobante', FORMAT(SIH."Amount Including VAT", 0, '<Precision,5:5><Standard Format,9>'), '', XmlNode2);

        //*******************************INFORMACON DE REFERENCIA************************************
        IF SIH."Tipo Doc. Ref." <> SIH."Tipo Doc. Ref."::" " THEN BEGIN
            XmlDomMgnt.AddElement(XmlNode, 'InformacionReferencia', '', '', XmlNode1);

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '08', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    XmlDomMgnt.AddElement(XmlNode1, 'TipoDocIR', '10', '', XmlNode2); // Cambiado a TipoDocIR según versión 4.4
            END;

            XmlDomMgnt.AddElement(XmlNode1, 'Numero', SIH."Numero Referencia FE", '', XmlNode2);
            XmlDomMgnt.AddElement(XmlNode1, 'FechaEmisionIR', FormatDateTime(SIH."Posting Date", TIME), '', XmlNode2); // Cambiado a FechaEmisionIR según versión 4.4

            CASE SIH."Tipo Doc. Ref." OF
                SIH."Tipo Doc. Ref."::"Comprobante por Contingencia":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '05', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Sustituye Comprobante', '', XmlNode2);
                    END;
                SIH."Tipo Doc. Ref."::"Sustituye Comprobante":
                    BEGIN
                        XmlDomMgnt.AddElement(XmlNode1, 'Codigo', '01', '', XmlNode2);
                        XmlDomMgnt.AddElement(XmlNode1, 'Razon', 'Anula documento de referencia', '', XmlNode2);
                    END;
            END;
        END;

        // Save the XML document
        IF XmlDoc.HasChildNodes THEN
            XmlDoc.Save(DirectorioTemp);

    end;
}

