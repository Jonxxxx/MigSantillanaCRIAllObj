codeunit 55743 "Anular nomina"
{
    Permissions = TableData 55758 = rimd,
                  TableData 55759 = rimd;
    TableNo = 55758;

    trigger OnRun()
    begin
        GlobalRec.COPY(Rec);
        WITH GlobalRec DO BEGIN
            IF "No. Contabilizacion" <> '' THEN
                IF NOT CONFIRM('Ya está contabilizada (' + "No. Contabilizacion" + ').¿Desea anular?') THEN
                    EXIT;

            IF "No. Contabilizacion" = '' THEN
                IF NOT CONFIRM('¿Confirma que desea anular?') THEN
                    EXIT;
            GlobalRec.Anular;

        END;
        Rec.COPY(GlobalRec);
    end;

    var
        ok: Boolean;
        RegCooncep: Record 55752;
        "Lin.nomina": Record 55759;
        "Lin.esquema": Record 55756;
        "Cab.esquema": Record 55755;
        diascotiz: Integer;
        RegTrab: Record 5200;
        PagaExtra: Decimal;
        SiNo: Boolean;
        "añoActual": Integer;
        fechai: Date;
        fechaf: Date;
        "diasAño": Integer;
        copiar: Boolean;
        "hayLin": Boolean;
        GlobalRec: Record 55758;
        Window: Dialog;

    procedure CODIGO()
    var
        CabAporteEmp: Record 55762;
        LinAporteEmp: Record 55763;
    begin
        WITH GlobalRec DO BEGIN
            Window.OPEN(
              'Borrar una nomina del historico     \\' +
              'Mes                   #1######## \' +
              'Tipo                  #2######## \' +
              'Copiar a esq.Simul    #3######## \\' +
              'Yes/No                 #4######## \');

            Window.UPDATE(1, Periodo);
            Window.UPDATE(2, "Tipo de nomina");
            copiar := CONFIRM('¿Desea copiar la nómina al esquema de simulación?', FALSE);
            Window.UPDATE(3, copiar);
            SiNo := CONFIRM('¿Desea anular la nómina?', FALSE);
            Window.UPDATE(4, SiNo);

            IF SiNo = FALSE THEN
                EXIT;

            LOCKTABLE;

            IF GlobalRec."No. Contabilizacion" <> '' THEN
                IF NOT CONFIRM('Ya está contabilizada (' + "No. Contabilizacion" + ').¿Desea anular?') THEN
                    EXIT;

            "Lin.nomina".RESET;
            //  "Lin.nomina".SETRANGE("No. Documento","No. Documento");
            "Lin.nomina".SETRANGE("No. empleado", "No. empleado");
            "Lin.nomina".SETRANGE(Periodo, Periodo);
            "Lin.nomina".SETRANGE("Tipo Nomina", "Tipo Nomina");
            "Lin.nomina".DELETEALL;

            //LinAporteEmp.SETRANGE("No. Documento","No. Documento");
            LinAporteEmp.SETRANGE(Periodo, Periodo);
            //LinAporteEmp.SETRANGE("No. Empleado","No. empleado");
            LinAporteEmp.DELETEALL;
            DELETE;

        END;
    end;
}

