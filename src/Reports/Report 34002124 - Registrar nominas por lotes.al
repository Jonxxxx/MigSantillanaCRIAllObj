report 34002124 "Registrar nominas por lotes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Tipo Empleado";

            trigger OnAfterGetRecord()
            begin
                PerfilSalarios."Empresa cotizacion" := Company;
                PerfilSalarios."No. empleado" := "No.";
                PerfilSalarios."Mes Fin" := IntroLinPerfSal."Mes Fin";
                PerfilSalarios."Inicio Periodo" := IntroLinPerfSal."Inicio Periodo";
                PerfilSalarios."Fin Periodo" := IntroLinPerfSal."Fin Periodo";
                PerfilSalarios."Tipo nomina" := "Tipo Nomina";
                PerfilSalarios."Tipo de nomina" := TipoNom;
                //PerfilSalarios."Perfil salarial"    := "Perfil Salarios";
                IF ("Employment Date" > IntroLinPerfSal."Fin Periodo") THEN
                    CurrReport.SKIP;

                Contrato.SETRANGE("No. empleado", "No.");
                Contrato.SETRANGE("Cod. contrato", Employee."Emplymt. Contract Code");
                IF TiposNom."Tipo de nomina" <> TiposNom."Tipo de nomina"::Prestaciones THEN
                    Contrato.SETRANGE(Activo, TRUE)
                ELSE
                    Contrato.SETRANGE(Activo, FALSE);
                Contrato.FINDFIRST;
                IF (Contrato."Frecuencia de pago" <> TipoCalculo) AND
                   (TiposNom."Tipo de nomina" = TiposNom."Tipo de nomina"::Regular) THEN
                    CurrReport.SKIP;

                //GRN 12/01/2011 CalculoNomina.RUN(PerfilSalarios);
                ConfNomina.TESTFIELD("Codeunit calculo nomina");
                CODEUNIT.RUN(ConfNomina."Codeunit calculo nomina", PerfilSalarios);


                Calculadas += 1;
                Ventana.UPDATE(1, ROUND(Calculadas / ACalcular, 1));
            end;

            trigger OnPreDataItem()
            begin
                ConfNomina.GET();
                IF NOT CONFIRM(Text002) THEN
                    CurrReport.BREAK;

                Ventana.OPEN(
                  Text001 +
                  '   @1@@@@@@@@@@@@@    \');

                TiposNom.GET(TipoNom);
                IF TiposNom."Tipo de nomina" <> TiposNom."Tipo de nomina"::Prestaciones THEN
                    SETRANGE("Calcular Nomina", TRUE)
                ELSE
                    SETRANGE("Calcular Nomina", FALSE);
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
                field(TipoNom; TipoNom)
                {
                    ApplicationArea = All;
                    Caption = 'Payroll type';
                    ToolTip = 'Payroll type';
                    TableRelation = "Tipos de nominas";

                    trigger OnValidate()
                    begin
                        IF TiposNom.GET(TipoNom) THEN BEGIN
                            TipoCalculo := TiposNom."Frecuencia de pago";
                            ActualizarControles;
                            IF ((TipoCalculo = TipoCalculo::Semanal) OR (TipoCalculo = TipoCalculo::"Bi-Semanal")) AND (Semana <> 0) THEN
                                ValidaFecha;
                        END;
                    end;
                }
                field("Tipo Calculo"; TipoCalculo)
                {

                    ApplicationArea = All;
                    ToolTip = 'Tipo Calculo';
                    trigger OnValidate()
                    begin
                        ActualizarControles;
                        IF ((TipoCalculo = TipoCalculo::Semanal) OR (TipoCalculo = TipoCalculo::"Bi-Semanal")) AND (Semana <> 0) THEN
                            ValidaFecha;
                    end;
                }
                group(Semanal)
                {
                    Visible = blnSemanalVisible;
                    field(Semana; Semana)
                    {

                        ApplicationArea = All;
                        ToolTip = 'Semana';
                        trigger OnValidate()
                        begin
                            ValidaFecha;
                        end;
                    }
                    field(Inicio; IntroLinPerfSal."Inicio Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'Start:';
                        ToolTip = 'Start:';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            dia := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 1);
                            IF TipoCalculo = TipoCalculo::Quincenal THEN BEGIN
                                //    IF (dia <> 1) AND (dia <> 16) THEN
                                //       ERROR(Err001);
                                mes := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 2);
                                Ano := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 3);
                                IF dia = 1 THEN
                                    IntroLinPerfSal."Fin Periodo" := DMY2DATE(15, mes, Ano)
                                ELSE BEGIN
                                    Fecha.RESET;
                                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                    Fecha.SETRANGE("Period Start", DMY2DATE(1, mes, Ano));
                                    IF Fecha.FIND('-') THEN
                                        IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                                END;
                            END
                            ELSE BEGIN
                                Inicio := DMY2DATE(1, mes, Ano);
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                Fecha.SETRANGE("Period Start", Inicio);
                                IF Fecha.FIND('-') THEN
                                    IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                            END;
                        end;
                    }
                    field(Fin; IntroLinPerfSal."Fin Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'End:';
                        ToolTip = 'End:';
                        Editable = false;
                    }
                }
                group(BiSemanal)
                {
                    Visible = blnbiSemanalVisible;
                    field(boInicio; IntroLinPerfSal."Inicio Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'Start:';
                        ToolTip = 'Start:';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            dia := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 1);
                            IF TipoCalculo = TipoCalculo::Quincenal THEN BEGIN
                                IF (dia <> TiposNom."Dia inicio 1ra") AND (dia <> TiposNom."Dia inicio 2da") THEN
                                    ERROR(STRSUBSTNO(Err001, TiposNom."Dia inicio 1ra", TiposNom."Dia inicio 2da"));

                                mes := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 2);
                                Ano := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 3);
                                IF dia = 1 THEN
                                    IntroLinPerfSal."Fin Periodo" := DMY2DATE(15, mes, Ano)
                                ELSE BEGIN
                                    Fecha.RESET;
                                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                    Fecha.SETRANGE("Period Start", DMY2DATE(1, mes, Ano));
                                    IF Fecha.FIND('-') THEN
                                        IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                                END;
                            END
                            ELSE BEGIN
                                Inicio := DMY2DATE(1, mes, Ano);
                                Fecha.RESET;
                                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                Fecha.SETRANGE("Period Start", Inicio);
                                IF Fecha.FIND('-') THEN
                                    IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                            END;
                        end;
                    }
                    field(biFin; IntroLinPerfSal."Fin Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'End:';
                        ToolTip = 'End:';
                        Editable = false;
                    }
                }
                group(Mensual)
                {
                    Visible = blnMensualVisible;
                    field(Mes; IntroLinPerfSal.Mes)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Mes';
                        MaxValue = 12;
                        MinValue = 1;

                        trigger OnValidate()
                        begin
                            ValidaFecha;
                        end;
                    }
                    field(Ano; Ano)
                    {

                        ApplicationArea = All;
                        ToolTip = 'Ano';
                        trigger OnValidate()
                        begin
                            IF IntroLinPerfSal.Mes = 0 THEN
                                ERROR(Err004);

                            dia := 1;
                            Inicio := DMY2DATE(1, IntroLinPerfSal.Mes, Ano);
                            IntroLinPerfSal."Mes Inicio" := DMY2DATE(1, IntroLinPerfSal.Mes, Ano);
                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start", Inicio);
                            IF Fecha.FINDFIRST THEN
                                IntroLinPerfSal."Mes Fin" := NORMALDATE(Fecha."Period End");
                        end;
                    }
                    field(InicioMes; IntroLinPerfSal."Inicio Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'Start:';
                        ToolTip = 'Start:';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            dia := DATE2DMY(IntroLinPerfSal."Inicio Periodo", TiposNom."Dia inicio 1ra");
                            IF TipoCalculo = TipoCalculo::Quincenal THEN BEGIN
                                IF (dia <> TiposNom."Dia inicio 1ra") AND (dia <> TiposNom."Dia inicio 2da") THEN
                                    ERROR(STRSUBSTNO(Err001, TiposNom."Dia inicio 1ra", TiposNom."Dia inicio 2da"));

                                mes := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 2);
                                Ano := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 3);
                                IF dia = TiposNom."Dia inicio 1ra" THEN
                                    IntroLinPerfSal."Fin Periodo" := DMY2DATE(15, mes, Ano)
                                ELSE BEGIN
                                    Fecha.RESET;
                                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                                    Fecha.SETRANGE("Period Start", DMY2DATE(1, mes, Ano));
                                    IF Fecha.FIND('-') THEN
                                        IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                                END;
                            END
                            ELSE BEGIN
                                Inicio := DMY2DATE(TiposNom."Dia inicio 1ra", mes, Ano);
                                /* Fecha.RESET;
                                 Fecha.SETRANGE("Period Type",Fecha."Period Type"::Month);
                                 Fecha.SETRANGE("Period Start",Inicio);
                                 IF Fecha.FINDFIRST THEN
                                    IntroLinPerfSal."Fin Periodo":= NORMALDATE(Fecha."Period End");
                                */
                                IntroLinPerfSal."Fin Periodo" := CALCDATE('+1M', NORMALDATE(Fecha."Period End"));
                            END;

                        end;
                    }
                    field(FinMes; IntroLinPerfSal."Fin Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'End:';
                        ToolTip = 'End:';
                        Editable = false;
                    }
                }
                group(Quincenal)
                {
                    Visible = blnQuincenalVisible;
                    field(qInicio; IntroLinPerfSal."Inicio Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'Start:';
                        ToolTip = 'Start:';

                        trigger OnValidate()
                        begin
                            ValidaFecha;
                        end;
                    }
                    field(qFin; IntroLinPerfSal."Fin Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'End:';
                        ToolTip = 'End:';
                        Editable = false;
                    }
                }
                group(Diaria)
                {
                    Visible = blnDiariolVisible;
                    field(dInicio; IntroLinPerfSal."Inicio Periodo")
                    {
                        ApplicationArea = All;
                        Caption = 'Start:';
                        ToolTip = 'Start:';

                        trigger OnValidate()
                        begin
                            ValidaFecha;
                        end;
                    }
                }
                group(Anual)
                {
                    Visible = blnAnualVisible;
                    field(Ano2; Ano)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                        ToolTip = 'Year';

                        trigger OnValidate()
                        begin
                            IF IntroLinPerfSal.Mes = 0 THEN
                                ERROR(Err004);

                            Inicio := DMY2DATE(1, DATE2DMY(TODAY, 2), Ano);
                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start", Inicio);
                            IF Fecha.FINDFIRST THEN
                                IntroLinPerfSal."Inicio Periodo" := NORMALDATE(Fecha."Period Start");
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF Ano = 0 THEN
                Ano := DATE2DMY(TODAY, 3);

            ActualizarControles;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ContarEmpleados.COPYFILTERS(Employee);
        ACalcular := ContarEmpleados.COUNT;
        ACalcular := ACalcular / 10000;
        Calculadas := 0;
    end;

    var
        ConfNomina: Record 34002103;
        Calendar: Record 34002134;
        ContarEmpleados: Record 5200;
        IntroLinPerfSal: Record 34002115;
        PerfilSalarios: Record 34002115;
        Contrato: Record 34002109;
        TiposNom: Record 34002158;
        Fecha: Record 2000000007;
        Ventana: Dialog;
        ACalcular: Decimal;
        Calculadas: Decimal;
        TipoCalculo: Option Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        Semana: Integer;
        dia: Integer;
        mes: Integer;
        Ano: Integer;
        Inicio: Date;
        "Tipo Nomina": Option Normal,"Regalia",Bonificacion,Propina,Renta;
        Text001: Label 'Processing payroll ... \\';
        Text002: Label 'Do you confirm you want to post the payroll?';
        Text003: Label 'You must select %1 for employee %2';
        Err001: Label 'Starting date must be %1 or %2';
        Err002: Label 'Debe indicar fecha inicial';
        Err003: Label 'Debe indicar semana a calcular';
        Err004: Label 'Debe indicar mes a calcular';
        Err005: Label 'Debe indicar Ano a calcular';
        Err006: Label 'No puede indicar al mismo tiempo mes y semana';
        [InDataSet]
        blnSemanalVisible: Boolean;
        [InDataSet]
        blnBiSemanalVisible: Boolean;
        [InDataSet]
        blnMensualVisible: Boolean;
        [InDataSet]
        blnQuincenalVisible: Boolean;
        [InDataSet]
        blnAnualVisible: Boolean;
        [InDataSet]
        blnDiariolVisible: Boolean;
        TipoNom: Code[20];

    procedure ActualizarControles()
    begin
        blnSemanalVisible := FALSE;
        blnMensualVisible := FALSE;
        blnQuincenalVisible := FALSE;
        blnDiariolVisible := FALSE;
        blnAnualVisible := FALSE;

        CASE TipoCalculo OF
            TipoCalculo::Semanal:
                blnSemanalVisible := TRUE;
            TipoCalculo::Mensual:
                blnMensualVisible := TRUE;
            TipoCalculo::Quincenal:
                blnQuincenalVisible := TRUE;
            TipoCalculo::Diaria:
                blnDiariolVisible := TRUE;
            TipoCalculo::Anual:
                blnAnualVisible := TRUE;
        END;
    end;

    local procedure ValidaFecha()
    var
        PCB: Record 34002124;
    begin
        TiposNom.GET(TipoNom);

        IF TipoCalculo <> TipoCalculo::Mensual THEN
            dia := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 1)
        ELSE
            dia := 1;

        Fecha.RESET;

        CASE TipoCalculo OF
            TipoCalculo::Anual:
                BEGIN
                    Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(WORKDATE, 2), Ano));
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                END;
            /*
              TipoCalculo::"Bi-Semanal":
               BEGIN
                PCB.RESET;
                PCB.SETRANGE("Frecuencia de pago",TipoCalculo);
                PCB.SETRANGE("No. ciclo",BiSemana);
                PCB.FINDFIRST;

               END;
            */
            TipoCalculo::Diaria:
                BEGIN
                    Fecha.SETRANGE("Period Start", IntroLinPerfSal."Inicio Periodo");
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Date);
                END;
            TipoCalculo::Semanal:
                BEGIN
                    Fecha.SETRANGE("Period Start", DMY2DATE(1, 1, DATE2DMY(WORKDATE, 3)), DMY2DATE(31, 12, DATE2DMY(WORKDATE, 3)));
                    Fecha.SETRANGE(Fecha."Period No.", Semana);
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
                END;
            TipoCalculo::Quincenal:
                BEGIN
                    mes := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 2);
                    Ano := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 3);
                    dia := DATE2DMY(IntroLinPerfSal."Inicio Periodo", 1);
                    IF TiposNom."Dia inicio 1ra" > TiposNom."Dia inicio 2da" THEN
                        IntroLinPerfSal."Fin Periodo" := CALCDATE('-1D', DMY2DATE(TiposNom."Dia inicio 2da", DATE2DMY(CALCDATE('+15D', IntroLinPerfSal."Inicio Periodo"), 2), DATE2DMY(CALCDATE('+15D', IntroLinPerfSal."Inicio Periodo"), 3)))
                    ELSE BEGIN
                        Fecha.RESET;
                        Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(IntroLinPerfSal."Inicio Periodo", 2), DATE2DMY(IntroLinPerfSal."Inicio Periodo", 3)));
                        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                        Fecha.FINDFIRST;
                        IF dia = 1 THEN
                            IntroLinPerfSal."Fin Periodo" := DMY2DATE(15, mes, Ano)
                        ELSE BEGIN
                            Fecha.RESET;
                            Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                            Fecha.SETRANGE("Period Start", DMY2DATE(1, mes, Ano));
                            IF Fecha.FINDFIRST THEN
                                IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                        END;
                    END;
                END;
            TipoCalculo::Mensual:
                BEGIN
                    mes := IntroLinPerfSal.Mes;
                    Fecha.SETRANGE("Period Start", DMY2DATE(1, mes, Ano));
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                    Fecha.FINDFIRST;
                    IntroLinPerfSal."Inicio Periodo" := Fecha."Period Start";
                    IntroLinPerfSal."Fin Periodo" := Fecha."Period End";
                END
            ELSE BEGIN
                mes := DATE2DMY(TODAY, 2);

                Inicio := DMY2DATE(1, mes, Ano);
                Fecha.RESET;
                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE("Period Start", Inicio);
            END;
        END;


        Fecha.FINDFIRST;

        IF (TipoCalculo = TipoCalculo::Mensual) OR (TipoCalculo = TipoCalculo::Anual) THEN BEGIN
            IntroLinPerfSal."Inicio Periodo" := NORMALDATE(Fecha."Period Start");
            IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
        END
        ELSE
            IF TipoCalculo = TipoCalculo::Semanal THEN BEGIN
                IntroLinPerfSal."Inicio Periodo" := NORMALDATE(Fecha."Period Start");
                Fecha.FINDLAST;
                IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
            END
            ELSE
                IF TipoCalculo = TipoCalculo::Diaria THEN BEGIN
                    IntroLinPerfSal."Inicio Periodo" := NORMALDATE(Fecha."Period Start");
                    IntroLinPerfSal."Fin Periodo" := NORMALDATE(Fecha."Period End");
                END;

        /*
      ELSE
      IF TipoCalculo = TipoCalculo::"Bi-Semanal" THEN
         BEGIN
          IntroLinPerfSal."Inicio Periodo":= PCB."Fecha de inicio";
          IntroLinPerfSal."Fin Periodo" := PCB."Fecha fin";
        END;
        */

    end;
}

