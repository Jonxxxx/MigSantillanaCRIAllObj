report 34002164 "Recibo Nomina sin copia - coop"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Recibo Nomina sin copia - coop.rdl';
    Permissions = TableData 55758 = rimd,
                  TableData 55759 = rimd;

    dataset
    {
        dataitem("Historico Cab. nomina"; 55758)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", "Tipo de nomina", Periodo;
            column(Historico_Cab__nomina_No__empleado; "No. empleado")
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Per_odo; Periodo)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }
            column(Texto_Coop; TextoCoop)
            {
            }
            dataitem("Historico Lin. nomina"; 55759)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado"),
                               "Tipo de nomina" = FIELD("Tipo de nomina"),
                               Periodo = FIELD(Periodo),
                               "Job No." = FIELD("Job No.");
                DataItemTableView = SORTING("No. empleado", "Tipo de nomina", Periodo, "No. Orden")
                                    WHERE("Texto Informativo" = CONST(false));
                column("Historico_Lin__nomina__No__empleado_"; "No. empleado")
                {
                }
                column(Historico_Cab__nomina__Nombre; "Historico Cab. nomina".Nombre)
                {
                }
                column(txtDesc; txtDesc)
                {
                }
                column(Comentarion_; Comentario)
                {
                }
                column(TODAY; TODAY)
                {
                }
                column(TIME; TIME)
                {
                }
                column(Historico_Cab__nomina__Inicio; "Historico Cab. nomina".Inicio)
                {
                }
                column(Historico_Cab__nomina__Fin; "Historico Cab. nomina".Fin)
                {
                }
                column(TotIng___TotDed; TotIng + TotDed)
                {
                }
                column(Historico_Cab__nomina__Cuenta; "Historico Cab. nomina".Cuenta)
                {
                }
                column(rEmpresa_Picture; rEmpresa.Picture)
                {
                }
                column(txttextoInf; TextoInformativo)
                {
                }
                column(DescDeducc_1_; DescDeducc[1])
                {
                }
                column(DescDeducc_2_; DescDeducc[2])
                {
                }
                column(DescDeducc_3_; DescDeducc[3])
                {
                }
                column(DescDeducc_4_; DescDeducc[4])
                {
                }
                column(DescDeducc_5_; DescDeducc[5])
                {
                }
                column(DescDeducc_6_; DescDeducc[6])
                {
                }
                column(DescDeducc_7_; DescDeducc[7])
                {
                }
                column(DescDeducc_8_; DescDeducc[8])
                {
                }
                column(DescDeducc_9_; DescDeducc[9])
                {
                }
                column(DescIngreso_1_; DescIngreso[1])
                {
                }
                column(DescIngreso_2_; DescIngreso[2])
                {
                }
                column(DescIngreso_3_; DescIngreso[3])
                {
                }
                column(DescIngreso_4_; DescIngreso[4])
                {
                }
                column(DescIngreso_5_; DescIngreso[5])
                {
                }
                column(DescIngreso_6_; DescIngreso[6])
                {
                }
                column(DescIngreso_7_; DescIngreso[7])
                {
                }
                column(DescIngreso_8_; DescIngreso[8])
                {
                }
                column(DescIngreso_9_; DescIngreso[9])
                {
                }
                column(DescIngreso_10_; DescIngreso[10])
                {
                }
                column(DescDeducc_10_; DescDeducc[10])
                {
                }
                column(Horas_1_; Horas[1])
                {
                    AutoFormatType = 1;
                }
                column(Horas_2_; Horas[2])
                {
                    AutoFormatType = 1;
                }
                column(Horas_3_; Horas[3])
                {
                    AutoFormatType = 1;
                }
                column(Horas_4_; Horas[4])
                {
                    AutoFormatType = 1;
                }
                column(Horas_5_; Horas[5])
                {
                    AutoFormatType = 1;
                }
                column(Horas_6_; Horas[6])
                {
                    AutoFormatType = 1;
                }
                column(Horas_7_; Horas[7])
                {
                    AutoFormatType = 1;
                }
                column(Horas_8_; Horas[8])
                {
                    AutoFormatType = 1;
                }
                column(Horas_9_; Horas[9])
                {
                    AutoFormatType = 1;
                }
                column(Horas_10_; Horas[10])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_1_; ImportIngreso[1])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 2;
                }
                column(ImportIngreso_2_; ImportIngreso[2])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_3_; ImportIngreso[3])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_4_; ImportIngreso[4])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_5_; ImportIngreso[5])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_6_; ImportIngreso[6])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_7_; ImportIngreso[7])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_8_; ImportIngreso[8])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_9_; ImportIngreso[9])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_10_; ImportIngreso[10])
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_1__; ABS(ImportEgreso[1]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_2__; ABS(ImportEgreso[2]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_3__; ABS(ImportEgreso[3]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_4__; ABS(ImportEgreso[4]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_5__; ABS(ImportEgreso[5]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_6__; ABS(ImportEgreso[6]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_7__; ABS(ImportEgreso[7]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_8__; ABS(ImportEgreso[8]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_9__; ABS(ImportEgreso[9]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_10__; ABS(ImportEgreso[10]))
                {
                    AutoFormatType = 1;
                }
                column(ImporteIngresoTotal; ImporteIngresoTotal)
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgresoTotal_; ABS(ImportEgresoTotal))
                {
                    AutoFormatType = 1;
                }
                column("Historico_Lin__nomina__No__empleado_Caption"; FIELDCAPTION("No. empleado"))
                {
                }
                column(Historico_Cab__nomina__NombreCaption; Histrico_Cab__nomina__NombreCaptionLbl)
                {
                }
                column(txtDescCaption; txtDescCaptionLbl)
                {
                }
                column(TODAYCaption; TODAYCaptionLbl)
                {
                }
                column(TIMECaption; TIMECaptionLbl)
                {
                }
                column(Recibo_de_nomina_periodoCaption; TextoTipoNomina)
                {
                }
                column(alCaption; alCaptionLbl)
                {
                }
                column(TotIng___TotDedCaption; TotIng___TotDedCaptionLbl)
                {
                }
                column(Historico_Cab__nomina__CuentaCaption; Historico_Cab__nomina__CuentaCaptionLbl)
                {
                }
                column(V1Caption; V1CaptionLbl)
                {
                }
                column(DescuentosCaption; DescuentosCaptionLbl)
                {
                }
                column(IngresosCaption; IngresosCaptionLbl)
                {
                }
                column(DescripcionCaption; DescripcionCaptionLbl)
                {
                }
                column(HorasCaption; HorasCaptionLbl)
                {
                }
                column(ValorCaption; ValorCaptionLbl)
                {
                }
                column(ValorCaption_Control41; ValorCaption_Control41Lbl)
                {
                }
                column(DescripcionCaption_Control43; DescripcionCaption_Control43Lbl)
                {
                }
                column(Total_ingresosCaption; Total_ingresosCaptionLbl)
                {
                }
                column(Total_deduccionesCaption; Total_deduccionesCaptionLbl)
                {
                }
                column(Agree_with_ReceiveCaption; Agree_with_ReceiveCaptionLbl)
                {
                }
                column(Historico_Lin__nomina_Tipo_nomina; "Tipo nomina")
                {
                }
                column(Historico_Lin__nomina_Periodo; Periodo)
                {
                }
                column(Historico_Lin__nomina_No__Orden; "No. Orden")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF "Tipo concepto" = "Tipo concepto"::Ingresos THEN BEGIN
                        i += 1;
                        DescIngreso[i] := Descripcion;
                        Horas[i] := Cantidad;
                        ImportIngreso[i] := Total;
                        ImporteIngresoTotal += ImportIngreso[i];
                        TotIng += Total;
                    END
                    ELSE BEGIN
                        id += 1;
                        DescDeducc[id] := Descripcion;
                        Cant[id] := Cantidad;
                        ImportEgreso[id] := Total;
                        ImportEgresoTotal += ImportEgreso[id];
                        TotDed += Total;
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    FOR i := 1 TO 10 DO BEGIN
                        DescIngreso[i] := '';
                        Horas[i] := 0;
                        ImportIngreso[i] := 0;
                    END;
                    FOR id := 1 TO 10 DO BEGIN
                        DescDeducc[i] := '';
                        Cant[i] := 0;
                        ImportEgreso[i] := 0;
                    END;
                    i := 0;
                    id := 0;

                    TotIng := 0;
                    TotDed := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ImportIngreso);
                CLEAR(ImportEgreso);
                CLEAR(ImporteIngresoTotal);
                CLEAR(ImportEgresoTotal);
                CLEAR(TotIng);
                CLEAR(TotDed);
                CLEAR(Horas);
                CLEAR(DescIngreso);
                CLEAR(DescDeducc);
                CLEAR(Cant);
                txtDesc := '';
                TextoCoop := '';
                /*
                CALCFIELDS("Total Ingresos", "Total deducciones");
                TotIng  := "Total Ingresos";
                TotDed  := "Total deducciones";
                */

                IF MiembrosCoop.GET("No. empleado") THEN BEGIN
                    MiembrosCoop.CALCFIELDS("Ahorro acumulado", "Importe pendiente");

                    TextoCoop := STRSUBSTNO(Text001, "No. empleado" + ' - ' + Nombre, MiembrosCoop.FIELDCAPTION("Ahorro acumulado"), FORMAT(MiembrosCoop."Ahorro acumulado", 0, '<Integer thousand><Decimals,3>'),
                                  MiembrosCoop.FIELDCAPTION("Importe pendiente"), FORMAT(MiembrosCoop."Importe pendiente", 0, '<Integer thousand><Decimals,3>'));
                END;

                TextoTipoNomina := STRSUBSTNO(Recibo_de_nomina_periodoCaptionLbl, "Tipo de nomina");

                IF NOT rCargos.GET(Departamento, Cargo) THEN
                    rCargos.INIT
                ELSE
                    txtDesc := rCargos.Descripcion;

                rEmp.GET("No. empleado");

                IF NOT rDepto.GET(rEmp.Departamento) THEN
                    rDepto.INIT
                ELSE
                    txtDesc += ' / ' + rDepto.Descripcion;

                IF NOT rSubDepto.GET(rEmp.Departamento, rEmp."Sub-Departamento") THEN
                    rSubDepto.INIT
                ELSE
                    txtDesc += ' / ' + rSubDepto.Descripcion;


                TextoInformativo := '';
                "Historico Lin. nomina".RESET;
                "Historico Lin. nomina".SETRANGE("No. empleado", "No. empleado");
                "Historico Lin. nomina".SETRANGE("Tipo de nomina", "Tipo de nomina");
                "Historico Lin. nomina".SETRANGE(Periodo, Periodo);
                "Historico Lin. nomina".SETRANGE("No. Documento", "No. Documento");
                "Historico Lin. nomina".SETRANGE("Texto Informativo", TRUE);
                IF "Historico Lin. nomina".FINDFIRST THEN
                    TextoInformativo := "Historico Lin. nomina".Descripcion + ', ' + FORMAT("Historico Lin. nomina".Total);

            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
                rEmpresa.CALCFIELDS(Picture);
            end;
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
        rEmpresa: Record 79;
        rEmp: Record 5200;
        rCargos: Record 55751;
        rDepto: Record 55776;
        rSubDepto: Record 55777;
        MiembrosCoop: Record 34002195;
        DescIngreso: array[10] of Text[50];
        DescDeducc: array[10] of Text[50];
        Horas: array[10] of Decimal;
        ImportIngreso: array[10] of Decimal;
        Cant: array[10] of Decimal;
        ImportEgreso: array[10] of Decimal;
        i: Integer;
        id: Integer;
        ImporteIngresoTotal: Decimal;
        ImportEgresoTotal: Decimal;
        TotIng: Decimal;
        TotDed: Decimal;
        txtDesc: Text[250];
        TextoInformativo: Text[250];
        Histrico_Cab__nomina__NombreCaptionLbl: Label 'Full Name';
        txtDescCaptionLbl: Label 'Cargo';
        TODAYCaptionLbl: Label 'Date:';
        TIMECaptionLbl: Label 'Time:';
        Recibo_de_nomina_periodoCaptionLbl: Label 'Payment slip payroll %1, period';
        alCaptionLbl: Label 'al';
        TotIng___TotDedCaptionLbl: Label 'Net Income';
        Historico_Cab__nomina__CuentaCaptionLbl: Label 'Bank Account';
        V1CaptionLbl: Label '1';
        DescuentosCaptionLbl: Label 'Descuentos';
        IngresosCaptionLbl: Label 'Ingresos';
        DescripcionCaptionLbl: Label 'Descripcion';
        HorasCaptionLbl: Label 'Horas';
        ValorCaptionLbl: Label 'Valor';
        ValorCaption_Control41Lbl: Label 'Valor';
        DescripcionCaption_Control43Lbl: Label 'Descripcion';
        Total_ingresosCaptionLbl: Label 'Total ingresos';
        Total_deduccionesCaptionLbl: Label 'Total deducciones';
        Agree_with_ReceiveCaptionLbl: Label 'Agree with Receive';
        Historico_Cab__nomina__Nombre2_CaptionLbl: Label 'Full Name';
        txtDescCaption2Lbl: Label 'Cargo';
        TODAY_2_CaptionLbl: Label 'Date:';
        TIME_2_CaptionLbl: Label 'Time:';
        Recibo_de_nomina_periodo2CaptionLbl: Label 'Recibo de nomina periodo';
        al2CaptionLbl: Label 'al';
        TotIng2___TotDedCaptionLbl: Label 'Net Income';
        Historico_Cab__nomina2__CuentaCaptionLbl: Label 'Bank Account';
        V2CaptionLbl: Label '2';
        Descuentos2_CaptionLbl: Label 'Descuentos';
        Ingresos2_CaptionLbl: Label 'Ingresos';
        DescripcionC2_aptionLbl: Label 'Descripcion';
        Horas2_CaptionLbl: Label 'Horas';
        Valor2_CaptionLbl: Label 'Valor';
        ValorCaption2_Control41Lbl: Label 'Valor';
        DescripcionCaption2_Control43Lbl: Label 'Descripcion';
        Total_ingresos2_CaptionLbl: Label 'Total ingresos';
        Total_deducciones2_CaptionLbl: Label 'Total deducciones';
        Agree_with_Receive2CaptionLbl: Label 'Agree with Receive';
        TextoTipoNomina: Text[250];
        Text001: Label 'COOPERATIVE: The emplyee %1 has an %2 of %3 and a %4 of %5';
        TextoCoop: Text;
}

