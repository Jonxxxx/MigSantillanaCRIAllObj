codeunit 34002524 "Facturas Pendientes POS"
{

    trigger OnRun()
    var
        recTPV: Record 34002501;
        recTienda: Record 34002503;
        pagTiendas: Page 34002552;
        CduPOS: Codeunit 34002502;
        pagFact: Page 34002555;
        recFact: Record 36;
        recTiendaTMP: Record 34002503 temporary;
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

