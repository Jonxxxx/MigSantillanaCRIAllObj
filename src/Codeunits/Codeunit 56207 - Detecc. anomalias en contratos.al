codeunit 56207 "Detecc. anomalias en contratos"
{

    trigger OnRun()
    begin
        DeteccionAnomaliasEnContratos;
    end;

    procedure DeteccionAnomaliasEnContratos()
    var
        lrEmployee: Record 5200;
        lWindow: Dialog;
        TextL001: Label 'Revisando contratos del empleado ###########1';
        lExigirContinuidadContratos: Boolean;
        lRevisarContratoIndefinidoQueSeaUltimo: Boolean;
        lrAuditoria: Record 56102;
    begin
        //+#269159
        //... Se realizará un recorrido por empleados.

        lExigirContinuidadContratos := TRUE;
        lRevisarContratoIndefinidoQueSeaUltimo := TRUE;

        lrAuditoria.RESET;
        lrAuditoria.SETRANGE("Creado por proceso", TRUE);
        lrAuditoria.DELETEALL;

        lWindow.OPEN(TextL001);
        lrEmployee.RESET;
        IF lrEmployee.FINDFIRST THEN
            REPEAT
                lWindow.UPDATE(1, lrEmployee."No.");
                RevisarContratosEmpleado(lrEmployee."No.", lExigirContinuidadContratos, lRevisarContratoIndefinidoQueSeaUltimo);
            UNTIL lrEmployee.NEXT = 0;
        lWindow.CLOSE;
    end;

    procedure RevisarContratosEmpleado(pCodEmpleado: Code[15]; pExigirContinuidadContratos: Boolean; pRevisarContratoIndefinidoQueSeaUltimo: Boolean)
    var
        lrContrato: Record 34002109;
        lrAuditoria: Record 56102;
        lFechaFinalAnterior: Date;
        lModificar: Boolean;
        lFechaInicio: Date;
        lFechaFinal: Date;
    begin

        //+#269159
        //... Se realizará un recorrido por empleados.

        lrAuditoria.INIT;
        lrAuditoria."No. empleado" := pCodEmpleado;
        lrAuditoria.Estado := lrAuditoria.Estado::Ok;
        lrAuditoria.INSERT(TRUE);

        lrContrato.RESET;
        lrContrato.SETCURRENTKEY("No. empleado", "No. Orden");
        lrContrato.SETRANGE("No. empleado", pCodEmpleado);

        lFechaFinalAnterior := 01011900D;

        IF lrContrato.FINDFIRST THEN
            REPEAT

                lModificar := FALSE;

                //... 1. Empezaremos revisando si la fecha de inicio NO tiene valor asignado.
                IF lrContrato."Fecha inicio" = 0D THEN BEGIN
                    lrAuditoria."Errores fecha inicio" := lrAuditoria."Errores fecha inicio" + 1;
                    lModificar := TRUE;
                END;

                //Calculo de las fechas de inicio y final teorico.
                lFechaInicio := lrContrato."Fecha inicio";
                lFechaFinal := lrContrato."Fecha finalización";
                IF lFechaInicio = 0D THEN
                    lFechaInicio := 01011900D;

                IF lFechaFinal = 0D THEN
                    lFechaFinal := 12319999D;

                //... 2. Revisamos la continuidad de contratos.
                IF pExigirContinuidadContratos THEN BEGIN
                    IF (lFechaInicio < lFechaFinalAnterior) OR (lFechaInicio > lFechaFinal) THEN BEGIN
                        lrAuditoria."Errores continuidad" := lrAuditoria."Errores continuidad" + 1;
                        lModificar := TRUE;
                    END;
                END;

                //... 3. Permitiremos que la fecha final esté sin valor, sólo si y solo, se trata del último contrato ligado al empleado.
                IF pRevisarContratoIndefinidoQueSeaUltimo THEN BEGIN
                    IF lrContrato."Fecha finalización" = 0D THEN BEGIN
                        IF NOT UltimoContrato(lrContrato) THEN BEGIN
                            lrAuditoria."Errores por fecha final" := lrAuditoria."Errores por fecha final" + 1;
                            lModificar := TRUE;
                        END;
                    END;
                END;

                IF lModificar THEN BEGIN
                    lrAuditoria.Estado := lrAuditoria.Estado::Errores;
                    lrAuditoria.MODIFY(TRUE);
                END;

                lFechaFinalAnterior := lFechaFinal;

            UNTIL lrContrato.NEXT = 0;
    end;

    procedure UltimoContrato(lrContratoRef Record: 34002109"): Boolean
    var
        lrContrato: Record 34002109;
    begin
        lrContrato.RESET;
        lrContrato.SETCURRENTKEY("No. empleado", "No. Orden");
        lrContrato.SETRANGE("No. empleado", lrContratoRef."No. empleado");
        lrContrato.SETFILTER("No. Orden", '>%1', lrContratoRef."No. Orden");
        IF lrContrato.FINDFIRST THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;
}

