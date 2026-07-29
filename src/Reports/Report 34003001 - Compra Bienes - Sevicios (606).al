report 34003001 "Compra Bienes - Sevicios (606)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Compra Bienes - Sevicios (606).rdl';

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
                IF (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECCION') OR (COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECTION') THEN
                    CurrReport.SKIP;

                ImporteBase := 0;
                ImporteTotal := 0;
                ImporteITBIS := 0;
                ISRRetenido := 0;
                ImporteGravado := 0;
                ImporteExento := 0;
                "%ITBIS" := 0;
                ITBISRetenido := 0;
                ISRRetenido := 0;
                OtrasRetenciones := 0;
                CLEAR(txtCostosGastos);

                //ISR Retenido
                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionISR);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ISRRetenido += GLE.Amount * -1;
                    UNTIL GLE.NEXT = 0;

                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionITBIS);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FIND('-') THEN
                    REPEAT
                        ITBISRetenido += GLE.Amount * -1;
                    UNTIL GLE.NEXT = 0;

                //si se elige divisa local tenemos que hacer la conversion
                IF DivAd THEN BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    VLE.SETRANGE("Document No.", "No.");
                    VLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date", "Posting Date");
                    VLE.SETRANGE("Bal. Account Type", 0);
                    VLE.SETFILTER("Bal. Account No.", CtasRetencionITBIS);
                    IF VLE.FINDFIRST THEN BEGIN
                        VLE.CALCFIELDS(Amount);
                        ITBISRetenido := VLE.Amount * -1;
                    END;
                END;

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

                ImporteBase += ImporteGravado + ImporteExento;
                ImporteTotal := ImporteGravado + ImporteExento + ImporteITBIS;

                IF NOT Vendor.GET("Buy-from Vendor No.") THEN
                    Vendor.INIT;


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
                ArchITBIS."Total Documento" := ImporteBase;
                ArchITBIS."ITBIS Pagado" := ImporteITBIS;
                ArchITBIS."ITBIS Retenido" := ITBISRetenido;
                ArchITBIS."ISR Retenido" := ISRRetenido;

                IF ArchITBIS.RNC <> '' THEN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC
                ELSE
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;

                //Para calcular el dia de pago
                VLE.RESET;
                VLE.SETRANGE(VLE."Vendor No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                VLE.SETRANGE(VLE."Posting Date", "Posting Date");
                VLE.SETRANGE(VLE."Document Type", VLE."Document Type"::Invoice);
                VLE.SETRANGE("Document No.", "No.");
                VLE.SETFILTER("Closed at Date", '<>%1', 0D);
                IF VLE.FINDFIRST THEN
                    ArchITBIS."Dia Pago" := FORMAT(VLE."Closed at Date", 0, '<day,2>')
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
                        IF VLE1.FINDFIRST THEN
                            ArchITBIS."Dia Pago" := FORMAT(VLE."Posting Date", 0, '<day,2>');
                    END
                END;

                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
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
                FechaIni := GETRANGEMIN("Posting Date");
                FechaFin := GETRANGEMAX("Posting Date");
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; 124)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
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
            column(PorcentITBISNCr; "%ITBISNCr")
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
            column(ImporteGpoNCr; ImporteGpoNCr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF COPYSTR("No. Comprobante Fiscal", 1, 10) = 'CORRECCION' THEN
                    CurrReport.SKIP;

                IF "Applies-to Doc. No." <> '' THEN BEGIN
                    IF PIH.GET("Applies-to Doc. No.") THEN
                        IF (COPYSTR(PIH."No. Comprobante Fiscal", 1, 10) = 'CORRECCION') OR
                           (COPYSTR(PIH."No. Comprobante Fiscal", 1, 10) = 'CORRECTION') THEN
                            CurrReport.SKIP;
                END;

                IF "Purch. Cr. Memo Hdr."."Correccion Doc. NCF" THEN
                    CurrReport.SKIP;

                ImporteBaseNCr := 0;
                ImporteTotalNCr := 0;
                ImporteITBISNCr := 0;
                "%ITBISNCr" := 0;
                ISRRetenidoNCR := 0;

                //Retencion ISR
                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionISR);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ISRRetenidoNCR += GLE.Amount;
                    UNTIL GLE.NEXT = 0;
                //Retencion ISR


                //Retencion ITBIS
                GLE.RESET;
                GLE.SETFILTER("G/L Account No.", CtasRetencionITBIS);
                GLE.SETRANGE("Posting Date", "Posting Date");
                GLE.SETRANGE("Document Type", GLE."Document Type"::Payment);
                GLE.SETRANGE("Document No.", "No.");
                IF GLE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ITBISRetenidoNCR += GLE.Amount;
                    UNTIL GLE.NEXT = 0;
                //Retencion ITBIS

                IF DivAd THEN BEGIN
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    VLE.SETRANGE("Document No.", "No.");
                    VLE.SETRANGE("Document Type", VLE."Document Type"::Payment);
                    VLE.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                    VLE.SETRANGE("Posting Date", "Posting Date");
                    VLE.SETRANGE("Bal. Account Type", 0);
                    VLE.SETRANGE("Bal. Account No.", CtasRetencionITBIS);
                    IF VLE.FINDFIRST THEN BEGIN
                        VLE.CALCFIELDS(Amount);
                        ITBISRetenidoNCR := VLE.Amount;
                    END;
                END;


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
                        END
                        ELSE BEGIN
                            IF VE.Amount <> 0 THEN
                                ImporteGravadoNCr += VE.Base * -1
                            ELSE
                                ImporteExentoNCr += VE.Base * -1;

                            ImporteITBISNCr += VE.Amount * -1;
                        END;
                    UNTIL VE.NEXT = 0;

                ImporteTotalNCr := ImporteGravadoNCr + ImporteExentoNCr + ImporteITBISNCr;
                ImporteBaseNCr := ImporteGravadoNCr + ImporteExentoNCr;

                IF NOT Vendor.GET("Buy-from Vendor No.") THEN
                    Vendor.INIT;

                //Se llena la tabla ITBIS
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
                RNCTxt := DELCHR(Vendor."VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                ArchITBIS."Total Documento" := Amount;
                ArchITBIS."ITBIS Pagado" := "Amount Including VAT" - Amount;
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."ITBIS Retenido" := ITBISRetenidoNCR;
                ArchITBIS."ISR Retenido" := ISRRetenidoNCR;


                IF ArchITBIS.RNC <> '' THEN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC
                ELSE
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;


                //002 de los NCF relacionados buscamos el del importe mayor
                //Buscamos el mov. cliente perteneciente al abono.
                NCFLiq.RESET;
                IF NCFLiq.FINDSET THEN
                    NCFLiq.DELETEALL;

                VLE.RESET;
                VLE.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                VLE.SETRANGE("Vendor No.", "Buy-from Vendor No.");
                VLE.SETRANGE("Posting Date", "Posting Date");
                VLE.SETRANGE("Document Type", VLE."Document Type"::"Credit Memo");
                VLE.SETRANGE("Document No.", "No.");
                IF VLE.FINDFIRST THEN BEGIN
                    //Buscamos los movimientos que la cerraron
                    IF VLE."Closed by Entry No." <> 0 THEN BEGIN
                        IF VLECopy.GET(VLE."Closed by Entry No.") THEN BEGIN
                            //Buscamos el historico de factura para capturar el NCF
                            PIH.RESET;
                            PIH.SETRANGE("No.", VLECopy."Document No.");
                            IF PIH.FINDFIRST THEN BEGIN
                                NCFLiq.NCF := PIH."No. Comprobante Fiscal";
                                IF NOT NCFLiq.INSERT THEN
                                    NCFLiq.MODIFY;
                            END;
                        END;
                    END;

                    //Buscamos movimientos cerrados por ella
                    VLECopy.RESET;
                    VLECopy.SETCURRENTKEY("Closed by Entry No.");
                    VLECopy.SETRANGE("Closed by Entry No.", VLE."Entry No.");
                    IF VLECopy.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            //Buscamos el historico de factura para capturar el NCF
                            PIH.RESET;
                            PIH.SETRANGE("No.", VLECopy."Document No.");
                            IF PIH.FINDFIRST THEN BEGIN
                                NCFLiq.NCF := PIH."No. Comprobante Fiscal";
                                IF NOT NCFLiq.INSERT THEN
                                    NCFLiq.MODIFY;
                            END;
                        UNTIL VLECopy.NEXT = 0;
                END;

                NCFLiq.SETCURRENTKEY(NCFLiq.Importe);
                IF NCFLiq.FIND('+') THEN
                    ArchITBIS."NCF Relacionado" := NCFLiq.NCF;

                NCFLiq.RESET;
                IF NCFLiq.FIND('-') THEN
                    REPEAT
                        NCFLiq.DELETE;
                    UNTIL NCFLiq.NEXT = 0;

                //ArchITBIS."Clasific. Gastos y Costos NCF" := txtCostosGastos;
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
                ArchITBIS."Tipo documento" := 2; //Nota de credito
                ArchITBIS."Codigo reporte" := '606';
                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.PAGENO := 1;

                SETFILTER("Vendor Posting Group", FiltroGpoContProv);
                SETRANGE("Posting Date", FechaIni, FechaFin);
                IF "Purch. Inv. Header".GETFILTER("Shortcut Dimension 1 Code") <> '' THEN
                    SETFILTER("Shortcut Dimension 1 Code", "Purch. Inv. Header".GETFILTER("Shortcut Dimension 1 Code"));
                IF "Purch. Inv. Header".GETFILTER("Shortcut Dimension 2 Code") <> '' THEN
                    SETFILTER("Shortcut Dimension 2 Code", "Purch. Inv. Header".GETFILTER("Shortcut Dimension 2 Code"));

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
                ArchITBIS.NCF := "No. Comprobante Fiscal";
                ArchITBIS."NCF Relacionado" := '';
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Cod. Clasificacion Gasto";
                ArchITBIS."Codigo reporte" := '606';

                IF ArchITBIS.RNC <> '' THEN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC
                ELSE
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                ArchITBIS."No. Mov." := "Entry No.";
                ArchITBIS.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", FechaIni, FechaFin);
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
                    Caption = 'ITBIS Retention Account';
                    TableRelation = "G/L Account";
                }
                field(CtasRetencionISR; CtasRetencionISR)
                {
                    Caption = 'ISR Retention Account';
                    TableRelation = "G/L Account";
                }
                field(DivAd; DivAd)
                {
                    Caption = 'Currency';
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

        FiltrosPIH := "Purch. Inv. Header".GETFILTERS;
        FiltrosCMH := "Purch. Cr. Memo Hdr.".GETFILTERS;
        FiltrosGLE := "G/L Entry".GETFILTERS;

        IF "G/L Entry".GETFILTER("G/L Account No.") = '' THEN
            ERROR(Error002, "G/L Entry".FIELDCAPTION("G/L Entry"."G/L Account No."), txt002);

        IF "G/L Entry".GETFILTER("Posting Date") = '' THEN
            ERROR(Error002, "G/L Entry".FIELDCAPTION("Posting Date"), txt002);
    end;

    var
        InfoEmpresa: Record 79;
        DirEmpresa: array[7] of Text[50];
        ImporteBase: Decimal;
        "%ITBIS": Decimal;
        ImporteITBIS: Decimal;
        ImporteGravado: Decimal;
        ImporteExento: Decimal;
        ImporteTotal: Decimal;
        ImporteGpo: Decimal;
        DebeGpo: Decimal;
        HaberGpo: Decimal;
        FiltroGpoContProv: Text[150];
        FechaIni: Date;
        FechaFin: Date;
        ImporteBaseNCr: Decimal;
        "%ITBISNCr": Decimal;
        ImporteITBISNCr: Decimal;
        ImporteGravadoNCr: Decimal;
        ImporteExentoNCr: Decimal;
        ImporteTotalNCr: Decimal;
        ImporteGpoNCr: Decimal;
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
        GLE: Record 17;
        DivAd: Boolean;
        VLE: Record 25;
        VLE1: Record 25;
        VE: Record 254;
        Vendor: Record 23;
        PIH: Record 122;
        ITBISRetenidoNCR: Decimal;
        ArchITBIS: Record 34003004;
        FiltrosPIH: Text[1024];
        FiltrosCMH: Text[1024];
        FiltrosGLE: Text[1024];
        GpoContProv: Record 93;
        txt002: Label 'G/L Entry';
        Error001: Label 'Ya existen registro similares en la tabla de archivo NCF, favor limpiarla';
        Error002: Label 'Filter Required for the field %1 of the table %2';
        NCFLiq: Record 34003005;
        VLECopy: Record 25;
}

