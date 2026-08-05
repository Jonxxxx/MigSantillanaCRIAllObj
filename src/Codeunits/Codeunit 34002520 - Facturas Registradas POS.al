codeunit 55914 "Facturas Registradas POS"
{

    trigger OnRun()
    var
        recTPV: Record 55895;
        recTienda: Record 55897;
        recTiendaTMP: Record 55897 temporary;
        pagTiendas: Page 55946;
        pagHistFact: Page 55947;
        recHistFact: Record 112;
    begin

        recTPV.RESET;
        recTPV.SETCURRENTKEY("Usuario windows");
        recTPV.SETRANGE("Usuario windows", USERID);
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

