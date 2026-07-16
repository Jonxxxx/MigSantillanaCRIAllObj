codeunit 34002104 "Funciones Nomina"
{

    trigger OnRun()
    begin

        //ProcesaDatosPonchador;
    end;

    var
        ConfNomina: Record 34002103;
        TiposCotiza: Record 34002129;
        Fecha: Record 2000000007;
        Empl: Record 5200;
        LinPerfSalarial: Record 34002115;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        FechaInicioMes: Date;
        AnoInicio: Integer;
        MesInicio: Integer;
        "DiaInicio": Integer;
        AnoFin: Integer;
        MesFin: Integer;
        "DiaFin": Integer;
        Text001: Label 'Processing Wedge... \ #1########## \ #2##############################';
        Text002: Label 'End of update';
        Text003: Label 'The Customer %1 had been created, you must finish the setup of the Posting Groups fields and unblock it to be able to use it.';
        Text004: Label 'The Resource %1 had been created, you must finish the setup of the Posting Groups fields and unblock it to be able to use it.';
        Text005: Label 'The Salesperson %1 had been created.';
        Err001: Label 'Starting date can''t be bigger than Ending date, %1 > %2';
        AsciiStr: Text[250];
        AnsiStr: Text[250];
        CharVar: array[32] of Char;
        OnesText: array[30] of Text[30];
        TensText: array[10] of Text[30];
        HundredsText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        HundredText: Text[30];
        AndText: Text[30];
        ZeroText: Text[30];
        CentsText: Text[30];
        OneMillionText: Text[30];
        ThousText: array[10] of Text[30];
        Text010: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Text011: Label 'All pending records have been processed, please check the data on employees';

    procedure CalculoEntreFechas(var FechaInicio: Date; var FechaFin: Date; var AnoCalculado: Integer; var MesCalculado: Integer; var "DiaCalculado": Integer): Date
    begin
        IF FechaInicio > FechaFin THEN
            ERROR(Err001, FechaInicio, FechaFin);


        AnoInicio := DATE2DMY(FechaInicio, 3);
        MesInicio := DATE2DMY(FechaInicio, 2);
        DiaInicio := DATE2DMY(FechaInicio, 1);
        AnoFin := DATE2DMY(FechaFin, 3);
        MesFin := DATE2DMY(FechaFin, 2);
        DiaFin := DATE2DMY(FechaFin, 1);
        FechaInicioMes := FechaInicio;

        AnoCalculado := AnoFin - AnoInicio;
        MesCalculado := MesFin - MesInicio;
        DiaCalculado := DiaFin - DiaInicio + 1;


        IF AnoCalculado = 0 THEN BEGIN
            IF DiaCalculado < 0 THEN BEGIN
                DiaCalculado += 30;
                MesCalculado -= 1;
                IF MesCalculado < 0 THEN BEGIN
                    MesCalculado += 12;
                    AnoCalculado -= 1;
                END;
            END
            ELSE BEGIN
                Fecha.RESET;
                Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, 1, DATE2DMY(FechaInicioMes, 3)));
                Fecha.FINDFIRST;
                IF DiaCalculado = DATE2DMY(Fecha."Period End", 1) THEN BEGIN
                    MesCalculado += 1;
                    DiaCalculado := 0;
                END;
            END;
        END
        ELSE
            IF (AnoCalculado = 1) AND (MesCalculado = 0) AND ((DiaCalculado = 1) OR (DiaCalculado = 0)) THEN
                AnoCalculado := 1
            ELSE BEGIN
                IF MesCalculado <= 0 THEN BEGIN
                    MesCalculado += 12;
                    AnoCalculado -= 1;
                    //DiaCalculado += 1;
                END;

                IF MesCalculado = 12 THEN BEGIN
                    MesCalculado := 0;
                    AnoCalculado += 1;
                END;

                IF DiaCalculado < 0 THEN BEGIN
                    DiaCalculado += 30;
                    MesCalculado -= 1;
                    IF MesCalculado < 0 THEN BEGIN
                        MesCalculado += 12;
                        AnoCalculado -= 1;
                    END
                    ELSE
                        IF MesCalculado = 0 THEN BEGIN
                            MesCalculado := 11;
                            AnoCalculado -= 1;
                            DiaCalculado += 1;
                        END;
                END
                ELSE BEGIN
                    Fecha.RESET;
                    Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, 1, DATE2DMY(FechaInicio, 3)));
                    Fecha.FINDFIRST;
                    IF DiaCalculado = DATE2DMY(Fecha."Period End", 1) THEN BEGIN
                        MesCalculado += 1;
                        DiaCalculado := 0;
                    END;
                END;
            END;



        //MESSAGE('Calculo entre fechas %1 %2 %3 %4', DiaCalculado, MesCalculado, AnoCalculado,FechaInicio);
    end;

    procedure CalculoDiaVacaciones(CodEmpl: Code[20]; MesTrabajo: Integer; AnoTrabajo: Integer; var MontoVacaciones: Decimal; FechaIngreso: Date; FechaFinal: Date) DiasVacaciones: Integer
    var
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        SueldoTotal: Decimal;
    begin
        // 6 dias de salario ordinario, si tiene más de cinco meses de servicio
        // 7 dias de salario ordinario, si tiene más de seis meses de servicio
        // 8 dias de salario ordinario, si tiene más de siete meses de servicio
        // 9 dias de salario ordinario, si tiene más de ocho meses de servicio
        //10 dias de salario ordinario, si tiene más de nueve meses de servicio
        //11 dias de salario ordinario, si tiene más de diez meses de servicio
        //12 dias de salario ordinario, si tiene más de once meses de servicio (Arts.180 y 182)
        ConfNomina.GET();
        SueldoTotal := 0;
        Empl.GET(CodEmpl);
        IF FechaIngreso = 0D THEN
            ERROR(Err001, CodEmpl);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");

        CalculoEntreFechas(FechaIngreso, FechaFin, Anos, Meses, Dias);
        //ERROR('%1 %2',FechaFin,Dias);
        /*
        IF DATE2DMY(FechaFin,1) = Dias THEN
          BEGIN
           Meses += 1;
          Dias := 0;
         END;
        */

        LinPerfSalarial.SETRANGE("No. empleado", CodEmpl);
        LinPerfSalarial.SETRANGE("Salario Base", TRUE);
        LinPerfSalarial.SETFILTER(Cantidad, '>%1', 0);
        LinPerfSalarial.SETFILTER(Importe, '<>%1', 0);
        LinPerfSalarial.SETFILTER("Concepto salarial", '<>%1', ConfNomina."Concepto Vacaciones");
        LinPerfSalarial.FINDSET;
        REPEAT
            IF LinPerfSalarial."Currency Code" <> '' THEN BEGIN
                SueldoTotal += LinPerfSalarial.Importe * ConfNomina."Tasa Cambio Calculo Divisa";
            END
            ELSE
                SueldoTotal += LinPerfSalarial.Importe;
        UNTIL LinPerfSalarial.NEXT = 0;

        IF (Anos >= 1) AND (Anos < 5) THEN
            DiasVacaciones := 14
        ELSE
            IF Anos >= 5 THEN
                DiasVacaciones := 18
            ELSE
                CASE Meses OF
                    5:
                        DiasVacaciones := 6;
                    6:
                        DiasVacaciones := 7;
                    7:
                        DiasVacaciones := 8;
                    8:
                        DiasVacaciones := 9;
                    9:
                        DiasVacaciones := 10;
                    10:
                        DiasVacaciones := 11;
                    11:
                        DiasVacaciones := 12;
                    ELSE
                        DiasVacaciones := 0;
                END;

        MontoVacaciones := SueldoTotal / 23.83 * DiasVacaciones;

        /*GRN 25/02/2020 Debo cambiar la programacion
        IF Anos >= 1 THEN
           DiasVacaciones := 14
        ELSE
           CASE Meses OF
             0..4:
              DiasVacaciones := 0;
             5:
              DiasVacaciones := 6;
             6:
              DiasVacaciones := 7;
             7:
              DiasVacaciones := 8;
             8:
              DiasVacaciones := 9;
             9:
              DiasVacaciones := 10;
            10:
              DiasVacaciones := 11;
            11:
              DiasVacaciones := 12;
            ELSE
              DiasVacaciones := 14;
           END;
        */
        // ERROR('%1 %2',DiasVacaciones,MontoVacaciones);
        EXIT(DiasVacaciones);

    end;

    procedure CalculoDiaVacacionesEC(CodEmpl: Code[20]; MesTrabajo: Integer; AnoTrabajo: Integer; MontoVacaciones: Decimal) DiasVacaciones: Integer
    var
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
    begin
        // 15 dias al primer año
        // 1 dia x cada año hasta llegar a 30

        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);

        Fecha.RESET;
        Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");

        CalculoEntreFechas(Empl."Employment Date", FechaFin, Anos, Meses, Dias);

        LinPerfSalarial.SETRANGE("No. empleado", CodEmpl);
        LinPerfSalarial.SETRANGE("Salario Base", TRUE);
        LinPerfSalarial.FINDFIRST;

        IF Anos = 1 THEN
            DiasVacaciones := 15
        ELSE
            IF Anos > 1 THEN
                DiasVacaciones += 1 * Anos - 1;

        IF DiasVacaciones > 30 THEN
            DiasVacaciones := 30;

        MontoVacaciones := LinPerfSalarial.Importe / 23.83 * DiasVacaciones;
    end;

    procedure CalculoDiaVacacionesCR(CodEmpl: Code[20]; MesTrabajo: Integer; AnoTrabajo: Integer; MontoVacaciones: Decimal) DiasVacaciones: Integer
    var
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        Contrato: Record 5211;
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
    begin
        // 1.83 dias de vacaciones, si tiene 1 año o mas por cada mes para los empleados fijos
        // 1    dia de vacaciones, por cada mes para los empleados temporales

        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");

        CalculoEntreFechas(Empl."Employment Date", FechaFin, Anos, Meses, Dias);

        Meses := Meses + (Anos * 12);

        LinPerfSalarial.SETRANGE("No. empleado", CodEmpl);
        LinPerfSalarial.SETRANGE("Salario Base", TRUE);
        LinPerfSalarial.FINDFIRST;

        Contrato.GET(Empl."Emplymt. Contract Code");
        IF Contrato.Undefined THEN
            DiasVacaciones := Meses * 1.83
        ELSE
            DiasVacaciones := Meses * 1;

        MontoVacaciones := LinPerfSalarial.Importe / 23.83 * DiasVacaciones;
    end;

    procedure CalculoDiaVacacionesPR(CodEmpl: Code[20]; MesTrabajo: Integer; AnoTrabajo: Integer; MontoVacaciones: Decimal) DiasVacaciones: Integer
    var
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        HistLinNom: Record 34002118;
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        Horas: Decimal;
    begin
        // Regla de acumulativo por concepto de dias de
        // vacaciones y enfermedad a razon de que si labora
        // 115 horas o más al mes, acumula 8 horas de enfermedad
        // y 10 horas de vacaciones mensualmente.

        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", CodEmpl);
        HistLinNom.SETRANGE("Tipo Nomina", HistLinNom."Tipo Nomina"::Normal);
        HistLinNom.SETRANGE(Periodo, Fecha."Period Start", FechaFin);
        HistLinNom.SETRANGE("Salario Base", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                Horas += HistLinNom.Cantidad;
            UNTIL HistLinNom.NEXT = 0;

        Horas := ROUND(Horas / 115, 1);

        DiasVacaciones := 10 * Horas;
    end;

    procedure CalculoDiaEnfermedadPR(CodEmpl: Code[20]; MesTrabajo: Integer; AnoTrabajo: Integer; MontoVacaciones: Decimal) DiasVacaciones: Integer
    var
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        HistLinNom: Record 34002118;
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        Horas: Decimal;
    begin
        // Regla de acumulativo por concepto de dias de
        // vacaciones y enfermedad a razon de que si labora
        // 115 horas o más al mes, acumula 8 horas de enfermedad
        // y 10 horas de vacaciones mensualmente.

        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE("Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", CodEmpl);
        HistLinNom.SETRANGE("Tipo Nomina", HistLinNom."Tipo Nomina"::Normal);
        HistLinNom.SETRANGE(Periodo, Fecha."Period Start", FechaFin);
        HistLinNom.SETRANGE("Salario Base", TRUE);
        IF HistLinNom.FINDSET THEN
            REPEAT
                Horas += HistLinNom.Cantidad;
            UNTIL HistLinNom.NEXT = 0;

        Horas := ROUND(Horas / 115, 1);

        DiasVacaciones := 8 * Horas;
    end;

    procedure BuscaNovedades(Emp: Record 5200): Integer
    var
        MNA: Record 34002114;
        HistAccionesdepersonal: Record 34002159;
    begin
        /*
        MNA.SETRANGE("Tipo de accion",Emp."No.");
        MNA.SETFILTER("ID Documento",Emp.GETFILTER("Date Filter"));
        
        EXIT(MNA.COUNT);
        */

        HistAccionesdepersonal.RESET;
        HistAccionesdepersonal.SETRANGE("No. empleado", Emp."No.");
        EXIT(HistAccionesdepersonal.COUNT);

    end;

    procedure MuestraNovedades(Emp: Record 5200)
    var
        HistAccionesdepersonal: Record 34002159;
        frmMNA: Page 34002170;
    begin

        HistAccionesdepersonal.RESET;
        HistAccionesdepersonal.SETRANGE("No. empleado", Emp."No.");
        frmMNA.SETTABLEVIEW(HistAccionesdepersonal);
        frmMNA.RUNMODAL;
        CLEAR(frmMNA);
    end;

    procedure BuscaAusencias(Emp: Record 5200): Integer
    var
        EmpAbs: Record 5207;
    begin
        EmpAbs.SETRANGE("Employee No.", Emp."No.");
        IF Emp.GETFILTER("Date Filter") <> '' THEN BEGIN
            EmpAbs.SETFILTER("From Date", '>=%1', Emp.GETRANGEMIN("Date Filter"));
            EmpAbs.SETFILTER("To Date", '<=%1', Emp.GETRANGEMAX("Date Filter"));
        END;
        EmpAbs.SETRANGE(Closed, TRUE);
        EXIT(EmpAbs.COUNT);
    end;

    procedure MuestraAusencias(Emp: Record 5200)
    var
        EmpAbs: Record 5207;
        frmEmpAbs: Page 5211;
    begin
        EmpAbs.SETRANGE("Employee No.", Emp."No.");
        IF Emp.GETFILTER("Date Filter") <> '' THEN BEGIN
            EmpAbs.SETFILTER("From Date", '>=%1', Emp.GETRANGEMIN("Date Filter"));
            EmpAbs.SETFILTER("To Date", '<=%1', Emp.GETRANGEMAX("Date Filter"));
        END;
        frmEmpAbs.SETTABLEVIEW(EmpAbs);
        frmEmpAbs.RUNMODAL;
        CLEAR(frmEmpAbs);
    end;

    procedure BuscaDimensiones(NoEmp: Code[20]): Integer
    var
        DefDim: Record 352;
    begin
        DefDim.SETRANGE("Table ID", 5200);
        DefDim.SETRANGE("No.", NoEmp);
        EXIT(DefDim.COUNT);
    end;

    procedure MuestraDimensiones(NoEmp: Code[20])
    var
        frmDefDim: Page 540;
        DefDim: Record 352;
    begin
        DefDim.SETRANGE("Table ID", 5200);
        DefDim.SETRANGE("No.", NoEmp);
        frmDefDim.SETTABLEVIEW(DefDim);
        frmDefDim.RUNMODAL;
        CLEAR(frmDefDim);
    end;

    procedure BuscaCualificaciones(NoEmp: Code[20]): Integer
    var
        Cualific: Record 5203;
    begin
        Cualific.SETRANGE("Employee No.", NoEmp);
        EXIT(Cualific.COUNT);
    end;

    procedure MuestraCualificaciones(NoEmp: Code[20])
    var
        frmCualific: Page 5206;
        Cualific: Record 5203;
    begin
        Cualific.SETRANGE("Employee No.", NoEmp);
        frmCualific.SETTABLEVIEW(Cualific);
        frmCualific.RUNMODAL;
        CLEAR(frmCualific);
    end;

    procedure BuscaNominas(Emp: Record 5200): Integer
    var
        HCNom: Record 34002117;
    begin
        HCNom.SETRANGE("No. empleado", Emp."No.");
        IF Emp.GETFILTER("Date Filter") <> '' THEN
            HCNom.SETRANGE(Periodo, Emp.GETRANGEMIN("Date Filter"), Emp.GETRANGEMIN("Date Filter"));
        EXIT(HCNom.COUNT);
    end;

    procedure MuestraNominas(Emp: Record 5200)
    var
        HCNom: Record 34002117;
        pHCNom: Page 34002123;
    begin
        HCNom.SETRANGE("No. empleado", Emp."No.");
        IF Emp.GETFILTER("Date Filter") <> '' THEN
            HCNom.SETRANGE(Periodo, Emp.GETRANGEMIN("Date Filter"), Emp.GETRANGEMIN("Date Filter"));
        pHCNom.SETTABLEVIEW(HCNom);
        pHCNom.RUNMODAL;
        CLEAR(pHCNom);
    end;

    procedure CalculoDiasBonificacion(CodEmpl: Code[20]; FechaFin: Date) DiasBonificacion: Integer
    var
        Empl: Record 5200;
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
    begin
        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);

        /*
        Fecha.RESET;
        Fecha.SETRANGE(Fecha."Period Type",Fecha."Period Type"::Month);
        Fecha.SETRANGE(Fecha."Period Start",DMY2DATE(1,12,AnoTrabajo));
        IF Fecha.FINDFIRST THEN
           FechaFin:= NORMALDATE(Fecha."Period End");
           */

        CalculoEntreFechas(Empl."Employment Date", FechaFin, Anos, Meses, Dias);

        LinPerfSalarial.SETRANGE("No. empleado", CodEmpl);
        LinPerfSalarial.SETRANGE("Salario Base", TRUE);
        LinPerfSalarial.FINDFIRST;

        IF Anos < 3 THEN
            DiasBonificacion := 45
        ELSE
            DiasBonificacion := 60;

    end;

    procedure CalculoMontoBonificacion(CodEmpl: Code[20]; AnoTrabajo: Integer; MontoVacaciones: Decimal; FechaFinal: Date) MontoBonificac: Decimal
    var
        Empl: Record 5200;
        Err001: Label 'Missing Starting Date for  Employee %1 ';
        LinPerfSalarial: Record 34002115;
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        DiasBonificacion: Integer;
    begin
        Empl.GET(CodEmpl);
        IF Empl."Employment Date" = 0D THEN
            ERROR(Err001, CodEmpl);


        Fecha.RESET;
        Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
        Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, 12, AnoTrabajo));
        IF Fecha.FINDFIRST THEN
            FechaFin := NORMALDATE(Fecha."Period End");


        CalculoEntreFechas(Empl."Employment Date", FechaFin, Anos, Meses, Dias);

        LinPerfSalarial.SETRANGE("No. empleado", CodEmpl);
        LinPerfSalarial.SETRANGE("Salario Base", TRUE);
        LinPerfSalarial.FINDFIRST;

        IF Anos < 3 THEN
            DiasBonificacion := 45
        ELSE
            DiasBonificacion := 60;
        /*
        IF Anos = 0 THEN
           BEGIN
            Empl.SETRANGE("Date Filter",DMY2DATE(1,1,AnoTrabajo),DMY2DATE(31,12,AnoTrabajo));
            Empl.CALCFIELDS("Acumulado Salario");
            MontoBonificac := ROUND(Empl."Acumulado Salario" / 12,0.01);
            MontoBonificac := ROUND(MontoBonificac / 23.83 * DiasBonificacion,0.01);
           END
        ELSE
        */
        MontoBonificac := ROUND(LinPerfSalarial.Importe / 23.83 * DiasBonificacion, 0.01);

    end;

    procedure InicializaConceptosSalariales()
    var
        ParamInicConceptos: Record 34002106;
        LinEsqPercepcion: Record 34002115;
        Contrato: Record 34002109;
        Ventana: Dialog;
        Modifica: Boolean;
    begin
        Ventana.OPEN(Text001);
        ConfNomina.GET();
        ParamInicConceptos.FINDFIRST;
        WITH ParamInicConceptos DO
            REPEAT
                LinEsqPercepcion.RESET;
                LinEsqPercepcion.SETRANGE("Concepto salarial", ParamInicConceptos.Codigo);
                Ventana.UPDATE(1, ParamInicConceptos.Codigo);
                Ventana.UPDATE(2, ParamInicConceptos.Descripcion);
                IF LinEsqPercepcion.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        Modifica := FALSE;
                        Empl.GET(LinEsqPercepcion."No. empleado");
                        Contrato.RESET;
                        Contrato.SETRANGE("No. empleado", LinEsqPercepcion."No. empleado");
                        Contrato.SETRANGE("Cod. contrato", Empl."Emplymt. Contract Code");
                        //Contrato.SETRANGE(Activo,TRUE);
                        IF NOT Contrato.FINDFIRST THEN
                            Contrato.INIT;

                        IF (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Mensual) AND
                           (Contrato."Frecuencia de pago" <> Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
                            IF "Inicializa Cantidad" THEN BEGIN
                                //                IF (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Sal. Base") AND
                                //                   (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Dieta") THEN
                                BEGIN
                                    LinEsqPercepcion.Cantidad := 0;
                                    Modifica := TRUE;
                                END;
                            END;

                            IF ("Inicializa Importe") AND (LinEsqPercepcion."Formula cálculo" = '') THEN BEGIN
                                IF "Inicializa Cantidad" THEN BEGIN
                                    //                    IF (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Sal. Base") AND
                                    //                       (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Dieta") THEN
                                    BEGIN
                                        LinEsqPercepcion.Importe := 0;
                                        Modifica := TRUE;
                                    END;
                                END;
                            END;
                        END
                        ELSE BEGIN
                            IF "Inicializa Cantidad" THEN BEGIN
                                IF (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Sal. Base") AND
                                   (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Dieta") THEN BEGIN
                                    LinEsqPercepcion.Cantidad := 0;
                                    Modifica := TRUE;
                                END;
                            END;

                            IF ("Inicializa Importe") AND (LinEsqPercepcion."Formula cálculo" = '') THEN BEGIN
                                IF "Inicializa Cantidad" THEN BEGIN
                                    IF (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Sal. Base") AND
                                       (LinEsqPercepcion."Concepto salarial" <> ConfNomina."Concepto Dieta") THEN BEGIN
                                        LinEsqPercepcion.Importe := 0;
                                        Modifica := TRUE;
                                    END;
                                END;
                            END;
                        END;

                        IF Modifica THEN
                            LinEsqPercepcion.MODIFY;
                    UNTIL LinEsqPercepcion.NEXT = 0;
            UNTIL ParamInicConceptos.NEXT = 0;
        MESSAGE(Text002);
    end;

    procedure BuscaBalCte(Emp: Record 5200): Decimal
    var
        Cte: Record 18;
    begin
        IF Cte.GET(Emp."Codigo Cliente") THEN BEGIN
            Cte.CALCFIELDS("Balance (LCY)");
            EXIT(Cte."Balance (LCY)");
        END;
    end;

    procedure MuestraBalCte(Emp: Record 5200)
    var
        CLE: Record 21;
        frmCLE: Page 25;
    begin
        CLE.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CLE.SETRANGE("Customer No.", Emp."Codigo Cliente");
        CLE.SETRANGE(Open, TRUE);
        frmCLE.SETTABLEVIEW(CLE);
        frmCLE.RUNMODAL;
        CLEAR(frmCLE);
    end;

    procedure BuscaHistSalario(Emp: Record 5200): Integer
    var
        HSalario: Record 34002149;
    begin
        HSalario.SETRANGE("No. empleado", Emp."No.");
        EXIT(HSalario.COUNT);
    end;

    procedure MuestraHistSalario(Emp: Record 5200)
    var
        HSalario: Record 34002149;
        frmHSalario: Page 34002137;
    begin
        HSalario.SETRANGE("No. empleado", Emp."No.");
        frmHSalario.SETTABLEVIEW(HSalario);
        frmHSalario.RUNMODAL;
        CLEAR(frmHSalario);
    end;

    procedure BuscaSaldoISRFavor(Emp: Record 5200): Decimal
    var
        SFISR: Record 34002128;
    begin
        SFISR.RESET;
        SFISR.SETRANGE("Cod. Empleado", Emp."No.");
        SFISR.SETRANGE(Ano, DATE2DMY(WORKDATE, 3));
        IF SFISR.FINDFIRST THEN
            EXIT(SFISR."Importe Pendiente");
    end;

    procedure MuestraSaldoISRFavor(Emp: Record 5200)
    var
        SFISR: Record 34002128;
        fSFISR: Page 34002148;
    begin
        SFISR.RESET;
        SFISR.SETRANGE("Cod. Empleado", Emp."No.");
        SFISR.SETRANGE(Ano, DATE2DMY(WORKDATE, 3));
        IF SFISR.FINDFIRST THEN BEGIN
            fSFISR.SETRECORD(SFISR);
            fSFISR.RUNMODAL;
        END;

        CLEAR(fSFISR);
    end;

    procedure AcumuladoFUTA(CodEmpleado: Code[20]; FechaIni: Date; FechaFin: Date): Decimal
    var
        HistLinNom: Record 34002118;
        HistLinEmp: Record 34002122;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();
        Acumulado := 0;
        TiposCotiza.GET(DATE2DMY(TODAY, 3), ConfNomina."Concepto AFP");
        IF (TiposCotiza."Acumula por" = 1) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinNom.SETCURRENTKEY("No. empleado", Periodo, "Concepto salarial");
            HistLinNom.SETRANGE("No. empleado", CodEmpleado);
            HistLinNom.SETRANGE(Periodo, FechaIni, FechaFin);
            HistLinNom.SETRANGE("Concepto salarial", ConfNomina."Concepto AFP");
            IF HistLinNom.FINDFIRST THEN
                HistLinNom.CALCSUMS(Total);
            Acumulado += HistLinNom.Total;
        END;

        IF (TiposCotiza."Acumula por" = 2) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinEmp.SETCURRENTKEY("No. Empleado", Periodo, "Concepto Salarial");
            HistLinEmp.SETRANGE("No. Empleado", CodEmpleado);
            HistLinEmp.SETRANGE(Periodo, FechaIni, FechaFin);
            HistLinEmp.SETRANGE("Concepto Salarial", ConfNomina."Concepto AFP");
            IF HistLinEmp.FINDFIRST THEN
                HistLinEmp.CALCSUMS(Importe);
            Acumulado += HistLinEmp.Importe;
        END;

        EXIT(ABS(ROUND(Acumulado, 0.01)));
    end;

    procedure AcumuladoSUTA(CodEmpleado: Code[20]; FechaIni: Date; FechaFin: Date): Decimal
    var
        HistLinNom: Record 34002118;
        HistLinEmp: Record 34002122;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();
        Acumulado := 0;
        TiposCotiza.GET(DATE2DMY(TODAY, 3), ConfNomina."Concepto INFOTEP");
        IF (TiposCotiza."Acumula por" = 1) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
            HistLinNom.SETRANGE("No. empleado", CodEmpleado);
            HistLinNom.SETRANGE(Periodo, FechaIni, FechaFin);
            HistLinNom.SETRANGE("Concepto salarial", ConfNomina."Concepto INFOTEP");
            HistLinNom.CALCSUMS(Total);
            Acumulado += HistLinNom.Total;
        END;

        IF (TiposCotiza."Acumula por" = 2) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinEmp.SETCURRENTKEY("No. Empleado", Periodo, "Concepto Salarial");
            HistLinEmp.SETRANGE("No. Empleado", CodEmpleado);
            HistLinEmp.SETRANGE(Periodo, FechaIni, FechaFin);
            HistLinEmp.SETRANGE("Concepto Salarial", ConfNomina."Concepto INFOTEP");
            HistLinEmp.CALCSUMS(Importe);
            Acumulado += HistLinEmp.Importe;
        END;

        EXIT(ABS(ROUND(Acumulado, 0.01)));
    end;

    procedure AcumuladoFICA(CodEmpleado: Code[20]; FechaIni: Date; FechaFin: Date): Decimal
    var
        HistLinNom: Record 34002118;
        HistLinEmp: Record 34002122;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();
        Acumulado := 0;
        TiposCotiza.GET(DATE2DMY(TODAY, 3), ConfNomina."Concepto Retroactivo");
        IF (TiposCotiza."Acumula por" = 1) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinNom.RESET;
            HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
            HistLinNom.SETRANGE("No. empleado", CodEmpleado);
            HistLinNom.SETRANGE(Periodo, FechaIni, FechaFin);
            HistLinNom.SETRANGE("Cotiza FICA", TRUE);
            HistLinNom.CALCSUMS(Total);
            Acumulado += HistLinNom.Total;
        END;

        IF (TiposCotiza."Acumula por" = 2) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinEmp.RESET;
            HistLinEmp.SETCURRENTKEY("No. Empleado", Periodo, "Concepto Salarial");
            HistLinEmp.SETRANGE("No. Empleado", CodEmpleado);
            HistLinEmp.SETFILTER(Periodo, '<%1', FechaIni);
            //    histlinemp.setrange("Cotiza FICA",true);
            HistLinEmp.CALCSUMS(Importe);
            Acumulado += HistLinEmp.Importe;
        END;

        EXIT(ABS(ROUND(Acumulado, 0.01)));
    end;

    procedure AcumuladoSINOT(CodEmpleado: Code[20]; FechaIni: Date; FechaFin: Date): Decimal
    var
        HistLinNom: Record 34002118;
        HistLinEmp: Record 34002122;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();
        Acumulado := 0;
        TiposCotiza.GET(DATE2DMY(TODAY, 3), ConfNomina."Concepto SFS");
        IF (TiposCotiza."Acumula por" = 1) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinNom.RESET;
            HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Periodo, "Concepto salarial");
            HistLinNom.SETRANGE("No. empleado", CodEmpleado);
            HistLinNom.SETFILTER(Periodo, '<%1', FechaIni);
            HistLinNom.SETRANGE("Cotiza SFS", TRUE);
            HistLinNom.SETFILTER("Tipo Nomina", '<>%1', HistLinNom."Tipo Nomina"::Renta);
            HistLinNom.CALCSUMS(Total);
            Acumulado += HistLinNom.Total;
            //    message('%1 %2 %3 %4 %5',acumulado,HistLinNom."Concepto salarial",HistLinNom.getfilters);
        END;

        IF (TiposCotiza."Acumula por" = 2) OR (TiposCotiza."Acumula por" = 3) THEN BEGIN
            HistLinEmp.RESET;
            HistLinEmp.SETCURRENTKEY("No. Empleado", Periodo, "Concepto Salarial");
            HistLinEmp.SETRANGE("No. Empleado", CodEmpleado);
            HistLinEmp.SETFILTER(Periodo, '<%1', FechaIni);
            HistLinEmp.SETRANGE("Concepto Salarial", ConfNomina."Concepto SFS");
            HistLinEmp.CALCSUMS(Importe);
            Acumulado += HistLinEmp.Importe;
        END;

        EXIT(ABS(ROUND(Acumulado, 0.01)));
    end;

    procedure VacacionesAcumuladas(CodEmpleado: Code[20]; FechaIni: Date; FechaFin: Date): Decimal
    var
        EmpAbs: Record 5207;
        CA: Record 5206;
        Acumulado: Decimal;
    begin
        ConfNomina.GET();

        CA.RESET;
        CA.SETRANGE("Cod. concepto salarial", ConfNomina."Concepto Vacaciones");
        CA.FINDFIRST;

        Acumulado := 0;
        EmpAbs.SETCURRENTKEY("Employee No.", "Cause of Absence Code");
        EmpAbs.SETRANGE("Employee No.", CodEmpleado);
        EmpAbs.SETRANGE("Cause of Absence Code", CA.Code);
        EmpAbs.SETFILTER("From Date", '%1..', FechaIni);
        EmpAbs.CALCSUMS(Quantity);
        Acumulado := EmpAbs.Quantity;
        EXIT(Acumulado);
    end;

    procedure BuscaSaldoISRFavorBO(Emp: Record 5200): Decimal
    var
        SFISR: Record 34002128;
    begin
        SFISR.SETRANGE("Cod. Empleado", Emp."No.");
        IF SFISR.FINDLAST THEN
            EXIT(SFISR."Importe Pendiente");
    end;

    procedure MuestraSaldoISRFavorBO(Emp: Record 5200)
    var
        SFISR: Record 34002128;
        fSFISR: Page 34002148;
    begin
        SFISR.RESET;
        SFISR.SETRANGE("Cod. Empleado", Emp."No.");
        IF SFISR.FINDFIRST THEN BEGIN
            fSFISR.SETRECORD(SFISR);
            fSFISR.RUNMODAL;
        END;

        CLEAR(fSFISR);
    end;

    procedure CreaRecurso(Employee: Record 5200)
    var
        Res: Record 156;
        ResSetup: Record 314;
        ResUOM: Record 205;
    begin
        //Res.GET(Employee."Resource No.");
        ResSetup.GET();
        //ResSetup.TESTFIELD("Default Unit of Measure");

        Res.INIT;
        Res."No." := Employee."No.";
        Res."Job Title" := Employee."Job Title";
        Res.Name := COPYSTR(Employee.FullName, 1, 30);
        Res.Address := Employee.Address;
        Res."Address 2" := Employee."Address 2";
        Res.VALIDATE("Post Code", Employee."Post Code");
        Res."Social Security No." := Employee."Social Security No.";
        Res."Employment Date" := Employee."Employment Date";
        Employee.CALCFIELDS(Salario);
        Employee.TESTFIELD(Salario);
        Res."Direct Unit Cost" := ROUND(Employee.Salario / 23.83 / 8, 0.01);
        Res."Unit Cost" := Res."Direct Unit Cost";
        Res.Blocked := TRUE;

        Res.INSERT(TRUE);

        ResUOM.INIT;
        ResUOM.VALIDATE("Resource No.", Employee."No.");
        //ResUOM.VALIDATE(Code,ResSetup."Default Unit of Measure");
        ResUOM."Qty. per Unit of Measure" := 1;
        IF ResUOM.INSERT(TRUE) THEN;

        //Res.VALIDATE("Base Unit of Measure",ResSetup."Default Unit of Measure");
        Res.MODIFY;

        Employee."Resource No." := Res."No.";
        Employee.MODIFY(TRUE);

        MESSAGE(Text004, Res."No.");
    end;

    procedure CreaCliente(Employee: Record 5200)
    var
        Cte: Record 18;
    begin
        Cte.INIT;
        Cte."No." := Employee."No.";
        Cte.VALIDATE(Name, Employee."Full Name");
        Cte.Address := Employee.Address;
        Cte."Address 2" := Employee."Address 2";
        Cte.City := Employee.City;
        Cte."Phone No." := Employee."Phone No.";
        Cte."VAT Registration No." := Employee."Document ID";
        Cte."Post Code" := Employee."Post Code";
        Cte.County := Employee.County;
        Cte."E-Mail" := Employee."E-Mail";
        Cte."No. Series" := Employee."No. Series";
        Cte.Blocked := Cte.Blocked::All;
        Cte.INSERT(TRUE);
        Cte.VALIDATE("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
        Cte.VALIDATE("Global Dimension 2 Code", Employee."Global Dimension 2 Code");
        Cte.MODIFY;

        Employee."Codigo Cliente" := Cte."No.";
        Employee.MODIFY(TRUE);

        MESSAGE(Text003, Cte."No.");
    end;

    procedure CreaVendedor(Employee: Record 5200)
    var
        SalesPerson: Record 13;
    begin
        SalesPerson.Code := Employee."No.";
        SalesPerson.Name := Employee."Full Name";
        SalesPerson."E-Mail" := Employee."E-Mail";
        SalesPerson."Phone No." := Employee."Phone No.";
        SalesPerson."Job Title" := Employee."Job Title";
        SalesPerson.INSERT(TRUE);

        SalesPerson.VALIDATE("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
        SalesPerson.VALIDATE("Global Dimension 2 Code", Employee."Global Dimension 2 Code");

        SalesPerson.MODIFY;

        Employee."Salespers./Purch. Code" := SalesPerson.Code;
        Employee.MODIFY(TRUE);

        MESSAGE(Text005, SalesPerson.Code);
    end;

    procedure BuscaActividades(Emp: Record 5200; FechaIni: Date; FechaFin: Date): Integer
    var
        MovAct: Record 34002157;
    begin
        MovAct.SETRANGE("No. empleado", Emp."No.");
        MovAct.SETFILTER("Inicio Periodo", '>=%1', FechaIni);
        MovAct.SETFILTER("Fin Periodo", '<=%1', FechaFin);
        //MovAct.SETRANGE(Closed,TRUE);
        EXIT(MovAct.COUNT);
    end;

    procedure MuestraActividades(Emp: Record 5200; FechaIni: Date; FechaFin: Date)
    var
        MovAct: Record 34002157;
        frmMovAct: Page 34002165;
    begin
        MovAct.SETRANGE("No. empleado", Emp."No.");
        MovAct.SETFILTER("Inicio Periodo", '>=%1', FechaIni);
        MovAct.SETFILTER("Fin Periodo", '<=%1', FechaFin);
        frmMovAct.SETTABLEVIEW(MovAct);
        frmMovAct.RUNMODAL;
        CLEAR(frmMovAct);
    end;

    procedure Ansi2Ascii(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AnsiStr, AsciiStr));
    end;

    procedure Ascii2Ansi(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AsciiStr, AnsiStr));
    end;

    local procedure MakeVars()
    begin
        AsciiStr := 'áéioúñÑAÉIOUü';
        AnsiStr := 'aeiounNAEIOUU';
        /*AsciiStr := 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáioúñÑªº¿®¬½¼¡«»¦¦¦¦¦ÁÂÀ©¦¦++¢¥++--+-+ãÃ++--¦-+A';
        AsciiStr := AsciiStr +'¤ðÐÊËÈiiÎÏ++¦_¦Ì¯oßÔÒõÕµþÞÚÛÙýÝ¯´­±=¾¶§÷¸°¨·¹³²¦ ';
        CharVar[1] := 196;
        CharVar[2] := 197;
        CharVar[3] := 201;
        CharVar[4] := 242;
        CharVar[5] := 220;
        CharVar[6] := 186;
        CharVar[7] := 191;
        CharVar[8] := 188;
        CharVar[9] := 187;
        CharVar[10] := 193;
        CharVar[11] := 194;
        CharVar[12] := 192;
        CharVar[13] := 195;
        CharVar[14] := 202;
        CharVar[15] := 203;
        CharVar[16] := 200;
        CharVar[17] := 205;
        CharVar[18] := 206;
        CharVar[19] := 204;
        CharVar[20] := 175;
        CharVar[21] := 223;
        CharVar[22] := 213;
        CharVar[23] := 254;
        CharVar[24] := 218;
        CharVar[25] := 219;
        CharVar[26] := 217;
        CharVar[27] := 180;
        CharVar[28] := 177;
        CharVar[29] := 176;
        CharVar[30] := 185;
        CharVar[31] := 179;
        CharVar[32] := 178;
        AnsiStr  := 'Ã³ÚÔõoÕþÛÙÞ´¯ý'+FORMAT(CharVar[1])+FORMAT(CharVar[2])+FORMAT(CharVar[3])+ 'µã¶÷'+FORMAT(CharVar[4]);
        AnsiStr := AnsiStr + '¹¨ i'+FORMAT(CharVar[5])+'°úÏÎâßÝ¾·±Ð¬'+FORMAT(CharVar[6])+FORMAT(CharVar[7]);
        AnsiStr := AnsiStr + '«¼¢'+FORMAT(CharVar[8])+'i½'+FORMAT(CharVar[9])+'___ªª' + FORMAT(CharVar[10])+FORMAT(CharVar[11]);
        AnsiStr := AnsiStr + FORMAT(CharVar[12]) + '®ªª++oÑ++--+-+Ò' + FORMAT(CharVar[13]) + '++--ª-+ñ­ð';
        AnsiStr  :=  AnsiStr +FORMAT(CharVar[14])+FORMAT(CharVar[15])+FORMAT(CharVar[16])+'i'+FORMAT(CharVar[17])+FORMAT(CharVar[18]);
        AnsiStr  :=  AnsiStr + '¤++__ª' + FORMAT(CharVar[19])+FORMAT(CharVar[20])+'Ë'+FORMAT(CharVar[21])+'ÈÊ§';
        AnsiStr  :=  AnsiStr + FORMAT(CharVar[22]) + 'Á' + FORMAT(CharVar[23]) + 'Ì' + FORMAT(CharVar[24])+ FORMAT(CharVar[25]);
        AnsiStr  :=  AnsiStr + FORMAT(CharVar[26]) + '²¦»' + FORMAT(CharVar[27]) + '¡' + FORMAT(CharVar[28]) +'=¥Âº¸©'+ FORMAT(CharVar[29]);
        AnsiStr  :=  AnsiStr + '¿À' + FORMAT(CharVar[30]) +FORMAT(CharVar[31]) +FORMAT(CharVar[32]) +'_ A';
        */

    end;

    procedure FechaCorta(Fecha_Loc: Date): Text[250]
    var
        txtFecha: Text[250];
        txtdia: Text[30];
        txtmes: Text[30];
        txtano: Text[30];
        dia: Integer;
        mes: Integer;
        ano: Integer;
        Esp: Text[1];
    begin
        Esp := ' ';
        dia := DATE2DMY(Fecha_Loc, 1);
        mes := DATE2DMY(Fecha_Loc, 2);
        ano := DATE2DMY(Fecha_Loc, 3);

        txtdia := FORMAT(dia);
        txtano := FORMAT(ano);

        CASE mes OF
            1:
                txtmes := 'enero';
            2:
                txtmes := 'febrero';
            3:
                txtmes := 'marzo';
            4:
                txtmes := 'abril';
            5:
                txtmes := 'mayo';
            6:
                txtmes := 'junio';
            7:
                txtmes := 'julio';
            8:
                txtmes := 'agosto';
            9:
                txtmes := 'septiembre';
            10:
                txtmes := 'octubre';
            11:
                txtmes := 'noviembre';
            12:
                txtmes := 'diciembre';
        END;

        txtFecha := txtdia + Esp + 'de' + Esp + txtmes + Esp + 'del' + Esp + txtano;

        EXIT(txtFecha);
    end;

    procedure FechaLarga(Fecha_Loc: Date): Text[250]
    var
        txtFecha: Text[250];
        txtdia: Text[30];
        txtmes: Text[30];
        txtano: Text[30];
        Esp: Text[1];
        dia: Integer;
        mes: Integer;
        ano: Integer;
    begin
        Esp := ' ';

        dia := DATE2DMY(Fecha_Loc, 1);
        mes := DATE2DMY(Fecha_Loc, 2);
        ano := DATE2DMY(Fecha_Loc, 3);

        txtdia := (LOWERCASE(txtdia));
        dia := DATE2DMY(Fecha_Loc, 1);

        dia := DATE2DMY(Fecha_Loc, 1);
        mes := DATE2DMY(Fecha_Loc, 2);
        ano := DATE2DMY(Fecha_Loc, 3);

        txtdia := FORMAT(dia);
        txtano := FORMAT(ano);

        CASE dia OF
            1:
                txtdia := 'primero (01)';
            2:
                txtdia := 'dos (02)';
            3:
                txtdia := 'tres (30)';
            4:
                txtdia := 'cuatro (04)';
            5:
                txtdia := 'cinco (05)';
            6:
                txtdia := 'seis (06)';
            7:
                txtdia := 'siete (07)';
            8:
                txtdia := 'ocho (08)';
            9:
                txtdia := 'nueve (09)';
            10:
                txtdia := 'diez (10)';
            11:
                txtdia := 'once (11)';
            12:
                txtdia := 'doce (12)';
            13:
                txtdia := 'trece (13)';
            14:
                txtdia := 'catorce (14)';
            15:
                txtdia := 'quince (15)';
            16:
                txtdia := 'dieciséis (16)';
            17:
                txtdia := 'diecisiete (17)';
            18:
                txtdia := 'dieciocho (18)';
            19:
                txtdia := 'diecinueve (19)';
            20:
                txtdia := 'veinte (20)';
            21:
                txtdia := 'veintiuno (21)';
            22:
                txtdia := 'veintidos (22)';
            23:
                txtdia := 'veintitrés (23)';
            24:
                txtdia := 'veinticuatro (24)';
            25:
                txtdia := 'veinticinco (25)';
            26:
                txtdia := 'veintiséis (26)';
            27:
                txtdia := 'veintisiete (27)';
            28:
                txtdia := 'veintiocho (28)';
            29:
                txtdia := 'veintinueve (29)';
            30:
                txtdia := 'treinta (30)';
            31:
                txtdia := 'Treinta y uno (31)';
        END;


        CASE mes OF
            1:
                txtmes := 'enero';
            2:
                txtmes := 'febrero';
            3:
                txtmes := 'marzo';
            4:
                txtmes := 'abril';
            5:
                txtmes := 'mayo';
            6:
                txtmes := 'junio';
            7:
                txtmes := 'julio';
            8:
                txtmes := 'agosto';
            9:
                txtmes := 'septiembre';
            10:
                txtmes := 'octubre';
            11:
                txtmes := 'noviembre';
            12:
                txtmes := 'diciembre';
        END;

        //txtano := LOWERCASE(cuDocWord.FechaALetras(ano,''));

        txtFecha := txtdia + Esp + 'dias' + Esp + 'del mes de' + Esp + txtmes + Esp + 'del' + Esp + 'año' + Esp;

        EXIT(txtFecha);
    end;

    procedure NombreDia(Fecha_Loc: Date): Text[250]
    var
        txtFecha: Text[250];
        txtdia: Text[30];
        txtmes: Text[30];
        txtano: Text[30];
        Esp: Text[1];
        dia: Integer;
        mes: Integer;
        ano: Integer;
    begin
        Esp := ' ';

        dia := DATE2DMY(Fecha_Loc, 1);
        mes := DATE2DMY(Fecha_Loc, 2);
        ano := DATE2DMY(Fecha_Loc, 3);

        txtdia := (LOWERCASE(txtdia));
        dia := DATE2DMY(Fecha_Loc, 1);

        dia := DATE2DMY(Fecha_Loc, 1);
        mes := DATE2DMY(Fecha_Loc, 2);
        ano := DATE2DMY(Fecha_Loc, 3);

        txtdia := FORMAT(dia);
        txtano := FORMAT(ano);

        CASE dia OF
            1:
                txtdia := 'primero (01)';
            2:
                txtdia := 'dos (02)';
            3:
                txtdia := 'tres (03)';
            4:
                txtdia := 'cuatro (04)';
            5:
                txtdia := 'cinco (05)';
            6:
                txtdia := 'seis (06)';
            7:
                txtdia := 'siete (07)';
            8:
                txtdia := 'ocho (08)';
            9:
                txtdia := 'nueve (09)';
            10:
                txtdia := 'diez (10)';
            11:
                txtdia := 'once (11)';
            12:
                txtdia := 'doce (12)';
            13:
                txtdia := 'trece (13)';
            14:
                txtdia := 'catorce (14)';
            15:
                txtdia := 'quince (15)';
            16:
                txtdia := 'dieciséis (16)';
            17:
                txtdia := 'diecisiete (17)';
            18:
                txtdia := 'dieciocho (18)';
            19:
                txtdia := 'diecinueve (19)';
            20:
                txtdia := 'veinte (20)';
            21:
                txtdia := 'veintiuno (21)';
            22:
                txtdia := 'veintidos (22)';
            23:
                txtdia := 'veintitrés (23)';
            24:
                txtdia := 'veinticuatro (24)';
            25:
                txtdia := 'veinticinco (25)';
            26:
                txtdia := 'veintiséis (26)';
            27:
                txtdia := 'veintisiete (27)';
            28:
                txtdia := 'veintiocho (28)';
            29:
                txtdia := 'veintinueve (29)';
            30:
                txtdia := 'treinta (30)';
            31:
                txtdia := 'Treinta y uno (31)';
        END;


        txtFecha := txtdia;

        EXIT(txtFecha);
    end;

    procedure ProcesaControlAsistencia(FechaIni: Date; FechaFin: Date)
    var
        CA: Record 34002160;
        DCA: Record 34002160;
        PerfSal: Record 34002115;
        HorReg: Decimal;
        Hor35: Decimal;
        Hor100: Decimal;
        HorFer: Decimal;
        HorNoc: Decimal;
        HorENoc: Decimal;
    begin
        //Buscamos la configuracion
        ConfNomina.GET();

        //Verificamos que los conceptos esten configurados
        //ConfNomina.TESTFIELD("Concepto Horas Ext. 100%");
        ConfNomina.TESTFIELD("Concepto Horas Ext. 35%");
        ConfNomina.TESTFIELD("Concepto Horas nocturnas");
        ConfNomina.TESTFIELD("Concepto Dias feriados");
        ConfNomina.TESTFIELD("Concepto Sal. Base");

        //Leemos la tabla de control de asistencia y la de distribucion para calcular el pago por concepto
        CA.RESET;
        IF (FechaIni <> 0D) AND (FechaFin <> 0D) THEN
            CA.SETRANGE("Fecha registro", FechaIni, FechaFin);
        CA.SETRANGE(Status, CA.Status::Pendiente);
        CA.FINDSET;
        CounterTotal := CA.COUNT;
        Window.OPEN(Text010);
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, CA."Cod. Empleado");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            Hor100 := 0;
            Hor35 := 0;
            HorFer := 0;
            HorNoc := 0;
            HorReg := 0;
            HorENoc := 0;

            DCA.RESET;
            DCA.SETRANGE("Cod. Empleado", CA."Cod. Empleado");
            DCA.SETFILTER("Fecha registro", CA.GETFILTER("Fecha registro"));
            //DCA.SETRANGE("Hora registro",CA."Hora registro");

            IF DCA.FINDSET THEN
                REPEAT
                    IF DCA."Horas extras 100" <> 0 THEN
                        HorENoc += DCA."Horas extras 100";

                    IF DCA."Dias feriados" <> 0 THEN
                        Hor100 += DCA."Dias feriados";

                    IF DCA."Horas extras al 35" <> 0 THEN
                        Hor35 += DCA."Horas extras al 35";

                    IF DCA."Dias feriados" <> 0 THEN
                        HorFer += DCA."Dias feriados";

                    IF DCA."Horas nocturnas" <> 0 THEN
                        HorNoc += DCA."Horas nocturnas";

                    IF DCA."Horas regulares" <> 0 THEN
                        HorReg += DCA."Horas regulares";

                UNTIL DCA.NEXT = 0;

            IF HorENoc <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Sal. hora");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorENoc;
                PerfSal.MODIFY;
            END
            ELSE
                IF Hor100 <> 0 THEN BEGIN
                    PerfSal.RESET;
                    PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas Ext. 100%");
                    PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                    PerfSal.FINDFIRST;
                    PerfSal.Cantidad := Hor100;
                    PerfSal.MODIFY;
                END;
            IF Hor35 <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas Ext. 35%");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := Hor35;
                PerfSal.MODIFY;
            END;
            IF HorFer <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Dias feriados");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorFer;
                PerfSal.MODIFY;
            END;
            IF HorNoc <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas nocturnas");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorNoc;
                PerfSal.MODIFY;
            END;
            IF HorReg <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Sal. Base");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorReg;
                PerfSal.MODIFY;
            END;
        UNTIL CA.NEXT = 0;
        Window.CLOSE;
        MESSAGE(Text011);
    end;

    procedure ProcesaControlAsistenciaJob(FechaIni: Date; FechaFin: Date; CodProyecto: Code[20])
    var
        CA: Record 34002160;
        DCA: Record 34002163;
        PerfSal: Record 34002115;
        HorReg: Decimal;
        Hor35: Decimal;
        Hor100: Decimal;
        HorFer: Decimal;
        HorNoc: Decimal;
        HorENoc: Decimal;
    begin
        //Buscamos la configuracion
        ConfNomina.GET();

        //Verificamos que los conceptos esten configurados
        ConfNomina.TESTFIELD("Concepto Horas Ext. 100%");
        ConfNomina.TESTFIELD("Concepto Horas Ext. 35%");
        ConfNomina.TESTFIELD("Concepto Horas nocturnas");
        ConfNomina.TESTFIELD("Concepto Dias feriados");
        ConfNomina.TESTFIELD("Concepto Sal. Base");

        //Leemos la tabla de control de asistencia y la de distribucion para calcular el pago por concepto
        CA.RESET;
        IF (FechaIni <> 0D) AND (FechaFin <> 0D) THEN
            CA.SETRANGE("Fecha registro", FechaIni, FechaFin);
        CA.SETRANGE(Status, CA.Status::Pendiente);
        CA.FINDSET;
        CounterTotal := CA.COUNT;
        Window.OPEN(Text010);
        REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1, CA."Cod. Empleado");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            Hor100 := 0;
            Hor35 := 0;
            HorFer := 0;
            HorNoc := 0;
            HorReg := 0;
            HorENoc := 0;

            DCA.RESET;
            DCA.SETRANGE("Cod. Empleado", CA."Cod. Empleado");
            DCA.SETRANGE("Job No.", CodProyecto);
            DCA.SETFILTER("Fecha registro", CA.GETFILTER("Fecha registro"));
            //DCA.SETRANGE("Hora registro",CA."Hora registro");

            IF DCA.FINDSET THEN
                REPEAT
                    IF DCA."Horas Extras Nocturnas" <> 0 THEN
                        HorENoc += DCA."Horas Extras Nocturnas";

                    IF DCA."Horas extras al 100" <> 0 THEN
                        Hor100 += DCA."Horas extras al 100";

                    IF DCA."Horas extras al 35" <> 0 THEN
                        Hor35 += DCA."Horas extras al 35";

                    IF DCA."Horas feriadas" <> 0 THEN
                        HorFer += DCA."Horas feriadas";

                    IF DCA."Horas nocturnas" <> 0 THEN
                        HorNoc += DCA."Horas nocturnas";

                    IF DCA."Horas regulares" <> 0 THEN
                        HorReg += DCA."Horas regulares";

                UNTIL DCA.NEXT = 0;

            IF HorENoc <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Sal. hora");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorENoc;
                PerfSal.MODIFY;
            END
            ELSE
                IF Hor100 <> 0 THEN BEGIN
                    PerfSal.RESET;
                    PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas Ext. 100%");
                    PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                    PerfSal.FINDFIRST;
                    PerfSal.Cantidad := Hor100;
                    PerfSal.MODIFY;
                END;
            IF Hor35 <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas Ext. 35%");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := Hor35;
                PerfSal.MODIFY;
            END;
            IF HorFer <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Dias feriados");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorFer;
                PerfSal.MODIFY;
            END;
            IF HorNoc <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Horas nocturnas");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorNoc;
                PerfSal.MODIFY;
            END;
            IF HorReg <> 0 THEN BEGIN
                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", ConfNomina."Concepto Sal. Base");
                PerfSal.SETRANGE("No. empleado", CA."Cod. Empleado");
                PerfSal.FINDFIRST;
                PerfSal.Cantidad := HorReg;
                PerfSal.MODIFY;
            END;
        UNTIL CA.NEXT = 0;
        Window.CLOSE;
        MESSAGE(Text011);
    end;

    procedure ProcesaDatosPonchador()
    var
        LogPonchador: Record 34002177;
        LogPonchador2: Record 34002177;
        ControlAsist: Record 34002160;
        ShiftSch: Record 34002180;
        ContadorReg: Integer;
        Contador: Integer;
        EmpAnt: Code[20];
        FechaAnt: Date;
        HoraReg: Time;
    begin
        ConfNomina.GET();
        IF ConfNomina."Integracion ponche activa" THEN BEGIN
            ConfNomina.TESTFIELD("CU Procesa datos ponchador");
            CODEUNIT.RUN(ConfNomina."CU Procesa datos ponchador");
            COMMIT;
        END;

        LogPonchador.RESET;
        //LogPonchador.SETRANGE("Cod. Empleado",'1007');
        LogPonchador.SETRANGE("Fecha registro", CALCDATE('-7D', TODAY), TODAY);
        //LogPonchador.SETRANGE(Procesado,FALSE);
        CounterTotal := LogPonchador.COUNT;
        Window.OPEN(Text010);
        IF LogPonchador.FINDSET(TRUE, FALSE) THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, LogPonchador."Cod. Empleado");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                Empl.GET(LogPonchador."Cod. Empleado");
                IF (Empl.Status = Empl.Status::Active) AND (LogPonchador."Fecha registro" <> 0D) THEN BEGIN
                    //Busco los registros de ese dia para ese empleado
                    IF (EmpAnt <> LogPonchador."Cod. Empleado") OR (FechaAnt <> LogPonchador."Fecha registro") THEN BEGIN
                        EmpAnt := LogPonchador."Cod. Empleado";
                        FechaAnt := LogPonchador."Fecha registro";
                        LogPonchador2.RESET;
                        LogPonchador2.SETRANGE("Cod. Empleado", LogPonchador."Cod. Empleado");
                        LogPonchador2.SETRANGE("Fecha registro", LogPonchador."Fecha registro");
                        //habilitar LogPonchador2.SETRANGE(Procesado,FALSE);

                        IF Empl.Shift <> '' THEN BEGIN
                            ShiftSch.RESET;
                            ShiftSch.SETRANGE("Codigo turno", Empl.Shift);
                            ShiftSch.FINDFIRST;
                            ConfNomina.TESTFIELD("Horas de almuerzo");
                            IF ShiftSch."Hora Inicio" > 120000T THEN
                                LogPonchador2.SETRANGE("Fecha registro", LogPonchador."Fecha registro", CALCDATE('+1D', LogPonchador."Fecha registro"));
                        END;

                        //            LogPonchador2.FINDSET;
                        ContadorReg := LogPonchador2.COUNT;
                        Contador := 0;
                    END;

                    CLEAR(HoraReg);
                    HoraReg := LogPonchador."Hora registro";// + 14400000; //4 horas

                    ControlAsist.RESET;
                    ControlAsist.SETRANGE("Cod. Empleado", LogPonchador."Cod. Empleado");
                    ControlAsist.SETRANGE("Fecha registro", LogPonchador."Fecha registro");
                    IF NOT ControlAsist.FINDFIRST THEN BEGIN
                        Contador += 1;
                        ControlAsist.INIT;
                        ControlAsist.VALIDATE("Cod. Empleado", LogPonchador."Cod. Empleado");
                        ControlAsist.VALIDATE("Fecha registro", LogPonchador."Fecha registro");
                        ControlAsist."Hora registro" := TIME;
                        ControlAsist."ID Equipo" := LogPonchador."ID Equipo";

                        IF Contador <= ContadorReg THEN
                            CASE Contador OF
                                1:
                                    BEGIN
                                        ControlAsist.VALIDATE("1ra entrada", HoraReg);
                                        ControlAsist."Fecha Entrada" := LogPonchador."Fecha registro";
                                    END;
                                2:
                                    BEGIN
                                        ControlAsist."1ra salida" := HoraReg;
                                        ControlAsist."Fecha Salida" := LogPonchador."Fecha registro";
                                        /*
                                        IF Empl.Shift <> '' THEN
                                           BEGIN
                                             ControlAsist."1ra salida"  := ShiftSch."Hora almuerzo";
                                           END;
                                           */
                                    END;
                                3:
                                    BEGIN
                                        ControlAsist."2da entrada" := HoraReg;
                                        ControlAsist."Fecha Entrada" := LogPonchador."Fecha registro";
                                    END
                                ELSE BEGIN
                                    ControlAsist."2da salida" := HoraReg;
                                    ControlAsist."Fecha Salida" := LogPonchador."Fecha registro";
                                END;
                            END;

                        ControlAsist.VALIDATE("1ra entrada");
                        ControlAsist.INSERT;
                    END
                    ELSE BEGIN
                        Contador += 1;
                        ControlAsist."2da entrada" := 0T;
                        ControlAsist."2da salida" := 0T;
                        IF Contador <= ContadorReg THEN
                            CASE Contador OF
                                1:
                                    BEGIN
                                        ControlAsist."1ra entrada" := HoraReg;
                                        ControlAsist."Fecha Entrada" := LogPonchador."Fecha registro";
                                    END;
                                2:
                                    BEGIN
                                        ControlAsist."1ra salida" := HoraReg;
                                        ControlAsist."Fecha Salida" := LogPonchador."Fecha registro";
                                        /*
                                        IF Empl.Shift <> '' THEN
                                           BEGIN
                                             ControlAsist."1ra salida"  := ShiftSch."Hora almuerzo";
                                             ControlAsist."2da entrada" := ShiftSch."Hora almuerzo" + 1 * 60 * 60 * 1000;
                                             ControlAsist.VALIDATE("2da salida",HoraReg);
                                           END;
                                           */
                                    END;

                                3:
                                    BEGIN
                                        ControlAsist."2da entrada" := HoraReg;
                                        ControlAsist."Fecha Entrada" := LogPonchador."Fecha registro";
                                    END;
                                ELSE BEGIN
                                    ControlAsist."2da salida" := HoraReg;
                                    ControlAsist."Fecha Salida" := LogPonchador."Fecha registro";
                                END;
                            END;
                        ControlAsist.VALIDATE("Fecha registro", LogPonchador."Fecha registro");
                        ControlAsist.VALIDATE("1ra entrada");
                        ControlAsist.MODIFY;
                    END;
                END;

                LogPonchador.Procesado := TRUE;
                LogPonchador.MODIFY;

            UNTIL LogPonchador.NEXT = 0;
        Window.CLOSE;
        MESSAGE(Text011);

    end;

    procedure ProcesaDatosPonchadorManual()
    var
        LogPonchador: Record 34002177;
        LogPonchador2: Record 34002177;
        ControlAsist: Record 34002160;
        ShiftSch: Record 34002180;
        ContadorReg: Integer;
        Contador: Integer;
        EmpAnt: Code[20];
        FechaAnt: Date;
    begin
        ConfNomina.GET();
        ConfNomina.TESTFIELD("XML importa datos ponchador");
        XMLPORT.RUN(ConfNomina."XML importa datos ponchador");


        LogPonchador.RESET;
        LogPonchador.SETRANGE(Procesado, FALSE);
        CounterTotal := LogPonchador.COUNT;
        Window.OPEN(Text010);
        IF LogPonchador.FINDSET(TRUE, FALSE) THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, LogPonchador."Cod. Empleado");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                Empl.GET(LogPonchador."Cod. Empleado");
                IF Empl.Status = Empl.Status::Active THEN BEGIN
                    //Busco los registros de ese dia para ese empleado
                    IF (EmpAnt <> LogPonchador."Cod. Empleado") OR (FechaAnt <> LogPonchador."Fecha registro") THEN BEGIN
                        EmpAnt := LogPonchador."Cod. Empleado";
                        FechaAnt := LogPonchador."Fecha registro";
                        LogPonchador2.RESET;
                        LogPonchador2.SETRANGE("Cod. Empleado", LogPonchador."Cod. Empleado");
                        LogPonchador2.SETRANGE("Fecha registro", LogPonchador."Fecha registro");
                        LogPonchador2.SETRANGE(Procesado, FALSE);
                        //            LogPonchador2.FINDSET;
                        ContadorReg := LogPonchador2.COUNT;
                        Contador := 0;
                    END;

                    IF Empl.Shift <> '' THEN BEGIN
                        ShiftSch.RESET;
                        ShiftSch.SETRANGE("Codigo turno", Empl.Shift);
                        ShiftSch.FINDFIRST;
                        ConfNomina.TESTFIELD("Horas de almuerzo");
                    END;

                    ControlAsist.RESET;
                    ControlAsist.SETRANGE("Cod. Empleado", LogPonchador."Cod. Empleado");
                    ControlAsist.SETRANGE("Fecha registro", LogPonchador."Fecha registro");
                    IF NOT ControlAsist.FINDFIRST THEN BEGIN
                        Contador += 1;
                        ControlAsist.INIT;
                        ControlAsist.VALIDATE("Cod. Empleado", LogPonchador."Cod. Empleado");
                        ControlAsist.VALIDATE("Fecha registro", LogPonchador."Fecha registro");
                        ControlAsist."Hora registro" := TIME;
                        ControlAsist."ID Equipo" := LogPonchador."ID Equipo";
                        /*
                        IF LogPonchador."Hora registro" < 120000T THEN
                           BEGIN
                            ControlAsist.VALIDATE("1ra entrada",LogPonchador."Hora registro");
            //                ControlAsist.VALIDATE("1ra salida",120000T);
            //                ControlAsist.VALIDATE("2da entrada",130000T);
                           END
                        ELSE
                        IF ContadorReg > 3 THEN
                           BEGIN
                             ControlAsist.VALIDATE("1ra salida",LogPonchador."Hora registro");
                             ControlAsist.VALIDATE("2da salida",130000T);
                           END
                        ELSE
                          ControlAsist.VALIDATE("1ra salida",LogPonchador."Hora registro");
                        */

                        IF Contador <= ContadorReg THEN
                            CASE Contador OF
                                1:
                                    ControlAsist.VALIDATE("1ra entrada", LogPonchador."Hora registro");
                                2:
                                    BEGIN
                                        ControlAsist."1ra salida" := LogPonchador."Hora registro";
                                        IF Empl.Shift <> '' THEN BEGIN
                                            //   ControlAsist."1ra salida"  := ConfNomina."Horas de almuerzo";
                                            //ControlAsist."2da entrada" := ConfNomina."Horas de almuerzo" + 010000t;
                                            ControlAsist.VALIDATE("2da salida", LogPonchador."Hora registro");
                                        END;
                                    END;
                                3:
                                    ControlAsist."2da entrada" := LogPonchador."Hora registro";
                                ELSE
                                    ControlAsist."2da salida" := LogPonchador."Hora registro";
                            END;
                        ControlAsist.INSERT;
                    END
                    ELSE BEGIN
                        Contador += 1;
                        IF Contador <= ContadorReg THEN
                            CASE Contador OF
                                1:
                                    ControlAsist."1ra entrada" := LogPonchador."Hora registro";
                                2:
                                    BEGIN
                                        ControlAsist."1ra salida" := LogPonchador."Hora registro";
                                        IF Empl.Shift <> '' THEN BEGIN
                                            //                        ControlAsist."1ra salida"  := ShiftSch."Hora almuerzo";
                                            //                        ControlAsist."2da entrada" := ShiftSch."Hora almuerzo" + 1 * 60 * 60 * 1000;
                                            //                        ControlAsist.VALIDATE("2da salida",LogPonchador."Hora registro");
                                        END;
                                    END;

                                3:
                                    ControlAsist."2da entrada" := LogPonchador."Hora registro";
                                ELSE
                                    ControlAsist."2da salida" := LogPonchador."Hora registro";
                            END;

                        /*
                        IF LogPonchador."Hora registro" < 120000T THEN
                           BEGIN
                            ControlAsist.VALIDATE("1ra entrada",LogPonchador."Hora registro");
            //                ControlAsist.VALIDATE("1ra salida",120000T);
            //                ControlAsist.VALIDATE("2da entrada",130000T);
                           END
                        ELSE
                        IF ContadorReg >= 3 THEN
                           BEGIN
                             ControlAsist.VALIDATE("1ra salida",LogPonchador."Hora registro");
                             ControlAsist.VALIDATE("2da entrada",130000T);
                           END
                        ELSE
                        IF ContadorReg > 2 THEN
                           ControlAsist.VALIDATE("1ra salida",LogPonchador."Hora registro");
                        ELSE
                            ControlAsist.VALIDATE("1ra salida",LogPonchador."Hora registro");
                        */
                        ControlAsist.VALIDATE("Fecha registro", LogPonchador."Fecha registro");
                        ControlAsist.VALIDATE("1ra entrada");
                        ControlAsist.MODIFY;
                    END;
                END;

                LogPonchador.Procesado := TRUE;
                LogPonchador.MODIFY;

            UNTIL LogPonchador.NEXT = 0;
        Window.CLOSE;
        MESSAGE(Text011);

    end;

    procedure ValidarCedula(NoCed: Text[11]): Boolean
    var
        Digito: Integer;
        Digito2: Integer;
        i: Integer;
        Resta: Integer;
        Numero_Base: Text;
        Suma: Integer;
        Division: Integer;
    begin
        //Verificamos que la longitud del parametro sea igual a 11, de lo contrario, no es valida
        IF STRLEN(NoCed) < 11 THEN
            EXIT(FALSE);

        Numero_Base := '1212121212';
        FOR i := 10 DOWNTO 1 DO BEGIN
            EVALUATE(Digito, COPYSTR(NoCed, i, 1)); //1 digito del string de la cedula
            EVALUATE(Digito2, COPYSTR(Numero_Base, i, 1)); //1 digito del string numero base
            Resta := Digito * Digito2;
            IF Resta > 10 THEN //Si se pasa de 10 le resto 9
                Resta := Resta - 9
            ELSE
                IF Resta = 10 THEN
                    Resta := 1;
            Suma += Resta;
        END;

        Division := Suma DIV 10 * 10;
        IF Division <> Suma THEN BEGIN
            Division := Division + 10;
            Division -= Suma;
        END
        ELSE
            Division -= Suma;

        IF FORMAT(Division) = COPYSTR(NoCed, 11, 1) THEN
            EXIT(TRUE);
    end;

    procedure TraspasaEmpleados(Empresa: Text[60]; Accionesdepersonal: Record 34002133)
    var
        Empl: Record 5200;
        Empto: Record 5200;
        PerfilSal: Record 34002115;
        PerfilSalTo: Record 34002115;
        Contrato: Record 34002109;
        ContratoTo: Record 34002109;
        Banco: Record 34002108;
        BancoTo: Record 34002108;
        HistCabNom: Record 34002117;
        HistCabNomTo: Record 34002117;
        HistLinNom: Record 34002118;
        HistLinNomTo: Record 34002118;
        Vacac: Record 34002141;
        VacacTo: Record 34002141;
        SaldoISR: Record 34002128;
        SaldoISRTo: Record 34002128;
        MovAct: Record 34002157;
        MovActTo: Record 34002157;
        HistSal: Record 34002149;
        HistSalTo: Record 34002149;
        AltAddr: Record 5201;
        AltAddrTo: Record 5201;
        Qualif: Record 5203;
        QualifTo: Record 5203;
        Ausencia: Record 5205;
        AusenciaTo: Record 5205;
        RecDiv: Record 5214;
        RecDivTo: Record 5214;
        InfConf: Record 5216;
        InfConfTo: Record 5216;
        HistCabCxC: Record 34002146;
        HistCabCxCTo: Record 34002146;
        HistLinCxC: Record 34002147;
        HistLinCxCTo: Record 34002147;
        HistAccepersonal: Record 34002159;
        HistAccepersonalTo: Record 34002159;
    begin
        IF Empresa = COMPANYNAME THEN
            EXIT;

        //Empleados.SETFILTER("Codigo Empleado",'%1','4230');
        Empl.GET(Accionesdepersonal."No. empleado");
        CLEAR(Empto);

        Empto.CHANGECOMPANY(Empresa);
        IF Empto.GET(Empl."No.") THEN;

        Empto.TRANSFERFIELDS(Empl, FALSE);
        Empto."No." := Accionesdepersonal."No. empleado";
        IF NOT Empto.INSERT THEN
            Empto.MODIFY;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado", Empl."No.");
        IF PerfilSal.FINDSET THEN
            REPEAT
                CLEAR(PerfilSalTo);
                PerfilSalTo.TRANSFERFIELDS(PerfilSal, FALSE);
                PerfilSalTo."No. empleado" := Empto."No.";
                PerfilSalTo."Perfil salarial" := PerfilSal."Perfil salarial";
                PerfilSalTo."Concepto salarial" := PerfilSal."Concepto salarial";
                PerfilSalTo.CHANGECOMPANY(Empresa);
                IF NOT PerfilSalTo.INSERT THEN
                    PerfilSalTo.MODIFY;
            UNTIL PerfilSal.NEXT = 0;

        Contrato.RESET;
        Contrato.SETRANGE("No. empleado", Empl."No.");
        IF Contrato.FINDSET THEN
            REPEAT
                CLEAR(ContratoTo);
                ContratoTo.TRANSFERFIELDS(Contrato, FALSE);
                ContratoTo."No. empleado" := Empto."No.";
                ContratoTo."No. Orden" := Contrato."No. Orden";
                ContratoTo.CHANGECOMPANY(Empresa);
                IF NOT ContratoTo.INSERT THEN BEGIN
                    ContratoTo."Fecha finalizacion" := 0D;
                    ContratoTo.MODIFY;
                END;
            UNTIL Contrato.NEXT = 0;

        Banco.RESET;
        Banco.SETRANGE("No. empleado", Empl."No.");
        IF Banco.FINDSET THEN
            REPEAT
                CLEAR(BancoTo);
                BancoTo.TRANSFERFIELDS(Banco, FALSE);
                BancoTo."No. empleado" := Empto."No.";
                BancoTo."Cod. Banco" := Banco."Cod. Banco";
                BancoTo.CHANGECOMPANY(Empresa);
                IF NOT BancoTo.INSERT THEN
                    BancoTo.MODIFY;
            UNTIL Banco.NEXT = 0;

        HistCabNom.RESET;
        HistCabNom.SETRANGE("No. empleado", Empl."No.");
        IF HistCabNom.FINDSET THEN
            REPEAT
                CLEAR(HistCabNomTo);
                HistCabNomTo.TRANSFERFIELDS(HistCabNom);
                HistCabNomTo."No. empleado" := Empto."No.";
                HistCabNomTo.CHANGECOMPANY(Empresa);
                IF HistCabNomTo.INSERT THEN;
            UNTIL HistCabNom.NEXT = 0;

        HistLinNom.RESET;
        HistLinNom.SETRANGE("No. empleado", Empl."No.");
        IF HistLinNom.FINDSET THEN
            REPEAT
                CLEAR(HistLinNomTo);
                HistLinNomTo.TRANSFERFIELDS(HistLinNom);
                HistLinNomTo."No. empleado" := Empto."No.";
                HistLinNomTo.CHANGECOMPANY(Empresa);
                IF HistLinNomTo.INSERT THEN;
            UNTIL HistLinNom.NEXT = 0;

        Vacac.RESET;
        Vacac.SETRANGE("No. empleado", Empl."No.");
        IF Vacac.FINDSET THEN
            REPEAT
                CLEAR(VacacTo);
                VacacTo.TRANSFERFIELDS(Vacac);
                VacacTo."No. empleado" := Empto."No.";
                VacacTo.CHANGECOMPANY(Empresa);
                IF VacacTo.INSERT THEN;
            UNTIL Vacac.NEXT = 0;

        SaldoISR.RESET;
        SaldoISR.SETRANGE("Cod. Empleado", Empl."No.");
        IF SaldoISR.FINDSET THEN
            REPEAT
                CLEAR(SaldoISRTo);
                SaldoISRTo.TRANSFERFIELDS(SaldoISR);
                SaldoISRTo."Cod. Empleado" := Empto."No.";
                SaldoISRTo.CHANGECOMPANY(Empresa);
                IF NOT SaldoISRTo.INSERT THEN
                    SaldoISRTo.MODIFY;
            UNTIL SaldoISR.NEXT = 0;

        MovAct.RESET;
        MovAct.SETRANGE("No. empleado", Empl."No.");
        IF MovAct.FINDSET THEN
            REPEAT
                CLEAR(MovActTo);
                MovActTo.TRANSFERFIELDS(MovAct);
                MovActTo."No. empleado" := Empto."No.";
                MovActTo.CHANGECOMPANY(Empresa);
                IF NOT MovActTo.INSERT THEN
                    MovActTo.MODIFY;
            UNTIL MovAct.NEXT = 0;

        HistSal.RESET;
        HistSal.SETRANGE("No. empleado", Empl."No.");
        IF HistSal.FINDSET THEN
            REPEAT
                CLEAR(HistSalTo);
                HistSalTo.TRANSFERFIELDS(HistSal);
                HistSalTo."No. empleado" := Empto."No.";
                HistSalTo.CHANGECOMPANY(Empresa);
                IF HistSalTo.INSERT THEN;
            UNTIL HistSal.NEXT = 0;

        AltAddr.RESET;
        AltAddr.SETRANGE("Employee No.", Empl."No.");
        IF AltAddr.FINDSET THEN
            REPEAT
                CLEAR(AltAddrTo);
                AltAddrTo.TRANSFERFIELDS(AltAddr);
                AltAddrTo."Employee No." := Empto."No.";
                AltAddrTo.CHANGECOMPANY(Empresa);
                IF NOT AltAddrTo.INSERT THEN
                    AltAddrTo.MODIFY;
            UNTIL AltAddr.NEXT = 0;

        Qualif.RESET;
        Qualif.SETRANGE("Employee No.", Empl."No.");
        IF Qualif.FINDSET THEN
            REPEAT
                CLEAR(QualifTo);
                QualifTo.TRANSFERFIELDS(Qualif);
                QualifTo."Employee No." := Empto."No.";
                QualifTo.CHANGECOMPANY(Empresa);
                IF NOT QualifTo.INSERT THEN
                    QualifTo.MODIFY;
            UNTIL Qualif.NEXT = 0;

        Ausencia.RESET;
        Ausencia.SETRANGE("Employee No.", Empl."No.");
        IF Ausencia.FINDSET THEN
            REPEAT
                CLEAR(AusenciaTo);
                AusenciaTo.TRANSFERFIELDS(Ausencia);
                AusenciaTo."Employee No." := Empto."No.";
                AusenciaTo.CHANGECOMPANY(Empresa);
                IF AusenciaTo.INSERT THEN;
            UNTIL Ausencia.NEXT = 0;

        RecDiv.RESET;
        RecDiv.SETRANGE("Employee No.", Empl."No.");
        IF RecDiv.FINDSET THEN
            REPEAT
                CLEAR(RecDivTo);
                RecDivTo.TRANSFERFIELDS(RecDiv);
                RecDivTo."Employee No." := Empto."No.";
                RecDivTo.CHANGECOMPANY(Empresa);
                IF NOT RecDivTo.INSERT THEN
                    RecDivTo.MODIFY;
            UNTIL RecDiv.NEXT = 0;

        InfConf.RESET;
        InfConf.SETRANGE("Employee No.", Empl."No.");
        IF InfConf.FINDSET THEN
            REPEAT
                CLEAR(InfConfTo);
                InfConfTo.TRANSFERFIELDS(InfConf);
                InfConfTo."Employee No." := Empto."No.";
                InfConfTo.CHANGECOMPANY(Empresa);
                IF NOT InfConfTo.INSERT THEN
                    InfConfTo.MODIFY;
            UNTIL InfConf.NEXT = 0;

        HistCabCxC.RESET;
        HistCabCxC.SETRANGE("Employee No.", Empl."No.");
        IF HistCabCxC.FINDSET THEN
            REPEAT
                HistCabCxCTo.TRANSFERFIELDS(HistCabCxC);
                HistCabCxCTo."Employee No." := Empto."No.";
                HistCabCxCTo.CHANGECOMPANY(Empresa);
                IF NOT HistCabCxCTo.INSERT THEN;
            UNTIL HistCabCxC.NEXT = 0;
        HistLinCxC.RESET;
        HistLinCxC.SETRANGE("Codigo Empleado", Empl."No.");
        IF HistLinCxC.FINDSET THEN
            REPEAT
                HistLinCxCTo.TRANSFERFIELDS(HistLinCxC);
                HistLinCxCTo."Codigo Empleado" := Empto."No.";
                HistLinCxCTo.CHANGECOMPANY(Empresa);
                IF NOT HistLinCxCTo.INSERT THEN;
            UNTIL HistLinCxC.NEXT = 0;

        HistAccepersonal.RESET;
        HistAccepersonal.SETRANGE("No. empleado", Empto."No.");
        IF HistAccepersonal.FINDSET THEN
            REPEAT
                HistAccepersonalTo.TRANSFERFIELDS(HistAccepersonal);
                HistAccepersonalTo.CHANGECOMPANY(Empresa);
                IF HistAccepersonalTo.INSERT THEN;
            UNTIL HistAccepersonal.NEXT = 0;

        HistAccepersonal.INIT;
        HistAccepersonal.TRANSFERFIELDS(Accionesdepersonal);
        HistAccepersonal.CHANGECOMPANY(Empresa);
        IF HistAccepersonal.INSERT THEN;
    end;

    procedure CalculoEntreFechaDotNet(TipoFecha: Code[6]; FechaIni: DateTime; FechaFin: DateTime): Integer
    var
    //TODO: Ver DateandTime: DotNet DateAndTime;
    //TODO: Ver DayOfWeekInput: DotNet FirstDayOfWeek;
    //TODO: Ver WeekOfYearInput: DotNet FirstWeekOfYear;
    begin
        IF TipoFecha = '' THEN
            TipoFecha := 'YYYY';

        //TODO: Ver EXIT(DateandTime.DateDiff(TipoFecha, FechaIni, FechaFin, DayOfWeekInput, WeekOfYearInput));
    end;

    procedure VacacionesporVencer() Vacaciones: Decimal
    var
        HistoricoVacaciones: Record 34002141;
        Contar: Boolean;
    begin
        Vacaciones := 0;
        Empl.RESET;
        Empl.SETRANGE(Status, Empl.Status::Active);
        IF Empl.FINDSET THEN
            REPEAT
                Contar := FALSE;
                HistoricoVacaciones.RESET;
                HistoricoVacaciones.SETRANGE("No. empleado", Empl."No.");
                HistoricoVacaciones.SETFILTER("Fecha Fin", '<%1', CALCDATE('+60D', TODAY));
                IF HistoricoVacaciones.FINDSET THEN BEGIN
                    HistoricoVacaciones.CALCSUMS(Dias);
                    IF HistoricoVacaciones.Dias > 0 THEN
                        Contar := TRUE;
                END;
                IF Contar THEN
                    Vacaciones += 1
            UNTIL Empl.NEXT = 0;
        ;
    end;

    procedure MuestraVacporVencer()
    var
        HistoricoVacaciones: Record 34002141;
        pEmployeeList: Page 5201;
    begin
        Empl.RESET;
        Empl.SETRANGE(Status, Empl.Status::Active);
        IF Empl.FINDSET THEN
            REPEAT
                HistoricoVacaciones.RESET;
                HistoricoVacaciones.SETRANGE("No. empleado", Empl."No.");
                HistoricoVacaciones.SETFILTER("Fecha Fin", '<%1', CALCDATE('+60D', TODAY));
                IF HistoricoVacaciones.FINDSET THEN BEGIN
                    HistoricoVacaciones.CALCSUMS(Dias);
                    IF HistoricoVacaciones.Dias > 0 THEN
                        Empl.MARK(TRUE);
                END;
            UNTIL Empl.NEXT = 0;

        Empl.MARKEDONLY(TRUE);
        pEmployeeList.SETTABLEVIEW(Empl);
        pEmployeeList.RUNMODAL;
        CLEAR(pEmployeeList);
    end;

    procedure AniversarioEmpleados() TotalEmp: Decimal
    var
        Contar: Boolean;
    begin
        AnoInicio := DATE2DMY(TODAY, 3);
        MesInicio := DATE2DMY(TODAY, 2);
        Empl.RESET;
        Empl.SETRANGE(Status, Empl.Status::Active);
        Empl.SETFILTER("Employment Date", '<>%1', 0D);
        IF Empl.FINDSET THEN
            REPEAT
                AnoFin := DATE2DMY(Empl."Employment Date", 3);
                MesFin := DATE2DMY(Empl."Employment Date", 2);
                IF (AnoFin <> AnoInicio) AND (MesFin = MesInicio) THEN
                    TotalEmp += 1;
            UNTIL Empl.NEXT = 0;
    end;

    procedure MuestraAniversarioEmpl()
    var
        pEmployeeList: Page 5201;
    begin
        AnoInicio := DATE2DMY(TODAY, 3);
        MesInicio := DATE2DMY(TODAY, 2);
        Empl.RESET;
        Empl.SETRANGE(Status, Empl.Status::Active);
        Empl.SETFILTER("Employment Date", '<>%1', 0D);
        IF Empl.FINDSET THEN
            REPEAT
                AnoFin := DATE2DMY(Empl."Employment Date", 3);
                MesFin := DATE2DMY(Empl."Employment Date", 2);
                IF (AnoFin <> AnoInicio) AND (MesFin = MesInicio) THEN
                    Empl.MARK(TRUE);
            UNTIL Empl.NEXT = 0;

        Empl.MARKEDONLY(TRUE);
        pEmployeeList.SETTABLEVIEW(Empl);
        pEmployeeList.RUNMODAL;
        CLEAR(pEmployeeList);
    end;

    procedure GetBirthdays(var Noticias: Text[250])
    var
        Emp: Record 5200;
        PrimeraVez: Boolean;
        Contador: Integer;
        Contador2: Integer;
    begin
        PrimeraVez := TRUE;
        Contador := 0;
        Contador2 := 0;

        Emp.RESET;
        Emp.SETCURRENTKEY("Mes Nacimiento", "Dia nacimiento");
        Emp.SETRANGE("Mes Nacimiento", DATE2DMY(TODAY, 2));
        Emp.SETRANGE("Dia nacimiento", DATE2DMY(TODAY, 1));
        Contador := Emp.COUNT;
        IF Emp.FINDSET THEN
            REPEAT
                Contador2 += 1;
                IF Contador2 = 1 THEN
                    Noticias := Emp."Full Name"
                ELSE
                    IF Contador = Contador2 THEN
                        Noticias += ' y ' + Emp."Full Name"
                    ELSE
                        Noticias += ', ' + Emp."Full Name";
            UNTIL Emp.NEXT = 0;
    end;

    local procedure EntrenamientosSemana()
    begin
    end;

    procedure CalculoEntreFechasDT(var FechaInicioDT: DateTime; var FechaFinDT: DateTime; var AnoCalculado: Integer; var MesCalculado: Integer; var DiaCalculado: Integer; var HorasCalculadas: Integer; var MinutosCalculados: Integer)
    var
        Duracion: Duration;
        txtDias: Label 'day';
        txtMes: Label 'month';
        txtAno: Label 'year';
        txtHora: Label 'hour';
        txtMin: Label 'minute';
        CampoTrabajo: Text;
        StringDato: Text;
    begin
        // FechaInicioDT := CREATEDATETIME(DMY2DATE(3,2,2020),214500T);
        // FechaFinDT := CREATEDATETIME(DMY2DATE(7,6,2022),083000T);
        Duracion := FechaFinDT - FechaInicioDT;
        StringDato := FORMAT(Duracion);
        AnoCalculado := 0;
        MesCalculado := 0;
        DiaCalculado := 0;
        HorasCalculadas := 0;
        MinutosCalculados := 0;

        IF STRPOS(UPPERCASE(StringDato), UPPERCASE(txtAno)) <> 0 THEN BEGIN
            CampoTrabajo := COPYSTR(StringDato, 1, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtAno)) - 1);
            StringDato := COPYSTR(StringDato, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtAno)), 50);
            CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
            EVALUATE(AnoCalculado, CampoTrabajo);
        END;

        IF STRPOS(UPPERCASE(FORMAT(StringDato)), UPPERCASE(txtMes)) <> 0 THEN BEGIN
            CampoTrabajo := COPYSTR(StringDato, 1, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtMes)) - 1);
            StringDato := COPYSTR(StringDato, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtMes)), 50);
            CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
            EVALUATE(MesCalculado, CampoTrabajo);
        END;
        IF STRPOS(UPPERCASE(FORMAT(StringDato)), UPPERCASE(txtDias)) <> 0 THEN BEGIN
            CampoTrabajo := COPYSTR(StringDato, 1, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtDias)) - 1);
            StringDato := COPYSTR(StringDato, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtDias)), 50);
            CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
            EVALUATE(DiaCalculado, CampoTrabajo);
        END;

        IF STRPOS(UPPERCASE(FORMAT(StringDato)), UPPERCASE(txtHora)) <> 0 THEN BEGIN
            CampoTrabajo := COPYSTR(StringDato, 1, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtHora)) - 1);
            StringDato := COPYSTR(StringDato, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtHora)), 50);
            CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
            EVALUATE(HorasCalculadas, CampoTrabajo);
        END;

        IF STRPOS(UPPERCASE(FORMAT(StringDato)), UPPERCASE(txtMin)) <> 0 THEN BEGIN
            CampoTrabajo := COPYSTR(StringDato, 1, STRPOS(UPPERCASE(StringDato), UPPERCASE(txtMin)) - 1);
            CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
            EVALUATE(MinutosCalculados, CampoTrabajo);
        END;

        CampoTrabajo := DELCHR(CampoTrabajo, '=', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzáéioú');
        //MESSAGE('%1\%2\%3\%4\%5\%6',Duracion,AnoCalculado,MesCalculado,DiaCalculado,HorasCalculadas,MinutosCalculados);
    end;
}

