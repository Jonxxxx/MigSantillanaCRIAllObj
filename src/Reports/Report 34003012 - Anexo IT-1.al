report 34003012 "Anexo IT-1"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Anexo IT-1.rdl';
    Caption = 'Anexo IT-1';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Posting Date");
            RequestFilterFields = "Posting Date", "Customer Posting Group", "Shortcut Dimension 1 Code";

            trigger OnAfterGetRecord()
            begin
                IF Correction THEN
                    CurrReport.SKIP;

                IF COPYSTR("No. Comprobante Fiscal", 1, 6) = 'CORREC' THEN
                    CurrReport.SKIP;

                IF "No. Comprobante Fiscal" <> '' THEN
                    NCF := COPYSTR("No. Comprobante Fiscal", 10, 2)
                ELSE
                    /*
                    IF ("No. Comprobante Fiscal" = '') AND ("No. Comprobante Fiscal Borr." <> '') THEN
                       BEGIN
                        "No. Comprobante Fiscal" := "No. Comprobante Fiscal Borr.";
                        NCF := COPYSTR("No. Comprobante Fiscal",10,2);
                       END
                    ELSE
                    */
                   NCF := '99';

                //IF (STRPOS("Sell-to Customer No.",'CONTADO') <> 0) AND (NCF = '02') THEN
                //   CurrReport.SKIP;
                ImporteVta := 0;
                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::Invoice);
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ImporteVta += ABS(VE.Base)
                    UNTIL VE.NEXT = 0;

                CASE NCF OF
                    '01':
                        BEGIN
                            Importe[1] += ImporteVta;
                            Cantidad[1] += 1;
                        END;
                    '02':
                        BEGIN
                            Importe[2] += ImporteVta;
                            Cantidad[2] += 1;
                        END;
                    '03':
                        BEGIN
                            Importe[3] += ImporteVta;
                            Cantidad[3] += 1;
                        END;
                    '11' .. '12':
                        BEGIN
                            Importe[5] += ImporteVta;
                            Cantidad[5] += 1;
                        END;
                    '14':
                        BEGIN
                            Importe[6] += ImporteVta;
                            Cantidad[6] += 1;
                        END;
                    '15':
                        BEGIN
                            Importe[7] += ImporteVta;
                            Cantidad[7] += 1;
                        END;
                /*'99' :
                  BEGIN
                   Importe[8] += Amount;
                   Cantidad[8] += 1;
                  END;
               */
                END;

                IF PaymtMethod.GET("Payment Method Code") THEN BEGIN
                    IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"1 - Efectivo" THEN
                        Importe[8] += ImporteVta
                    ELSE
                        IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"3 - Tarjeta Credito/Debito" THEN
                            Importe[10] += ImporteVta
                        ELSE
                            IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"4 - Compra a credito" THEN
                                Importe[11] += ImporteVta
                            ELSE
                                IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"2 - Cheques/Transferencias/Depositos" THEN
                                    Importe[9] += ImporteVta;
                END;

            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Importe);
                CLEAR(Cantidad);

                Filtros := GETFILTERS;
                FechaDesde := GETRANGEMIN("Posting Date");
                FechaHasta := GETRANGEMAX("Posting Date");
            end;
        }
        dataitem("Service Invoice Header"; 5992)
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Posting Date");

            trigger OnAfterGetRecord()
            begin
                IF "No. Comprobante Fiscal" <> '' THEN
                    NCF := COPYSTR("No. Comprobante Fiscal", 10, 2)
                ELSE
                    /*
                    IF ("No. Comprobante Fiscal" = '') AND ("No. Comprobante Fiscal Borr." <> '') THEN
                       BEGIN
                        "No. Comprobante Fiscal" := "No. Comprobante Fiscal Borr.";
                        NCF := COPYSTR("No. Comprobante Fiscal",10,2);
                       END
                    ELSE
                    */
                   NCF := '99';

                //IF (STRPOS("Sell-to Customer No.",'CONTADO') <> 0) AND (NCF = '02') THEN
                //   CurrReport.SKIP;
                ImporteVta := 0;
                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::Invoice);
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ImporteVta += ABS(VE.Base)
                    UNTIL VE.NEXT = 0;

                CASE NCF OF
                    '01':
                        BEGIN
                            Importe[1] += ImporteVta;
                            Cantidad[1] += 1;
                        END;
                    '02':
                        BEGIN
                            Importe[2] += ImporteVta;
                            Cantidad[2] += 1;
                        END;
                    '03':
                        BEGIN
                            Importe[3] += ImporteVta;
                            Cantidad[3] += 1;
                        END;
                    '11' .. '12':
                        BEGIN
                            Importe[5] += ImporteVta;
                            Cantidad[5] += 1;
                        END;
                    '14':
                        BEGIN
                            Importe[6] += ImporteVta;
                            Cantidad[6] += 1;
                        END;
                    '15':
                        BEGIN
                            Importe[7] += ImporteVta;
                            Cantidad[7] += 1;
                        END;
                /*'99' :
                  BEGIN
                   Importe[8] += Amount;
                   Cantidad[8] += 1;
                  END;
               */
                END;

                IF PaymtMethod.GET("Payment Method Code") THEN BEGIN
                    IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"1 - Efectivo" THEN
                        Importe[8] += ImporteVta
                    ELSE
                        IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"3 - Tarjeta Credito/Debito" THEN
                            Importe[10] += ImporteVta
                        ELSE
                            IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"4 - Compra a credito" THEN
                                Importe[11] += ImporteVta
                            ELSE
                                IF PaymtMethod."Forma de pago DGII" = PaymtMethod."Forma de pago DGII"::"2 - Cheques/Transferencias/Depositos" THEN
                                    Importe[9] += ImporteVta;
                END;

            end;

            trigger OnPreDataItem()
            begin
                //CLEAR(Importe);
                //CLEAR(Cantidad);
                SETFILTER("Posting Date", "Sales Invoice Header".GETFILTER("Posting Date"));
                IF "Sales Invoice Header".GETFILTER("Customer Posting Group") <> '' THEN
                    SETFILTER("Customer Posting Group", "Sales Invoice Header".GETFILTER("Customer Posting Group"));

                Filtros := GETFILTERS;
            end;
        }
        dataitem("Sales Cr.Memo Header"; 114)
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Posting Date");

            trigger OnAfterGetRecord()
            begin
                IF Correction THEN
                    CurrReport.SKIP;

                IF "No. Comprobante Fiscal" <> '' THEN
                    NCF := COPYSTR("No. Comprobante Fiscal", 2, 2)
                ELSE
                    NCF := '99';

                ImporteVta := 0;
                VE.RESET;
                VE.SETCURRENTKEY("Document No.", "Posting Date");
                VE.SETRANGE("Document No.", "No.");
                VE.SETRANGE("Posting Date", "Posting Date");
                VE.SETRANGE("Document Type", VE."Document Type"::"Credit Memo");
                IF VE.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        ImporteVta += ABS(VE.Base)
                    UNTIL VE.NEXT = 0;

                Importe[4] += ImporteVta;
                Cantidad[4] += 1;

                IF "No. Comprobante Fiscal Rel." <> '' THEN BEGIN
                    "Sales Invoice Header".RESET;
                    "Sales Invoice Header".SETCURRENTKEY("No. Comprobante Fiscal");
                    "Sales Invoice Header".SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal Rel.");

                    "Service Invoice Header".RESET;
                    "Service Invoice Header".SETCURRENTKEY("No. Comprobante Fiscal");
                    "Service Invoice Header".SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal Rel.");

                    IF "Sales Invoice Header".FINDFIRST THEN BEGIN
                        Dias := "Posting Date" - "Sales Invoice Header"."Posting Date";
                        IF Dias > 30 THEN BEGIN
                            Importe[15] += ImporteVta;
                            //           MESSAGE('%1',"Sales Invoice Header"."No.");
                        END;
                    END
                    ELSE
                        IF "Service Invoice Header".FINDFIRST THEN BEGIN

                            Dias := "Posting Date" - "Service Invoice Header"."Posting Date";
                            IF Dias > 30 THEN BEGIN
                                Importe[15] += ImporteVta;
                                //         MESSAGE('%1',"Service Invoice Header"."No.");
                            END;
                        END

                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", "Sales Invoice Header".GETFILTER("Posting Date"));
                IF "Sales Invoice Header".GETFILTER("Customer Posting Group") <> '' THEN
                    SETFILTER("Customer Posting Group", "Sales Invoice Header".GETFILTER("Customer Posting Group"));
            end;
        }
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(Nombre_Empresa; COMPANYNAME)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Fecha_Desde; FechaDesde)
            {
            }
            column(Fecha_Hasta; FechaHasta)
            {
            }
            column(USERID; USERID)
            {
            }
            column(ncfvalido_txt; ncfvalidotxt)
            {
            }
            column(ncfconsfinal_txt; ncfconsfinaltxt)
            {
            }
            column(ncfnotadb_txt; ncfnotadbtxt)
            {
            }
            column(ncfnotacr_txt; ncfnotacrtxt)
            {
            }
            column(ncfunicoingreso_txt; ncfunicoingresotxt)
            {
            }
            column(ncfregesp_txt; ncfregesptxt)
            {
            }
            column(ncfgobierno_txt; ncfgobiernotxt)
            {
            }
            column(noncf_txt; noncftxt)
            {
            }
            column(Efectivo_txt; Efectivotxt)
            {
            }
            column(Cheque_txt; Chequetxt)
            {
            }
            column(Tarjeta_txt; Tarjetatxt)
            {
            }
            column(ACredito_txt; ACreditotxt)
            {
            }
            column(Bonos_txt; Bonostxt)
            {
            }
            column(Permutas_txt; Permutastxt)
            {
            }
            column(Otros_txt; Otrostxt)
            {
            }
            column(NotasCr_txt; NotasCrtxt)
            {
            }
            column(importe_1; Importe[1])
            {
            }
            column(importe_2; Importe[2])
            {
            }
            column(importe_3; Importe[3])
            {
            }
            column(importe_4; Importe[4])
            {
            }
            column(importe_5; Importe[5])
            {
            }
            column(importe_6; Importe[6])
            {
            }
            column(importe_7; Importe[7])
            {
            }
            column(importe_8; Importe[8])
            {
            }
            column(importe_9; Importe[9])
            {
            }
            column(importe_10; Importe[10])
            {
            }
            column(importe_11; Importe[11])
            {
            }
            column(importe_12; Importe[12])
            {
            }
            column(importe_13; Importe[13])
            {
            }
            column(importe_14; Importe[14])
            {
            }
            column(importe_15; Importe[15])
            {
            }
            column(importe_16; Importe[16])
            {
            }
            column(Cantidad_1; Cantidad[1])
            {
            }
            column(Cantidad_2; Cantidad[2])
            {
            }
            column(Cantidad_3; Cantidad[3])
            {
            }
            column(Cantidad_4; Cantidad[4])
            {
            }
            column(Cantidad_5; Cantidad[5])
            {
            }
            column(Cantidad_6; Cantidad[6])
            {
            }
            column(Cantidad_7; Cantidad[7])
            {
            }
            column(Cantidad_8; Cantidad[8])
            {
            }
            column(Cantidad_9; Cantidad[9])
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

    var
        PaymtMethod: Record 289;
        VE: Record 254;
        NCF: Code[2];
        Importe: array[16] of Decimal;
        ncfvalidotxt: Label '1.- VALIDO PARA CREDITO FISCAL';
        ncfconsfinaltxt: Label '2.- CONSUMIDOR FINAL';
        ncfnotadbtxt: Label '3.- NOTA DE DEBITO';
        ncfnotacrtxt: Label '4.- NOTA DE CREDITO';
        ncfunicoingresotxt: Label '5.- REGISTRO UNICO DE INGRESOS';
        ncfregesptxt: Label '6.- REGISTRO REGIMENES ESPECIALES';
        ncfgobiernotxt: Label '7.- GUBERNAMENTALES';
        noncftxt: Label 'NO REQUIERE COMPROBANTES';
        Efectivotxt: Label '11.- EFECTIVO';
        Chequetxt: Label '12.- CHEQUE / TRANSFERENCIA';
        Tarjetatxt: Label '13.- TARJETA DEBITO / CREDITO';
        ACreditotxt: Label '14.- A CREDITO';
        Bonostxt: Label '15.- BONOS O CERTIFICADOS DE REGALO';
        Permutastxt: Label '16.- PERMUTAS';
        Otrostxt: Label '17.- OTRAS FORMAS DE PAGO';
        NotasCrtxt: Label '50.- NOTAS DE CREDITOS EMITIDAS CON MAS DE 30 DIAS DESDE LA FACTURACION';
        Cantidad: array[9] of Decimal;
        Filtros: Text[1020];
        Dias: Integer;
        ImporteVta: Decimal;
        FechaDesde: Date;
        FechaHasta: Date;
}

