codeunit 56008 "Registro de costos"
{

    trigger OnRun()
    begin

        EVALUATE(Hor, '081500');
        IF TIME > Hor THEN
            EXIT;

        RegCostos;
    end;

    var
        PrimeraVez: Boolean;
        PrimeraVez2: Boolean;
        PostValueEntrytoGL: Record 5811;
        PostInventoryCosttoGL: Report 1002;
        Date: Record 2000000007;
        Hor: Time;
        Archivo: File;

    local procedure RegCostos()
    begin
        PrimeraVez := TRUE;
        PrimeraVez2 := TRUE;
        Date.RESET;
        Date.SETRANGE("Period Type", Date."Period Type"::Date);
        //Date.SETRANGE("Period Type",Date."Period Type"::Week);
        //Date.SETRANGE("Period Start",CALCDATE('-80D',TODAY),TODAY);
        //Date.SETRANGE("Period Start",DMY2DATE(1,11,2021),DMY2DATE(3,1,2022));
        Date.SETRANGE("Period Start", TODAY);
        Date.FINDSET;
        //ERROR('%1',Date.GETFILTERS);

        REPEAT
            EVALUATE(Hor, '081500');
            IF (TIME > Hor) AND (STRPOS(FORMAT(TIME), 'a') <> 0) THEN
                EXIT;

            IF TIME < Hor THEN BEGIN

                IF PrimeraVez THEN BEGIN
                    MESSAGE('Inicio valoracion ' + FORMAT(TIME));
                    REPORT.RUN(REPORT::"Adjust Cost - Item Entries", FALSE, TRUE);
                    MESSAGE('Fin valoracion ' + FORMAT(TIME));
                    PrimeraVez := FALSE;
                    COMMIT;
                END;
                IF (Date."Period Start" = TODAY) AND (PrimeraVez2) THEN
                    PrimeraVez2 := FALSE;

                //   IF PrimeraVez2 AND (NOT EXISTS('COSTOS-' + FORMAT(NORMALDATE(Date."Period End")))) THEN
                BEGIN
                    PostValueEntrytoGL.RESET;
                    PostValueEntrytoGL.SETRANGE("Posting Date", 0D, NORMALDATE(Date."Period End"));
                    IF PostValueEntrytoGL.FINDFIRST THEN BEGIN
                        PostInventoryCosttoGL.InitializeRequest(0, 'COSTOS-' + FORMAT(NORMALDATE(Date."Period End")), TRUE);
                        PostInventoryCosttoGL.SETTABLEVIEW(PostValueEntrytoGL);
                        PostInventoryCosttoGL.SAVEASPDF('\\SAZPBIBCP1\Reporte de Costos\costos-' + FORMAT(Date."Period End", 0, '<Day,2><Month,2><Year4>') + '.pdf');
                        CLEAR(PostInventoryCosttoGL);
                        //PostInventoryCosttoGL.RUN;
                        COMMIT;
                    END;
                END;
            END;

        UNTIL Date.NEXT = 0;
        MESSAGE('Fin de tareas nocturnas ');
    end;
}

