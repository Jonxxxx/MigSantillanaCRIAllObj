report 56056 "Reporte de posicion bancos"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Reporte de posicion bancos.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Cabecera; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending);
            MaxIteration = 1;
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(wTxtMoneda; wTxtMoneda)
            {
            }
            column(wFechaBalance; wFechaBalance)
            {
            }
            column(wTipoCambioDR; wTipoCambioDR)
            {
                DecimalPlaces = 0 : 5;
            }
            column(TODAY; TODAY)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(TIME; TIME)
            {
                AutoFormatType = 0;
            }
            column(REPORTE_POSICION_EN_BANCOSCaption; REPORTE_POSICION_EN_BANCOSCaptionLbl)
            {
            }
            column(Cuenta_bancariaCaption; Cuenta_bancariaCaptionLbl)
            {
            }
            column("Saldo_inicial_del_diaCaption"; Saldo_inicial_del_diaCaptionLbl)
            {
            }
            column(IngresosCaption; IngresosCaptionLbl)
            {
            }
            column(EgresosCaption; EgresosCaptionLbl)
            {
            }
            column(Saldo_en_librosCaption; Saldo_en_librosCaptionLbl)
            {
            }
            column(MonedaCaption; MonedaCaptionLbl)
            {
            }
            column("Al_DiaCaption"; Al_DiaCaptionLbl)
            {
            }
            column(Tipo_de_CambioCaption; Tipo_de_CambioCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(Cabecera_Number; Number)
            {
            }
            dataitem("Bank Account"; 270)
            {
                DataItemTableView = SORTING("Currency Code")
                                    ORDER(Descending);
                column(Bank_Account__Currency_Code_; "Currency Code")
                {
                }
                column(No________Name; wNombre1)
                {
                }
                column(wSaldoInicial; wSaldoInicial)
                {
                }
                column(wIngresos; wIngresos)
                {
                }
                column(wEgresos; wEgresos)
                {
                }
                column(Bank_Account__Net_Change_; "Net Change")
                {
                }
                column(wNombre2; wNombre2)
                {
                }
                column(Bank_Account__Net_Change__Control1000000012; "Net Change")
                {
                }
                column(MONEDACaption_Control1000000007; MONEDACaption_Control1000000007Lbl)
                {
                }
                column(TotalesCaption; TotalesCaptionLbl)
                {
                }
                column(Bank_Account_No_; "No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    lrBank: Record 270;
                    lrMov: Record 271;
                begin
                    CLEAR(wSaldoInicial);
                    CLEAR(wIngresos);
                    CLEAR(wEgresos);

                    IF "Bank Account No." <> '' THEN BEGIN
                        wNombre1 := COPYSTR("No.", 1, 3) + ' ' + "Bank Account No.";
                        wNombre2 := "Search Name";
                    END
                    ELSE BEGIN
                        wNombre1 := Name;
                        wNombre2 := "Search Name";
                    END;

                    lrBank.RESET;
                    lrBank.GET("Bank Account"."No.");
                    lrBank.SETRANGE("Date Filter", 0D, wFechaBalance - 1);
                    lrBank.CALCFIELDS("Net Change");
                    wSaldoInicial := lrBank."Net Change";

                    //... Se calculan los ingresos y egresos en la fecha de balance.
                    lrMov.RESET;
                    lrMov.SETCURRENTKEY("Bank Account No.", "Posting Date");
                    lrMov.SETRANGE("Bank Account No.", "Bank Account"."No.");
                    lrMov.SETRANGE("Posting Date", wFechaBalance);
                    lrMov.SETFILTER(Amount, '>=%1', 0);
                    IF lrMov.FIND('-') THEN
                        REPEAT
                            wIngresos := wIngresos + lrMov.Amount;
                        UNTIL lrMov.NEXT = 0;

                    lrMov.SETFILTER(Amount, '<%1', 0);
                    IF lrMov.FIND('-') THEN
                        REPEAT
                            wEgresos := wEgresos + ABS(lrMov.Amount);
                        UNTIL lrMov.NEXT = 0;

                    CALCFIELDS("Net Change");


                    IF ("Currency Code" = wDivisaLocal) OR ("Currency Code" = '') THEN
                        wSaldoDL := wSaldoDL + "Net Change";

                    IF "Currency Code" = wDivisaRef THEN
                        wSaldoDR := wSaldoDR + "Net Change";
                end;

                trigger OnPostDataItem()
                var
                    lrExchangeRate: Record 330;
                    lAux: Decimal;
                begin
                    lAux := lrExchangeRate.ExchangeAmtFCYToFCY(wFechaBalance, '', wDivisaRef, wSaldoDL);
                    wTotalDR := wSaldoDR + lAux;
                end;

                trigger OnPreDataItem()
                begin
                    IF wDivisa <> '' THEN
                        SETRANGE("Currency Code", wDivisa);

                    SETRANGE("Date Filter", 0D, wFechaBalance);
                end;
            }
            dataitem(Total; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                MaxIteration = 1;
                column(wTotalDR; wTotalDR)
                {
                }
                column(TOTAL_GENERAL_DOLARESCaption; TOTAL_GENERAL_DOLARESCaptionLbl)
                {
                }
                column(Total_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                lrExchangeRate: Record 330;
                lAux: Decimal;
            begin
                lAux := lrExchangeRate.ExchangeAmtFCYToFCY(wFechaBalance, '', wDivisaRef, wSaldoDL);
                wTotalDR := wSaldoDR + lAux;
            end;

            trigger OnPreDataItem()
            var
                lrConfig: Record 98;
                lrExchangeRate: Record 330;
            begin
                lrConfig.GET;
                wDivisaLocal := lrConfig."LCY Code";

                //... De momento, a piñon fijo.
                wDivisaRef := 'USD';

                wTipoCambioDR := 1 / lrExchangeRate.ExchangeRate(wFechaBalance, wDivisaRef);

                wSaldoDL := 0;
                wSaldoDR := 0;

                IF wDivisa <> '' THEN
                    wTxtMoneda := wDivisa
                ELSE
                    wTxtMoneda := Text001;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fecha Balance"; wFechaBalance)
                {
                }
                field(Moneda; wDivisa)
                {
                    TableRelation = Currency.Code;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            wFechaBalance := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        TextL001: Label 'Falta especificar la fecha de balance';
    begin
        IF wFechaBalance = 0D THEN
            ERROR(TextL001);
    end;

    var
        wFechaBalance: Date;
        wSaldoInicial: Decimal;
        wIngresos: Decimal;
        wEgresos: Decimal;
        wDivisa: Code[10];
        Text001: Label 'Todos';
        wTxtMoneda: Text[30];
        wTipoCambioDR: Decimal;
        wDivisaLocal: Code[10];
        wDivisaRef: Code[10];
        wSaldoDL: Decimal;
        wSaldoDR: Decimal;
        wTotalDR: Decimal;
        wNombre1: Text[80];
        wNombre2: Text[50];
        REPORTE_POSICION_EN_BANCOSCaptionLbl: Label 'REPORTE POSICION EN BANCOS';
        Cuenta_bancariaCaptionLbl: Label 'Cuenta bancaria';
        "Saldo_inicial_del_diaCaptionLbl": Label 'Saldo inicial del dia';
        IngresosCaptionLbl: Label 'Ingresos';
        EgresosCaptionLbl: Label 'Egresos';
        Saldo_en_librosCaptionLbl: Label 'Saldo en libros';
        MonedaCaptionLbl: Label 'Moneda';
        "Al_DiaCaptionLbl": Label 'Al Dia';
        Tipo_de_CambioCaptionLbl: Label 'Tipo de Cambio';
        PageCaptionLbl: Label 'Page';
        MONEDACaption_Control1000000007Lbl: Label 'MONEDA';
        TotalesCaptionLbl: Label 'Totales';
        TOTAL_GENERAL_DOLARESCaptionLbl: Label 'TOTAL GENERAL DOLARES';
}

