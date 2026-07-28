report 34003002 "ITBIS Ventas (607)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ITBIS Ventas (607).rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("Posting Date");
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

            trigger OnAfterGetRecord()
            begin
                ImporteBase := 0;
                ImporteTotal := 0;
                ImporteITBIS := 0;
                "%ITBIS" := 0;
                ImporteExento := 0;
                ImporteGravado := 0;

                IF DivAd THEN BEGIN
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

                /*Solo funciona para UB
                IF Promocion THEN
                   BEGIN
                    ImporteITBIS    := 0;
                    ImporteGravado  := 0;
                    VPSetup.RESET;
                    VPSetup.SETRANGE("VAT Bus. Posting Group","VAT Bus. Posting Group");
                    VPSetup.FINDFIRST;
                
                    GLE.RESET;
                    GLE.SETCURRENTKEY("Posting Date",Description);
                    GLE.SETRANGE("G/L Account No.",VPSetup."Sales VAT Account");
                    GLE.SETFILTER("Posting Date",FiltroFecha);
                    GLE.SETFILTER(Description,'%1','*' + "No." + '*');
                    IF GLE.FINDSET THEN
                       REPEAT
                        ImporteITBIS += GLE.Amount *-1;
                       UNTIL GLE.NEXT = 0;
                
                
                     GLE.RESET;
                     GLE.SETCURRENTKEY("Document No.","Posting Date");
                     GLE.SETRANGE("Document No.","No.");
                     GLE.SETRANGE("Posting Date","Posting Date");
                     GLE.SETFILTER("Debit Amount",'<>%1',0);
                     IF GLE.FINDSET THEN
                       REPEAT
                        ImporteGravado += GLE."Debit Amount";
                       UNTIL GLE.NEXT = 0;
                
                    SIL.RESET;
                    SIL.SETRANGE("Document No.","No.");
                    SIL.SETFILTER(Quantity,'<>%1',0);
                    SIL.SETRANGE(Amount,0);
                    SIL.SETRANGE(Type,SIL.Type::Item);
                    SIL.SETFILTER("No.",'<>%1','');
                    IF SIL.FINDFIRST THEN
                       BEGIN
                         IF SIL."Posting Group" = 'POP' THEN
                            BEGIN
                              ImporteGravado := 0;
                              ImporteITBIS := 0;
                            END;
                       END;
                
                
                {
                    SIL.RESET;
                    SIL.SETRANGE("Document No.","No.");
                    SIL.SETFILTER(Quantity,'<>%1',0);
                    SIL.SETRANGE(Amount,0);
                    SIL.SETRANGE(Type,SIL.Type::Item);
                    SIL.SETFILTER("No.",'<>%1','');
                    IF SIL.FINDSET THEN
                       REPEAT
                        ImporteGravado += SIL."Unit Cost (LCY)" * SIL.Quantity;
                       UNTIL SIL.NEXT = 0;
                    ImporteGravado := ROUND(ImporteGravado,0.01);
                }
                   END;
                */

                ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;
                ImporteBase += ImporteGravado + ImporteExento;

                tImporteBase += ABS(ImporteBase);
                tImporteTotal += ABS(ImporteTotal);
                tImporteITBIS += ABS(ImporteITBIS);
                tImporteGravado += ABS(ImporteGravado);
                tImporteExento += ABS(ImporteExento);

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    Cust.INIT;

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
        }
        dataitem("Sales Cr.Memo Header"; 114)
        {
            DataItemTableView = SORTING("No.");
            column(NoComprobanteFiscal_SalesCrMemoHeader; "No. Comprobante Fiscal")
            {
            }
            column(NoComprobanteFiscalRel_SalesCrMemoHeader; "No. Comprobante Fiscal Rel.")
            {
            }
            column(No_SalesCrMemoHeader; "No.")
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

            trigger OnAfterGetRecord()
            begin
                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;
                "%ITBISNCr" := 0;
                ImporteGravadoNCr := 0;
                ImporteExentoNCr := 0;

                IF DivAd THEN BEGIN
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
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

                /*GRN Solo funciona para UB
                IF Promocion THEN
                   BEGIN
                    ImporteITBIS := 0;
                    VPSetup.RESET;
                    VPSetup.SETRANGE("VAT Bus. Posting Group","VAT Bus. Posting Group");
                    VPSetup.FINDFIRST;
                
                    GLE.RESET;
                    GLE.SETCURRENTKEY("Posting Date",Description);
                    GLE.SETRANGE("G/L Account No.",VPSetup."Sales VAT Account");
                    GLE.SETFILTER("Posting Date",FiltroFecha);
                    GLE.SETFILTER(Description,'%1','*' + "No." + '*');
                    IF GLE.FINDSET THEN
                       REPEAT
                        ImporteITBIS += GLE.Amount;
                       UNTIL GLE.NEXT = 0;
                   END;
                */
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

                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);

            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", "Sales Invoice Header".GETFILTER("Posting Date"));
                IF "Sales Invoice Header".GETFILTER("Customer Posting Group") <> '' THEN
                    SETFILTER("Customer Posting Group", "Sales Invoice Header".GETFILTER("Customer Posting Group"));
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

                IF DivAd THEN BEGIN
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
                    VE.SETCURRENTKEY("Document No.", "Posting Date");
                    VE.SETRANGE("Document No.", "No.");
                    VE.SETRANGE("Posting Date", "Posting Date");
                    VE.SETRANGE(VE."Document Type", VE."Document Type"::Invoice);
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
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."NCF Relacionado" := "No. Comprobante Fiscal Rel.";
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
        dataitem(DtldCustEntry; 379)
        {
            column(NoComprobanteFiscalDtldCustEntry; ' ')
            {
            }
            column(NoComprobanteFiscalRelDtldCustEntry; ' ')
            {
            }
            column(No_DtldCustEntry; DtldCustEntry."Document No.")
            {
            }
            column(BilltoCustomerNoDtldCustEntry; ' ')
            {
            }
            column(BilltoNameDtldCustEntry; ' ')
            {
            }
            column(PostingDatDtldCustEntry; "Posting Date")
            {
            }
            column(RNCCliente_NCRDtldCustEntry; Cust."VAT Registration No.")
            {
            }
            column(ImporteBaseNCrDtldCustEntry; ImporteBaseNCr)
            {
            }
            column(ImporteITBISNCrDtldCustEntry; ImporteITBISNCr)
            {
            }
            column(ImporteGravadoNCrDtldCustEntry; ImporteGravadoNCr)
            {
            }
            column(ImporteExentoNCrDtldCustEntry; ImporteExentoNCr)
            {
            }
            column(ImporteTotalNCrDtldCustEntry; ImporteTotalNCr)
            {
            }
        }
    }

    requestpage
    {

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
        ImporteTotalCta: Decimal;
        ImporteGpoCta: Decimal;
        ImporteGpo: Decimal;
        DebeGpo: Decimal;
        HaberGpo: Decimal;
        FiltroGpoContProv: Text[30];
        FechaIni: Date;
        FechaFin: Date;
        ImporteBaseNCr: Decimal;
        "%ITBISNCr": Decimal;
        ImporteITBISNCr: Decimal;
        ImporteGravadoNCr: Decimal;
        ImporteExentoNCr: Decimal;
        ImporteTotalNCr: Decimal;
        ImporteGpoNCr: Decimal;
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
}

