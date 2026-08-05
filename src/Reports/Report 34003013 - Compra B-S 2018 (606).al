report 55968 "Compra B-S 2018 (606)"
{
    // Proyecto: Microsoft Dynamics Nav
    // ---------------------------------
    // JPG    : John Peralta Guzman
    // ------------------------------------------------------------------------
    // No.         Fecha       Firma      Descripcion
    // ------------------------------------------------------------------------
    // DSLoc1.04   11-jun-2019  JPG       Texto CORREC Incluido y tipo identificacion
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Compra B-S 2018 (606).rdl';


    dataset
    {
        dataitem("Purch. Inv. Header"; 122)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Pay-to Vendor No.", "Posting Date";
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(VATRegistrationNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
            {
            }
            column(PaytoName_PurchInvHeader; "Purch. Inv. Header"."Pay-to Name")
            {
            }
            column(NoComprobanteFiscal_PurchInvHeader; "Purch. Inv. Header"."No. Comprobante Fiscal")
            {
            }
            column(RNCProveedor; Vendor."VAT Registration No.")
            {
            }
            column(DirEmpresa1; DirEmpresa[1])
            {
            }
            column(DirEmpresa2; DirEmpresa[2])
            {
            }
            column(DirEmpresa3; DirEmpresa[3])
            {
            }
            column(DirEmpresa4; DirEmpresa[4])
            {
            }
            column(FiltrosPIH; FiltrosPIH)
            {
            }
            column(FiltrosCMH; FiltrosCMH)
            {
            }
            column(FiltrosGLE; FiltrosGLE)
            {
            }
            column(ImporteBase; ImporteBase)
            {
            }
            column(ImporteExento; ImporteExento)
            {
            }
            column(ImporteGravado; ImporteGravado)
            {
            }
            column(ImporteTotal; ImporteTotal)
            {
            }
            column(CodClasifGasto; "Purch. Inv. Header"."Cod. Clasificacion Gasto")
            {
            }
            column(ITBISPagado; ArchITBIS."ITBIS Pagado")
            {
            }
            column(ITBISRetenido; ArchITBIS."ITBIS Retenido")
            {
            }
            column(ISRRetenido; ArchITBIS."ISR Retenido")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECCION')
                  OR (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECTION')
                  OR (COPYSTR("No. Comprobante Fiscal", 1, 6) = 'CORREC') THEN
                    CurrReport.SKIP;

                //jpg no facturas en 0 para evitar errores
                CALCFIELDS(Amount);
                IF (Amount = 0) THEN
                    CurrReport.SKIP;

                ImporteBase := 0;
                ImporteTotal := 0;
                ImporteITBIS := 0;
                ISRRetenido := 0;
                ImporteGravado := 0;
                ImporteExento := 0;
                ImporteSelectivo := 0;
                ImporteBien := 0;
                ImporteServicios := 0;
                ImportePropina := 0;
                ImporteOtros := 0;
                ITBISRetenido := 0;
                ISRRetenido := 0;
                OtrasRetenciones := 0;
                FactorDivisaAdicional := 0;
                FactorDivisa := 0;
                CLEAR(txtCostosGastos);

                //ISR Retenido
                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionISR);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                    BEGIN
                        IF DivAd THEN //++ 21-11+2019 jpg mod para divisa adicional
                            ISRRetenido += ABS(GLE."Additional-Currency Amount")
                        ELSE //-- 21-11+2019 jpg mod para divisa adicional
                            ISRRetenido += ABS(GLE.Amount);
                    END
                    UNTIL GLE.NEXT = 0;


                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionITBIS);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FIND('-') THEN
                    REPEAT
                        IF DivAd THEN //jpg para divisa adicional
                            ITBISRetenido += ABS(GLE."Additional-Currency Amount")
                        ELSE
                            ITBISRetenido += ABS(GLE.Amount);
                    UNTIL GLE.NEXT = 0;

                //++ 21-11+2019 jpg mod para divisa adicional
                //si se elige divisa local tenemos que hacer la conversion
                /*IF DivAd THEN
                  BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                    VLE.SETRANGE("Document No.","No.");
                    VLE.SETRANGE("Document Type",GLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.","Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date","Posting Date");
                    VLE.SETRANGE("Bal. Account Type",0);
                    VLE.SETFILTER("Bal. Account No.",CtasRetencionISR);
                    IF VLE.FINDFIRST THEN
                      BEGIN
                        VLE.CALCFIELDS(Amount);
                        ISRRetenido := ABS(VLE.Amount);
                      END;
                  END;
                
                IF DivAd THEN
                  BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                    VLE.SETRANGE("Document No.","No.");
                    VLE.SETRANGE("Document Type",GLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.","Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date","Posting Date");
                    VLE.SETRANGE("Bal. Account Type",0);
                    VLE.SETFILTER("Bal. Account No.",CtasRetencionITBIS);
                    IF VLE.FINDFIRST THEN
                      BEGIN
                        VLE.CALCFIELDS(Amount);
                        ITBISRetenido := ABS(VLE.Amount) ;
                      END;
                  END;*/
                //-- 21-11+2019 jpg mod para divisa adicional

                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::Invoice);
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF DivAd THEN BEGIN
                            IF VE.Amount <> 0 THEN
                                ImporteGravado += VE."Additional-Currency Base"
                            ELSE
                                ImporteExento += VE."Additional-Currency Base";

                            ImporteITBIS += VE."Additional-Currency Amount";

                            //para capturar factor divisa adicional.
                            IF (FactorDivisaAdicional = 0) AND ("Purch. Inv. Header"."Currency Code" = '') THEN
                                FactorDivisaAdicional := VE."Additional-Currency Base" / VE.Base;
                        END
                        ELSE BEGIN
                            IF VE.Amount <> 0 THEN BEGIN
                                ImporteGravado += VE.Base;
                                ImporteITBIS += VE.Amount;
                            END
                            ELSE
                                ImporteExento += VE.Base;
                        END;
                    UNTIL VE.NEXT = 0;
                //jpg 15-11-2019
                //ImporteBase  += ImporteGravado + ImporteExento;
                //ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;

                IF NOT Vendor.GET("Buy-from Vendor No.") THEN
                    Vendor.INIT;

                //Se buscan los importes por su clasificacion en lineas del historico
                PIL.RESET;
                PIL.SETRANGE("Document No.", "No.");
                IF PIL.FINDSET THEN
                    REPEAT
                        IF NOT VPPG.GET(PIL."VAT Prod. Posting Group") THEN
                            VPPG.INIT;
                        IF DivAd AND ("Currency Code" = '') THEN BEGIN
                            CASE VPPG."Tipo de bien-servicio" OF
                                0: //Bien
                                    ImporteBien += PIL.Amount * FactorDivisaAdicional;
                                1: //Servicio
                                    ImporteServicios += PIL.Amount * FactorDivisaAdicional;
                                2: //Selectivo
                                    ImporteSelectivo += PIL.Amount * FactorDivisaAdicional;
                                3: //Propina
                                    ImportePropina += PIL.Amount * FactorDivisaAdicional;
                                ELSE //Otro
                                    ImporteOtros += PIL.Amount * FactorDivisaAdicional
                            END;
                        END ELSE BEGIN
                            ///008 conversion factura otra monedas.
                            IF "Currency Code" <> '' THEN
                                FactorDivisa := "Currency Factor"
                            ELSE
                                FactorDivisa := 1;

                            CASE VPPG."Tipo de bien-servicio" OF
                                0: //Bien
                                    ImporteBien += PIL.Amount / FactorDivisa;
                                1: //Servicio
                                    ImporteServicios += PIL.Amount / FactorDivisa;
                                2: //Selectivo
                                    ImporteSelectivo += PIL.Amount / FactorDivisa;
                                3: //Propina
                                    ImportePropina += PIL.Amount / FactorDivisa;
                                ELSE //Otro
                                    ImporteOtros += PIL.Amount / FactorDivisa;
                            END;
                        END;
                    UNTIL PIL.NEXT = 0;

                //jpg 15-11-2019
                ImporteBase += ImporteGravado + ImporteExento - ImporteSelectivo - ImportePropina - ImporteOtros;
                ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;

                //Busco tipo de retencion
                CLEAR(TipoRetISR);
                HRP.RESET;
                HRP.SETRANGE("No. documento", "No.");
                IF HRP.FINDSET THEN
                    REPEAT
                        CRP.GET(HRP."Codigo Retencion");
                        IF CRP."Tipo retencion ISR" <> 0 THEN
                            TipoRetISR := CRP."Tipo retencion ISR";
                    UNTIL HRP.NEXT = 0;

                //Busco la forma de pago
                IF NOT FormaPago.GET("Payment Method Code") THEN
                    FormaPago.INIT;

                //Se llena la tabla ITBIS
                GpoContProv.GET("Vendor Posting Group");
                CLEAR(ArchITBIS);
                CALCFIELDS("Amount Including VAT", Amount);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS.Dia := FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                               FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR("Pay-to Name", '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                ArchITBIS."Tipo retencion ISR" := TipoRetISR;
                ArchITBIS."Monto Bienes" := ImporteBien;
                ArchITBIS."Monto Servicios" := ImporteServicios;
                ArchITBIS."Monto Selectivo" := ImporteSelectivo;
                ArchITBIS."Monto Propina" := ImportePropina;
                ArchITBIS."Monto otros" := ImporteOtros;
                IF "VAT Registration No." <> '' THEN
                    RNCTxt := DELCHR("VAT Registration No.", '=', '- ')
                ELSE BEGIN
                    Vendor.GET("Buy-from Vendor No.");
                    RNCTxt := DELCHR(Vendor."VAT Registration No.", '=', '- ');
                END;
                RNCTxt := DELCHR(RNCTxt, '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                //DSLoc1.04 jpg 08-07-2020
                ArchITBIS."Total Documento" := ImporteBien + ImporteServicios;
                //ArchITBIS."Total Documento"                 := ImporteBase;


                //DSLoc1.04
                IF rGeneralLedgerSetup."ITBIS al costo activo" THEN
                    ArchITBIS."ITBIS llevado al costo" := ImporteITBIS;

                //DSLoc1.04 jpg 08-07-2020
                ArchITBIS."ITBIS Por adelantar" := ImporteITBIS - ArchITBIS."ITBIS llevado al costo";

                ArchITBIS."ITBIS Pagado" := ImporteITBIS;

                ArchITBIS."ITBIS Retenido" := ITBISRetenido;
                ArchITBIS."ISR Retenido" := ISRRetenido;
                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";

                //Proporcionalidad
                ArchITBIS.Proporcionalidad := Proporcionalidad;

                //DSLoc1.04
                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    IF ArchITBIS."RNC/Cedula" <> '' THEN
                        ArchITBIS."Tipo Identificacion" := 2;
                END;

                //Para calcular el dia de pago
                VLE.RESET;
                VLE.SETRANGE(VLE."Vendor No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                VLE.SETRANGE(VLE."Posting Date", "Posting Date");
                VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Invoice);
                VLE.SETRANGE("Document No.", "No.");
                VLE.SETFILTER("Closed at Date", '<>%1', 0D);
                IF VLE.FINDFIRST THEN BEGIN
                    ArchITBIS."Dia Pago" := FORMAT(VLE."Closed at Date", 0, '<day,2>');
                    //jpg 15-11-2019
                    ArchITBIS."Fecha Pago" := FORMAT(VLE."Closed at Date", 0, '<year4>') + FORMAT(VLE."Closed at Date", 0, '<Month,2>') +
                                                            FORMAT(VLE."Closed at Date", 0, '<day,2>');
                END
                ELSE BEGIN
                    VLE.RESET;
                    VLE.SETRANGE(VLE."Vendor No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                    VLE.SETRANGE(VLE."Posting Date", "Posting Date");
                    VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Invoice);
                    VLE.SETRANGE("Document No.", "No.");
                    IF VLE.FINDFIRST THEN BEGIN
                        VLE1.RESET;
                        VLE1.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                        VLE1.SETRANGE("Document Type", VLE1."Document Type"::Payment);
                        VLE1.SETRANGE("Closed by Entry No.", VLE."Entry No.");
                        IF VLE1.FINDFIRST THEN BEGIN
                            ArchITBIS."Dia Pago" := FORMAT(VLE."Posting Date", 0, '<day,2>');
                            //jpg 15-11-2019
                            ArchITBIS."Fecha Pago" := FORMAT(VLE."Closed at Date", 0, '<year4>') + FORMAT(VLE."Closed at Date", 0, '<Month,2>') +
                                                                 FORMAT(VLE."Closed at Date", 0, '<day,2>');
                        END
                    END
                END;

                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
                CASE "Cod. Clasificacion Gasto" OF
                    '01':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 1; //'01-GASTOS DE PERSONAL'
                    '02':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 2; //'02-GASTOS POR TRABAJOS, SUMINISTROS Y SERVICIOS'
                    '03':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 3; //'03-ARRENDAMIENTOS'
                    '04':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 4; //'04-GASTOS DE ACTIVOS FIJO'
                    '05':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 5; //'05 -GASTOS DE REPRESENTACION'
                    '06':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 6; //'06 -OTRAS DEDUCCIONES ADMITIDAS'
                    '07':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 7; //'07 -GASTOS FINANCIEROS'
                    '08':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 8; //'08 -GASTOS EXTRAORDINARIOS'
                    '09':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 9; //'09 -COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA'
                    '10':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 10; //'10 -ADQUISICIONES DE ACTIVOS'
                    '11':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 11; //'11- GASTOS DE SEGUROS'
                END;
                ArchITBIS."Tipo documento" := 1; //Factura
                ArchITBIS."Codigo reporte" := '606';
                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);

            end;

            trigger OnPreDataItem()
            begin
                InfoEmpresa.GET;
                DirEmpresa[1] := InfoEmpresa.Name;
                DirEmpresa[2] := InfoEmpresa."Name 2";
                DirEmpresa[3] := InfoEmpresa.Address;
                DirEmpresa[4] := InfoEmpresa."Address 2";
                DirEmpresa[5] := InfoEmpresa.City;
                DirEmpresa[6] := InfoEmpresa."Post Code" + ' ' + InfoEmpresa.County;
                DirEmpresa[7] := txt001 + InfoEmpresa."VAT Registration No.";
                COMPRESSARRAY(DirEmpresa);

                FiltroGpoContProv := GETFILTER("Vendor Posting Group");
                //FechaIni          := GETRANGEMIN("Posting Date");
                //FechaFin          := GETRANGEMAX("Posting Date");

                //"G/L Entry".SETRANGE("Posting Date", FechaIni,FechaFin);

                FiltrosPIH := "Purch. Inv. Header".GETFILTERS;
                FiltrosCMH := "Purch. Cr. Memo Hdr.".GETFILTERS;
                FiltrosGLE := "G/L Entry".GETFILTERS;

                IF "G/L Entry".GETFILTER("G/L Account No.") = '' THEN
                    ERROR(Error002, "G/L Entry".FIELDCAPTION("G/L Entry"."G/L Account No."), txt002);
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; 124)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Pay-to Vendor No.", "Posting Date";
            column(VATRegistrationNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."VAT Registration No.")
            {
            }
            column(BuyfromVendorNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
            {
            }
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(PaytoName_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Pay-to Name")
            {
            }
            column(PostingDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(VendorCrMemoNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
            {
            }
            column(NoComprobanteFiscal_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No. Comprobante Fiscal")
            {
            }
            column(NoComprobanteFiscalRel_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No. Comprobante Fiscal Rel.")
            {
            }
            column(ImporteBaseNCr; ImporteBaseNCr)
            {
            }
            column(CodClasifGtoNCr; "Purch. Cr. Memo Hdr."."Cod. Clasificacion Gasto")
            {
            }
            column(ImporteITBISNCr; ImporteITBISNCr)
            {
            }
            column(ImporteGravadoNCr; ImporteGravadoNCr)
            {
            }
            column(ImporteExentoNCr; ImporteExentoNCr)
            {
            }
            column(ImporteTotalNCr; ImporteTotalNCr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECCION') OR (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECTION') OR (COPYSTR("No. Comprobante Fiscal", 1, 6) = 'CORREC') THEN
                    CurrReport.SKIP;

                IF "Applies-to Doc. No." <> '' THEN BEGIN
                    IF PIH.GET("Applies-to Doc. No.") THEN
                        IF (COPYSTR(PIH."No. Comprobante Fiscal", 1, 10) = 'CORRECCION') OR
                           (COPYSTR(PIH."No. Comprobante Fiscal", 1, 10) = 'CORRECTION') OR
                           (COPYSTR(PIH."No. Comprobante Fiscal", 1, 6) = 'CORREC') THEN
                            CurrReport.SKIP;
                END;

                IF "Purch. Cr. Memo Hdr.".Correction THEN
                    CurrReport.SKIP;

                //jpg no facturas en 0 para evitar errores
                CALCFIELDS(Amount);
                IF (Amount = 0) THEN
                    CurrReport.SKIP;

                NCFLiq.DELETEALL;

                ImporteGravadoNCr := 0;
                ImporteExentoNCr := 0;
                ImporteSelectivoNCr := 0;
                ImporteBienNCr := 0;
                ImporteServiciosNCr := 0;
                ImportePropinaNCr := 0;
                ImporteOtrosNCr := 0;
                ITBISRetenidoNCR := 0;
                ISRRetenidoNCR := 0;
                FactorDivisaAdicional := 0;
                FactorDivisa := 0;
                CLEAR(txtCostosGastos);

                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;

                //ISR Retenido
                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionISR);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                    BEGIN
                        IF DivAd THEN //++ 21-11+2019 jpg mod para divisa adicional
                            ISRRetenidoNCR += ABS(GLE."Additional-Currency Amount")
                        ELSE //-- 21-11+2019 jpg mod para divisa adicional
                            ISRRetenidoNCR += ABS(GLE.Amount);
                    END
                    UNTIL GLE.NEXT = 0;


                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionITBIS);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FIND('-') THEN
                    REPEAT
                        IF DivAd THEN //jpg para divisa adicional
                            ITBISRetenidoNCR += ABS(GLE."Additional-Currency Amount")
                        ELSE
                            ITBISRetenidoNCR += ABS(GLE.Amount);
                    UNTIL GLE.NEXT = 0;

                //++ 21-11+2019 jpg mod para divisa adicional
                //si se elige divisa local tenemos que hacer la conversion
                /*IF DivAd THEN
                  BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                    VLE.SETRANGE("Document No.","No.");
                    VLE.SETRANGE("Document Type",GLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.","Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date","Posting Date");
                    VLE.SETRANGE("Bal. Account Type",0);
                    VLE.SETFILTER("Bal. Account No.",CtasRetencionISR);
                    IF VLE.FINDFIRST THEN
                      BEGIN
                        VLE.CALCFIELDS(Amount);
                        ISRRetenido := ABS(VLE.Amount);
                      END;
                  END;
                
                IF DivAd THEN
                  BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                    VLE.SETRANGE("Document No.","No.");
                    VLE.SETRANGE("Document Type",GLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.","Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date","Posting Date");
                    VLE.SETRANGE("Bal. Account Type",0);
                    VLE.SETFILTER("Bal. Account No.",CtasRetencionITBIS);
                    IF VLE.FINDFIRST THEN
                      BEGIN
                        VLE.CALCFIELDS(Amount);
                        ITBISRetenido := ABS(VLE.Amount) ;
                      END;
                  END;*/
                //-- 21-11+2019 jpg mod para divisa adicional

                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::"Credit Memo");
                IF VE.FINDSET THEN
                    REPEAT
                        IF DivAd THEN BEGIN
                            IF VE.Amount <> 0 THEN
                                ImporteGravadoNCr += VE."Additional-Currency Base" * -1
                            ELSE
                                ImporteExentoNCr += VE."Additional-Currency Base" * -1;

                            ImporteITBISNCr += VE."Additional-Currency Amount" * -1;

                            //para capturar factor divisa adicional.
                            IF (FactorDivisaAdicional = 0) AND ("Purch. Cr. Memo Hdr."."Currency Code" = '') THEN
                                FactorDivisaAdicional := ABS((VE."Additional-Currency Base" / VE.Base) * -1);

                        END
                        ELSE BEGIN
                            IF VE.Amount <> 0 THEN
                                ImporteGravadoNCr += VE.Base * -1
                            ELSE
                                ImporteExentoNCr += VE.Base * -1;

                            ImporteITBISNCr += VE.Amount * -1;
                        END;
                    UNTIL VE.NEXT = 0;
                //jpg 15-11-2019
                //ImporteTotalNCr   := ImporteGravadoNCr + ImporteExentoNCr + ImporteITBISNCr;
                //ImporteBaseNCr    := ImporteGravadoNCr + ImporteExentoNCr;

                IF NOT Vendor.GET("Buy-from Vendor No.") THEN
                    Vendor.INIT;

                //Se buscan los importes por su clasificacion en lineas del historico
                PCmL.RESET;
                PCmL.SETRANGE("Document No.", "No.");
                IF PCmL.FINDSET THEN
                    REPEAT
                        IF NOT VPPG.GET(PCmL."VAT Prod. Posting Group") THEN
                            VPPG.INIT;
                        IF DivAd AND ("Currency Code" = '') THEN BEGIN
                            CASE VPPG."Tipo de bien-servicio" OF
                                0: //Bien
                                    ImporteBienNCr += ABS(PCmL.Amount * FactorDivisaAdicional);
                                1: //Servicio
                                    ImporteServiciosNCr += ABS(PCmL.Amount * FactorDivisaAdicional);
                                2: //Selectivo
                                    ImporteSelectivoNCr += ABS(PCmL.Amount * FactorDivisaAdicional);
                                3: //Propina
                                    ImportePropinaNCr += ABS(PCmL.Amount * FactorDivisaAdicional);
                                ELSE //Otro
                                    ImporteOtrosNCr += ABS(PCmL.Amount * FactorDivisaAdicional)
                            END;
                        END ELSE BEGIN
                            ///008 conversion factura otra monedas.
                            IF "Currency Code" <> '' THEN
                                FactorDivisa := "Currency Factor"
                            ELSE
                                FactorDivisa := 1;

                            CASE VPPG."Tipo de bien-servicio" OF
                                0: //Bien
                                    ImporteBienNCr += ABS(PCmL.Amount) / FactorDivisa;
                                1: //Servicio
                                    ImporteServiciosNCr += ABS(PCmL.Amount) / FactorDivisa;
                                2: //Selectivo
                                    ImporteSelectivoNCr += ABS(PCmL.Amount) / FactorDivisa;
                                3: //Propina
                                    ImportePropinaNCr += ABS(PCmL.Amount) / FactorDivisa;
                                ELSE //Otro
                                    ImporteOtrosNCr += ABS(PCmL.Amount) / FactorDivisa;
                            END;
                        END;
                    UNTIL PCmL.NEXT = 0;

                //jpg 15-11-2019
                ImporteBaseNCr := ImporteGravadoNCr + ImporteExentoNCr - ImporteSelectivoNCr - ImportePropinaNCr - ImporteOtrosNCr;
                ImporteTotalNCr := ImporteGravadoNCr + ImporteExentoNCr + ImporteITBISNCr;

                //Busco tipo de retencion
                CLEAR(TipoRetISR);
                HRP.RESET;
                HRP.SETRANGE("No. documento", "No.");
                IF HRP.FINDSET THEN
                    REPEAT
                        CRP.GET(HRP."Codigo Retencion");
                        IF CRP."Tipo retencion ISR" <> 0 THEN
                            TipoRetISR := CRP."Tipo retencion ISR";
                    UNTIL HRP.NEXT = 0;

                //Busco la forma de pago
                IF NOT FormaPago.GET("Payment Method Code") THEN
                    FormaPago.INIT;

                GpoContProv.GET("Vendor Posting Group");
                CLEAR(ArchITBIS);
                CALCFIELDS("Amount Including VAT", Amount);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS.Dia := FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                               FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR("Pay-to Name", '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                ArchITBIS."Tipo retencion ISR" := TipoRetISR;
                ArchITBIS."Monto Bienes" := ImporteBienNCr;
                ArchITBIS."Monto Servicios" := ImporteServiciosNCr;
                ArchITBIS."Monto Selectivo" := ImporteSelectivoNCr;
                ArchITBIS."Monto Propina" := ImportePropinaNCr;
                ArchITBIS."Monto otros" := ImporteOtrosNCr;
                IF "VAT Registration No." <> '' THEN
                    RNCTxt := DELCHR("VAT Registration No.", '=', '- ')
                ELSE BEGIN
                    Vendor.GET("Buy-from Vendor No.");
                    RNCTxt := DELCHR(Vendor."VAT Registration No.", '=', '- ');
                END;
                RNCTxt := DELCHR(RNCTxt, '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);

                //Proporcionalidad
                ArchITBIS.Proporcionalidad := Proporcionalidad;

                //DSLoc1.04
                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    IF ArchITBIS."RNC/Cedula" <> '' THEN
                        ArchITBIS."Tipo Identificacion" := 2;
                END;

                //DSLoc1.04 jpg 08-07-2020
                ArchITBIS."Total Documento" := ImporteBienNCr + ImporteServiciosNCr;
                //ArchITBIS."Total Documento"                 := ImporteBase;

                //DSLoc1.04
                IF rGeneralLedgerSetup."ITBIS al costo activo" THEN
                    ArchITBIS."ITBIS llevado al costo" := ImporteITBISNCr;

                //DSLoc1.04 jpg 08-07-2020
                ArchITBIS."ITBIS Por adelantar" := ImporteITBISNCr - ArchITBIS."ITBIS llevado al costo";

                ArchITBIS."ITBIS Pagado" := ImporteITBISNCr;

                IF ITBISRetenido <> 0 THEN
                    ArchITBIS."Fecha Pago" := ArchITBIS."Fecha Documento";

                ArchITBIS."ITBIS Retenido" := ITBISRetenidoNCR;
                ArchITBIS."ISR Retenido" := ISRRetenidoNCR;
                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                //jpg comentado -- 12-05-2020
                //002 de los NCF relacionados buscamos el del importe mayor
                //Buscamos el mov. proveedor perteneciente al abono.
                /*NCFLiq.RESET;
                IF NCFLiq.FINDSET THEN
                  NCFLiq.DELETEALL;
                
                VLE.RESET;
                VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                VLE.SETRANGE("Vendor No.","Buy-from Vendor No.");
                VLE.SETRANGE("Posting Date","Posting Date");
                VLE.SETRANGE("Document Type",VLE."Document Type"::"Credit Memo");
                VLE.SETRANGE("Document No.","No.");
                IF VLE.FINDFIRST THEN
                  BEGIN
                    //Buscamos los movimientos que la cerraron
                    IF VLE."Closed by Entry No." <> 0 THEN
                      BEGIN
                        IF VLECopy.GET(VLE."Closed by Entry No.") THEN
                          BEGIN
                            //Buscamos el historico de factura para capturar el NCF
                            PIH.RESET;
                            PIH.SETRANGE("No.",VLECopy."Document No.");
                            IF PIH.FINDFIRST THEN
                              BEGIN
                                NCFLiq.NCF := PIH."No. Comprobante Fiscal";
                                IF NOT NCFLiq.INSERT THEN
                                  NCFLiq.MODIFY;
                              END;
                          END;
                      END;
                
                    //Buscamos movimientos cerrados por ella
                    VLECopy.RESET;
                    VLECopy.SETCURRENTKEY("Closed by Entry No.");
                    VLECopy.SETRANGE("Closed by Entry No.",VLE."Entry No.");
                    IF VLECopy.FINDSET(FALSE,FALSE) THEN
                      REPEAT
                        //Buscamos el historico de factura para capturar el NCF
                        PIH.RESET;
                        PIH.SETRANGE("No.",VLECopy."Document No.");
                        IF PIH.FINDFIRST THEN
                          BEGIN
                            NCFLiq.NCF := PIH."No. Comprobante Fiscal";
                            IF NOT NCFLiq.INSERT THEN
                              NCFLiq.MODIFY;
                          END;
                      UNTIL VLECopy.NEXT = 0;
                  END;
                
                NCFLiq.SETCURRENTKEY(NCFLiq.Importe);
                IF NCFLiq.FINDLAST THEN
                  ArchITBIS."NCF Relacionado"         := NCFLiq.NCF;*/
                ArchITBIS."NCF Relacionado" := "No. Comprobante Fiscal Rel."; //jpg-- 12-05-2020

                //ArchITBIS."Clasific. Gastos y Costos NCF" := txtCostosGastos;
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
                CASE "Cod. Clasificacion Gasto" OF
                    '01':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 1; //'01-GASTOS DE PERSONAL'
                    '02':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 2; //'02-GASTOS POR TRABAJOS, SUMINISTROS Y SERVICIOS'
                    '03':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 3; //'03-ARRENDAMIENTOS'
                    '04':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 4; //'04-GASTOS DE ACTIVOS FIJO'
                    '05':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 5; //'05 -GASTOS DE REPRESENTACION'
                    '06':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 6; //'06 -OTRAS DEDUCCIONES ADMITIDAS'
                    '07':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 7; //'07 -GASTOS FINANCIEROS'
                    '08':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 8; //'08 -GASTOS EXTRAORDINARIOS'
                    '09':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 9; //'09 -COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA'
                    '10':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 10; //'10 -ADQUISICIONES DE ACTIVOS'
                    '11':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 11; //'11- GASTOS DE SEGUROS'
                END;
                ArchITBIS."Tipo documento" := 2; //Nota de credito
                ArchITBIS."Codigo reporte" := '606';
                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);

            end;

            trigger OnPreDataItem()
            begin
                CurrReport.PAGENO := 1;
                /*
                SETFILTER("Vendor Posting Group", FiltroGpoContProv);
                SETRANGE("Posting Date", FechaIni,FechaFin);
                IF "Purch. Inv. Header".GETFILTER("Shortcut Dimension 1 Code") <> '' THEN
                   SETFILTER("Shortcut Dimension 1 Code","Purch. Inv. Header".GETFILTER("Shortcut Dimension 1 Code"));
                IF "Purch. Inv. Header".GETFILTER("Shortcut Dimension 2 Code") <> '' THEN
                   SETFILTER("Shortcut Dimension 2 Code","Purch. Inv. Header".GETFILTER("Shortcut Dimension 2 Code"));
                   */
                CurrReport.CREATETOTALS(ImporteBaseNCr, ImporteTotalNCr, ImporteITBISNCr, ImporteExentoNCr, ImporteGravadoNCr);

            end;
        }
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "G/L Account No.";
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(NoComprobanteFiscal_GLEntry; "G/L Entry"."No. Comprobante Fiscal")
            {
            }

            trigger OnAfterGetRecord()
            begin

                //jpg no facturas en 0 para evitar errores
                IF (Amount = 0) THEN
                    CurrReport.SKIP;

                CLEAR(ArchITBIS);
                ArchITBIS."Numero Documento" := "Document No.";
                ArchITBIS.Dia := FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                    FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := '';
                ArchITBIS."Nombre Comercial" := '';
                RNCTxt := DELCHR(InfoEmpresa."VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);

                ArchITBIS."Total Documento" := Amount;
                ArchITBIS."ITBIS Pagado" := 0;
                ArchITBIS."ITBIS llevado al costo" := 0;
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."NCF Relacionado" := '';
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
                CASE "Cod. Clasificacion Gasto" OF
                    '01':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 1; //'01-GASTOS DE PERSONAL'
                    '02':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 2; //'02-GASTOS POR TRABAJOS, SUMINISTROS Y SERVICIOS'
                    '03':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 3; //'03-ARRENDAMIENTOS'
                    '04':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 4; //'04-GASTOS DE ACTIVOS FIJO'
                    '05':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 5; //'05 -GASTOS DE REPRESENTACION'
                    '06':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 6; //'06 -OTRAS DEDUCCIONES ADMITIDAS'
                    '07':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 7; //'07 -GASTOS FINANCIEROS'
                    '08':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 8; //'08 -GASTOS EXTRAORDINARIOS'
                    '09':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 9; //'09 -COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA'
                    '10':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 10; //'10 -ADQUISICIONES DE ACTIVOS'
                    '11':
                        ArchITBIS."Tipo Bienes y Serv. comprados" := 11; //'11- GASTOS DE SEGUROS'
                END;
                ArchITBIS."Codigo reporte" := '606';

                //DSLoc1.04
                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    IF ArchITBIS."RNC/Cedula" <> '' THEN
                        ArchITBIS."Tipo Identificacion" := 2;
                END;


                ArchITBIS."No. Mov." := "Entry No.";
                ArchITBIS.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Posting Date", FechaIni,FechaFin);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(CtasRetencionITBIS; CtasRetencionITBIS)
                {
                    ApplicationArea = All;
                    Caption = 'ITBIS Retention Account';
                    ToolTip = 'ITBIS Retention Account';
                    TableRelation = "G/L Account";
                }
                field(CtasRetencionISR; CtasRetencionISR)
                {
                    ApplicationArea = All;
                    Caption = 'ISR Retention Account';
                    ToolTip = 'ISR Retention Account';
                    TableRelation = "G/L Account";
                }
                field(DivAd; DivAd)
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                    ToolTip = 'Currency';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ArchITBIS.RESET;
        ArchITBIS.SETRANGE("Codigo reporte", '606');
        ArchITBIS.DELETEALL;

        /*
        IF "G/L Entry".GETFILTER("Posting Date") = '' THEN
          ERROR(Error002,"G/L Entry".FIELDCAPTION("Posting Date"),txt002);
        */
        rGeneralLedgerSetup.GET;

    end;

    var
        InfoEmpresa: Record 79;
        GLE: Record 17;
        VLE: Record 25;
        VLE1: Record 25;
        VE: Record 254;
        Vendor: Record 23;
        PIH: Record 122;
        PIL: Record 123;
        PCmL: Record 125;
        VPPG: Record 324;
        ArchITBIS: Record 55959;
        GpoContProv: Record 93;
        NCFLiq: Record 55960 temporary;
        VLECopy: Record 25;
        FormaPago: Record 289;
        CRP: Record 55955;
        HRP: Record 55958;
        DirEmpresa: array[7] of Text[50];
        ImporteBase: Decimal;
        ImporteITBIS: Decimal;
        ImporteGravado: Decimal;
        ImporteExento: Decimal;
        ImporteTotal: Decimal;
        ImporteSelectivo: Decimal;
        ImportePropina: Decimal;
        ImporteBien: Decimal;
        ImporteServicios: Decimal;
        ImporteOtros: Decimal;
        FiltroGpoContProv: Text[150];
        FechaIni: Date;
        FechaFin: Date;
        ImporteBaseNCr: Decimal;
        ImporteITBISNCr: Decimal;
        ImporteGravadoNCr: Decimal;
        ImporteExentoNCr: Decimal;
        ImporteTotalNCr: Decimal;
        ImporteSelectivoNCr: Decimal;
        ImportePropinaNCr: Decimal;
        ImporteBienNCr: Decimal;
        ImporteServiciosNCr: Decimal;
        ImporteOtrosNCr: Decimal;
        ITBISRetenidoNCR: Decimal;
        RNCTxt: Text[30];
        GeneraArchivoITBIS: Boolean;
        Clasificacion: Code[2];
        ITBISRetenido: Decimal;
        CtasRetencionITBIS: Code[100];
        OtrasRetenciones: Decimal;
        CtasRetencionISR: Code[100];
        ISRRetenido: Decimal;
        ISRRetenidoNCR: Decimal;
        txt001: Label 'RNC/Cedula ';
        txtCostosGastos: Text[2];
        DivAd: Boolean;
        FiltrosPIH: Text[1024];
        FiltrosCMH: Text[1024];
        FiltrosGLE: Text[1024];
        txt002: Label 'G/L Entry';
        Error001: Label 'Ya existen registro similares en la tabla de archivo NCF, favor limpiarla';
        Error002: Label 'Filter Required for the field %1 of the table %2';
        TipoRetISR: Integer;
        rGeneralLedgerSetup: Record 98;
        FactorDivisaAdicional: Decimal;
        FactorDivisa: Decimal;
}

