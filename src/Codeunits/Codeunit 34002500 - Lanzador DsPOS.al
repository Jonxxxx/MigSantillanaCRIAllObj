codeunit 34002500 "Lanzador DsPOS"
{

    trigger OnRun()
    var
        cfAddin: Codeunit 34002502;
        pPOS: Page 34002530;
    begin


        CLEAR(cfAddin);
        // TODO: Manual review - The DsPOS control-add-in initialization methods are disabled in the referenced codeunit and the legacy client add-in is not SaaS-compatible.
        // Original code preserved below.
        // cfAddin.RegistrarAddin();
        // cfAddin.CrearAcciones();

        CLEAR(pPOS);
        COMMIT;
        pPOS.RUN;
    end;
}

