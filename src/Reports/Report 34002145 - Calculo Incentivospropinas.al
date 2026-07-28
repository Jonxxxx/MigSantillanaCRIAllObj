report 34002145 "Calculo Incentivos/propinas"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Calculo Incentivospropinas.rdlc';
    Caption = 'Calculate Incentives/tips';
    ProcessingOnly = false;

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Incentivos/Puntos" = FILTER(<> 0),
                                      "Calcular Nomina" = CONST(true));
            RequestFilterFields = "No.";
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(PrecioPto__Monto_a_Distribuir_; PrecioPto."Monto a Distribuir")
            {
            }
            column(PrecioPto__Fecha_Ult__Corte_; PrecioPto."Fecha Ult. Corte")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(Employee__Incentivos_Puntos_; "Incentivos/Puntos")
            {
            }
            column(LinPerfSal_Importe; LinPerfSal.Importe)
            {
                DecimalPlaces = 2 : 2;
            }
            column(DiasTrabajados; DiasTrabajados)
            {
            }
            column(Employee__Fecha_salida_empresa_; "Fecha salida empresa")
            {
            }
            column(FechaIniAusencia; FechaIniAusencia)
            {
            }
            column(FechaFinAusencia; FechaFinAusencia)
            {
            }
            column(blnMostrar; blnMostrar)
            {
            }
            column(Employee__Incentivos_Puntos__Control7; "Incentivos/Puntos")
            {
            }
            column(LinPerfSal_Importe_Control15; LinPerfSal.Importe)
            {
            }
            column(Diferencia; Diferencia)
            {
            }
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Employee__Full_Name_Caption; Employee__Full_Name_CaptionLbl)
            {
            }
            column(Employee__Incentivos_Puntos_Caption; Employee__Incentivos_Puntos_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Incentive_Tips_DistributionCaption; Incentive_Tips_DistributionCaptionLbl)
            {
            }
            column(Importe_a_Distribuir_Caption; Importe_a_Distribuir_CaptionLbl)
            {
            }
            column(ImporteCaption; ImporteCaptionLbl)
            {
            }
            column(DiasTrabajadosCaption; DiasTrabajadosCaptionLbl)
            {
            }
            column(Fecha_de_Cancelaci_nCaption; Fecha_de_Cancelaci_nCaptionLbl)
            {
            }
            column(Fecha_Ult__CorteCaption; Fecha_Ult__CorteCaptionLbl)
            {
            }
            column(FechaIniAusenciaCaption; FechaIniAusenciaCaptionLbl)
            {
            }
            column(FechaFinAusenciaCaption; FechaFinAusenciaCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Diferencia_Caption; Diferencia_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Contador := Contador + 1;
                Ventana.UPDATE(1, ROUND(Contador / AModificar, 1));

                blnMostrar := TRUE;

                DiasTrabajados := 15;
                DiasAusencia := 0;
                FechaIniAusencia := 0D;
                FechaFinAusencia := 0D;


                Ausencia.RESET;
                Ausencia.SETRANGE("Employee No.", "No.");
                //GRN rAusencia.SETRANGE("Cod. causa ausencia", ConfNomina."Incidencias Ausencia Propinas");
                Ausencia.SETRANGE("From Date", PrecioPto."Fecha Ult. Corte", PrecioPto."Fecha de Corte");
                Ausencia.SETFILTER(Quantity, '<>%1', 0);
                IF Ausencia.FIND('-') THEN
                    REPEAT
                        IF "Fecha salida empresa" >= Ausencia."To Date" THEN BEGIN
                            FechaIniAusencia := Ausencia."From Date";
                            FechaFinAusencia := Ausencia."To Date";
                            DiasAusencia := FechaFinAusencia - FechaIniAusencia + 1;
                        END
                        ELSE
                            IF "Fecha salida empresa" = 0D THEN BEGIN
                                FechaIniAusencia := Ausencia."From Date";
                                FechaFinAusencia := Ausencia."To Date";
                                DiasAusencia := FechaFinAusencia - FechaIniAusencia + 1;
                            END;
                    UNTIL Ausencia.NEXT = 0;

                IF "Employment Date" > PrecioPto."Fecha de Corte" THEN
                    IF "Employment Date" <= PrecioPto."Fecha de Corte" THEN
                        DiasTrabajados := PrecioPto."Fecha de Corte" - "Employment Date" + 1;

                IF "Fecha salida empresa" <> 0D THEN
                    IF "Fecha salida empresa" <= PrecioPto."Fecha de Corte" THEN BEGIN
                        DiasTrabajados := "Fecha salida empresa" - PrecioPto."Fecha Ult. Corte" + 1;

                        IF DiasTrabajados < 0 THEN
                            DiasTrabajados := 1
                        ELSE
                            IF "Fecha salida empresa" <= PrecioPto."Fecha de Corte" THEN
                                DiasTrabajados := DiasTrabajados - 1;
                    END;

                DiasTrabajados := DiasTrabajados - DiasAusencia;
                IF DiasTrabajados < 0 THEN
                    DiasTrabajados := 1;

                //PtosEmpleados   := "Incentivos/Puntos" * DiasTrabajados;
                PtosEmpleados := "Incentivos/Puntos";
                MontoPropina := 0;

                IF DiasTrabajados > 0 THEN
                    //GRN   MontoPropina    := "TotalPropDistrib." / 15 * PtosEmpleados;

                    MontoPropina := "TotalPropDistrib." * PtosEmpleados;

                LinPerfSal.RESET;
                LinPerfSal.SETCURRENTKEY("No. empleado", "Concepto salarial");
                LinPerfSal.SETRANGE("No. empleado", "No.");
                LinPerfSal.SETRANGE("Concepto salarial", ConceptoSalarial);
                IF LinPerfSal.FIND('-') THEN BEGIN
                    LinPerfSal.Importe := MontoPropina;
                    LinPerfSal.Cantidad := 1;
                    LinPerfSal.MODIFY;
                END
                ELSE
                    //   CurrReport.SKIP;
                    blnMostrar := FALSE;


                /*   ERROR(Err003,"No. empleado",LinPerfSal.FIELDCAPTION("Concepto salarial"),conceptosalarial,
                         LinPerfSal.TABLECAPTION);
                */

                Diferencia := PrecioPto."Monto a Distribuir" - LinPerfSal.Importe;

            end;

            trigger OnPostDataItem()
            begin
                Ventana.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                IF ConceptoSalarial = '' THEN
                    ERROR(Err002);
                IF (FechaIni = 0D) OR (FechaFin = 0D) THEN
                    ERROR(Err001);

                ConfNomina.FINDFIRST;

                // Busca el record correspondiente al periodo de nomina que se va a generar
                PrecioPto.RESET;
                PrecioPto.SETRANGE("Concepto Salarial", ConceptoSalarial);
                PrecioPto.SETRANGE("Fecha de Corte", FechaIni, FechaFin);
                PrecioPto.FINDFIRST;

                TotalPtos := 0;
                TotalDias := 0;
                PromedioPtos := 0;

                // Filtra a los empleados que les toca propina aunque no est´Š¢n dentro del periodo
                // normal de la nomina. Si est´Š¢ despu´Š¢s de la fecha de corte de la propina se
                // incluye dentro del presente pago de nominas.
                Empleado.RESET;
                Empleado.SETFILTER("Fecha salida empresa", '> %1 & <= %2 | > %3 | = %4',
                                   PrecioPto."Fecha Ult. Corte", PrecioPto."Fecha de Corte",
                                   PrecioPto."Fecha de Corte", 0D);
                Empleado.SETFILTER("Employment Date", '<= %1', PrecioPto."Fecha de Corte");
                Empleado.SETFILTER("Calcular Nomina", '=%1', TRUE);
                Empleado.FIND('-');
                AModificar := COUNT;

                Ventana.OPEN(Msg001);

                AModificar := AModificar / 10000;
                Contador := 0;

                WITH Empleado DO
                    REPEAT
                        DiasTrabajados := 15;
                        DiasAusencia := 0;
                        FechaIniAusencia := 0D;
                        FechaFinAusencia := 0D;

                        Ausencia.RESET;
                        Ausencia.SETRANGE("Employee No.", "No.");
                        Ausencia.SETRANGE(Ausencia."From Date", PrecioPto."Fecha Ult. Corte", PrecioPto."Fecha de Corte");
                        Ausencia.SETFILTER(Ausencia.Quantity, '<>%1', 0);
                        IF Ausencia.FIND('-') THEN
                            REPEAT
                                IF "Fecha salida empresa" >= Ausencia."To Date" THEN BEGIN
                                    FechaIniAusencia := Ausencia."From Date";
                                    FechaFinAusencia := Ausencia."To Date";
                                    DiasAusencia := FechaFinAusencia - FechaIniAusencia + 1;
                                END
                                ELSE
                                    IF "Fecha salida empresa" = 0D THEN BEGIN
                                        FechaIniAusencia := Ausencia."From Date";
                                        FechaFinAusencia := Ausencia."To Date";
                                        DiasAusencia := FechaFinAusencia - FechaIniAusencia + 1;
                                    END;
                            UNTIL Ausencia.NEXT = 0;

                        IF "Employment Date" > PrecioPto."Fecha Ult. Corte" THEN
                            IF "Employment Date" <= PrecioPto."Fecha de Corte" THEN
                                DiasTrabajados := PrecioPto."Fecha de Corte" - "Employment Date" + 1;

                        IF "Fecha salida empresa" <> 0D THEN
                            IF "Fecha salida empresa" <= PrecioPto."Fecha de Corte" THEN BEGIN
                                DiasTrabajados := "Fecha salida empresa" - PrecioPto."Fecha Ult. Corte" + 1;
                                IF DiasTrabajados < 0 THEN
                                    DiasTrabajados := 1
                                ELSE
                                    IF "Fecha salida empresa" <= PrecioPto."Fecha de Corte" THEN
                                        DiasTrabajados := DiasTrabajados - 1;
                            END;

                        DiasTrabajados := DiasTrabajados - DiasAusencia;
                        IF DiasTrabajados < 0 THEN
                            DiasTrabajados := 1;

                        //     TotalPtos := TotalPtos + ("Incentivos/Puntos" * DiasTrabajados);
                        TotalPtos := TotalPtos + ("Incentivos/Puntos");
                    UNTIL Empleado.NEXT = 0;

                PromedioPtos := TotalPtos / 15;
                //GRN "TotalPropDistrib." := PrecioPto."Monto a Distribuir"/PromedioPtos;
                "TotalPropDistrib." := PrecioPto."Monto a Distribuir";


                /*GRN
                MESSAGE('Promedio ptos %1',PromedioPtos);
                MESSAGE('Total puntos %1',TotalPtos);
                MESSAGE('Total a distrib. %1', "TotalPropDistrib.");
                
                
                Empleado.RESET;
                Empleado.SETFILTER("Fecha salida empresa",'> %1 & <= %2 | > %3 | = %4',
                                   PrecioPto."Fecha Ult. Corte",PrecioPto."Fecha de Corte",
                                   PrecioPto."Fecha de Corte",0D);
                Empleado.SETFILTER("Fecha Ingreso empresa",'<= %1',PrecioPto."Fecha de Corte");
                Empleado.SETRANGE("Calcular Nomina", TRUE);
                Empleado.FINDfirst;
                */
                ConfNomina.GET();
                //ConfNomina.TESTFIELD("Incidencias Ausencia Propinas");
                //ConfNomina.TESTFIELD("Concepto Salarial Incentivos");
                CurrReport.CREATETOTALS(LinPerfSal.Importe, "Incentivos/Puntos", PromedioPtos);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Concepto salarial"; ConceptoSalarial)
                {
                    TableRelation = "Conceptos salariales".Codigo;
                }
                field("Fecha inicio"; FechaIni)
                {

                    trigger OnValidate()
                    begin
                        Dia := DATE2DMY(FechaIni, 1);
                        IF (Dia <> 1) AND (Dia <> 16) THEN
                            ERROR('La fecha Inicial debe ser Dia 1 o Dia 16');
                        Mes := DATE2DMY(FechaIni, 2);
                        Ano := DATE2DMY(FechaIni, 3);
                        IF Dia = 1 THEN
                            FechaFin := DMY2DATE(15, Mes, Ano)
                        ELSE BEGIN
                            Inicio := DMY2DATE(1, Mes, Ano);
                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start", Inicio);
                            IF Fecha.FIND('-') THEN
                                FechaFin := NORMALDATE(Fecha."Period End");
                        END;
                    end;
                }
                field("Fecha final"; FechaFin)
                {
                    Editable = false;
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

    var
        Empleado: Record 5200;
        PrecioPto: Record 34002126;
        Ausencia: Record 5207;
        ConfNomina: Record 34002103;
        Fecha: Record 2000000007;
        LinPerfSal: Record 34002115;
        ImporteTotal: Decimal;
        Ventana: Dialog;
        AModificar: Decimal;
        Contador: Decimal;
        Dia: Integer;
        Mes: Integer;
        Ano: Integer;
        Inicio: Date;
        DiasTrabajados: Integer;
        DiasAusencia: Integer;
        Diferencia: Decimal;
        PromedioPtos: Decimal;
        TotalPtos: Decimal;
        TotalDias: Decimal;
        "TotalPropDistrib.": Decimal;
        PtosEmpleados: Decimal;
        MontoPropina: Decimal;
        FechaIni: Date;
        FechaFin: Date;
        FechaIniAusencia: Date;
        FechaFinAusencia: Date;
        Msg001: Label 'Processing ...          \\    @1@@@@@@@@@@@@@    \';
        Err001: Label 'Specify Initial and Final Dates';
        ConceptoSalarial: Code[10];
        Err002: Label 'Specify Wage code for Incentive/Tip';
        Err003: Label 'Employee # %1 doesn''t have %2 %3 in %4';
        blnMostrar: Boolean;
        Employee__Full_Name_CaptionLbl: Label 'Apellidos y nombres';
        Employee__Incentivos_Puntos_CaptionLbl: Label 'Incentivos / Puntos';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Incentive_Tips_DistributionCaptionLbl: Label 'Incentive/Tips Distribution';
        Importe_a_Distribuir_CaptionLbl: Label 'Importe a Distribuir:';
        ImporteCaptionLbl: Label 'Importe';
        DiasTrabajadosCaptionLbl: Label 'Dias Cotizados';
        Fecha_de_Cancelaci_nCaptionLbl: Label 'Fecha de Cancelacion';
        Fecha_Ult__CorteCaptionLbl: Label 'Fecha Ult. Corte';
        FechaIniAusenciaCaptionLbl: Label 'Fecha Inicio Ausencia';
        FechaFinAusenciaCaptionLbl: Label 'Fecha Fin Ausencia';
        TotalCaptionLbl: Label 'Total';
        Diferencia_CaptionLbl: Label 'Diferencia:';
}

