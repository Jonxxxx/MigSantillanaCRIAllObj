report 55761 "Listado de prestamos personal"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado de prestamos personal.rdl';

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
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
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(intAntesNomina; intAntesNomina)
            {

            }
            column(CantEmpl; CantEmpl)
            {
            }
            column(LinPerSal_Importe; LinPerSal.Importe)
            {
                DecimalPlaces = 2 : 2;
            }
            column(HistCabPrestamo__Importe_Pendiente____LinPerSal_Importe_; (HistCabPrestamo."Importe Pendiente" - LinPerSal.Importe))
            {
                DecimalPlaces = 2 : 2;
            }
            column(HistCabPrestamo__Importe_Pendiente_; HistCabPrestamo."Importe Pendiente")
            {
                DecimalPlaces = 2 : 2;
            }
            column(HistCabPrestamo__Importe_Original_; HistCabPrestamo."Importe Original")
            {
                DecimalPlaces = 2 : 2;
            }
            column(CantEmpl_Control39; CantEmpl)
            {
            }
            column(LinPerSal_Importe_Control41; LinPerSal.Importe)
            {
                DecimalPlaces = 2 : 2;
            }
            column(HistCabPrestamo__Importe_Pendiente__Control42; HistCabPrestamo."Importe Pendiente")
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImportePte; ImportePte)
            {
                DecimalPlaces = 2 : 2;
            }
            column(HistCabPrestamo__Importe_Original__Control44; HistCabPrestamo."Importe Original")
            {
                DecimalPlaces = 2 : 2;
            }
            column(Listado_pr_stamos_personalCaption; Listado_pr_stamos_personalCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Control9Caption; Control9CaptionLbl)
            {
            }
            column(Control12Caption; Control12CaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Original_Caption; "Historico Cab. Prestamo".FIELDCAPTION("Importe Original"))
            {
            }
            column(Importe_Pendiente____LinPerSal_Importe_Caption; Importe_Pendiente____LinPerSal_Importe_CaptionLbl)
            {
            }
            column(LinPerSal_Importe_Control19Caption; LinPerSal_Importe_Control19CaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_Caption; Hist_rico_Cab__Pr_stamo__Importe_Pendiente_CaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_Caption; Hist_rico_Cab__Pr_stamo__Importe_Cuota_CaptionLbl)
            {
            }
            column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_Caption; "Historico Cab. Prestamo".FIELDCAPTION("No. Prestamo"))
            {
            }
            column(Hist_rico_Cab__Pr_stamo__Fecha_Inicio_Deducci_n_Caption; "Historico Cab. Prestamo".FIELDCAPTION("Fecha Inicio Deduccion"))
            {
            }
            column(Total_de_empleadosCaption; Total_de_empleadosCaptionLbl)
            {
            }
            column(Total_de_empleadosCaption_Control40; Total_de_empleadosCaption_Control40Lbl)
            {
            }
            dataitem("Historico Cab. Prestamo"; 55787)
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Pendiente)
                                    WHERE(Pendiente = CONST(true));
                column(Hist_rico_Cab__Pr_stamo__Importe_Original_; "Importe Original")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Hist_rico_Cab__Pr_stamo__Importe_Cuota_; "Importe Cuota")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente_; "Importe Pendiente")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LinPerSal_Importe_Control19; LinPerSal.Importe)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Importe_Pendiente____LinPerSal_Importe_; ("Importe Pendiente" - LinPerSal.Importe))
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Hist_rico_Cab__Pr_stamo__No__Pr_stamo_; "No. Prestamo")
                {

                }
                column(Hist_rico_Cab__Pr_stamo__Fecha_Inicio_Deducci_n_; "Fecha Inicio Deduccion")
                {

                }
                column(Hist_rico_Cab__Pr_stamo__Importe_Original__Control33; "Importe Original")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Hist_rico_Cab__Pr_stamo__Importe_Cuota__Control38; "Importe Cuota")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Importe_Pendiente_____Importe_Cuota_; "Importe Pendiente" + "Importe Cuota")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LinPerSal_Importe_Control36; LinPerSal.Importe)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Hist_rico_Cab__Pr_stamo__Importe_Pendiente__Control35; "Importe Pendiente")
                {
                    DecimalPlaces = 2 : 2;
                }
                column("Historico_Cab__Prestamo_Codigo_Empleado"; "Employee No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF AntesDespuesNomina = 1 THEN
                        ImportePte += "Importe Pendiente" + "Importe Cuota";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                HistCabPrestamo.RESET;
                HistCabPrestamo.SETRANGE("Employee No.", "No.");
                HistCabPrestamo.SETFILTER("Fecha Inicio Deduccion", '<%1', FechaFin);
                HistCabPrestamo.SETRANGE(Pendiente, TRUE);
                IF NOT HistCabPrestamo.FINDFIRST THEN
                    CurrReport.SKIP;

                HistCabPrestamo.CALCFIELDS("Importe Pendiente", "Importe Original");

                REPEAT
                    LinPerSal.RESET;
                    LinPerSal.SETRANGE("No. empleado", HistCabPrestamo."Employee No.");
                    LinPerSal.SETRANGE("Concepto salarial", HistCabPrestamo."Concepto Salarial");
                    IF LinPerSal.FINDFIRST THEN BEGIN
                        LinPerSal.Cantidad := 1;
                        LinPerSal.Importe := HistCabPrestamo."Importe Cuota";
                        LinPerSal."1ra Quincena" := HistCabPrestamo."1ra Quincena";
                        LinPerSal."2da Quincena" := HistCabPrestamo."2da Quincena";
                        //Para actualizar el monto en el esq. percepcion
                        IF AplicaaNomina THEN
                            LinPerSal.MODIFY;
                    END;
                UNTIL HistCabPrestamo.NEXT = 0;
                CantEmpl += 1;
            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CREATETOTALS(LinPerSal.Importe, HistCabPrestamo."Importe Original", HistCabPrestamo."Importe Pendiente",
                                        HistCabPrestamo."Importe Pendiente Cte.");

                ConfNominas.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fecha inicio"; FechaInicio)
                {

                    ApplicationArea = All;
                    ToolTip = 'Fecha inicio';
                    trigger OnValidate()
                    var
                        Fecha: Record 2000000007;
                    begin
                        ConfEmpresa.FINDFIRST;

                        IF ConfEmpresa."Tipo Pago Nomina" = ConfEmpresa."Tipo Pago Nomina"::Quincenal THEN BEGIN
                            Dia := DATE2DMY(FechaInicio, 1);
                            IF (Dia <> 1) AND (Dia <> 16) THEN
                                ERROR(Text002);

                            Mes := DATE2DMY(FechaInicio, 2);
                            Ano := DATE2DMY(FechaInicio, 3);
                            IF Dia = 1 THEN
                                FechaFin := DMY2DATE(15, Mes, Ano)
                            ELSE BEGIN
                                FechaInicio := DMY2DATE(1, Mes, Ano);
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                Fecha.SETRANGE("Period Start", FechaInicio);
                                IF Fecha.FINDFIRST THEN
                                    FechaFin := NORMALDATE(Fecha."Period End");
                            END;
                        END
                        ELSE BEGIN
                            Dia := DATE2DMY(FechaInicio, 1);
                            IF Dia <> 1 THEN
                                ERROR(Text001);

                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start", DMY2DATE(Dia, DATE2DMY(FechaInicio, 2), DATE2DMY(FechaInicio, 3)));
                            IF Fecha.FINDFIRST THEN
                                FechaFin := NORMALDATE(Fecha."Period End");
                        END;
                    end;
                }
                field("Fecha fin"; FechaFin)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha fin';
                    Editable = false;
                }
                field("Antes de nomina"; AntesDespuesNomina)
                {
                    ApplicationArea = All;
                    ToolTip = 'Antes de nomina';
                }
                field("Aplicar a nomina"; AplicaaNomina)
                {

                    ApplicationArea = All;
                    ToolTip = 'Aplicar a nomina';
                    trigger OnValidate()
                    begin
                        IF AplicaaNomina AND (AntesDespuesNomina = 1) THEN
                            ERROR('Solo se puede aplicar a nomina si selecciona\' +
                                   'la opcion de Antes de nomina');
                    end;
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

    trigger OnPreReport()
    begin
        intAntesNomina := AntesDespuesNomina;
    end;

    var
        ConfNominas: Record 55744;
        ConfEmpresa: Record 55741;
        HistCabPrestamo: Record 55787;
        LinPerSal: Record 55756;
        MesTrabajo: Integer;
        AnoTrabajo: Integer;
        FechaInicio: Date;
        FechaFin: Date;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        CantEmpl: Integer;
        AplicaaNomina: Boolean;
        NoCuota: Integer;
        AntesDespuesNomina: Option "Antes de nomina","Despu´Š¢s de nomina";
        ImportePte: Decimal;
        Dia: Integer;
        Mes: Integer;
        Ano: Integer;
        Text001: Label 'Starting date must be 1st day';
        Text002: Label 'Starting date mus be 1st or 16th day';
        intAntesNomina: Integer;
        Listado_pr_stamos_personalCaptionLbl: Label 'Listado Prestamos personal';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Control9CaptionLbl: Label 'N´Š¢';
        Control12CaptionLbl: Label 'Nombre completo';
        Importe_Pendiente____LinPerSal_Importe_CaptionLbl: Label 'Balance';
        LinPerSal_Importe_Control19CaptionLbl: Label 'Importe Cuota';
        Hist_rico_Cab__Pr_stamo__Importe_Pendiente_CaptionLbl: Label 'Importe pendiente';
        Hist_rico_Cab__Pr_stamo__Importe_Cuota_CaptionLbl: Label 'Cantidad Cuotas';
        Total_de_empleadosCaptionLbl: Label 'Total de empleados';
        Total_de_empleadosCaption_Control40Lbl: Label 'Total de empleados';
}

