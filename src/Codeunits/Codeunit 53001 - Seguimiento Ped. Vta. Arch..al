codeunit 55222 "Seguimiento Ped. Vta. Arch."
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
        frmCaptura: Page 55212;
        frmSeguimiento: Page 55201;
        datFechaIni: Date;
        datFechaFin: Date;
}

