report 34003014 "ITBIS Ventas 2018 (607)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/ITBIS Ventas 2018 (607).rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Posting Date")
                                WHERE(Correction = CONST(false));
            RequestFilterFields = "Posting Date", "Customer Posting Group", "Shortcut Dimension 1 Code";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(NoComprobanteFiscal_SalesInvoiceHeader; "Sales Invoice Header"."No. Comprobante Fiscal")
            {
            }
            column(RNCCliente; Cust."VAT Registration No.")
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
            column(ImporteITBIS; ImporteITBIS)
            {
            }
            column(ImporteTotal; ImporteTotal)
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
            column(FiltrosSIH; FiltrosSIH)
            {
            }
            column(FiltrosSCMH; FiltrosSCMH)
            {
            }
            column(ImporteITBIS16; ImporteITBIS16)
            {
            }
            column(ImporteITBIS18; ImporteITBIS18)
            {
            }
            column(BaseITBIS16; BaseITBIS16)
            {
            }
            column(BaseITBIS18; BaseITBIS18)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteBase := 0;
                ImporteTotal := 0;
                ImporteITBIS := 0;
                "%ITBIS" := 0;
                ImporteExento := 0;
                ImporteGravado := 0;
                ImporteGravado := 0;
                ImporteExento := 0;
                ImporteSelectivo := 0;
                ImporteBien := 0;
                ImporteServicios := 0;
                ImportePropina := 0;
                ImporteOtros := 0;
                ITBISRetenido := 0;

                CALCFIELDS("Amount Including VAT", Amount);
                IF "Amount Including VAT" = 0 THEN
                    CurrReport.SKIP;

                IF "No. Comprobante Fiscal" = '' THEN
                    CurrReport.SKIP;

                //para excluir las que tiene corregida.
                SCMH.RESET;
                SCMH.SETRANGE("No. Comprobante Fiscal Rel.", "No. Comprobante Fiscal");
                SCMH.SETRANGE(Correction, TRUE);
                SCMH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                IF SCMH.FINDFIRST THEN
                    CurrReport.SKIP;


                IF DivAd THEN BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN
                                ImporteGravado += ABS(VE."Additional-Currency Base")
                            ELSE
                                ImporteExento += ABS(VE."Additional-Currency Base");

                            ImporteITBIS += VE."Additional-Currency Amount";
                        UNTIL VE.NEXT = 0;
                END
                ELSE BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN BEGIN
                                ImporteGravado += VE.Base * -1;
                                ImporteITBIS += VE.Amount * -1;
                            END
                            ELSE
                                ImporteExento += VE.Base * -1;
                        UNTIL VE.NEXT = 0;
                END;

                ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;
                ImporteBase += ImporteGravado + ImporteExento;

                tImporteBase += ABS(ImporteBase);
                tImporteTotal += ABS(ImporteTotal);
                tImporteITBIS += ABS(ImporteITBIS);
                tImporteGravado += ABS(ImporteGravado);
                tImporteExento += ABS(ImporteExento);

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    Cust.INIT;


                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::Invoice);
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF NOT VPPG.GET(VE."VAT Prod. Posting Group") THEN
                            VPPG.INIT;
                        CASE VPPG."Tipo de bien-servicio" OF
                            0: //Bien
                                ImporteBien += VE.Base * -1;
                            1: //Servicio
                                ImporteServicios += VE.Base * -1;
                            2: //Selectivo
                                ImporteSelectivo += VE.Base * -1;
                            3: //Propina
                                ImportePropina += VE.Base * -1;
                            ELSE //Otro
                                ImporteOtros += VE.Base * -1;
                        END;
                    UNTIL VE.NEXT = 0;

                //Busco la forma de pago
                IF NOT FormaPago.GET("Payment Method Code") OR ("Payment Method Code" = '') THEN
                    FormaPago."Forma de pago DGII" := FormaPago."Forma de pago DGII"::"2 - Cheques/Transferencias/Depositos";


                //Se llena la tabla de ITBIS
                GCC.GET("Customer Posting Group");
                CLEAR(ArchITBIS);
                CALCFIELDS("Amount Including VAT", Amount);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                    FORMAT("Posting Date", 0, '<day,2>');

                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := ImporteBase;
                ArchITBIS."ITBIS Pagado" := ABS(ImporteITBIS);
                ArchITBIS."Fecha Pago" := ArchITBIS."Fecha Documento";
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."Tipo documento" := 1; //Factura
                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";
                ArchITBIS."Tipo de ingreso" := DELCHR("Tipo de ingreso", '=', '0');
                ArchITBIS."Monto Bienes" := ImporteBien;
                ArchITBIS."Monto Servicios" := ImporteServicios;
                ArchITBIS."Monto Selectivo" := ImporteSelectivo;
                ArchITBIS."Monto Propina" := ImportePropina;
                ArchITBIS."Monto otros" := ImporteOtros;
                ArchITBIS."Codigo reporte" := '607';
                CASE FormaPago."Forma de pago DGII" OF
                    1:
                        ArchITBIS."Monto Efectivo" := ImporteTotal;
                    2:
                        ArchITBIS."Monto Cheque" := ImporteTotal;
                    3:
                        ArchITBIS."Monto tarjetas" := ImporteTotal;
                    4:
                        ArchITBIS."Venta a credito" := ImporteTotal;
                    5:
                        ArchITBIS."Venta bonos" := ImporteTotal;
                    6:
                        ArchITBIS."Venta Permuta" := ImporteTotal;
                    7:
                        BEGIN //jpg pago mixto +
                            CLEAR(ImporteTotal2);
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE("Document No.", "No.");
                            CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::" ", CustLedgerEntry."Document Type"::Payment);
                            CustLedgerEntry.SETRANGE("Posting Date", "Posting Date");
                            IF CustLedgerEntry.FINDSET THEN
                                REPEAT

                                    CLEAR(ImporteTotal2);
                                    DetailedCustLedgEntry.RESET;
                                    DetailedCustLedgEntry.SETRANGE("Ledger Entry Amount", TRUE);
                                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                                    DetailedCustLedgEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                                    DetailedCustLedgEntry.CALCSUMS(Amount);
                                    ImporteTotal2 := ABS(DetailedCustLedgEntry.Amount);

                                    FormaPago.RESET;
                                    FormaPago.SETRANGE(Code, DELCHR(SELECTSTR(2, CustLedgerEntry.Description), '=', ' '));
                                    IF FormaPago.FINDFIRST THEN
                                        CASE FormaPago."Forma de pago DGII" OF
                                            1:
                                                ArchITBIS."Monto Efectivo" += ImporteTotal2;
                                            2:
                                                ArchITBIS."Monto Cheque" += ImporteTotal2;
                                            3:
                                                ArchITBIS."Monto tarjetas" += ImporteTotal2;
                                            4:
                                                ArchITBIS."Venta a credito" += ImporteTotal2;
                                            5:
                                                ArchITBIS."Venta bonos" += ImporteTotal2;
                                            6:
                                                ArchITBIS."Venta Permuta" += ImporteTotal2;
                                        END;

                                UNTIL CustLedgerEntry.NEXT = 0;
                            // ArchITBIS."Monto mixto" := "amount including vat";
                        END
                END;
                //jpg pago mixto --

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;


                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;
        }
        dataitem("Sales Cr.Memo Header"; 114)
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("No.")
                                WHERE(Correction = CONST(false));
            RequestFilterFields = "Posting Date", "Customer Posting Group", "Shortcut Dimension 1 Code";
            column(NoComprobanteFiscal_SalesCrMemoHeader; "Sales Cr.Memo Header"."No. Comprobante Fiscal")
            {
            }
            column(NoComprobanteFiscalRel_SalesCrMemoHeader; "Sales Cr.Memo Header"."No. Comprobante Fiscal Rel.")
            {
            }
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(RNCCliente_NCR; Cust."VAT Registration No.")
            {
            }
            column(ImporteBaseNCr; ImporteBaseNCr)
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
            column(ImporteITBIS16NCr; ImporteITBIS16NCr)
            {
            }
            column(ImporteITBIS18NCr; ImporteITBIS18NCr)
            {
            }
            column(BaseITBIS16NCr; BaseITBIS16NCr)
            {
            }
            column(BaseITBIS18NCr; BaseITBIS18NCr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;
                "%ITBISNCr" := 0;
                ImporteGravadoNCr := 0;
                ImporteExentoNCr := 0;

                //para excluir las que tiene corregida.
                SIH.RESET;
                SIH.SETRANGE("No. Comprobante Fiscal Rel.", "No. Comprobante Fiscal");
                SIH.SETRANGE(Correction, TRUE);
                SIH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                IF SIH.FINDFIRST THEN
                    CurrReport.SKIP;

                IF "No. Comprobante Fiscal" = '' THEN
                    CurrReport.SKIP;

                IF DivAd THEN BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::"Credit Memo");
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN
                                ImporteGravadoNCr += ABS(VE."Additional-Currency Base")
                            ELSE
                                ImporteExentoNCr += ABS(VE."Additional-Currency Base");

                            ImporteITBISNCr += VE."Additional-Currency Amount";
                        UNTIL VE.NEXT = 0;
                END
                ELSE BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::"Credit Memo");
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN BEGIN
                                ImporteGravadoNCr += VE.Base;
                                ImporteITBISNCr += VE.Amount;
                            END
                            ELSE
                                ImporteExentoNCr += VE.Base;
                        UNTIL VE.NEXT = 0;
                END;

                ImporteTotalNCr := ImporteGravadoNCr + ImporteExentoNCr + ImporteITBISNCr;
                ImporteBaseNCr := ImporteGravadoNCr + ImporteExentoNCr;

                tImporteBase += ABS(ImporteBaseNCr);
                tImporteTotal += ABS(ImporteTotalNCr);
                tImporteITBIS += ABS(ImporteITBISNCr);
                tImporteGravado += ABS(ImporteGravadoNCr);
                tImporteExento += ABS(ImporteExentoNCr);

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    Cust.INIT;



                //Se llena la tabla de ITIBS
                CLEAR(ArchITBIS);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                       FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := ImporteBaseNCr;
                ArchITBIS."ITBIS Pagado" := ABS(ImporteITBISNCr);
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."NCF Relacionado" := "No. Comprobante Fiscal Rel.";
                ArchITBIS."Tipo documento" := 2; //Nota de credito
                ArchITBIS."Codigo reporte" := '607';

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;

                //jpg 03-08-2020 ++
                //Busco la forma de pago
                //Busco la forma de pago
                IF NOT FormaPago.GET("Payment Method Code") OR ("Payment Method Code" = '') THEN
                    FormaPago."Forma de pago DGII" := FormaPago."Forma de pago DGII"::"2 - Cheques/Transferencias/Depositos";


                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";

                CASE FormaPago."Forma de pago DGII" OF
                    1:
                        ArchITBIS."Monto Efectivo" := ImporteTotalNCr;
                    2:
                        ArchITBIS."Monto Cheque" := ImporteTotalNCr;
                    3:
                        ArchITBIS."Monto tarjetas" := ImporteTotalNCr;
                    4:
                        ArchITBIS."Venta a credito" := ImporteTotalNCr;
                    5:
                        ArchITBIS."Venta bonos" := ImporteTotalNCr;
                    6:
                        ArchITBIS."Venta Permuta" := ImporteTotalNCr;
                    7:
                        BEGIN //jpg pago mixto +
                            CLEAR(ImporteTotal2);
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE("Document No.", "No.");
                            CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::" ", CustLedgerEntry."Document Type"::Payment);
                            CustLedgerEntry.SETRANGE("Posting Date", "Posting Date");
                            IF CustLedgerEntry.FINDSET THEN
                                REPEAT

                                    CLEAR(ImporteTotal2);
                                    DetailedCustLedgEntry.RESET;
                                    DetailedCustLedgEntry.SETRANGE("Ledger Entry Amount", TRUE);
                                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                                    DetailedCustLedgEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                                    DetailedCustLedgEntry.CALCSUMS(Amount);
                                    ImporteTotal2 := ABS(DetailedCustLedgEntry.Amount);

                                    FormaPago.RESET;
                                    FormaPago.SETRANGE(Code, DELCHR(SELECTSTR(2, CustLedgerEntry.Description), '=', ' '));
                                    IF FormaPago.FINDFIRST THEN
                                        CASE FormaPago."Forma de pago DGII" OF
                                            1:
                                                ArchITBIS."Monto Efectivo" += ImporteTotal2;
                                            2:
                                                ArchITBIS."Monto Cheque" += ImporteTotal2;
                                            3:
                                                ArchITBIS."Monto tarjetas" += ImporteTotal2;
                                            4:
                                                ArchITBIS."Venta a credito" += ImporteTotal2;
                                            5:
                                                ArchITBIS."Venta bonos" += ImporteTotal2;
                                            6:
                                                ArchITBIS."Venta Permuta" += ImporteTotal2;
                                        END;

                                UNTIL CustLedgerEntry.NEXT = 0;
                            // ArchITBIS."Monto mixto" := "amount including vat";
                        END
                END;
                //jpg pago mixto --


                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;

            trigger OnPreDataItem()
            begin
                /*GRN
                SETFILTER("Posting Date","Sales Invoice Header".GETFILTER("Posting Date"));
                IF "Sales Invoice Header".GETFILTER("Customer Posting Group") <> '' THEN
                   SETFILTER("Customer Posting Group","Sales Invoice Header".GETFILTER("Customer Posting Group"));
                */

            end;
        }
        dataitem("Service Invoice Header"; 5992)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "Customer Posting Group";
            column(No_SalesInvoiceHeader_S; "Service Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader_S; "Service Invoice Header"."Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader_S; "Service Invoice Header"."Bill-to Name")
            {
            }
            column(PostingDate_SalesInvoiceHeader_S; "Service Invoice Header"."Posting Date")
            {
            }
            column(NoComprobanteFiscal_SalesInvoiceHeader_S; "Service Invoice Header"."No. Comprobante Fiscal")
            {
            }
            column(RNCCliente_S; Cust."VAT Registration No.")
            {
            }
            column(ImporteBase_S; ImporteBase)
            {
            }
            column(ImporteExento_S; ImporteExento)
            {
            }
            column(ImporteGravado_S; ImporteGravado)
            {
            }
            column(ImporteITBIS_S; ImporteITBIS)
            {
            }
            column(ImporteTotal_S; ImporteTotal)
            {
            }
            column(DirEmpresa1_S; DirEmpresa[1])
            {
            }
            column(DirEmpresa2_S; DirEmpresa[2])
            {
            }
            column(DirEmpresa3_S; DirEmpresa[3])
            {
            }
            column(DirEmpresa4_S; DirEmpresa[4])
            {
            }
            column(FiltrosSIH_S; FiltrosSIH)
            {
            }
            column(FiltrosSCMH_S; FiltrosSCMH)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteBase := 0;
                ImporteTotal := 0;
                ImporteITBIS := 0;
                "%ITBIS" := 0;
                ImporteExento := 0;
                ImporteGravado := 0;
                ImporteSelectivo := 0;
                ImporteBien := 0;
                ImporteServicios := 0;
                ImportePropina := 0;
                ImporteOtros := 0;
                ITBISRetenido := 0;

                CALCFIELDS("Amount Including VAT", Amount);
                IF "Amount Including VAT" = 0 THEN
                    CurrReport.SKIP;

                IF "No. Comprobante Fiscal" = '' THEN
                    CurrReport.SKIP;

                //para excluir las que tiene corregida.
                SCMH.RESET;
                SCMH.SETRANGE("No. Comprobante Fiscal Rel.", "No. Comprobante Fiscal");
                SCMH.SETRANGE(Correction, TRUE);
                SCMH.SETRANGE("Sell-to Customer No.", "Customer No.");
                IF SCMH.FINDFIRST THEN
                    CurrReport.SKIP;


                IF DivAd THEN BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN
                                ImporteGravado += ABS(VE."Additional-Currency Base")
                            ELSE
                                ImporteExento += ABS(VE."Additional-Currency Base");

                            ImporteITBIS += VE."Additional-Currency Amount";
                        UNTIL VE.NEXT = 0;
                END
                ELSE BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN BEGIN
                                ImporteGravado += VE.Base * -1;
                                ImporteITBIS += VE.Amount * -1;
                            END
                            ELSE
                                ImporteExento += VE.Base * -1;
                        UNTIL VE.NEXT = 0;
                END;

                ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;
                ImporteBase += ImporteGravado + ImporteExento;

                tImporteBase += ABS(ImporteBase);
                tImporteTotal += ABS(ImporteTotal);
                tImporteITBIS += ABS(ImporteITBIS);
                tImporteGravado += ABS(ImporteGravado);
                tImporteExento += ABS(ImporteExento);

                IF NOT Cust.GET("Customer No.") THEN
                    Cust.INIT;

                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::Invoice);
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        IF NOT VPPG.GET(VE."VAT Prod. Posting Group") THEN
                            VPPG.INIT;
                        CASE VPPG."Tipo de bien-servicio" OF
                            0: //Bien
                                ImporteBien += VE.Base * -1;
                            1: //Servicio
                                ImporteServicios += VE.Base * -1;
                            2: //Selectivo
                                ImporteSelectivo += VE.Base * -1;
                            3: //Propina
                                ImportePropina += VE.Base * -1;
                            ELSE //Otro
                                ImporteOtros += VE.Base * -1;
                        END;
                    UNTIL VE.NEXT = 0;

                //Se llena la tabla de ITBIS
                GCC.GET("Customer Posting Group");
                CLEAR(ArchITBIS);
                CALCFIELDS("Amount Including VAT", Amount);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                    FORMAT("Posting Date", 0, '<day,2>');

                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := ImporteBase;
                ArchITBIS."ITBIS Pagado" := ABS(ImporteITBIS);
                ArchITBIS."Fecha Pago" := ArchITBIS."Fecha Documento";
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."Tipo documento" := 1; //Factura
                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";
                ArchITBIS."Tipo de ingreso" := DELCHR("Tipo de ingreso", '=', '0');
                ArchITBIS."Monto Bienes" := ImporteBien;
                ArchITBIS."Monto Servicios" := ImporteServicios;
                ArchITBIS."Monto Selectivo" := ImporteSelectivo;
                ArchITBIS."Monto Propina" := ImportePropina;
                ArchITBIS."Monto otros" := ImporteOtros;
                ArchITBIS."Codigo reporte" := '607';
                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;

                IF NOT FormaPago.GET("Payment Method Code") OR ("Payment Method Code" = '') THEN
                    FormaPago."Forma de pago DGII" := FormaPago."Forma de pago DGII"::"2 - Cheques/Transferencias/Depositos";


                ArchITBIS."Forma de pago DGII" := FormaPago."Forma de pago DGII";

                CASE FormaPago."Forma de pago DGII" OF
                    1:
                        ArchITBIS."Monto Efectivo" := ImporteTotalNCr;
                    2:
                        ArchITBIS."Monto Cheque" := ImporteTotalNCr;
                    3:
                        ArchITBIS."Monto tarjetas" := ImporteTotalNCr;
                    4:
                        ArchITBIS."Venta a credito" := ImporteTotalNCr;
                    5:
                        ArchITBIS."Venta bonos" := ImporteTotalNCr;
                    6:
                        ArchITBIS."Venta Permuta" := ImporteTotalNCr;
                    7:
                        BEGIN //jpg pago mixto +
                            CLEAR(ImporteTotal2);
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE("Document No.", "No.");
                            CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::" ", CustLedgerEntry."Document Type"::Payment);
                            CustLedgerEntry.SETRANGE("Posting Date", "Posting Date");
                            IF CustLedgerEntry.FINDSET THEN
                                REPEAT

                                    CLEAR(ImporteTotal2);
                                    DetailedCustLedgEntry.RESET;
                                    DetailedCustLedgEntry.SETRANGE("Ledger Entry Amount", TRUE);
                                    DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                                    DetailedCustLedgEntry.SETRANGE("Posting Date", CustLedgerEntry."Posting Date");
                                    DetailedCustLedgEntry.CALCSUMS(Amount);
                                    ImporteTotal2 := ABS(DetailedCustLedgEntry.Amount);

                                    FormaPago.RESET;
                                    FormaPago.SETRANGE(Code, DELCHR(SELECTSTR(2, CustLedgerEntry.Description), '=', ' '));
                                    IF FormaPago.FINDFIRST THEN
                                        CASE FormaPago."Forma de pago DGII" OF
                                            1:
                                                ArchITBIS."Monto Efectivo" += ImporteTotal2;
                                            2:
                                                ArchITBIS."Monto Cheque" += ImporteTotal2;
                                            3:
                                                ArchITBIS."Monto tarjetas" += ImporteTotal2;
                                            4:
                                                ArchITBIS."Venta a credito" += ImporteTotal2;
                                            5:
                                                ArchITBIS."Venta bonos" += ImporteTotal2;
                                            6:
                                                ArchITBIS."Venta Permuta" += ImporteTotal2;
                                        END;

                                UNTIL CustLedgerEntry.NEXT = 0;
                            // ArchITBIS."Monto mixto" := "amount including vat";
                        END
                END;
                //jpg pago mixto --

                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;

            trigger OnPreDataItem()
            begin
                FiltrosSIH_S := "Service Invoice Header".GETFILTERS;
                FiltrosSCMH_S := "Service Cr.Memo Header".GETFILTERS;

                IF "Service Invoice Header".GETFILTER("Posting Date") = '' THEN
                    ERROR(Error002, "Service Invoice Header".FIELDCAPTION("Posting Date"));

                //FiltroFecha := "Service Invoice Header".GETFILTER("Posting Date");
            end;
        }
        dataitem("Service Cr.Memo Header"; 5994)
        {
            DataItemTableView = SORTING("No.");
            column(NoComprobanteFiscal_SalesCrMemoHeader_S; "Service Cr.Memo Header"."No. Comprobante Fiscal")
            {
            }
            column(NoComprobanteFiscalRel_SalesCrMemoHeader_S; "Service Cr.Memo Header"."No. Comprobante Fiscal Rel.")
            {
            }
            column(No_SalesCrMemoHeader_S; "Service Cr.Memo Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader_S; "Service Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesCrMemoHeader_S; "Service Cr.Memo Header"."Bill-to Name")
            {
            }
            column(PostingDate_SalesCrMemoHeader_S; "Service Cr.Memo Header"."Posting Date")
            {
            }
            column(RNCCliente_NCR_S; Cust."VAT Registration No.")
            {
            }
            column(ImporteBaseNCr_S; ImporteBaseNCr)
            {
            }
            column(ImporteITBISNCr_S; ImporteITBISNCr)
            {
            }
            column(ImporteGravadoNCr_S; ImporteGravadoNCr)
            {
            }
            column(ImporteExentoNCr_S; ImporteExentoNCr)
            {
            }
            column(ImporteTotalNCr_S; ImporteTotalNCr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;
                "%ITBISNCr" := 0;
                ImporteGravadoNCr := 0;
                ImporteExentoNCr := 0;

                IF DivAd THEN BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::"Credit Memo");
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN
                                ImporteGravadoNCr += ABS(VE."Additional-Currency Base")
                            ELSE
                                ImporteExentoNCr += ABS(VE."Additional-Currency Base");

                            ImporteITBISNCr += VE."Additional-Currency Amount";
                        UNTIL VE.NEXT = 0;
                END
                ELSE BEGIN
                    VE.RESET;
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::"Credit Memo");
                    IF VE.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF VE.Amount <> 0 THEN BEGIN
                                ImporteGravadoNCr += VE.Base;
                                ImporteITBISNCr += VE.Amount;
                            END
                            ELSE
                                ImporteExentoNCr += VE.Base;
                        UNTIL VE.NEXT = 0;
                END;

                ImporteTotalNCr := ImporteGravadoNCr + ImporteExentoNCr + ImporteITBISNCr;
                ImporteBaseNCr := ImporteGravadoNCr + ImporteExentoNCr;

                tImporteBase += ABS(ImporteBaseNCr);
                tImporteTotal += ABS(ImporteTotalNCr);
                tImporteITBIS += ABS(ImporteITBISNCr);
                tImporteGravado += ABS(ImporteGravadoNCr);
                tImporteExento += ABS(ImporteExentoNCr);

                IF NOT Cust.GET("Customer No.") THEN
                    Cust.INIT;

                //Se llena la tabla de ITIBS
                CLEAR(ArchITBIS);
                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                       FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := ImporteBaseNCr;
                ArchITBIS."ITBIS Pagado" := ABS(ImporteITBISNCr);
                //ArchITBIS.NCF                       := "No. Comprobante Fiscal";
                //ArchITBIS."NCF Relacionado"         := "No. Comprobante Fiscal Rel.";
                ArchITBIS."Codigo reporte" := '607';

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;

                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", "Service Invoice Header".GETFILTER("Posting Date"));
                IF "Service Invoice Header".GETFILTER("Customer Posting Group") <> '' THEN
                    SETFILTER("Customer Posting Group", "Service Invoice Header".GETFILTER("Customer Posting Group"));
            end;
        }
        dataitem("Cust. Ledger Entry"; 21)
        {
            DataItemTableView = SORTING("Closed by Entry No.")
                                ORDER(Descending)
                                WHERE(Open = CONST(false),
                                      "Pmt. Disc. Given (LCY)" = FILTER(> 0),
                                      "No. Comprobante Fiscal DPP" = FILTER(<> ''));
            column(PostingDate_DetailedCustLedgEntry; rDetailedMovCliente."Posting Date")
            {
            }
            column(DocumentNo_DetailedCustLedgEntry; rDetailedMovCliente."Document No.")
            {
            }
            column(AmountLCY_DetailedCustLedgEntry; "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)")
            {
            }
            column(NoComprobanteFiscal_DetailedCustLedgEntry; "Cust. Ledger Entry"."No. Comprobante Fiscal DPP")
            {
            }
            column(RNCClientedt; Cust."VAT Registration No.")
            {
            }
            column(NoComprobanteFiscalRel_DetailedCustLedgEntry; "Cust. Ledger Entry"."No. Comprobante Fiscal")
            {
            }
            column(ImporteBaseNCrDetailedCustLedgEntry; ImporteBaseNCr)
            {
            }
            column(ImporteITBISNCrDetailedCustLedgEntry; ImporteITBISNCr)
            {
            }
            column(ImporteGravadoNCrDetailedCustLedgEntry; ImporteGravadoNCr)
            {
            }
            column(ImporteExentoNCrDetailedCustLedgEntry; ImporteExentoNCr)
            {
            }
            column(ImporteTotalNCrDetailedCustLedgEntry; ImporteTotalNCr)
            {
            }
            column(BilltoNameDetailedCustLedgEntry; Cust.Name)
            {
            }
            column(NoDetailedCustLedgEntry; Cust."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;
                "%ITBISNCr" := 0;
                ImporteGravadoNCr := 0;
                ImporteExentoNCr := 0;
                //para excluir las que tiene corregida.
                SIH.RESET;
                SIH.SETRANGE("No. Comprobante Fiscal Rel.", "No. Comprobante Fiscal");
                SIH.SETRANGE(Correction, TRUE);
                SIH.SETRANGE("Sell-to Customer No.", "Customer No.");
                IF SIH.FINDFIRST THEN
                    CurrReport.SKIP;

                ImporteTotalNCr := ABS("Pmt. Disc. Given (LCY)");
                ImporteBaseNCr := ImporteTotalNCr;
                ImporteExentoNCr := ImporteTotalNCr;

                tImporteBase += ABS(ImporteBaseNCr);
                tImporteTotal += ABS(ImporteTotalNCr);
                tImporteITBIS += ABS(ImporteITBISNCr);
                tImporteGravado += ABS(ImporteGravadoNCr);
                tImporteExento += ABS(ImporteTotalNCr);

                IF NOT Cust.GET("Customer No.") THEN
                    Cust.INIT;

                rDetailedMovCliente.RESET;
                rDetailedMovCliente.SETRANGE("Cust. Ledger Entry No.", "Cust. Ledger Entry"."Closed by Entry No.");
                rDetailedMovCliente.SETRANGE("Entry Type", rDetailedMovCliente."Entry Type"::"Payment Discount");
                //rDetailedMovCliente.SETFILTER("Posting Date","Sales Cr.Memo Header".GETFILTER("Posting Date"));
                IF NOT rDetailedMovCliente.FINDFIRST THEN
                    CurrReport.SKIP;

                //Se llena la tabla de ITIBS
                CLEAR(ArchITBIS);
                ArchITBIS."Numero Documento" := rDetailedMovCliente."Document No.";
                ArchITBIS."No. Mov." := "Entry No.";
                ArchITBIS."Fecha Documento" := FORMAT(rDetailedMovCliente."Posting Date", 0, '<year4>') + FORMAT(rDetailedMovCliente."Posting Date", 0, '<Month,2>') +
                                                       FORMAT(rDetailedMovCliente."Posting Date", 0, '<day,2>');
                ArchITBIS.Apellidos := '';
                ArchITBIS.Nombres := '';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR(Cust.Name, 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR(Cust."VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := ImporteBaseNCr;
                ArchITBIS."ITBIS Pagado" := ABS(ImporteITBISNCr);
                ArchITBIS.NCF := "No. Comprobante Fiscal DPP";
                ArchITBIS."NCF Relacionado" := "No. Comprobante Fiscal";
                ArchITBIS."Tipo documento" := 2; //Nota de credito
                ArchITBIS."Codigo reporte" := '607';

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;


                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;

            trigger OnPreDataItem()
            begin
                /*FiltrosNCDPP  := "Cust. Ledger Entry".GETFILTERS;
                
                IF "Cust. Ledger Entry".GETFILTER("Posting Date") = '' THEN
                  ERROR(Error002,"Cust. Ledger Entry".FIELDCAPTION("Posting Date"));
                
                FiltroFecha := "Cust. Ledger Entry".GETFILTER("Posting Date");
                SETFILTER("Posting Date",'');*/
                SETFILTER("Cust. Ledger Entry"."Pmt. Discount Date", "Sales Cr.Memo Header".GETFILTER("Posting Date"));
                SETFILTER("Cust. Ledger Entry"."Customer Posting Group", "Sales Cr.Memo Header".GETFILTER("Customer Posting Group"));

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
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
        ArchITBIS.SETRANGE("Codigo reporte", '607');
        ArchITBIS.DELETEALL;

        InfoEmpresa.GET;
        DirEmpresa[1] := InfoEmpresa.Name;
        DirEmpresa[2] := InfoEmpresa."Name 2";
        DirEmpresa[3] := InfoEmpresa.Address;
        DirEmpresa[4] := InfoEmpresa."Address 2";
        DirEmpresa[5] := InfoEmpresa.City;
        DirEmpresa[6] := InfoEmpresa."Post Code" + ' ' + InfoEmpresa.County;
        DirEmpresa[7] := txt001 + InfoEmpresa."VAT Registration No.";
        COMPRESSARRAY(DirEmpresa);

        FiltrosSIH := "Sales Invoice Header".GETFILTERS;
        FiltrosSCMH := "Sales Cr.Memo Header".GETFILTERS;

        IF "Sales Invoice Header".GETFILTER("Posting Date") = '' THEN
            ERROR(Error002, "Sales Invoice Header".FIELDCAPTION("Posting Date"));

        //IF "Sales Cr.Memo Header".GETFILTER("Posting Date") = '' THEN
        //  ERROR(Error002,"Sales Cr.Memo Header".FIELDCAPTION("Posting Date"));

        FiltroFecha := "Sales Invoice Header".GETFILTER("Posting Date");
    end;

    var
        Cust: Record 18;
        ArchITBIS: Record 34003004;
        GCC: Record 92;
        InfoEmpresa: Record 79;
        VE: Record 254;
        GLE: Record 17;
        VPSetup: Record 325;
        SIL: Record 113;
        FormaPago: Record 289;
        VPPG: Record 324;
        DirEmpresa: array[7] of Text[50];
        ImporteBase: Decimal;
        "%ITBIS": Decimal;
        ImporteITBIS: Decimal;
        ImporteGravado: Decimal;
        ImporteExento: Decimal;
        ImporteTotal: Decimal;
        ImporteBaseCta: Decimal;
        "%ITBISCta": Decimal;
        ImporteITBISCta: Decimal;
        ImporteGravadoCta: Decimal;
        ImporteExentoCta: Decimal;
        ImporteSelectivo: Decimal;
        ImportePropina: Decimal;
        ImporteBien: Decimal;
        ImporteServicios: Decimal;
        ImporteOtros: Decimal;
        FiltroGpoContProv: Text[30];
        FechaIni: Date;
        FechaFin: Date;
        ImporteBaseNCr: Decimal;
        "%ITBISNCr": Decimal;
        ImporteITBISNCr: Decimal;
        ImporteGravadoNCr: Decimal;
        ImporteExentoNCr: Decimal;
        ImporteTotalNCr: Decimal;
        DivAd: Boolean;
        RNCTxt: Text[30];
        GeneraArchivoITBIS: Boolean;
        Clasificacion: Code[2];
        ITBISRetenido: Decimal;
        CtasRetencionITBIS: Text[30];
        NoDoc: Code[20];
        tImporteBase: Decimal;
        tImporteITBIS: Decimal;
        tImporteGravado: Decimal;
        tImporteExento: Decimal;
        tImporteTotal: Decimal;
        DivisaAdicional: Boolean;
        RNCCliente: Text[30];
        txt001: Label 'RNC/Cedula ';
        Error001: Label 'Please Delete all the files in the NCF Table';
        FiltrosSIH: Text[1024];
        FiltrosSCMH: Text[1024];
        txt002: Label 'Sales Invoice Header';
        txt003: Label 'Sales Cr.Memo Header';
        Error002: Label 'Filter Required for the field %1 of the table %2';
        FiltrosSIH_S: Text[1024];
        FiltrosSCMH_S: Text[1024];
        FiltroFecha: Text[60];
        ImporteITBIS16: Decimal;
        ImporteITBIS18: Decimal;
        BaseITBIS16: Decimal;
        BaseITBIS18: Decimal;
        BaseExento: Decimal;
        ImporteITBIS16NCr: Decimal;
        ImporteITBIS18NCr: Decimal;
        BaseITBIS16NCr: Decimal;
        BaseITBIS18NCr: Decimal;
        BaseExentoNCr: Decimal;
        SCMH: Record 114;
        SIH: Record 112;
        rDetailedMovCliente: Record 379;
        FiltrosHDPP: Text[1024];
        CustLedgerEntry: Record 21;
        DetailedCustLedgEntry: Record 379;
        ImporteTotal2: Decimal;
}

