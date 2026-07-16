codeunit 34002525 "Notas Crédito Pdtes POS"
{

    trigger OnRun()
    var
        recTPV: Record 34002501;
        recTienda: Record 34002503;
        pagTiendas: Page 34002552;
        CduPOS: Codeunit 34002502;
        pagNC: Page 34002557;
        rNC: Record 36;
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
                recTiendaTMP."Cod. Tienda" := txtTodas;
                recTiendaTMP.Descripcion := TxtDescri;
                recTiendaTMP.INSERT;
            END;

            CLEAR(pagTiendas);
            pagTiendas.LOOKUPMODE(TRUE);
            pagTiendas.RecibirTiendas(recTiendaTMP);

            IF pagTiendas.RUNMODAL = ACTION::Yes THEN BEGIN
                pagTiendas.GETRECORD(recTiendaTMP);
                CLEAR(pagNC);
                rNC.FILTERGROUP(2);
                rNC.SETCURRENTKEY("Posting Date", Tienda, "Venta TPV", "Registrado TPV");
                rNC.SETRANGE("Document Type", rNC."Document Type"::"Credit Memo");
                rNC.SETRANGE("Venta TPV", TRUE);
                IF recTiendaTMP."Cod. Tienda" <> txtTodas THEN
                    rNC.SETRANGE(Tienda, recTiendaTMP."Cod. Tienda");
                rNC.FILTERGROUP(0);
                pagNC.SETTABLEVIEW(rNC);
                pagNC.RUNMODAL;
            END;
        END
        ELSE
            ERROR(Error001);
    end;

    var
        Error001: Label 'Funcion Solo disponible en Servidor Central';
        txtTodas: Label 'TODAS';
        TxtDescri: Label 'MOSTRAR TODAS LAS TIENDAS';
}

