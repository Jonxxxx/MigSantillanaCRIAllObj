report 55767 "Listado de Bonificaciones pers"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado de Bonificaciones pers.rdl';
    Caption = 'Employee Bonification''s Report';

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
            column(MontoVacaciones; MontoVacaciones)
            {
            }
            column(Employee_Salario; Salario)
            {
            }
            column(MontoVacaciones_Control1000000001; MontoVacaciones)
            {
            }
            column(CantEmpl; CantEmpl)
            {
            }
            column(MontoVacaciones_Control22; MontoVacaciones)
            {
            }
            column(MontoVacaciones_Control1000000005; MontoVacaciones)
            {
            }
            column(Employee_Bonification_s_ReportCaption; Employee_Bonification_s_ReportCaptionLbl)
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
            column(MontoVacacionesCaption; MontoVacacionesCaptionLbl)
            {
            }
            column(Employee_SalarioCaption; FIELDCAPTION(Salario))
            {
            }
            column(MontoVacaciones_Control1000000001Caption; MontoVacaciones_Control1000000001CaptionLbl)
            {
            }
            column(Total_de_empleadosCaption; Total_de_empleadosCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Employment Date" = 0D THEN
                    ERROR(Err001, FIELDCAPTION("Employment Date"), TABLECAPTION, "No.");
                /*
                CalculoFechas.CalculoEntreFechas("Employment Date", FechaFin,Anos, Meses, Dias);
                IF Meses = 0 THEN
                   Meses := 1;
                */

                DiasVacaciones := CalculoFechas.CalculoMontoBonificacion("No.", AnoTrabajo, MontoVacaciones, DMY2DATE(31, 12, AnoTrabajo));
                MontoVacaciones := DiasVacaciones;

                CantEmpl += 1;

                //Para actualizar el monto en el esq. percepcion
                IF AplicaaNomina THEN BEGIN
                    LinPerfSalarial2.SETRANGE("No. empleado", "No.");
                    LinPerfSalarial2.SETRANGE("Concepto salarial", ConceptoVac);
                    IF LinPerfSalarial2.FIND('-') THEN BEGIN
                        LinPerfSalarial2.Cantidad := 1;
                        LinPerfSalarial2.Importe := ROUND(MontoVacaciones, 0.01);
                        LinPerfSalarial2.MODIFY;
                    END;
                END;

            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                Fecha.RESET;
                Fecha.SETRANGE(Fecha."Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE(Fecha."Period Start", DMY2DATE(1, 12, AnoTrabajo));
                IF Fecha.FINDFIRST THEN
                    FechaFin := NORMALDATE(Fecha."Period End");

                CurrReport.CREATETOTALS(MontoVacaciones);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Ano a generar"; AnoTrabajo)
                {

                    ApplicationArea = All;
                    ToolTip = 'Ano a generar';
                    trigger OnValidate()
                    begin
                        IF (AnoTrabajo = 0) OR (AnoTrabajo < 1900) THEN
                            ERROR('Introduzca un Ano v´Š¢lido por favor');
                    end;
                }
                field("Concepto salarial bonifacion"; ConceptoVac)
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial bonifacion';
                    TableRelation = "Conceptos salariales".Codigo;
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
    }

    labels
    {
    }

    var
        ConfNominas: Record 55744;
        Fecha: Record 2000000007;
        LinPerfSalarial: Record 55756;
        LinPerfSalarial2: Record 55756;
        ConceptoVac: Code[20];
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
        Employee_Bonification_s_ReportCaptionLbl: Label 'Employee Bonification''s Report';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Employee_DepartamentoCaptionLbl: Label 'Departamento';
        MontoVacacionesCaptionLbl: Label 'Bonification Amount';
        MontoVacaciones_Control1000000001CaptionLbl: Label 'Total Bonification';
        Total_de_empleadosCaptionLbl: Label 'Total de empleados';
}

