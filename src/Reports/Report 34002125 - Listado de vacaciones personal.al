report 55766 "Listado de vacaciones personal"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado de vacaciones personal.rdl';

    dataset
    {
        dataitem(Employee; 5200)
        {
            CalcFields = Salario;
            DataItemTableView = WHERE("Fecha salida empresa" = FILTER(''),
                                      "Calcular Nomina" = CONST(true));
            RequestFilterFields = "No.", "Calcular Nomina", "Global Dimension 1 Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TIME; TIME)
            {
            }
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(Employee__Employment_Date_; "Employment Date")
            {
            }
            column(Employee_Departamento; Departamento)
            {
            }
            column(Dias_Vacaciones; DiasVacaciones)
            {
            }
            column(Monto_Vacaciones; MontoVacaciones)
            {
            }
            column(Employee_Salario; SalProm)
            {
            }
            column(Remanente_Vacaciones; Remanente)
            {
            }
            column(CantEmpl; CantEmpl)
            {
            }
            column(Employee_Vacaciones_ReportCaption; Employee_Vacaciones_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Employee__Full_Name_Caption; FIELDCAPTION("Full Name"))
            {
            }
            column(Employee__Employment_Date_Caption; FIELDCAPTION("Employment Date"))
            {
            }
            column(Employee_DepartamentoCaption; Employee_DepartamentoCaptionLbl)
            {
            }
            column(Dias_VacacionesCaption; Dias_VacacionesCaption)
            {
            }
            column(Monto_VacacionesCaption; MontoVacacionesCaptionLbl)
            {
            }
            column(Employee_SalarioCaption; FIELDCAPTION(Salario))
            {
            }
            column(Remanente_Vacaciones_Caption; Remanente_Vacaciones_Caption)
            {
            }
            column(Total_de_empleadosCaption; Total_de_empleadosCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Employment Date" = 0D THEN
                    CurrReport.SKIP;

                IF Mes <> Mes::"Ano completo" THEN
                    MesTrabajo := Mes + 1
                ELSE BEGIN
                    MesTrabajo := 12;
                    Fecha.RESET;
                    Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
                    IF Fecha.FINDFIRST THEN
                        FechaFin := NORMALDATE(Fecha."Period End");
                END;

                IF DATE2DMY("Employment Date", 3) > DATE2DMY(FechaFin, 3) THEN
                    CurrReport.SKIP;

                //Busco los datos del contrato
                Contrato.RESET;
                Contrato.SETRANGE("No. empleado", "No.");
                Contrato.SETRANGE("Cod. contrato", "Emplymt. Contract Code");
                IF NOT Contrato.FINDFIRST THEN
                    CurrReport.SKIP;


                IF "Employment Date" = 0D THEN
                    ERROR(Err001, FIELDCAPTION("Employment Date"), TABLECAPTION, "No.");

                IF Mes <> Mes::"Ano completo" THEN BEGIN
                    IF DATE2DMY("Employment Date", 2) <> MesTrabajo THEN
                        CurrReport.SKIP;

                    Fecha.RESET;
                    Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, 12, AnoTrabajo));
                    IF Fecha.FINDFIRST THEN
                        FechaFin := NORMALDATE(Fecha."Period End");
                END;

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                    IF Primera AND (NOT Segunda) AND (DATE2DMY("Employment Date", 1) > 15) THEN
                        CurrReport.SKIP
                    ELSE
                        IF (NOT Primera) AND Segunda AND (DATE2DMY("Employment Date", 1) < 16) THEN
                            CurrReport.SKIP;
                END;

                TESTFIELD("Employment Date");
                CalculoFechas.CalculoEntreFechas("Employment Date", FechaFin, Anos, Meses, Dias);
                DiasVacaciones := CalculoFechas.CalculoDiaVacaciones("No.", MesTrabajo, AnoTrabajo, MontoVacaciones, "Employment Date", FechaFin);

                IF DiasVacaciones = 0 THEN
                    CurrReport.SKIP;

                //Calculo en base a todos los conceptos de salario
                //CALCFIELDS(Salario);
                Salario := 0;
                LinPerfSalarial.RESET;
                LinPerfSalarial.SETRANGE("No. empleado", "No.");
                LinPerfSalarial.SETRANGE("Salario Base", TRUE);
                LinPerfSalarial.FINDSET;
                REPEAT
                    Salario += LinPerfSalarial.Importe;
                UNTIL LinPerfSalarial.NEXT = 0;

                SalProm := Salario;
                //Busco el sueldo promedio del empleado si es por hora
                IF "Tipo pago" = 1 THEN //Por hora
                   BEGIN
                    SalProm := 0;

                    Fecha.RESET;
                    Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
                    Fecha.FINDFIRST;
                    FechaFin := CALCDATE('-1A', DMY2DATE(1, MesTrabajo, AnoTrabajo));
                    MesAnt := 0;
                    CantNom := 0;

                    HLN.RESET;
                    HLN.SETRANGE(Periodo, DMY2DATE(1, DATE2DMY(FechaFin, 2), DATE2DMY(FechaFin, 3)), NORMALDATE(Fecha."Period End"));
                    HLN.SETRANGE("No. empleado", "No.");
                    HLN.SETRANGE("Salario Base", TRUE);
                    IF HLN.FINDSET THEN
                        REPEAT
                            IF MesAnt <> DATE2DMY(HLN.Periodo, 2) THEN BEGIN
                                MesAnt := DATE2DMY(HLN.Periodo, 2);
                                CantNom += 1;
                            END;
                            SalProm += HLN.Total;
                        UNTIL HLN.NEXT = 0;

                    SalProm := SalProm / CantNom;
                END;
                //MESSAGE('%1 %2 %3 %4 %5',ConfNominas."Salario Minimo",salario,SalProm,HLN.GETFILTERS,CantNom);
                SalDiario := SalProm / 23.83;

                IF (ConfNominas."Salario Minimo" <> 0) AND (ConfNominas."Salario Minimo" > SalProm) THEN BEGIN
                    SalDiario := ConfNominas."Salario Minimo" / 23.83;
                    SalProm := ConfNominas."Salario Minimo";
                END;

                MontoVacaciones := SalDiario * DiasVacaciones;

                IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual THEN
                    Remanente := ROUND(SalProm - MontoVacaciones, 0.01)
                ELSE
                    IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                        Remanente := ROUND(MontoVacaciones - (SalProm / 2), 0.01)
                    ELSE
                        Remanente := ROUND(MontoVacaciones, 0.01);
                CantEmpl += 1;

                //Para actualizar el monto en el esq. percepcion
                IF AplicaaNomina THEN BEGIN
                    LinPerfSalarial2.SETRANGE("No. empleado", "No.");
                    LinPerfSalarial2.SETRANGE("Concepto salarial", ConfNominas."Concepto Vacaciones");
                    IF LinPerfSalarial2.FINDFIRST THEN BEGIN
                        LinPerfSalarial2.Cantidad := 1;
                        IF "Tipo pago" = 1 THEN //Por hora
                            LinPerfSalarial2.Importe := Remanente
                        ELSE
                            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN
                                LinPerfSalarial2.Importe := Remanente

                            ELSE
                                LinPerfSalarial2.Importe := Remanente;
                        LinPerfSalarial2.MODIFY;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                //ConfNominas.TESTFIELD("Salario Minimo");
                ConfNominas.TESTFIELD("Concepto Vacaciones");
                IF Mes = Mes::"Ano completo" THEN
                    MesTrabajo := 12
                ELSE
                    MesTrabajo := Mes + 1;

                Fecha.RESET;
                Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, MesTrabajo, AnoTrabajo));
                IF Fecha.FINDFIRST THEN
                    FechaFin := NORMALDATE(Fecha."Period End");

                CurrReport.CREATETOTALS(MontoVacaciones);
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
                field("Ano a generar"; AnoTrabajo)
                {
                    ApplicationArea = All;
                    Caption = 'Year to calculate';
                    ToolTip = 'Year to calculate';

                    trigger OnValidate()
                    begin
                        IF (AnoTrabajo = 0) OR (AnoTrabajo < 1900) THEN
                            ERROR('Introduzca un Ano v´Š¢lido por favor');
                    end;
                }
                field("Mes a generar"; Mes)
                {
                    ApplicationArea = All;
                    Caption = 'Month to calculate';
                    ToolTip = 'Month to calculate';

                    trigger OnValidate()
                    begin
                        /*
                        IF Mes <> 12 THEN
                           BEGIN
                            Fecha.SETRANGE("Period Type",Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start",DMY2DATE(1,Mes+1,Anotrabajo));
                            Fecha.FINDFIRST;
                        
                            FechaIni := Fecha."Period Start";
                            FechaFin := NORMALDATE(Fecha."Period End");
                           END;
                        */

                    end;
                }
                field("Aplicar a nomina"; AplicaaNomina)
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplicar a nomina';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF AnoTrabajo = 0 THEN
                AnoTrabajo := DATE2DMY(TODAY, 3);
        end;
    }

    labels
    {
    }

    var
        ConfNominas: Record 55744;
        Contrato: Record 55750;
        Fecha: Record 2000000007;
        LinPerfSalarial: Record 55756;
        LinPerfSalarial2: Record 55756;
        HLN: Record 55759;
        Mes: Option Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre,"Ano completo";
        ConceptoVac: Code[10];
        MesTrabajo: Integer;
        AnoTrabajo: Integer;
        FechaFin: Date;
        CalculoFechas: Codeunit 55745;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        CantEmpl: Integer;
        DiasVacaciones: Decimal;
        MontoVacaciones: Decimal;
        AplicaaNomina: Boolean;
        Err001: Label 'Configure %1 to %2 %3';
        SalDiario: Decimal;
        Employee_Vacaciones_ReportCaptionLbl: Label 'Employee Vacation''s Report';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Employee_DepartamentoCaptionLbl: Label 'Departamento';
        MontoVacacionesCaptionLbl: Label 'Vacation''s Amount';
        MontoVacaciones_Control1000000001CaptionLbl: Label 'Total Vacation';
        Total_de_empleadosCaptionLbl: Label 'Total de empleados';
        Primera: Boolean;
        Segunda: Boolean;
        Dias_VacacionesCaption: Label 'Vacation''s days';
        Remanente_Vacaciones_Caption: Label 'Remaining';
        SalProm: Decimal;
        MesAnt: Integer;
        CantNom: Integer;
        Remanente: Decimal;
}

