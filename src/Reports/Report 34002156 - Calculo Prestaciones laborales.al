report 34002156 "Calculo Prestaciones laborales"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Calculo Prestaciones laborales.rdl';
    Caption = 'Calculation of labor benefits';

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(MontoCesantia; MontoCesantia)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(DiasCesantia; DiasCesantia)
            {
            }
            column(MontoPreaviso; MontoPreaviso)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(DiasPreaviso; DiasPreaviso)
            {
            }
            column(Importe_SFS; ImporteSFS)
            {
            }
            column(Importe_AFP; ImporteAFP)
            {
            }
            column(Employee__Global_Dimension_2_Code_; Depto.Descripcion)
            {
            }
            column(Employee_Employee__Full_Name_; "Full Name")
            {
            }
            column(RegRegUdadCotiz__Nombre_Empresa_cotizaci_n_; RegRegUdadCotiz."Nombre Empresa cotizacion")
            {
            }
            column(MontoRegalia; MontoRegalia)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(AcumuladoRegalia; AcumuladoRegalia)
            {
            }
            column(MontoVacaciones; MontoVacaciones)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(DiasVacaciones; DiasVacaciones)
            {

            }
            column(MontoCesantia___MontoPreaviso____MontoRegalia___MontoVacaciones___MontoRestante; (MontoCesantia + MontoPreaviso) + MontoRegalia + MontoVacaciones + MontoRestante)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(Categor__Descripci_n_; Categor.Descripcion)
            {
            }
            column(Employee__Employment_Date_; FORMAT("Employment Date", 0, '<Day,2> <Month Text> <Year4>'))
            {
            }
            column(Employee__Termination_Date_; FORMAT("Termination Date", 0, '<Day,2> <Month Text> <Year4>'))
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(Document_ID; "Document ID")
            {
            }
            column(Causa_Salida; Contrato."Causa de la Baja")
            {
            }
            column(FORMAT_GAno______A_os_______FORMAT_GMes______Meses______FORMAT__GD_a_______D_as_; FORMAT(GAno) + ' Anos, ' + FORMAT(GMes) + ' Meses, ' + FORMAT(GDia) + ' Dias')
            {
            }
            column(PromedioSalarioAnual; PromedioSalarioAnual)
            {
                AutoFormatType = 1;
            }
            column(PromedioSalarioMensual; PromedioSalarioMensual)
            {
                AutoFormatType = 1;
            }
            column(PromedioSalarioDiario; PromedioSalarioDiario)
            {
                AutoFormatType = 1;
            }
            column(Employee_Salario; UltimoSalario)
            {
                AutoFormatType = 1;
            }
            column(PromedioSalarioDiario_Control83; PromedioSalarioDiario)
            {
                AutoFormatType = 1;
            }
            column(PromedioSalarioDiario_Control88; PromedioSalarioDiario)
            {
                AutoFormatType = 1;
            }
            column(PromedioSalarioDiarioVac; PromedioSalarioDiarioVac)
            {
                AutoFormatType = 1;
            }
            column(DMY2DATE_1_DATE2DMY__Termination_Date__2__DATE2DMY__Termination_Date__3__; DMY2DATE(1, DATE2DMY("Termination Date", 2), DATE2DMY("Termination Date", 3)))
            {

            }
            column(Employee__Termination_Date__Control104; "Fin contrato")
            {

            }
            column(Monto_Restante; MontoRestante)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(AvanceSalario; AvanceSalario)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(MontoaDeducir; MontoaDeducir)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(AvanceSalario___MontoaDeducir; AvanceSalario + MontoaDeducir)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(MontoCesantia___MontoPreaviso____MontoRegalia___MontoVacaciones___MontoRestante_____AvanceSalario___MontoaDeducir__; (MontoCesantia + MontoPreaviso + MontoRegalia + MontoVacaciones + MontoRestante) + (AvanceSalario + MontoaDeducir + ImporteAFP + ImporteSFS + OtrasDeducciones))
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(MontoCesantia___MontoPreaviso; MontoCesantia + MontoPreaviso)
            {
                AutoFormatType = 1;
                DecimalPlaces = 2 : 2;
            }
            column(Devolucion_ISR; DevolucionISR)
            {
            }
            column(Otras_Deducciones; OtrasDeducciones)
            {
            }
            column(II__CESANTIACaption; II__CESANTIACaptionLbl)
            {
            }
            column(RD_Caption; RD_CaptionLbl)
            {
            }
            column(D_asCaption; D_asCaptionLbl)
            {
            }
            column(I__PREAVISOCaption; I__PREAVISOCaptionLbl)
            {
            }
            column(Nombres_y_ApellidosCaption; Nombres_y_ApellidosCaptionLbl)
            {
            }
            column(V__REGALIACaption; V__REGALIACaptionLbl)
            {
            }
            column(III__VACACIONESCaption; III__VACACIONESCaptionLbl)
            {
            }
            column(Gerencia_de_Recursos_HumanosCaption; Gerencia_de_Recursos_HumanosCaptionLbl)
            {
            }
            column(LIQUIDACION_DE_PRESTACIONES_LABORALESCaption; LIQUIDACION_DE_PRESTACIONES_LABORALESCaptionLbl)
            {
            }
            column(DepartamentoCaption; DepartamentoCaptionLbl)
            {
            }
            column(CargoCaption; CargoCaptionLbl)
            {
            }
            column(Fecha_de_IngresoCaption; Fecha_de_IngresoCaptionLbl)
            {
            }
            column(Fecha_de_SalidaCaption; Fecha_de_SalidaCaptionLbl)
            {
            }
            column(Tiempo_TrabajadoCaption; Tiempo_TrabajadoCaptionLbl)
            {
            }
            column(Sueldo_devengado_en_el__ltimo_a_oCaption; Sueldo_devengado_en_el__ltimo_a_oCaptionLbl)
            {
            }
            column(Promedio_Mensual_RD_Caption; Promedio_Mensual_RD_CaptionLbl)
            {
            }
            column(Promedio_DiarioCaption; Promedio_DiarioCaptionLbl)
            {
            }
            column(Ultimo_Sueldo_Mensual_RD_Caption; Ultimo_Sueldo_Mensual_RD_CaptionLbl)
            {
            }
            column(DETALLES_DE_LIQUIDACION_DE_PRESTACIONES_LABORALESCaption; DETALLES_DE_LIQUIDACION_DE_PRESTACIONES_LABORALESCaptionLbl)
            {
            }
            column(SFS_Caption; SFSCaption)
            {
            }
            column(AFP_Caption; AFPCaption)
            {
            }
            column(D_asCaption_Control86; D_asCaption_Control86Lbl)
            {
            }
            column(RD_Caption_Control89; RD_Caption_Control89Lbl)
            {
            }
            column(D_asCaption_Control90; D_asCaption_Control90Lbl)
            {
            }
            column(RD_Caption_Control95; RD_Caption_Control95Lbl)
            {
            }
            column(TOTAL_LIQUIDACION_PRESTACIONES_LABORALESCaption; TOTAL_LIQUIDACION_PRESTACIONES_LABORALESCaptionLbl)
            {
            }
            column(IV__Salario_devengado_del_Caption; IV__Salario_devengado_del_CaptionLbl)
            {
            }
            column(alCaption; alCaptionLbl)
            {
            }
            column(RD_Caption_Control105; RD_Caption_Control105Lbl)
            {
            }
            column(RD_Caption_Control109; RD_Caption_Control109Lbl)
            {
            }
            column(TOTAL_DE_PAGOSCaption; TOTAL_DE_PAGOSCaptionLbl)
            {
            }
            column(RD_Caption_Control113; RD_Caption_Control113Lbl)
            {
            }
            column(Otras_DeduccionesCaption; Otras_DeduccionesCaptionLbl)
            {
            }
            column(RD_Caption_Control117; RD_Caption_Control117Lbl)
            {
            }
            column(Avance_SalariosCaption; Avance_SalariosCaptionLbl)
            {
            }
            column(RD_Caption_Control121; RD_Caption_Control121Lbl)
            {
            }
            column(TOTAL_DEDUCCIONESCaption; TOTAL_DEDUCCIONESCaptionLbl)
            {
            }
            column(NETO_A_PAGARCaption; NETO_A_PAGARCaptionLbl)
            {
            }
            column(RD_Caption_Control127; RD_Caption_Control127Lbl)
            {
            }
            column(RD_Caption_Control128; RD_Caption_Control128Lbl)
            {
            }
            column(Aprobado_porCaption; Aprobado_porCaptionLbl)
            {
            }
            column(FechaCaption; FechaCaptionLbl)
            {
            }
            column(MENOS__Caption; MENOS__CaptionLbl)
            {
            }
            column(Recibido_ConformeCaption; Recibido_ConformeCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(Pago_Dias_Adci_Captionlbl; PagoDiasAdi_Captionlbl)
            {
            }
            dataitem("Perfil Salarial"; 34002115)
            {
                DataItemLink = "No. empleado" = FIELD("No.");
                DataItemTableView = SORTING("No. empleado", "Perfil salarial", "Concepto salarial", Cargo)
                                    ORDER(Ascending)
                                    WHERE("Salario Base" = FILTER(true));

                trigger OnAfterGetRecord()
                begin
                    //Busco tipo de nomina regular
                    TiposdenominasReg.RESET;
                    TiposdenominasReg.SETRANGE("Tipo de nomina", TiposdenominasReg."Tipo de nomina"::Regular);
                    TiposdenominasReg.FINDFIRST;

                    HistLinNom.RESET;
                    HistLinNom.SETRANGE("No. empleado", Employee."No.");
                    HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
                    HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto Preaviso");
                    HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
                    IF HistLinNom.FINDLAST THEN BEGIN
                        PromedioSalarioMensual := ROUND(HistLinNom."Importe Base" * 23.83, 0.01);
                        PromedioSalarioAnual := PromedioSalarioMensual * 12;
                        PromedioSalarioDiario := HistLinNom."Importe Base";
                        UltimoSalario := 0;

                        HistCabNom.RESET;
                        HistCabNom.SETRANGE("No. empleado", Employee."No.");
                        HistCabNom.SETRANGE("Tipo de nomina", TiposdenominasReg.Codigo);
                        HistCabNom.FINDLAST;

                        HistLinNom.RESET;
                        HistLinNom.SETRANGE("No. empleado", Employee."No.");
                        HistLinNom.SETRANGE(Periodo, HistCabNom.Periodo);
                        HistLinNom.SETRANGE("Tipo de nomina", TiposdenominasReg.Codigo);
                        HistLinNom.SETRANGE("Salario Base", TRUE);
                        HistLinNom.FINDSET;
                        REPEAT
                            UltimoSalario += HistLinNom."Importe Base";
                        UNTIL HistLinNom.NEXT = 0;
                        CalcularDesdeHistorico := TRUE;
                    END
                    ELSE
                        IF NOT Calculoenbaseultimosalario THEN
                            BuscaSalarioPromedio
                        ELSE BEGIN
                            Salario := Importe;
                            UltimoSalario := Importe;
                            HistLinNom.RESET;
                            HistLinNom.SETRANGE("No. empleado", Employee."No.");
                            HistLinNom.SETRANGE(Periodo, CALCDATE('-1' + CDateSymbol, DMY2DATE(1, DATE2DMY(Employee."Termination Date", 2), DATE2DMY(Employee."Termination Date", 3))),
                                                        Employee."Termination Date");
                            HistLinNom.SETRANGE("Salario Base", TRUE);
                            IF HistLinNom.FINDSET THEN
                                REPEAT
                                    PromedioSalarioAnual += HistLinNom.Total;
                                UNTIL HistLinNom.NEXT = 0;

                            PromedioSalarioMensual := UltimoSalario;
                            /*
                            IF GAno > 0 THEN
                              MontoRegalia  := UltimoSalario / 12
                            ELSE
                              MontoRegalia  := UltimoSalario / 12 * GMes;
                            */
                            HistLinNom.RESET;
                            HistLinNom.SETRANGE("No. empleado", Employee."No.");
                            HistLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Employee."Termination Date", 3)),
                                                        Employee."Termination Date");
                            HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                            IF HistLinNom.FINDSET THEN
                                REPEAT
                                    MontoRegalia += HistLinNom.Total;
                                UNTIL HistLinNom.NEXT = 0;
                            MontoRegalia := MontoRegalia / 12;
                            PromedioSalarioDiario := PromedioSalarioMensual / 23.83;
                        END;

                    IF (CalcularPreaviso) OR (CalcularDesdeHistorico) THEN
                        CalculoPreaviso(MontoPreaviso);

                    IF (CalcularCesantia) OR (CalcularDesdeHistorico) THEN
                        CalculoCesantea(MontoCesantia);

                    IF (NOT VacacionesPagadas) OR (CalcularDesdeHistorico) THEN
                        CalculoVacaciones(MontoVacaciones);

                    //GRN IF "Pagar Regalia" THEN
                    IF NOT Calculoenbaseultimosalario THEN
                        CalculoRegalia(MontoRegalia);

                    //IF DiasSalario <> 0 THEN
                    CompletivoUltSalarioNom(MontoRestante);


                    CalcularDtosLegales;


                    OtrasDeducciones := 0;
                    HistLinNom.RESET;
                    HistLinNom.SETRANGE("No. empleado", Employee."No.");
                    HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Deducciones);
                    HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
                    HistLinNom.SETFILTER("Concepto salarial", '<>%1&<>%2', ConfNominas."Concepto AFP", ConfNominas."Concepto SFS");
                    HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
                    //ERROR('%1',HistLinNom.GETFILTERS);
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            OtrasDeducciones += HistLinNom.Total;
                        UNTIL HistLinNom.NEXT = 0;
                    MontoCalculoGral := ROUND((MontoPreaviso + MontoCesantia + MontoRegalia + MontoVacaciones + MontoRestante),
                                               ConfCG."Amount Rounding Precision");
                    //"Salida%"        := FORMAT(MontoCalculoGral);

                    //MontoCalculoCesantia := ROUND((MontoCesantia + MontoPreaviso), rCongCG."Amount Rounding Precision");
                    EXIT;

                end;

                trigger OnPreDataItem()
                begin
                    ConfCG.GET();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Categor.GET(Departamento, "Job Type Code");
                InicializaVariables;
                IF "Termination Date" = 0D THEN
                    "Termination Date" := WORKDATE;

                Depto.GET(Departamento);
                IF NOT Bco.GET("Disponible 1") THEN
                    Bco.INIT;

                RegRegUdadCotiz.GET(Company);

                AnoTrabajo := DATE2DMY("Termination Date", 3);
                MesTrabajo := DATE2DMY("Termination Date", 2);
                diaTrabajo := DATE2DMY("Termination Date", 1);

                CalculoFechas.CalculoEntreFechas(Employee."Employment Date", Employee."Termination Date", Anos, Meses, Dias);
                IF NOT IncluirFechaSalida THEN
                    Dias -= 1;

                GAno := Anos;
                GMes := Meses;
                GDia := Dias;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                ConfNominas.TESTFIELD("Concepto Preaviso");
                ConfNominas.TESTFIELD("Concepto Cesantia");

                Tiposdenominas.RESET;
                Tiposdenominas.SETRANGE("Tipo de nomina", Tiposdenominas."Tipo de nomina"::Prestaciones);
                Tiposdenominas.FINDFIRST;

                CalcularDesdeHistorico := FALSE;
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
                field("Vacaciones pagadas"; VacacionesPagadas)
                {
                    ApplicationArea = All;
                    ToolTip = 'Vacaciones pagadas';
                }
                field(CalcularPreaviso; CalcularPreaviso)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Notificacion';
                    ToolTip = 'Calculate Notificacion';
                }
                field(CalcularCesantia; CalcularCesantia)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Censantea';
                    ToolTip = 'Calculate Censantea';
                }
                field("Pagar Regalia"; "Pagar Regalia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar Regalia';
                }
                field(Calculoenbaseultimosalario; Calculoenbaseultimosalario)
                {
                    ApplicationArea = All;
                    Caption = 'Calculation based on last salary';
                    ToolTip = 'Calculation based on last salary';
                }
                field(IncluirFechaSalida; IncluirFechaSalida)
                {
                    ApplicationArea = All;
                    Caption = 'Include end date in calculation';
                    ToolTip = 'Include end date in calculation';
                }
                field("Dias diferencia salario"; DiasSalario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias diferencia salario';
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
        ConfCG: Record 98;
        Categor: Record 34002110;
        RegRegUdadCotiz: Record 34002100;
        Bco: Record 34002139;
        Fecha: Record 2000000007;
        HistoricoSalarios: Record 34002149;
        Depto: Record 34002135;
        Contrato: Record 34002109;
        HistCabNom: Record 34002117;
        HistLinNom: Record 34002118;
        PerfilSal: Record 34002115;
        ConfNominas: Record 34002103;
        Tiposdenominas: Record 34002158;
        TiposdenominasReg: Record 34002158;
        CalculoFechas: Codeunit 34002104;
        Salario: Decimal;
        FechaCalculo: Date;
        GAno: Integer;
        GMes: Integer;
        GDia: Integer;
        ImportePreaviso: Decimal;
        ImporteCesantia: Decimal;
        ImporteAFP: Decimal;
        ImporteSFS: Decimal;
        DevolucionISR: Decimal;
        DiasPreaviso: Integer;
        DiasCesantia: Integer;
        DiasVacaciones: Integer;
        MontoPreaviso: Decimal;
        MontoCesantia: Decimal;
        MontoRegalia: Decimal;
        AcumuladoRegalia: Decimal;
        MontoVacaciones: Decimal;
        VacacionesPagadas: Boolean;
        "Pagar Regalia": Boolean;
        CalcularPreaviso: Boolean;
        CalcularCesantia: Boolean;
        FechaProceso: Date;
        MesesRegalia: Integer;
        UltimoSalario: Decimal;
        PromedioSalarioAnual: Decimal;
        PromedioSalarioMensual: Decimal;
        PromedioSalarioDiario: Decimal;
        InicioAno: Date;
        MontoRestante: Decimal;
        AvanceSalario: Decimal;
        OtrasDeducciones: Decimal;
        DiasSalario: Integer;
        PromedioSalarioDRegalia: Decimal;
        ImporteSueldoAcumulado: Decimal;
        MesesAcumulado: Decimal;
        MontoaDeducir: Decimal;
        PromedioSalarioDiarioVac: Decimal;
        MontoCalculoGral: Decimal;
        MontoCalculoCesantia: Decimal;
        SalidaCesantia: Text[30];
        AnoTrabajo: Integer;
        MesTrabajo: Integer;
        diaTrabajo: Integer;
        DiasReg: Integer;
        CDateSymbol: Label 'Y';
        II__CESANTIACaptionLbl: Label 'II. CESANTIA';
        RD_CaptionLbl: Label 'RD$';
        D_asCaptionLbl: Label 'Dias';
        I__PREAVISOCaptionLbl: Label 'I. PREAVISO';
        Nombres_y_ApellidosCaptionLbl: Label 'Full name';
        V__REGALIACaptionLbl: Label 'IV. REGALIA';
        III__VACACIONESCaptionLbl: Label 'III. VACACIONES';
        Gerencia_de_Recursos_HumanosCaptionLbl: Label 'Gerencia de Recursos Humanos';
        LIQUIDACION_DE_PRESTACIONES_LABORALESCaptionLbl: Label 'CALCULATION OF LABOR BENEFITS';
        DepartamentoCaptionLbl: Label 'Department';
        CargoCaptionLbl: Label 'Position';
        Fecha_de_IngresoCaptionLbl: Label 'Employment date';
        Fecha_de_SalidaCaptionLbl: Label 'Termination Date';
        Tiempo_TrabajadoCaptionLbl: Label 'Worked time';
        Sueldo_devengado_en_el__ltimo_a_oCaptionLbl: Label 'Acumulado Salario de Navidad';
        Promedio_Mensual_RD_CaptionLbl: Label 'Monthly average RD$';
        Promedio_DiarioCaptionLbl: Label 'Daily average';
        Ultimo_Sueldo_Mensual_RD_CaptionLbl: Label 'Last monthly salary RD$';
        DETALLES_DE_LIQUIDACION_DE_PRESTACIONES_LABORALESCaptionLbl: Label 'DETALLES DE LIQUIDACION DE PRESTACIONES LABORALES';
        D_asCaption_Control86Lbl: Label 'Dias';
        RD_Caption_Control89Lbl: Label 'RD$';
        D_asCaption_Control90Lbl: Label 'Dias';
        RD_Caption_Control95Lbl: Label 'RD$';
        TOTAL_LIQUIDACION_PRESTACIONES_LABORALESCaptionLbl: Label 'TOTAL LIQUIDACION PRESTACIONES LABORALES';
        IV__Salario_devengado_del_CaptionLbl: Label 'IV. Salario devengado del ';
        alCaptionLbl: Label 'al';
        RD_Caption_Control105Lbl: Label 'RD$';
        RD_Caption_Control109Lbl: Label 'RD$';
        TOTAL_DE_PAGOSCaptionLbl: Label 'TOTAL DE PAGOS';
        RD_Caption_Control113Lbl: Label 'RD$';
        Otras_DeduccionesCaptionLbl: Label 'Otras Deducciones';
        RD_Caption_Control117Lbl: Label 'RD$';
        Avance_SalariosCaptionLbl: Label 'Avance Salarios';
        RD_Caption_Control121Lbl: Label 'RD$';
        TOTAL_DEDUCCIONESCaptionLbl: Label 'TOTAL DEDUCCIONES';
        NETO_A_PAGARCaptionLbl: Label 'NETO A PAGAR';
        RD_Caption_Control127Lbl: Label 'RD$';
        RD_Caption_Control128Lbl: Label 'RD$';
        Aprobado_porCaptionLbl: Label 'Aprobado por';
        FechaCaptionLbl: Label 'Fecha';
        MENOS__CaptionLbl: Label 'MENOS :';
        Recibido_ConformeCaptionLbl: Label 'Recibido Conforme';
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        Calculoenbaseultimosalario: Boolean;
        SFSCaption: Label 'V. Seguro Familiar de Salud';
        AFPCaption: Label 'VI. Fondo de Pensiones';
        IncluirFechaSalida: Boolean;
        PagoDiasAdi_Captionlbl: Label 'Payment extra days worked';
        CalcularDesdeHistorico: Boolean;

    procedure CalculoPreaviso(var MontoPreaviso: Decimal)
    var
        FechaCalculo: Date;
        CantidadAnos: Integer;
    begin
        IF Anos = 0 THEN
            IF Meses > 0 THEN BEGIN
                IF (Meses >= 3) AND (Meses < 6) THEN
                    DiasPreaviso := 7
                ELSE
                    IF (Meses >= 6) AND (Meses < 12) THEN
                        DiasPreaviso := 14
                    ELSE
                        IF Meses = 12 THEN
                            DiasPreaviso := 28;
            END
            ELSE
                IF Anos > 0 THEN
                    DiasPreaviso := 28
                ELSE
                    EXIT
        ELSE
            DiasPreaviso := 28;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto Preaviso");
        //HistLinNom.SETRANGE(Periodo,Employee."Termination Date", CALCDATE('+45D',Employee."Termination Date"));
        IF HistLinNom.FINDLAST THEN BEGIN
            DiasPreaviso := HistLinNom.Cantidad;
            MontoPreaviso := HistLinNom.Total;
            //  MESSAGE('%',MontoPreaviso);
        END
        ELSE
            MontoPreaviso := PromedioSalarioDiario * DiasPreaviso;
    end;

    procedure CalculoCesantea(LMontoCesantea: Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
    begin
        CalculoFechas.CalculoEntreFechas(Employee."Employment Date", Employee."Termination Date", Anos, Meses, Dias);

        IF Anos = 0 THEN
            IF Meses > 0 THEN BEGIN
                IF (Meses >= 3) AND (Meses < 6) THEN
                    DiasCesantia := 6
                ELSE
                    IF Meses >= 6 THEN
                        DiasCesantia := 13;
            END
            ELSE
                EXIT
        ELSE
            IF (Anos >= 1) AND (Anos < 5) THEN BEGIN
                DiasCesantia := 21 * Anos;

                IF ((Meses >= 3) AND ((Meses <= 6) AND (Dias = 0))) OR
                   ((Meses >= 3) AND (Meses < 6)) THEN
                    DiasCesantia += 6
                ELSE
                    IF (Meses >= 6) AND (Dias > 0) THEN
                        DiasCesantia += 13;
            END
            ELSE
                IF Anos >= 5 THEN BEGIN
                    IF Employee."Employment Date" < DMY2DATE(29, 5, 92) THEN
                        DiasCesantia := 15 * Anos
                    ELSE
                        DiasCesantia := 23 * Anos;

                    IF (Meses >= 3) AND (Meses <= 6) THEN
                        DiasCesantia += 6
                    ELSE
                        IF Meses >= 7 THEN
                            DiasCesantia += 13;
                END;

        SalidaCesantia := FORMAT(ROUND(PromedioSalarioDiario * DiasCesantia, 0.01));
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto Cesantia");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDFIRST THEN BEGIN
            DiasCesantia := HistLinNom.Cantidad;
            MontoCesantia := HistLinNom.Total;
        END
        ELSE
            MontoCesantia := PromedioSalarioDiario * DiasCesantia;
    end;

    procedure CalculoVacaciones(var MontoVacaciones: Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
    begin
        //Vacaciones
        CalculoFechas.CalculoEntreFechas(Employee."Employment Date", Employee."Termination Date", Anos, Meses, Dias);
        DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Employee."No.", MesTrabajo, AnoTrabajo, MontoVacaciones, Employee."Employment Date", Employee."Fecha salida empresa");
        /*
        PromedioSalarioDiarioVac := "Perfil Salarial".Importe / 23.83;
        MontoVacaciones          := PromedioSalarioDiarioVac * DiasVacaciones;
        */
        MontoVacaciones := 0;
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Ingresos);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDSET THEN
            REPEAT
                MontoVacaciones += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

    end;

    procedure CalculoRegalia(var MontoRegalia: Decimal)
    var
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        FechaIni: Date;
    begin
        //Regalia
        IF (DATE2DMY(Employee."Employment Date", 3) < DATE2DMY(WORKDATE, 3)) AND (Employee."Termination Date" = 0D) THEN BEGIN
            FechaIni := DMY2DATE(1, 1, DATE2DMY(WORKDATE, 3));
            CalculoFechas.CalculoEntreFechas(FechaIni, Employee."Termination Date", Anos, Meses, Dias);
        END
        ELSE
            CalculoFechas.CalculoEntreFechas(Employee."Employment Date", Employee."Termination Date", Anos, Meses, Dias);

        MesesRegalia := Meses;

        Employee.SETRANGE("Date Filter", DMY2DATE(1, 1, DATE2DMY(WORKDATE, 3)), DMY2DATE(31, 12, DATE2DMY(WORKDATE, 3)));

        Employee.CALCFIELDS("Acumulado Salario");

        //message('%1 %2 %3 %4',employee."acumulado salario",promediosalariodregalia,montoregalia,dias);
        /*
        IF MesesRegalia < 12 THEN
           BEGIN
             MontoRegalia := Employee."Acumulado Salario";
             IF Dias <> 0 THEN
                MontoRegalia := PromedioSalarioDRegalia * Dias;
        
             MontoRegalia /= 12;
           END
        ELSE
           MontoRegalia := Employee."Acumulado Salario";
        */
        //Busco el acumulado de regalia en el periodo
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Employee."Termination Date", 3)),
                                    Employee."Termination Date");
        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                AcumuladoRegalia += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;

        MontoRegalia := AcumuladoRegalia / 12;

        DiasReg := Dias;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto Regalia");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDFIRST THEN
            MontoRegalia := HistLinNom.Total

    end;

    procedure BuscaSalarioPromedio()
    var
        Periodo: array[12] of Decimal;
        Salarios: array[12] of Decimal;
        TotalTiempoTrabajado: Decimal;
        TotalPeriodo: Decimal;
        M: Integer;
        N: Integer;
    begin
        //Salario Promedio
        //Busco la ultima nomina regular
        HistCabNom.RESET;
        HistCabNom.SETRANGE("No. empleado", Employee."No.");
        HistCabNom.SETRANGE("Tipo de nomina", TiposdenominasReg.Codigo);
        HistCabNom.FINDLAST;
        /*
        PerfilSal.SETRANGE("No. empleado", Employee."No.");
        PerfilSal.SETRANGE("Tipo concepto", "Perfil Salarial"."Tipo concepto"::Ingresos);
        PerfilSal.SETRANGE("Salario Base", TRUE);
        IF PerfilSal.FINDLAST THEN
           UltimoSalario := PerfilSal.Importe;
        */
        UltimoSalario := 0;
        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE(Periodo, HistCabNom.Periodo);
        HistLinNom.SETRANGE("Tipo de nomina", TiposdenominasReg.Codigo);
        HistLinNom.SETRANGE("Salario Base", TRUE);
        HistLinNom.FINDSET;
        REPEAT
            UltimoSalario += HistLinNom."Importe Base";
        UNTIL HistLinNom.NEXT = 0;

        CLEAR(Periodo);
        CLEAR(Salarios);
        M := 0;
        N := 0;
        PromedioSalarioAnual := 0;
        PromedioSalarioMensual := UltimoSalario;
        PromedioSalarioDiario := 0;
        TotalPeriodo := 0;
        MesesAcumulado := 12;


        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE(Periodo, CALCDATE('-1' + CDateSymbol, DMY2DATE(1, DATE2DMY(Employee."Termination Date", 2), DATE2DMY(Employee."Termination Date", 3))),
                                    Employee."Termination Date");
        HistLinNom.SETRANGE("Salario Base", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                PromedioSalarioAnual += HistLinNom.Total;
                ImporteSueldoAcumulado += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;
        /*
        
        HistoricoSalarios.RESET;
        HistoricoSalarios.SETRANGE("No. empleado", Employee."No.");
        HistoricoSalarios.SETRANGE("Fecha Hasta",CALCDATE('-1'+CDateSymbol,DMY2DATE(01,DATE2DMY(Employee."Termination Date",2),DATE2DMY(Employee."Termination Date",3))),
                                    Employee."Termination Date");
                                    //MESSAGE('%1',HistoricoSalarios.GETFILTERS);
        IF HistoricoSalarios.FINDSET THEN
          BEGIN
            WITH HistoricoSalarios DO
              REPEAT
                M := M + 1;
                IF "Fecha Hasta" <>0D THEN
                   Periodo[M]  := ("Fecha Hasta" - "Fecha Desde") / 30
                ELSE
                   Periodo[M]  := (Employee."Termination Date" - "Fecha Desde") / 30;
        
                Salarios[M] := Importe * Periodo[M];
        //        message('%1 %2 %3 %4',salarios[m],importe,periodo[m]);
              UNTIL HistoricoSalarios.NEXT = 0;
        
            FOR N := 1 TO M DO
              BEGIN
                PromedioSalarioAnual := PromedioSalarioAnual + Salarios[N];
                TotalPeriodo         := TotalPeriodo + Periodo[N];
              END;
        
            IF Calculoenbaseultimosalario THEN
               PromedioSalarioAnual := "Perfil Salarial".Importe;
            PromedioSalarioDRegalia  := UltimoSalario / 30;
        //GRN    PromedioSalarioMensual   := PromedioSalarioAnual / TotalPeriodo;
        //GRN    PromedioSalarioMensual   := ImporteSueldoAcumulado / MesesAcumulado / TotalPeriodo;
        //    MESSAGE('%1 %2 %3 %4',PromedioSalarioAnual,MesesAcumulado,PromedioSalarioAnual);
            PromedioSalarioMensual   := PromedioSalarioAnual / MesesAcumulado;
            PromedioSalarioDiario    := PromedioSalarioMensual / 23.83;
          END
        ELSE
        */
        BEGIN
            IF ImporteSueldoAcumulado <> 0 THEN BEGIN
                PromedioSalarioAnual := ImporteSueldoAcumulado;
                PromedioSalarioMensual := ImporteSueldoAcumulado / MesesAcumulado;
                PromedioSalarioDRegalia := ImporteSueldoAcumulado / 12;
                PromedioSalarioDiario := PromedioSalarioMensual / 23.83;
            END
            ELSE BEGIN
                PromedioSalarioAnual := UltimoSalario;
                PromedioSalarioMensual := UltimoSalario;
                PromedioSalarioDRegalia := UltimoSalario / 12;
                PromedioSalarioDiario := PromedioSalarioMensual / 23.83;
                PromedioSalarioAnual := ImporteSueldoAcumulado;
            END
        END;

    end;

    procedure InicializaVariables()
    begin
        GAno := 0;
        GMes := 0;
        GDia := 0;
        PromedioSalarioAnual := 0;
        PromedioSalarioMensual := 0;
        PromedioSalarioDiario := 0;
        Salario := 0;
        ImportePreaviso := 0;
        ImporteCesantia := 0;
        DiasPreaviso := 0;
        DiasCesantia := 0;
        DiasVacaciones := 0;
        MontoPreaviso := 0;
        MontoCesantia := 0;
        MontoRegalia := 0;
        MontoVacaciones := 0;
        MesesRegalia := 0;
        AcumuladoRegalia := 0;
        OtrasDeducciones := 0;
    end;

    procedure InicioReporte(StatusVacacionesParam: Boolean; PagarRegaliaParam: Boolean; DiasSalarioNomParam: Integer; ImporteAcumuladoParam: Decimal; MesesAcumuladoParam: Decimal; MontoDeduccionesParam: Decimal; PorcCesantia: Decimal; PorcPreaviso: Decimal; ProcMontoGral: Decimal)
    begin
        VacacionesPagadas := StatusVacacionesParam;
        "Pagar Regalia" := PagarRegaliaParam;
        DiasSalario := DiasSalarioNomParam;
        ImporteSueldoAcumulado := ImporteAcumuladoParam;
        MesesAcumulado := MesesAcumuladoParam;
        MontoaDeducir := MontoDeduccionesParam;
    end;

    procedure CompletivoUltSalarioNom(var completivoultsalarionomina: Decimal)
    begin
        Employee.CALCFIELDS(Salario);
        MontoRestante := ROUND(Employee.Salario / 23.83 * DiasSalario, 0.01);

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Tipo concepto", HistLinNom."Tipo concepto"::Ingresos);
        HistLinNom.SETFILTER("Concepto salarial", '<>%1&<>%2&<>%3&<>%4', ConfNominas."Concepto Regalia", ConfNominas."Concepto Vacaciones", ConfNominas."Concepto Cesantia", ConfNominas."Concepto Preaviso");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDSET THEN
            REPEAT
                MontoRestante += HistLinNom.Total;
            UNTIL HistLinNom.NEXT = 0;
    end;

    local procedure CalcularDtosLegales()
    var
        DeduccGob: Record 34002129;
    begin
        /*
        IF Employee."Excluido Cotizacion TSS" THEN
           EXIT;
        
        ConfNominas.GET();
        
        DeduccGob.RESET;
        DeduccGob.SETRANGE(Ano,AnoTrabajo);
        DeduccGob.SETFILTER("Porciento Empleado",'<>%1',0);
        IF DeduccGob.FINDSET THEN
           REPEAT
            IF ConfNominas."Concepto AFP" = DeduccGob.Codigo THEN
               ImporteAFP := (MontoVacaciones + MontoRestante) * DeduccGob."Porciento Empleado" /100
            ELSE
            IF ConfNominas."Concepto SFS" = DeduccGob.Codigo THEN
               ImporteSFS := (MontoVacaciones + MontoRestante) * DeduccGob."Porciento Empleado" /100;
           UNTIL DeduccGob.NEXT = 0;
        */
        ImporteAFP := ROUND(ImporteAFP, 0.01);
        ImporteSFS := ROUND(ImporteSFS, 0.01);

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto SFS");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDFIRST THEN
            ImporteSFS := HistLinNom.Total;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Employee."No.");
        HistLinNom.SETRANGE("Tipo de nomina", Tiposdenominas.Codigo);
        HistLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto AFP");
        HistLinNom.SETRANGE(Periodo, Employee."Termination Date", CALCDATE('+45D', Employee."Termination Date"));
        IF HistLinNom.FINDFIRST THEN
            ImporteAFP := HistLinNom.Total;

    end;
}

