codeunit 56007 "Funciones MOI"
{
    // MOI - 10/04/2015: Se añade la opcion de Costa Rica
    //                   Se crea la funcion VerObjetosLicencia
    //                   Se crea la funcion EstaEnLicencia
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripción
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migración Costa Rica. Corregir error compilación.


    trigger OnRun()
    var
        lTextSelectorCostaRica: Label '1. Ver Objetos Licencia, 2. Objeto en Licencia, 3. Corregir Datos';
    begin
        CASE (STRMENU(lTextSelectorCostaRica, 0, 'Funciones MOI - Funciones Costa Rica')) OF
            1:
                IF VerObjetosLicencia THEN
                    MESSAGE(TextProcesoCorrecto);
            2:
                IF EstaEnLicencia THEN
                    MESSAGE(TextProcesoCorrecto);
            3:
                IF CorregirDatos THEN
                    MESSAGE(TextProcesoCorrecto);
            ELSE
                MESSAGE(ErrorProcesoCancelado);
        END;
    end;

    var
        ErrorProcesoCancelado: Label 'Proceso cancelado por el usuario.';
        TextProcesoCorrecto: Label 'Proceso finalizado con exito.';
        gpPaginaMOI: Page56077;

    procedure VerObjetosLicencia(): Boolean
    begin
        //Abre la pagina con el listado de objetos creado he indica que permisos tiene.
        //CPMCR-CEC+
        /*
        CLEAR(gpPaginaLicencias);
        
        IF gpPaginaLicencias.RUNMODAL=ACTION::OK THEN
        BEGIN
          EXIT(TRUE);
        END
        ELSE
        BEGIN
          MESSAGE(ErrorProcesoCancelado);
          EXIT(FALSE);
        END;
        */
        //CPMCR-CEC-

    end;

    procedure EstaEnLicencia(): Boolean
    var
        lrPermisosLicencia: Record 2000000043;
    begin
        //Abre una pagina para preguntar si un objeto en cuestion está en la licencia.
        CLEAR(gpPaginaMOI);

        gpPaginaMOI.SetVisibleTipo(TRUE);
        gpPaginaMOI.SetVisibleID(TRUE);

        IF gpPaginaMOI.RUNMODAL = ACTION::OK THEN BEGIN
            lrPermisosLicencia.RESET;
            lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Type", gpPaginaMOI.GetTipo());
            lrPermisosLicencia.SETRANGE(lrPermisosLicencia."Object Number", gpPaginaMOI.GetID());

            IF lrPermisosLicencia.FINDFIRST THEN BEGIN
                MESSAGE('Se tiene permiso');
            END
            ELSE BEGIN
                MESSAGE('No se tiene permiso');
            END;
            EXIT(TRUE);
        END
        ELSE BEGIN
            MESSAGE(ErrorProcesoCancelado);
            EXIT(FALSE);
        END;
    end;

    procedure CorregirDatos(): Boolean
    var
        lrReferencia: RecordRef;
        lfReferencia: FieldRef;
        i: Integer;
        j: Integer;
        liCampo: Integer;
        ltValor: Text;
        ltNewValor: Text;
        lcCaracter: Char;
        liCaracter: Integer;
        ldgVentana: Dialog;
        liContador: Integer;
        liTotalContador: Integer;
        lTextVentana: Label 'Procesando\Linea #1#####\@2@@@@@';
    begin
        CLEAR(gpPaginaMOI);

        gpPaginaMOI.SetVisibleID(TRUE);

        IF gpPaginaMOI.RUNMODAL = ACTION::OK THEN BEGIN
            //abrir ventana
            CLEAR(liContador);
            ldgVentana.OPEN(lTextVentana);

            lrReferencia.OPEN(gpPaginaMOI.GetID());
            liTotalContador := lrReferencia.COUNT;

            IF lrReferencia.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    liContador += 1;
                    ldgVentana.UPDATE(1, liContador);
                    ldgVentana.UPDATE(2, ROUND(liContador / liTotalContador * 10000, 1));

                    liCampo := 1;
                    i := 1;
                    WHILE i <= lrReferencia.FIELDCOUNT DO BEGIN
                        IF lrReferencia.FIELDEXIST(liCampo) THEN BEGIN
                            i += 1;

                            lfReferencia := lrReferencia.FIELD(liCampo);
                            IF FORMAT(lfReferencia.CLASS) = 'Normal' THEN BEGIN
                                CASE FORMAT(lfReferencia.TYPE) OF
                                    'Code', 'Text':
                                        BEGIN
                                            CLEAR(ltNewValor);
                                            ltValor := lfReferencia.VALUE;
                                            FOR j := 1 TO STRLEN(ltValor) DO BEGIN
                                                lcCaracter := ltValor[j];
                                                liCaracter := lcCaracter;
                                                IF (liCaracter < 32) OR ((liCaracter > 127) AND (liCaracter < 190)) THEN
                                                    ltNewValor := DELSTR(ltValor, j, 1);
                                            END;
                                            IF ltNewValor <> '' THEN BEGIN
                                                lfReferencia.VALUE(ltNewValor);
                                                lrReferencia.MODIFY(FALSE);
                                            END;
                                        END;
                                END;
                            END;
                        END;
                        liCampo += 1;
                    END;
                UNTIL lrReferencia.NEXT = 0;
            ldgVentana.CLOSE;
            EXIT(TRUE);
        END;
    end;
}

