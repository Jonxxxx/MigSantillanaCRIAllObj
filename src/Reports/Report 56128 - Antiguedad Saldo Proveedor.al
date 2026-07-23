report 56128 "Antiguedad Saldo Proveedor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Antiguedad Saldo Proveedor.rdlc';
    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(FiltroProv; FiltroProv)
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4____FORMAT_TIME_; FORMAT(TODAY, 0, 4) + FORMAT(TIME))
            {
            }
            column(EmptyString; '')
            {
            }
            column(FechaInicPeriodo_1_; FechaInicPeriodo[1])
            {
            }
            column(FechaInicPeriodo_2_; FechaInicPeriodo[2])
            {
            }
            column(FechaInicPeriodo_3_; FechaInicPeriodo[3])
            {
            }
            column(FechaInicPeriodo_4_; FechaInicPeriodo[4])
            {
            }
            column(wLabelRango_1_; wLabelRango[1])
            {
            }
            column(wLabelRango_2_; wLabelRango[2])
            {
            }
            column(wLabelRango_3_; wLabelRango[3])
            {
            }
            column(wLabelRango_4_; wLabelRango[4])
            {
            }
            column(FechaFinPeriodo_1_; FechaFinPeriodo[1])
            {
            }
            column(FechaFinPeriodo_2_; FechaFinPeriodo[2])
            {
            }
            column(FechaFinPeriodo_3_; FechaFinPeriodo[3])
            {
            }
            column(FechaFinPeriodo_4_; FechaFinPeriodo[4])
            {
            }
            column(FORMAT_wFechaInicio_0_4_; FORMAT(wFechaInicio, 0, 4))
            {
            }
            column(wDetallado; wDetallado)
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(wTotalImporteMasDe90; wTotalImporteMasDe90)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wTotalImporte90; wTotalImporte90)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wTotalImporte60; wTotalImporte60)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wTotalImporte30; wTotalImporte30)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wTotalVencido; wTotalVencido)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wTotalSaldo; wTotalSaldo)
            {
            }
            column(wTotalImporteNoVencido; wTotalImporteNoVencido)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalImporte30; wGranTotalImporte30)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalImporte60; wGranTotalImporte60)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalImporte90; wGranTotalImporte90)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalImporteMasDe90; wGranTotalImporteMasDe90)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalVencido; wGranTotalVencido)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalSaldo; wGranTotalSaldo)
            {
                DecimalPlaces = 2 : 2;
            }
            column(wGranTotalImporteNoVencido; wGranTotalImporteNoVencido)
            {
                DecimalPlaces = 2 : 2;
            }
            column("PáginaCaption"; PáginaCaptionLbl)
            {
            }
            column(Proveedor___Saldo_por_AntiguedadCaption; Proveedor___Saldo_por_AntiguedadCaptionLbl)
            {
            }
            column(SaldoCaption; SaldoCaptionLbl)
            {
            }
            column(DescripcionCaption; DescripcionCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Saldo_vencidoCaption; Saldo_vencidoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VencidoCaption; VencidoCaptionLbl)
            {
            }
            column("DíasCaption"; DíasCaptionLbl)
            {
            }
            column(VencidoCaption_Control70; VencidoCaption_Control70Lbl)
            {
            }
            column(No_VencidasCaption; No_VencidasCaptionLbl)
            {
            }
            column(FacturasCaption; FacturasCaptionLbl)
            {
            }
            column(Saldos_al__Caption; Saldos_al__CaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(TotalCaption_Control51; TotalCaption_Control51Lbl)
            {
            }
            dataitem(MovProvNoVencido; 380)
            {
                DataItemLink = Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Vendor No., Posting Date, Entry Type, Currency Code);
                column(wImporteNoVencido; wImporteNoVencido)
                {
                }
                column(MovProvNoVencido__Document_No__; "Document No.")
                {
                }
                column(MovProvNoVencido_Entry_No_; "Entry No.")
                {
                }
                column(MovProvNoVencido_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    rMovProv.RESET;
                    rMovProv.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    rMovProv.SETRANGE("Document No.", "Document No.");
                    IF rMovProv.FIND('-') THEN
                        IF rMovProv.Open = FALSE THEN
                            CurrReport.SKIP;



                    BuscarPagos(MovProvNoVencido);
                    IF "Posting Date" > wFechaInicio THEN
                        CurrReport.SKIP
                    ELSE
                        IF ("Amount (LCY)" + wPagosAplicados) = 0 THEN
                            CurrReport.SKIP
                        ELSE BEGIN
                            wImporteNoVencido := "Amount (LCY)" + wPagosAplicados;
                            wTotalImporteNoVencido += "Amount (LCY)" + wPagosAplicados;
                            wGranTotalImporteNoVencido += "Amount (LCY)" + wPagosAplicados;
                            wTotalNoVencido += "Amount (LCY)" + wPagosAplicados;
                            wSaldo += "Amount (LCY)" + wPagosAplicados;
                            wTotalSaldo += "Amount (LCY)" + wPagosAplicados;
                            wGranTotalSaldo += "Amount (LCY)" + wPagosAplicados;
                        END;
                end;

                trigger OnPreDataItem()
                begin
                    MovProvNoVencido.SETFILTER(MovProvNoVencido."Initial Entry Due Date", '>%1|=%1', wFechaInicio);
                    wPagosAplicados := 0;
                end;
            }
            dataitem(MovProv30; 380)
            {
                DataItemLink = Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Vendor No., Posting Date, Entry Type, Currency Code)
                                    WHERE("Document Type" = FILTER(Invoice));
                column(wImporte30; wImporte30)
                {
                }
                column(MovProv30__Document_No__; "Document No.")
                {
                }
                column(wDias30; wDias30)
                {
                }
                column(MovProv30_Entry_No_; "Entry No.")
                {
                }
                column(MovProv30_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    rMovProv.RESET;
                    rMovProv.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    rMovProv.SETRANGE("Document No.", "Document No.");
                    IF rMovProv.FIND('-') THEN
                        IF rMovProv.Open = FALSE THEN
                            CurrReport.SKIP;


                    BuscarPagos(MovProv30);
                    IF ("Amount (LCY)" + wPagosAplicados) = 0 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        wImporte30 := "Amount (LCY)" + wPagosAplicados;
                        wTotalImporte30 += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalImporte30 += "Amount (LCY)" + wPagosAplicados;
                        wTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalSaldo += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wSaldo += "Amount (LCY)" + wPagosAplicados;
                        wTotalSaldo += "Amount (LCY)" + wPagosAplicados;

                        wDias30 := wFechaInicio - MovProv30."Initial Entry Due Date";
                        IF wDias30 < 0 THEN wDias30 := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    MovProv30.SETRANGE("Initial Entry Due Date", FechaFinPeriodo[1], FechaInicPeriodo[1]);
                    wPagosAplicados := 0;
                end;
            }
            dataitem(MovProv60; 380)
            {
                DataItemLink = Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Vendor No., Posting Date, Entry Type, Currency Code)
                                    WHERE("Document Type" = FILTER(Invoice));
                column(wImporte60; wImporte60)
                {
                }
                column(MovProv60__Document_No__; "Document No.")
                {
                }
                column(wDias60; wDias60)
                {
                }
                column(MovProv60_Entry_No_; "Entry No.")
                {
                }
                column(MovProv60_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    rMovProv.RESET;
                    rMovProv.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    rMovProv.SETRANGE("Document No.", "Document No.");
                    IF rMovProv.FIND('-') THEN
                        IF rMovProv.Open = FALSE THEN
                            CurrReport.SKIP;

                    BuscarPagos(MovProv60);
                    IF ("Amount (LCY)" + wPagosAplicados) = 0 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        wImporte60 := "Amount (LCY)" + wPagosAplicados;
                        wTotalImporte60 += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalImporte60 += "Amount (LCY)" + wPagosAplicados;
                        wTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wSaldo += "Amount (LCY)" + wPagosAplicados;
                        wTotalSaldo += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalSaldo += "Amount (LCY)" + wPagosAplicados;

                        wDias60 := wFechaInicio - MovProv60."Initial Entry Due Date";
                        IF wDias60 < 0 THEN wDias60 := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    MovProv60.SETRANGE("Initial Entry Due Date", FechaFinPeriodo[2], FechaInicPeriodo[2]);
                    wPagosAplicados := 0;
                end;
            }
            dataitem(MovProv90; 380)
            {
                DataItemLink = Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Vendor No., Posting Date, Entry Type, Currency Code)
                                    WHERE("Document Type" = FILTER(Invoice));
                column(wImporte90; wImporte90)
                {
                }
                column(MovProv90__Document_No__; "Document No.")
                {
                }
                column(wDias90; wDias90)
                {
                }
                column(MovProv90_Entry_No_; "Entry No.")
                {
                }
                column(MovProv90_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    rMovProv.RESET;
                    rMovProv.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    rMovProv.SETRANGE("Document No.", "Document No.");
                    IF rMovProv.FIND('-') THEN
                        IF rMovProv.Open = FALSE THEN
                            CurrReport.SKIP;


                    BuscarPagos(MovProv90);
                    IF ("Amount (LCY)" + wPagosAplicados) = 0 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        wImporte90 := "Amount (LCY)" + wPagosAplicados;
                        wTotalImporte90 += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalImporte90 += "Amount (LCY)" + wPagosAplicados;
                        wTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalVencido += "Amount (LCY)" + wPagosAplicados;
                        wSaldo += "Amount (LCY)" + wPagosAplicados;
                        wTotalSaldo += "Amount (LCY)" + wPagosAplicados;
                        wGranTotalSaldo += "Amount (LCY)" + wPagosAplicados;

                        wDias90 := wFechaInicio - MovProv90."Initial Entry Due Date";
                        IF wDias90 < 0 THEN wDias90 := 0;

                    END;
                end;

                trigger OnPreDataItem()
                begin
                    MovProv90.SETRANGE("Initial Entry Due Date", FechaFinPeriodo[3], FechaInicPeriodo[3]);
                    wPagosAplicados := 0;
                end;
            }
            dataitem(MovProvMasDe90; 380)
            {
                DataItemLink = Vendor No.=FIELD(No.);
                DataItemTableView = SORTING(Vendor No., Posting Date, Entry Type, Currency Code)
                                    WHERE("Document Type" = FILTER(Invoice));
                column(MovProvMasDe90__Document_No__; "Document No.")
                {
                }
                column(wImporteMasDe90; wImporteMasDe90)
                {
                }
                column(wDiasMasDe90; wDiasMasDe90)
                {
                }
                column(MovProvMasDe90_Entry_No_; "Entry No.")
                {
                }
                column(MovProvMasDe90_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    rMovProv.RESET;
                    rMovProv.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    rMovProv.SETRANGE("Document No.", "Document No.");
                    IF rMovProv.FIND('-') THEN
                        IF rMovProv.Open = FALSE THEN
                            CurrReport.SKIP;


                    BuscarPagos(MovProvMasDe90);
                    IF ("Amount (LCY)" + wPagosAplicados) = 0 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        wImporteMasDe90 := ("Amount (LCY)" + wPagosAplicados);
                        wTotalImporteMasDe90 += ("Amount (LCY)" + wPagosAplicados);
                        wGranTotalImporteMasDe90 += ("Amount (LCY)" + wPagosAplicados);
                        wTotalVencido += ("Amount (LCY)" + wPagosAplicados);
                        wGranTotalVencido += ("Amount (LCY)" + wPagosAplicados);
                        wSaldo += ("Amount (LCY)" + wPagosAplicados);
                        wTotalSaldo += ("Amount (LCY)" + wPagosAplicados);
                        wGranTotalSaldo += ("Amount (LCY)" + wPagosAplicados);

                        wDiasMasDe90 := wFechaInicio - MovProvMasDe90."Initial Entry Due Date";
                        IF wDias90 < 0 THEN wDias90 := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    MovProvMasDe90.SETRANGE("Initial Entry Due Date", FechaFinPeriodo[4], FechaInicPeriodo[4]);
                    //MESSAGE('desde %1 hasta %2',FechaFinPeriodo[4],FechaInicPeriodo[4]);
                    wPagosAplicados := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Balance (LCY)");
                IF "Balance (LCY)" = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(wTotalImporteNoVencido, wTotalImporte30, wTotalImporte60, wTotalImporte90, wTotalImporteMasDe90,
                                        wTotalVencido, wTotalSaldo);
                wPagosAplicados := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(wDetallado; wDetallado)
                {
                    Caption = 'Detallado';
                }
                field(wFechaInicio; wFechaInicio)
                {
                    Caption = 'Fecha';
                }
                field(wLongitudPeriodo; wLongitudPeriodo)
                {
                    Caption = 'Longitud periodo';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            wFechaInicio := WORKDATE;
            wLongitudPeriodo := '30D';
            wDetallado := TRUE;
            FechaInicPeriodo[1] := wFechaInicio;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FiltroProv := Vendor.GETFILTERS;

        FechaInicPeriodo[1] := wFechaInicio - 1;
        FOR I := 2 TO 6 DO BEGIN
            FechaInicPeriodo[I] := (CALCDATE('-' + wLongitudPeriodo, FechaInicPeriodo[I - 1]));
        END;

        FechaFinPeriodo[1] := FechaInicPeriodo[2] + 1;
        FechaFinPeriodo[2] := FechaInicPeriodo[3] + 1;
        FechaFinPeriodo[3] := FechaInicPeriodo[4] + 1;
        FechaFinPeriodo[4] := CALCDATE('-9999D', FechaInicPeriodo[4]);

        wFecha1 := CALCDATE('-' + wLongitudPeriodo, FechaInicPeriodo[1]);
        wRango := FechaInicPeriodo[1] - wFecha1;

        wLabelRango[1] := '1 - ' + FORMAT(wRango);
        wLabelRango[2] := FORMAT(wRango + 1) + ' - ' + FORMAT(wRango * 2);
        wLabelRango[3] := FORMAT(wRango * 2 + 1) + ' - ' + FORMAT(wRango * 3);
        wLabelRango[4] := 'Mas de ' + FORMAT(wRango * 3);
    end;

    var
        rMovProvTemp: Record 380;
        FechaInicPeriodo: array[7] of Date;
        FechaFinPeriodo: array[7] of Date;
        I: Integer;
        FiltroProv: Text[50];
        wLongitudPeriodo: Code[10];
        indicador: Integer;
        wMasDe90: Decimal;
        wImporte30: Decimal;
        wTotalImporte30: Decimal;
        wImporte60: Decimal;
        wTotalImporte60: Decimal;
        wImporte90: Decimal;
        wTotalImporte90: Decimal;
        wImporteMasDe90: Decimal;
        wTotalImporteMasDe90: Decimal;
        wSaldo: Decimal;
        wTotalSaldo: Decimal;
        wTotalVencido: Decimal;
        wDetallado: Boolean;
        wFechaInicio: Date;
        wGranTotalVencido: Decimal;
        wGranTotalSaldo: Decimal;
        wGranTotalImporteNoVencido: Decimal;
        wGranTotalImporte90: Decimal;
        wGranTotalImporte30: Decimal;
        wGranTotalImporte60: Decimal;
        wGranTotalImporteMasDe90: Decimal;
        wRango: Integer;
        wLabelRango: array[4] of Text[30];
        wFecha1: Date;
        wDiasVencido: Integer;
        wDias30: Integer;
        wDias60: Integer;
        wDias90: Integer;
        wDiasMasDe90: Integer;
        wDias: Integer;
        wPagosAplicados: Decimal;
        wImporteNoVencido: Decimal;
        wTotalImporteNoVencido: Decimal;
        wTotalNoVencido: Decimal;
        rMovProv: Record 25;
        "PáginaCaptionLbl": Label 'Página';
        Proveedor___Saldo_por_AntiguedadCaptionLbl: Label 'Proveedor - Saldo por Antiguedad';
        SaldoCaptionLbl: Label 'Saldo';
        DescripcionCaptionLbl: Label 'Descripcion';
        No_CaptionLbl: Label 'No.';
        Saldo_vencidoCaptionLbl: Label 'Saldo vencido';
        TotalCaptionLbl: Label 'Total';
        VencidoCaptionLbl: Label 'Vencido';
        "DíasCaptionLbl": Label 'Días';
        VencidoCaption_Control70Lbl: Label 'Vencido';
        No_VencidasCaptionLbl: Label 'No Vencidas';
        FacturasCaptionLbl: Label 'Facturas';
        Saldos_al__CaptionLbl: Label 'Saldos al :';
        SubtotalCaptionLbl: Label 'Subtotal';
        TotalCaption_Control51Lbl: Label ' Total';

    procedure BuscarPagos(rDetailedMovProv: Record 380)
    begin
        // Buscar Pagos si la liquidacion fue por Numero de Documento

        wPagosAplicados := 0;

        //Busco los pagos aplicados a la factura
        rMovProvTemp.RESET;
        rMovProvTemp.SETCURRENTKEY("Vendor Ledger Entry No.", "Posting Date", "Entry Type");
        rMovProvTemp.SETRANGE(rMovProvTemp."Vendor Ledger Entry No.", rDetailedMovProv."Vendor Ledger Entry No.");
        rMovProvTemp.SETRANGE(rMovProvTemp."Posting Date", FechaFinPeriodo[1], FechaInicPeriodo[1]);
        rMovProvTemp.SETRANGE(rMovProvTemp."Entry Type", rMovProvTemp."Entry Type"::Application);
        IF rMovProvTemp.FIND('-') THEN
            REPEAT
                wPagosAplicados += rMovProvTemp."Amount (LCY)";
            UNTIL rMovProvTemp.NEXT = 0;
    end;
}

