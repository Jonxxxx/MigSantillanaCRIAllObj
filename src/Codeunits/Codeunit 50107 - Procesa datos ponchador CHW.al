codeunit 50107 "Procesa datos ponchador CHW"
{

    trigger OnRun()
    begin
        Haydatos := FALSE;

        //DatosPonchador.SETRANGE(IdUser,'139');
        DatosPonchador.FIND('-');
        REPEAT
            IF Empl.GET(DatosPonchador.CodigoBC) THEN BEGIN
                Haydatos := TRUE;
                wFecha := DT2DATE(DatosPonchador.RecordTime);
                wHora := DT2TIME(DatosPonchador.RecordTime);

                tmpLogReloj.INIT;
                tmpLogReloj."Cod. Empleado" := Empl."No.";
                tmpLogReloj.VALIDATE("Fecha registro", wFecha);
                tmpLogReloj.VALIDATE("Hora registro", wHora);
                tmpLogReloj."No. tarjeta" := DatosPonchador.ProximityCard;
                tmpLogReloj."ID Equipo" := FORMAT(DatosPonchador.MachineNumber);
                IF tmpLogReloj.INSERT THEN;
            END;
        UNTIL DatosPonchador.NEXT = 0;

        IF Haydatos THEN
            FuncionesNom.ProcesaDatosPonchador;
        ;
    end;

    var
        Empl: Record 5200;
        tmpLogReloj: Record 34002177;
        LogReloj: Record 34002177;
        Text000: Label 'End of processing';
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        DatosPonchador: Record 50109;
        FuncionesNom: Codeunit 34002104;
        wFecha: Date;
        wHora: Time;
        Haydatos: Boolean;
}

