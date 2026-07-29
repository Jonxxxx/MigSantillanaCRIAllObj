report 34002105 "Parametros ciclos nominas"
{
    Caption = 'Payroll cicle parameters';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                ValidaFecha;
            end;

            trigger OnPreDataItem()
            begin
                ConfNomina.GET();

                Ventana.OPEN(
                  Text001 +
                  '   @1@@@@@@@@@@@@@    \');
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
                field("Tipo Calculo"; FrecuenciaPago)
                {
                    ApplicationArea = All;
                    Caption = ' Payment frequency';
                    ToolTip = ' Payment frequency';
                }
                field(Inicio; Inicio)
                {
                    ApplicationArea = All;
                    Caption = 'Starting';
                    ToolTip = 'Starting';
                }
                field(Cantidad; Cantidad)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    ToolTip = 'Quantity';
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

        /*
        CASE FrecuenciaPago OF
          FrecuenciaPago::Diaria : BEGIN
            IF IntroLinPerfSal."Inicio Periodo" = 0D THEN
              ERROR(Err002);
          END;
          FrecuenciaPago::Semanal : BEGIN
            IF Semana = 0 THEN
              ERROR(Err003);
            Calendar.SETRANGE(Semana,Semana);
            Calendar.SETRANGE("ANo.",DATE2DMY(WORKDATE,3));
            Calendar.FIND('-');
            IntroLinPerfSal."Mes Inicio" := Calendar.Fecha;
            Calendar.FIND('+');
            IntroLinPerfSal."Mes Fin" := Calendar.Fecha;
          END;
          FrecuenciaPago::Mensual : BEGIN
            IF IntroLinPerfSal.Mes = 0 THEN
              ERROR(Err004);
            Calendar.SETRANGE(Periodo,IntroLinPerfSal.Mes);
            Calendar.SETRANGE("ANo.",DATE2DMY(WORKDATE,3));
            Calendar.FIND('-');
            IntroLinPerfSal."Mes Inicio" := Calendar.Fecha;
            Calendar.FIND('+');
            IntroLinPerfSal."Mes Fin" := Calendar.Fecha;
          END;
        END;
        */

    end;

    var
        ConfNomina: Record 34002103;
        PCN: Record 34002124;
        Calendar: Record 34002134;
        Fecha: Record 2000000007;
        Ventana: Dialog;
        FrecuenciaPago: Option Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        Inicio: Date;
        Text001: Label 'Creating';
        Err001: Label 'Starting date must be 1 or 16';
        Err002: Label 'Debe indicar fecha inicial';
        Cantidad: Integer;
        Incremento: Integer;

    local procedure ValidaFecha()
    var
        Fecha2: Record 2000000007;
        PrimeraVez: Boolean;
        Cont: Integer;
        Seleccionar: Boolean;
    begin
        Fecha.RESET;

        CASE FrecuenciaPago OF
            FrecuenciaPago::Anual:
                BEGIN
                    Fecha.SETRANGE("Period Start", Inicio);
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                END;
            FrecuenciaPago::"Bi-Semanal":
                BEGIN
                    Fecha.SETRANGE("Period Start", Inicio, CALCDATE('+' + FORMAT(Cantidad * 2) + 'S', Inicio));
                    //Fecha.SETRANGE(Fecha."Period No.",cantidad);
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
                END;
            FrecuenciaPago::Semanal:
                BEGIN
                    Fecha.SETRANGE("Period Start", Inicio);
                    //Fecha.SETRANGE(Fecha."Period No.",Semana);
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Week);
                END;
            FrecuenciaPago::Quincenal:
                BEGIN
                    IF (DATE2DMY(Inicio, 1) <> 1) AND (DATE2DMY(Inicio, 1) <> 16) THEN
                        ERROR(Err001);
                END;
        END;

        PrimeraVez := TRUE;
        Seleccionar := TRUE;
        Cont := 0;
        Fecha.FINDSET;
        //MESSAGE('%1',Fecha.GETFILTERS);
        REPEAT
            IF PrimeraVez THEN BEGIN
                PrimeraVez := FALSE;
                PCN.RESET;
                PCN.SETRANGE("Frecuencia de pago", FrecuenciaPago);
                IF PCN.FINDSET THEN
                    PCN.DELETEALL;
            END;

            IF Seleccionar THEN BEGIN
                Seleccionar := FALSE;
                Cont += 1;
                IF Cont <= Cantidad THEN BEGIN
                    PCN.RESET;
                    PCN."No. ciclo" := Cont;
                    PCN."Frecuencia de pago" := FrecuenciaPago;
                    PCN."Fecha de inicio" := Fecha."Period Start";
                    PCN."Fecha fin" := CALCDATE('+1S', NORMALDATE(Fecha."Period End"));
                    PCN.INSERT();
                END;
            END
            ELSE
                Seleccionar := TRUE;
        UNTIL Fecha.NEXT = 0;
    end;
}

