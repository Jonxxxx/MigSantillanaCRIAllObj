codeunit 52503 ActualizarRutaClientes
{
    // //#33175

    Permissions = TableData 18 = rm;

    trigger OnRun()
    begin
        CLEAR(vContador);
        ldgVentana.OPEN(vtInformacion);

        recClientes.RESET;
        recRutasDistribucion.RESET;

        IF recClientes.FINDSET THEN BEGIN
            vContadorT := recClientes.COUNT;
            REPEAT
                recRutasDistribucion.SETRANGE(recRutasDistribucion.CP, recClientes."Post Code");
                IF recRutasDistribucion.FINDFIRST THEN BEGIN
                    recClientes."Ruta Distribucion" := recRutasDistribucion.Code;
                    recClientes.MODIFY;
                END;

                vContador += 1;
                IF vContador MOD 1000 = 0 THEN BEGIN
                    ldgVentana.UPDATE(1, vContador);
                    ldgVentana.UPDATE(2, ROUND(vContador / vContadorT * 10000, 1));
                END;

            UNTIL recClientes.NEXT = 0;
        END;

        ldgVentana.CLOSE;
    end;

    var
        recClientes: Record 18;
        recCodPostal: Record 225;
        recRutasDistribucion: Record 56071;
        ldgVentana: Dialog;
        vContador: Integer;
        vContadorT: Integer;
        vtInformacion: Label 'Borrando\Linea #1####\@2@@@@@@@@@@@';
}

