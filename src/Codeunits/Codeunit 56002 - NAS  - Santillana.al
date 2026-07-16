codeunit 56002 "NAS  - Santillana"
{
    SingleInstance = false;

    trigger OnRun()
    begin
        //RunCostAdjmt;
        //UpdateDim;
        UpdateMovildata();
    end;

    var
        RunAM: Text[3];
        Parameter: Text[2];
        EstatusNAS: Record 52500;
        xx: Text[250];
        xx1: Integer;
        xx2: Text[250];

    procedure RunCostAdjmt()
    begin
        /*MESSAGE('Iniciando Ajuste de costos %1',TIME);
        REPORT.RUNMODAL(REPORT::"Adjust Cost - Item Ent. - NAS",FALSE,FALSE);
        REPORT.RUNMODAL(REPORT::"Post Inventory Cost to G/L_NAS",FALSE,FALSE);
        
        MESSAGE('Fin Ajuste de costos %1',TIME);
         */

    end;

    procedure UpdateDim()
    var
        cuDim: Codeunit 410;
    begin
        /*  MESSAGE('Iniciando proceso dimensiones %1',TIME);
        cuDim.UpdateAll(2,FALSE);
        MESSAGE('Fin proceso dimensiones %1',TIME);
        */

    end;

    procedure UpdateMovildata()
    begin
        //SELECTLATESTVERSION;
        REPORT.RUN(56021, FALSE, FALSE);
        MESSAGE('Funcion NAS-Movil se ejecuto a las : %1', TIME);

        xx1 += 1;

        xx := FORMAT(xx1) + ' - NAS-Movil - Ejecutado a : ' + Parameter + ' - ' + RunAM + ' - Hora: ' + FORMAT(TIME);
        MESSAGE('%1', xx);
        EstatusNAS.Status := xx;
        EstatusNAS.INSERT;
    end;

    procedure FuncionHora(var RunAM1: Text[3]; var Parameter1: Text[2])
    var
        ParamStr: Text[260];
        SepPosition: Integer;
        TIMELen: Integer;
    begin

        ParamStr := FORMAT(TIME);
        SepPosition := STRPOS(ParamStr, ':');
        TIMELen := STRLEN(FORMAT(TIME));

        //Determina Hora del dia.
        Parameter1 := COPYSTR(ParamStr, 1, SepPosition - 1);

        //Determinar AM o PM.
        RunAM1 := COPYSTR(ParamStr, STRLEN(ParamStr) - 2, STRLEN(ParamStr));
    end;

    procedure EjecutaNAS()
    begin
        /*CREATE(NavNasTimer,FALSE,TRUE);
        //UpdateMovildata.Interval(3600000);
        NavNasTimer.Interval(300000);
        NavNasTimer.Enabled(TRUE);
        */
        EstatusNAS.INIT;

    end;
}

