report 34002104 "Nomina preliminar"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Nomina preliminar.rdlc';

    dataset
    {
        dataitem("Perfil Salarial"; 34002115)
        {
            DataItemTableView = SORTING("Concepto salarial");
            RequestFilterFields = "Concepto salarial", "Tipo de nomina";
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
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(TIME; TIME)
            {
            }
            column("Historico_Lin__nomina__Concepto_salarial_"; "Concepto salarial")
            {
            }
            column("Historico_Lin__nomina_Descripcion"; Descripcion)
            {
            }
            column("Historico_Lin__nomina__Concepto_salarial__Control14"; "Concepto salarial")
            {
            }
            column("Historico_Lin__nomina_Descripcion_Control17"; Descripcion)
            {
            }
            column("Historico_Lin__nomina_Cantidad"; Cantidad)
            {
            }
            column("Historico_Lin__nomina_Total"; Importe)
            {
            }
            column(rEmpleado__Full_Name_; rEmpleado."Full Name")
            {
            }
            column("Historico_Lin__nomina__No__empleado_"; "No. empleado")
            {
            }
            column("Historico_Lin__nomina_Total_Control7"; Importe)
            {
            }
            column("Historico_Lin__nomina_Cantidad_Control1000000000"; Cantidad)
            {
            }
            column("Historico_Lin__nomina_Total_Control10"; Importe)
            {
            }
            column(TotalEmpl; TotalEmpl)
            {
            }
            column("Historico_Lin__nomina_Cantidad_Control1000000001"; Cantidad)
            {
            }
            column(Resumen_Importes_PagadosCaption; Resumen_Importes_PagadosCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Full_nameCaption; Full_nameCaptionLbl)
            {
            }
            column("Historico_Lin__nomina_CantidadCaption"; FIELDCAPTION(Cantidad))
            {
            }
            column("Historico_Lin__nomina_TotalCaption"; FIELDCAPTION(Importe))
            {
            }
            column("Historico_Lin__nomina__No__empleado_Caption"; FIELDCAPTION("No. empleado"))
            {
            }
            column(Total_empleadoCaption; Total_empleadoCaptionLbl)
            {
            }
            column(Total_generalCaption; Total_generalCaptionLbl)
            {
            }
            column("Historico_Lin__nomina_Tipo_nomina"; "Tipo nomina")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF InicPer = 0D THEN
                //   ERROR('Se debe introducir una fecha inicio de proceso');

                rEmpleado.GET("No. empleado");

                /*
                //Para las deducciones sobre los ingresos diferentes del sueldo base
                IF "Deducir dias" THEN
                   BEGIN
                     ConfNominas.FIND('-');
                     DiasAusencia     := 0;
                     FechaIniAusencia := 0D;
                     FechafinAusencia := 0D;
                     rAusencia.RESET;
                     rAusencia.SETRANGE("no. empleado", "no. empleado");
                     rAusencia.SETRANGE("Acredita carencia", TRUE);
                     //GRN rAusencia.SETFILTER("Fecha finalizacion", '>=%1',InicPer);
                     rAusencia.SETFILTER("Fecha inicio", '>%1',DMY2DATE(ConfNominas."Dia Corte Incidencias",
                                     DATE2DMY(CALCDATE('-1M',InicPer),2),DATE2DMY(CALCDATE('-1M',InicPer),3)));
                
                     IF rAusencia.FIND('-') THEN
                        BEGIN
                          IF (rAusencia."Fecha finalizacion" <= DMY2DATE(ConfNominas."Dia Corte Incidencias",DATE2DMY(FinPer,2),
                                                                DATE2DMY(FinPer,3))) AND
                             (rAusencia."Fecha inicio"      >= DMY2DATE(ConfNominas."Dia Corte Incidencias",
                              DATE2DMY(CALCDATE('-1M',InicPer),2),DATE2DMY(CALCDATE('-1M',InicPer),3))) THEN
                              DiasAusencia := (rAusencia."Fecha finalizacion" - rAusencia."Fecha inicio" + 1) * (rAusencia."% Jornada"/100)
                          ELSE
                          IF (rAusencia."Fecha finalizacion" > DMY2DATE(ConfNominas."Dia Corte Incidencias",DATE2DMY(FinPer,2),
                                                                        DATE2DMY(FinPer,3))) AND
                             (rAusencia."Fecha inicio"       >= DMY2DATE(ConfNominas."Dia Corte Incidencias",
                              DATE2DMY(CALCDATE('-1M',InicPer),2),DATE2DMY(CALCDATE('-1M',InicPer),3))) THEN
                              DiasAusencia := (DMY2DATE(ConfNominas."Dia Corte Incidencias",DATE2DMY(FinPer,2),DATE2DMY(FinPer,3))
                                              - rAusencia."Fecha inicio" + 1) * (rAusencia."% Jornada"/100);
                        END;
                
                     IF Contrato."Tipo jornada" = Contrato."Tipo jornada"::Quincenales THEN
                        BEGIN
                          CantidadDias := 15;
                          IF DiasAusencia > 15 THEN
                             DiasAusencia := 15;
                        END
                     ELSE
                     IF Contrato."Tipo jornada" = Contrato."Tipo jornada"::Mensuales THEN
                        BEGIN
                          CantidadDias := 30;
                          IF DiasAusencia >  30 THEN
                             DiasAusencia := 30;
                
                          IF rEmpleado."Antig´Š¢edad empresa" >= InicPer THEN
                             BEGIN
                               IF DATE2DMY(FinPer,1) > 30 THEN
                                  CantidadDias    := DMY2DATE(30,DATE2DMY(FinPer,2),DATE2DMY(FinPer,3)) - rEmpleado."Antig´Š¢edad empresa" + 1
                               ELSE
                                  CantidadDias    := FinPer - rEmpleado."Antig´Š¢edad empresa" + 1;
                             END;
                
                        END;
                
                //GRN MESSAGE('%1 %2 %3 %4',"Deducir dias",CantidadDias, DiasAusencia,ImptLin);
                
                     DiasCotizadosPago := CantidadDias - DiasAusencia;
                     IF CantidadDias <= 0 THEN
                        CantidadDias := 1;
                
                     Importe    := Importe / 30 * DiasCotizadosPago;
                
                   END;
                */

                IF "No. empleado" <> EmplAnt THEN BEGIN
                    EmplAnt := "No. empleado";
                    TotalEmpl += 1;
                END;

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
        rFecha: Record 2000000007;
        rEmpleado: Record 5200;
        ConfNominas: Record 34002103;
        DiasAusencia: Decimal;
        FechaIniAusencia: Date;
        FechafinAusencia: Date;
        InicPer: Date;
        FinPer: Date;
        CantidadDias: Integer;
        DiasCotizadosPago: Decimal;
        TotalEmpl: Decimal;
        Dia: Integer;
        Mes: Integer;
        Ano: Integer;
        FechaInicio: Date;
        EmplAnt: Code[20];
        Resumen_Importes_PagadosCaptionLbl: Label 'Resumen Importes Pagados';
        CurrReport_PAGENOCaptionLbl: Label 'Pagina';
        Full_nameCaptionLbl: Label 'Full name';
        Total_empleadoCaptionLbl: Label 'Total empleado';
        Total_generalCaptionLbl: Label 'Total general';
}

