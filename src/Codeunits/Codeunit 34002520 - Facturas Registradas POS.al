codeunit 34002520 "Facturas Registradas POS"
{

    trigger OnRun()
    var
        recTPV: Record 34002501;
        recTienda: Record 34002503;
        recTiendaTMP: Record 34002503 temporary;
        pagTiendas: Page 34002552;
        CduPOS: Codeunit 34002502;
        pagHistFact: Page 34002553;
        recHistFact: Record 112;
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
                recTiendaTMP.Descripcion := TxtDescri;
                recTiendaTMP.INSERT;
            END;

            CLEAR(pagTiendas);
            pagTiendas.LOOKUPMODE(TRUE);
            pagTiendas.RecibirTiendas(recTiendaTMP);
            IF pagTiendas.RUNMODAL = ACTION::Yes THEN BEGIN
                pagTiendas.GETRECORD(recTiendaTMP);
                CLEAR(pagHistFact);
                recHistFact.FILTERGROUP(2);
                recHistFact.SETCURRENTKEY("Posting Date", Tienda, "Venta TPV");
                recHistFact.SETRANGE("Venta TPV", TRUE);
                IF recTiendaTMP."Cod. Tienda" <> txtTodas THEN
                    recHistFact.SETRANGE(Tienda, recTiendaTMP."Cod. Tienda");
                recHistFact.FILTERGROUP(0);
                pagHistFact.SETTABLEVIEW(recHistFact);
                pagHistFact.RUNMODAL;
            END;
        END
        ELSE
            ERROR(Error001);
    end;

    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        txtTodas: Label 'TODAS';
        TxtDescri: Label 'MOSTRAR TODAS LAS TIENDAS';
}

