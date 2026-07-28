report 34002123 "Anular nominas por lotes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", Periodo, "Tipo de nomina";

            trigger OnAfterGetRecord()
            begin
                TipoNom.GET("Tipo de nomina");

                //Anular;

                Borradas := Borradas + 1;
                Ventana.UPDATE(1, ROUND(Borradas / ABorrar, 1));

                FechaInicio := DMY2DATE(1, DATE2DMY(Periodo, 2), DATE2DMY(Periodo, 3));
                Fecha.RESET;
                Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                Fecha.SETRANGE("Period Start", FechaInicio);
                IF Fecha.FINDFIRST THEN
                    FechaFin := NORMALDATE(Fecha."Period End");

                //Se retornan los valores de los saldos de ISR a favor del empleado
                SaldoFavor.SETFILTER(Ano, '%1|%2', 0, DATE2DMY(FechaInicio, 3));
                SaldoFavor.SETRANGE("Cod. Empleado", "No. empleado");
                IF SaldoFavor.FINDFIRST THEN BEGIN
                    HistoricoLinnomina.RESET;
                    HistoricoLinnomina.SETRANGE("No. empleado", "No. empleado");
                    HistoricoLinnomina.SETRANGE(Periodo, Periodo);
                    HistoricoLinnomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
                    HistoricoLinnomina.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
                    IF HistoricoLinnomina.FINDFIRST THEN BEGIN
                        SaldoFavor."Importe Pendiente" += HistoricoLinnomina."ISR compensado";
                        SaldoFavor.MODIFY;
                    END;
                END;


                HistLinPrestamos.RESET;
                HistLinPrestamos.SETRANGE("Codigo Empleado", "No. empleado");
                HistLinPrestamos.SETRANGE("Fecha Transaccion", FechaInicio, FechaFin);
                HistLinPrestamos.SETFILTER("No. Cuota", '>0');
                IF HistLinPrestamos.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        HistCabPrestamos.GET(HistLinPrestamos."No. Prestamo");

                        HistoricoLinnomina.RESET;
                        HistoricoLinnomina.SETRANGE("No. empleado", "No. empleado");
                        HistoricoLinnomina.SETRANGE(Periodo, Periodo);
                        HistoricoLinnomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
                        HistoricoLinnomina.SETRANGE("Concepto salarial", HistCabPrestamos."Concepto Salarial");
                        IF HistoricoLinnomina.FINDFIRST THEN BEGIN
                            HistLinPrestamos2.RESET;
                            HistLinPrestamos2.COPYFILTERS(HistLinPrestamos);
                            IF HistLinPrestamos2.FINDFIRST THEN
                                HistLinPrestamos2.DELETE;

                            IF HistCabPrestamos.Pendiente = FALSE THEN BEGIN
                                HistCabPrestamos.Pendiente := TRUE;
                                HistCabPrestamos.MODIFY;
                            END;
                        END;
                    UNTIL HistLinPrestamos.NEXT = 0;

                Incidencias.SETRANGE("Employee No.", "No. empleado");
                Incidencias.SETFILTER("From Date", '>=%1', GETRANGEMIN(Periodo));
                IF Incidencias.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        Incidencias.Closed := FALSE;
                        Incidencias.MODIFY;
                    UNTIL Incidencias.NEXT = 0;

                //Se retornan los valores de los saldos de ISR a favor del empleado
                /*
                BKSaldoFavor.SETRANGE("Cod. Empleado","No. empleado");
                BKSaldoFavor.SETFILTER("Ano.",'%1|%2',0,DATE2DMY(FechaInicio,3));
                IF BKSaldoFavor.FINDFIRST THEN
                   BEGIN
                     SaldoFavor.SETRANGE("Cod. Empleado","No. empleado");
                     SaldoFavor.SETFILTER(Ano,BKSaldoFavor.GETFILTER("Ano."));
                     IF SaldoFavor.FINDFIRST THEN
                        BEGIN
                         SaldoFavor.TRANSFERFIELDS(BKSaldoFavor);
                         SaldoFavor.MODIFY;
                        END;
                   END;
                */

                IF (TipoNom."Tipo de nomina" <> TipoNom."Tipo de nomina"::Prestaciones) AND
                    (NOT ConfNominas."Usar Acciones de personal") THEN BEGIN
                    Empl.GET("No. empleado");
                    IF NOT Empl."Calcular Nomina" THEN BEGIN
                        Empl."Calcular Nomina" := TRUE;
                        Empl."Fin contrato" := 0D;
                        Empl.MODIFY;
                    END;

                    Cont.SETRANGE("Cod. contrato", Empl."Emplymt. Contract Code");
                    Cont.SETRANGE("No. empleado", "No. empleado");
                    Cont.SETRANGE(Finalizado, TRUE);
                    IF Cont.FINDLAST THEN BEGIN
                        //Cont."Fecha finalizacion" := 0D;
                        Cont.VALIDATE(Activo, FALSE);
                        Cont.MODIFY;
                    END;
                END;

                CabHistAEmpresa.RESET;
                CabHistAEmpresa.SETFILTER(Periodo, GETFILTER(Periodo));
                CabHistAEmpresa.SETRANGE("Tipo de nomina", "Tipo de nomina");
                IF CabHistAEmpresa.FINDFIRST THEN
                    CabHistAEmpresa.Anular;

                Anular;

                CLEAR(TotalImporte);

            end;

            trigger OnPostDataItem()
            var
                LinNomina: Record 34002118;
            begin
                /*
                LinNomina.RESET;
                //LinNomina.SETRANGE("No. empleado","No. empleado");
                LinNomina.SETRANGE(Periodo,Periodo);
                LinNomina.SETRANGE("Tipo nomina","Tipo Nomina");
                IF LinNomina.FINDSET(TRUE,FALSE) THEN
                REPEAT
                 LinNomina.DELETE();
                UNTIL LinNomina.NEXT = 0;
                */

            end;

            trigger OnPreDataItem()
            begin
                IF NOT AnulaContabilizados THEN
                    SETRANGE("No. Contabilizacion", '');
                ABorrar := COUNT;

                IF NOT CONFIRM(STRSUBSTNO(Text001, ABorrar)) THEN
                    CurrReport.BREAK;

                Ventana.OPEN(Text002 + '   @1@@@@@@@@@@@@@    \');

                ABorrar := ABorrar / 10000;
                Borradas := 0;

                ConfNominas.FINDFIRST;
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
                field("Anular los ya contabilizados"; AnulaContabilizados)
                {
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

    var
        CabHistAEmpresa: Record 34002121;
        LinHistAEmpresa: Record 34002122;
        Incidencias: Record 5207;
        Fecha: Record 2000000007;
        HistCabPrestamos: Record 34002146;
        HistLinPrestamos: Record 34002147;
        HistLinPrestamos2: Record 34002147;
        ConfNominas: Record 34002103;
        SaldoFavor: Record 34002128;
        BKSaldoFavor: Record 34002130;
        Empl: Record 5200;
        Cont: Record 34002109;
        TipoNom: Record 34002158;
        HistoricoLinnomina: Record 34002118;
        Ventana: Dialog;
        AnulaContabilizados: Boolean;
        ABorrar: Decimal;
        Borradas: Decimal;
        FechaInicio: Date;
        FechaFin: Date;
        TotalImporte: Decimal;
        Text001: Label 'Do you confirm you want to void %1 entries?';
        Text002: Label 'Voiding ...              \\';
}

