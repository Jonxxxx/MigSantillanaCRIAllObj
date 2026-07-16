codeunit 34002500 "Lanzador DsPOS"
{

    trigger OnRun()
    var
        cfAddin: Codeunit 34002502;
        pPOS: Page 34002530;
    begin


        CLEAR(cfAddin);
        //TODO: Ver cfAddin.RegistrarAddin();
        //TODO: Ver cfAddin.CrearAcciones();

        CLEAR(pPOS);
        COMMIT;
        pPOS.RUN;
    end;
}

