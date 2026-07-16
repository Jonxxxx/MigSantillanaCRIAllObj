codeunit 34002523 "Notas Crédito Regis POS"
{

    trigger OnRun()
    var
        recTPV: Record 34002501;
        recTienda: Record 34002503;
        pagTiendas: Page 34002552;
        CduPOS: Codeunit 34002502;
        pagHistNC: Page 34002554;
        recHistNC: Record 114;
        recTiendaTMP: Record 34002503 temporary;
        txtTodas: Label 'TODAS';
        txtDescri: Label 'MOSTRAR TODAS LAS TIENDAS';
    begin

        recTPV.RESET;
        recTPV.SETCURRENTKEY("Usuario windows");
        //TODO: Ver recTPV.SETRANGE("Usuario windows", CduPOS.TraerUsuarioWindows);
        IF NOT recTPV.FINDFIRST THEN BEGIN

            IF recTienda.FINDSET THEN BEGIN
                REPEAT
                    recTiendaTMP := recTienda;
                    recTiendaTMP.INSERT;
                UNTIL recTienda.NEXT = 0;
                recTiendaTMP.INIT;
                recTiendaTMP."Cod. Tienda" := txtTodas;
                recTiendaTMP.Descripcion := txtDescri;
                recTiendaTMP.INSERT;
            END;

            CLEAR(pagTiendas);
            pagTiendas.LOOKUPMODE(TRUE);
            pagTiendas.RecibirTiendas(recTiendaTMP);

            IF pagTiendas.RUNMODAL = ACTION::Yes THEN BEGIN
                pagTiendas.GETRECORD(recTiendaTMP);
                CLEAR(pagHistNC);
                recHistNC.FILTERGROUP(2);
                recHistNC.SETCURRENTKEY("Posting Date", Tienda, "Venta TPV");
                recHistNC.SETRANGE("Venta TPV", TRUE);

                IF recTiendaTMP."Cod. Tienda" <> txtTodas THEN
                    recHistNC.SETRANGE(Tienda, recTiendaTMP."Cod. Tienda");

                recHistNC.FILTERGROUP(0);
                pagHistNC.SETTABLEVIEW(recHistNC);
                pagHistNC.RUNMODAL;
            END;
        END
        ELSE
            ERROR(Error001);
    end;

    var
        Error001: Label 'Funcion Solo disponible en Servidor Central';
}

