codeunit 55918 "Facturas Pendientes POS"
{

    trigger OnRun()
    var
        recTPV: Record 55895;
        recTienda: Record 55897;
        pagTiendas: Page 55946;
        pagFact: Page 55949;
        recFact: Record 36;
        recTiendaTMP: Record 55897 temporary;
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
                recTiendaTMP."Cod. Tienda" := TxtTodas;
                recTiendaTMP.Descripcion := txtDescri;
                recTiendaTMP.INSERT;
            END;

            CLEAR(pagTiendas);
            pagTiendas.LOOKUPMODE(TRUE);
            pagTiendas.RecibirTiendas(recTiendaTMP);

            IF pagTiendas.RUNMODAL = ACTION::Yes THEN BEGIN
                pagTiendas.GETRECORD(recTiendaTMP);
                CLEAR(pagFact);

                recFact.FILTERGROUP(2);
                recFact.SETCURRENTKEY("Posting Date", Tienda, "Venta TPV", "Registrado TPV");
                recFact.SETRANGE("Document Type", recFact."Document Type"::Invoice);
                recFact.SETRANGE("Venta TPV", TRUE);

                IF recTiendaTMP."Cod. Tienda" <> TxtTodas THEN
                    recFact.SETRANGE(Tienda, recTiendaTMP."Cod. Tienda");

                recFact.SETRANGE("Registrado TPV", TRUE);
                recFact.FILTERGROUP(0);
                pagFact.SETTABLEVIEW(recFact);
                pagFact.RUNMODAL;
            END;
        END
        ELSE
            ERROR(Error001);
    end;

    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        TxtTodas: Label 'TODAS';
        txtDescri: Label 'MOSTRAR TODAS LAS TIENDAS';
}

