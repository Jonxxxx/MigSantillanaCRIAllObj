report 34002109 "Listado Pagos Efectivo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado Pagos Efectivo.rdlc';

    dataset
    {
        dataitem("Empresas Cotizacion"; 34002100)
        {
            DataItemTableView = SORTING("Empresa cotizacion");
            column(Empresas_Cotizacion_Empresa_cotizacion; "Empresa cotizacion")
            {
            }
            dataitem("Centros de Trabajo"; 34002101)
            {
                DataItemLink = "Empresa cotizacion" = FIELD("Empresa cotizacion");
                DataItemTableView = SORTING("Empresa cotizacion", "Centro de trabajo");
                RequestFilterFields = "Empresa cotizacion", "Centro de trabajo";
                column(Centros_de_Trabajo_Empresa_cotizacion; "Empresa cotizacion")
                {
                }
                column(Centros_de_Trabajo_Centro_de_trabajo; "Centro de trabajo")
                {
                }
                dataitem(Employee; 5200)
                {
                    DataItemLink = "Working Center" = FIELD("Centro de trabajo");
                    DataItemTableView = SORTING("Last Name", "First Name", "Middle Name");
                    column(Centros_de_Trabajo___C_P__; "Centros de Trabajo"."C.P.")
                    {
                    }
                    column(Centros_de_Trabajo___Poblaci_n_; "Centros de Trabajo".Poblacion)
                    {
                    }
                    column(Empresas_Cotizaci_n__Provincia; "Empresas Cotizacion".Provincia)
                    {
                    }
                    column(USERID; USERID)
                    {
                    }
                    column(COMPANYNAME; COMPANYNAME)
                    {
                    }
                    column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PAGENO)
                    {
                    }
                    column(Employee__Working_Center_; "Working Center")
                    {
                    }
                    column(Total; Total)
                    {
                    }
                    column(Centro_de_Trabajo_Caption; Centro_de_Trabajo_CaptionLbl)
                    {
                    }
                    column(Pago_N_minas_en_efectivoCaption; Pago_N_minas_en_efectivoCaptionLbl)
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                    {
                    }
                    column(V1Caption; V1CaptionLbl)
                    {
                    }
                    column(DOCCaption; DOCCaptionLbl)
                    {
                    }
                    column(NameCaption; NameCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(Income_detailCaption; Income_detailCaptionLbl)
                    {
                    }
                    column(Importe_TOTALCaption; Importe_TOTALCaptionLbl)
                    {
                    }
                    column(Employee_No_; "No.")
                    {
                    }
                    dataitem("Historico Cab. nomina"; 34002117)
                    {
                        DataItemLink = "No. empleado" = FIELD("No.");
                        DataItemLinkReference = Employee;
                        DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
                        RequestFilterFields = Periodo, "Tipo de nomina";
                        column(Employee__Document_ID_; Employee."Document ID")
                        {
                        }
                        column(Employee__Full_Name_; Employee."Full Name")
                        {
                        }
                        column(Total_Ingresos___Total_deducciones_; "Total Ingresos" - "Total deducciones")
                        {
                        }
                        column(Historico_Cab__nomina_No__empleado; "No. empleado")
                        {
                        }
                        column(Historico_Cab__nomina_Ano; Ano)
                        {
                        }
                        column(Historico_Cab__nomina_Periodo; Periodo)
                        {
                        }
                        column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CALCFIELDS("Total deducciones", "Total Ingresos");

                            importe := "Total Ingresos" - "Total deducciones";
                            Total := Total + importe;
                            Cheques := Cheques + 1;

                            FOR i := "Monedas usadas" DOWNTO 1 DO BEGIN
                                monedas[2, i] := monedas[2, i] + ROUND(importe / monedas[1, i], 1, '<');
                                // MESSAGE('%1 %2 %3',importe,monedas[1,i],monedas[2,i]);
                                importe := importe - (ROUND(importe / monedas[1, i], 1, '<') * monedas[1, i]);
                            END;
                            importe := "Total Ingresos" - "Total deducciones";
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT ok THEN
                            "Forma de Cobro" := 0;

                        //IF  ("Forma de Cobro" <>1) AND
                        //    (("Empresas Cotizacion"."Forma de Pago" <> 1) OR ("Forma de Cobro" <> 0)) THEN
                        //     CurrReport.SKIP;
                    end;
                }
                dataitem(Counter2; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(COMPANYNAME_Control76; COMPANYNAME)
                    {
                    }
                    column(Centros_de_Trabajo___C_P___Control79; "Centros de Trabajo"."C.P.")
                    {
                    }
                    column(Centros_de_Trabajo___Poblaci_n__Control80; "Centros de Trabajo".Poblacion)
                    {
                    }
                    column(FORMAT_TODAY_0_4__Control81; FORMAT(TODAY, 0, 4))
                    {
                    }
                    column(USERID_Control82; USERID)
                    {
                    }
                    column(CurrReport_PAGENO_Control84; CurrReport.PAGENO)
                    {
                    }
                    column(Centros_de_Trabajo___Centro_de_trabajo_; "Centros de Trabajo"."Centro de trabajo")
                    {
                    }
                    column(monedas_1_1_; monedas[1, 1])
                    {
                    }
                    column(monedas_2_1_; monedas[2, 1])
                    {
                    }
                    column(monedas_1_1__monedas_2_1_; monedas[1, 1] * monedas[2, 1])
                    {
                    }
                    column(monedas_1_2_; monedas[1, 2])
                    {
                    }
                    column(monedas_2_2_; monedas[2, 2])
                    {
                    }
                    column(monedas_1_2__monedas_2_2_; monedas[1, 2] * monedas[2, 2])
                    {
                    }
                    column(monedas_1_3_; monedas[1, 3])
                    {
                    }
                    column(monedas_2_3_; monedas[2, 3])
                    {
                    }
                    column(monedas_1_3__monedas_2_3_; monedas[1, 3] * monedas[2, 3])
                    {
                    }
                    column(monedas_1_4_; monedas[1, 4])
                    {
                    }
                    column(monedas_2_4_; monedas[2, 4])
                    {
                    }
                    column(monedas_1_4__monedas_2_4_; monedas[1, 4] * monedas[2, 4])
                    {
                    }
                    column(monedas_1_5_; monedas[1, 5])
                    {
                    }
                    column(monedas_2_5_; monedas[2, 5])
                    {
                    }
                    column(monedas_1_5__monedas_2_5_; monedas[1, 5] * monedas[2, 5])
                    {
                    }
                    column(monedas_1_6_; monedas[1, 6])
                    {
                    }
                    column(monedas_2_6_; monedas[2, 6])
                    {
                    }
                    column(monedas_1_6__monedas_2_6_; monedas[1, 6] * monedas[2, 6])
                    {
                    }
                    column(monedas_1_7_; monedas[1, 7])
                    {
                    }
                    column(monedas_2_7_; monedas[2, 7])
                    {
                    }
                    column(monedas_1_7__monedas_2_7_; monedas[1, 7] * monedas[2, 7])
                    {
                    }
                    column(monedas_1_8_; monedas[1, 8])
                    {
                    }
                    column(monedas_2_8_; monedas[2, 8])
                    {
                    }
                    column(monedas_1_8__monedas_2_8_; monedas[1, 8] * monedas[2, 8])
                    {
                    }
                    column(monedas_1_9_; monedas[1, 9])
                    {
                    }
                    column(monedas_2_9_; monedas[2, 9])
                    {
                    }
                    column(monedas_1_9__monedas_2_9_; monedas[1, 9] * monedas[2, 9])
                    {
                    }
                    column(monedas_1_10_; monedas[1, 10])
                    {
                    }
                    column(monedas_2_10_; monedas[2, 10])
                    {
                    }
                    column(monedas_1_10__monedas_2_10_; monedas[1, 10] * monedas[2, 10])
                    {
                    }
                    column(monedas_1_11_; monedas[1, 11])
                    {
                    }
                    column(monedas_2_11_; monedas[2, 11])
                    {
                    }
                    column(monedas_1_11__monedas_2_11_; monedas[1, 11] * monedas[2, 11])
                    {
                    }
                    column(Total_monedas_; "Total monedas")
                    {
                    }
                    column(Centro_de_Trabajo_Caption_Control74; Centro_de_Trabajo_Caption_Control74Lbl)
                    {
                    }
                    column(Pago_N_minas_en_efectivoCaption_Control77; Pago_N_minas_en_efectivoCaption_Control77Lbl)
                    {
                    }
                    column(CurrReport_PAGENO_Control84Caption; CurrReport_PAGENO_Control84CaptionLbl)
                    {
                    }
                    column(V2Caption; V2CaptionLbl)
                    {
                    }
                    column(Valor_Monedas_BilletesCaption; Valor_Monedas_BilletesCaptionLbl)
                    {
                    }
                    column(CantidadCaption; CantidadCaptionLbl)
                    {
                    }
                    column(Desglose_de_monedasCaption; Desglose_de_monedasCaptionLbl)
                    {
                    }
                    column(ImporteCaption; ImporteCaptionLbl)
                    {
                    }
                    column(Counter2_Number; Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        cabecera := 1;
                        CurrReport.NEWPAGE;

                        FOR i := 1 TO "Monedas usadas" DO BEGIN
                            "Total monedas" := "Total monedas" + (monedas[1, i] * monedas[2, i]);
                        END;

                        IF "Total monedas" = 0 THEN
                            CurrReport.SKIP;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    cabecera := 0;

                    FOR i := 1 TO "Monedas usadas" DO BEGIN
                        monedas[2, i] := 0;
                    END;
                    Total := 0;
                    "Total monedas" := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fecha Pago"; fechatrans)
                {
                }
                field("Desglose Moneda 1"; monedas[1, 1])
                {
                }
                field("Desglose Moneda 2"; monedas[1, 2])
                {
                }
                field("Desglose Moneda 3"; monedas[1, 3])
                {
                }
                field("Desglose Moneda 4"; monedas[1, 4])
                {
                }
                field("Desglose Moneda 5"; monedas[1, 5])
                {
                }
                field("Desglose Moneda 6"; monedas[1, 6])
                {
                }
                field("Desglose Moneda 7"; monedas[1, 7])
                {
                }
                field("Desglose Moneda 8"; monedas[1, 8])
                {
                }
                field("Desglose Moneda 9"; monedas[1, 9])
                {
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

    trigger OnInitReport()
    begin
        monedas[1, 1] := 1;
        monedas[1, 2] := 5;
        monedas[1, 3] := 25;
        monedas[1, 4] := 50;
        monedas[1, 5] := 100;
        monedas[1, 6] := 200;
        monedas[1, 7] := 500;
        monedas[1, 8] := 1000;
        monedas[1, 9] := 2000;
        "Monedas usadas" := 9;

        IF fechatrans = 0D THEN fechatrans := WORKDATE;
    end;

    var
        ok: Boolean;
        cabecera: Integer;
        importe: Decimal;
        i: Integer;
        "Monedas usadas": Integer;
        monedas: array[2, 20] of Decimal;
        "Total monedas": Decimal;
        Cheques: Decimal;
        RegTrabajad: Record 5200;
        Total: Decimal;
        fechatrans: Date;
        Total1: Decimal;
        Xbancos: Record 34002139;
        transac: Integer;
        Centro_de_Trabajo_CaptionLbl: Label 'Centro de Trabajo:';
        Pago_N_minas_en_efectivoCaptionLbl: Label 'Pago nominas en efectivo';
        CurrReport_PAGENOCaptionLbl: Label 'Pag.';
        V1CaptionLbl: Label '1';
        DOCCaptionLbl: Label 'DOC';
        NameCaptionLbl: Label 'Name';
        AmountCaptionLbl: Label 'Amount';
        Income_detailCaptionLbl: Label 'Income detail';
        Importe_TOTALCaptionLbl: Label 'Importe TOTAL';
        Centro_de_Trabajo_Caption_Control74Lbl: Label 'Centro de Trabajo:';
        Pago_N_minas_en_efectivoCaption_Control77Lbl: Label 'Pago nominas en efectivo';
        CurrReport_PAGENO_Control84CaptionLbl: Label 'Pag.';
        V2CaptionLbl: Label '2';
        Valor_Monedas_BilletesCaptionLbl: Label 'Valor Monedas/Billetes';
        CantidadCaptionLbl: Label 'Cantidad';
        Desglose_de_monedasCaptionLbl: Label 'Desglose de monedas';
        ImporteCaptionLbl: Label 'Importe';
}

