codeunit 53001 "Seguimiento Ped. Vta. Arch."
{

    trigger OnRun()
    begin

        IF frmCaptura.RUNMODAL = ACTION::OK THEN BEGIN
            frmCaptura.TraerFechas(datFechaIni, datFechaFin);
            frmSeguimiento.PasarFechas(datFechaIni, datFechaFin);
            frmSeguimiento.RUNMODAL;
        END;
    end;

    var
        frmCaptura: Page52503;
        frmSeguimiento: Page52502;
        datFechaIni: Date;
        datFechaFin: Date;
}

