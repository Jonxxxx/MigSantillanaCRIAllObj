codeunit 52506 "Registro de costo"
{

    trigger OnRun()
    begin

        EVALUATE(Hor, '031500');
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

    procedure RegCostos()
    begin
        PrimeraVez := TRUE;
        PrimeraVez2 := TRUE;
        Date.RESET;
        Date.SETRANGE("Period Type", Date."Period Type"::Date);
        //Date.SETRANGE("Period Start",CALCDATE('-5D',TODAY),TODAY);
        Date.SETRANGE("Period Start", TODAY);
        Date.FINDSET;
        REPEAT
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

                //TODO: Ver 
                /*
                IF PrimeraVez2 AND (NOT EXISTS('C:\Reporte de costos\costos-' + FORMAT(Date."Period Start", 0, '<Day,2><Month,2><Year4>') + '.pdf')) THEN BEGIN
                    PostValueEntrytoGL.RESET;
                    PostValueEntrytoGL.SETRANGE("Posting Date", 0D, NORMALDATE(Date."Period Start"));
                    IF PostValueEntrytoGL.FINDFIRST THEN BEGIN
                        PostInventoryCosttoGL.InitializeRequest(1, '', TRUE);
                        PostInventoryCosttoGL.SETTABLEVIEW(PostValueEntrytoGL);
                        PostInventoryCosttoGL.SAVEASPDF('C:\Reporte de costos\costos-' + FORMAT(Date."Period Start", 0, '<Day,2><Month,2><Year4>') + '.pdf');
                        CLEAR(PostInventoryCosttoGL);
                        //PostInventoryCosttoGL.RUN;
                        COMMIT;
                    END;
                END;
                */
            END;

        UNTIL Date.NEXT = 0;
        MESSAGE('Fin de tareas nocturnas ');
    end;
}

