report 55225 "Clasifica devoluciones"
{
    ApplicationArea = All;
    Caption = 'Classify returns';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PreDev; 55250)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Closed = CONST(True));
            RequestFilterFields = "No.", "Customer no.", "Receipt date";

            trigger OnAfterGetRecord()
            begin
                IF NOT Procesada THEN BEGIN
                    recTmpPreDev.INIT;
                    recTmpPreDev := PreDev;
                    recTmpPreDev.INSERT;
                END;

                CODEUNIT.RUN(recCfgSant."Codeunit clas. devoluciones", PreDev);
            end;

            trigger OnPreDataItem()
            begin
                recCfgSant.GET;
                recCfgSant.TESTFIELD("Codeunit clas. devoluciones");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        COMMIT;

        IF recTmpPreDev.COUNT > 0 THEN BEGIN
            CLEAR(repDocsGen);
            repDocsGen.PasarPreDev(recTmpPreDev);
            repDocsGen.USEREQUESTPAGE := TRUE;
            repDocsGen.RUNMODAL;
        END
        ELSE
            MESSAGE(Text001);
    end;

    trigger OnPreReport()
    begin
        IF PreDev.GETFILTERS = '' THEN
            IF NOT CONFIRM(Text002, FALSE) THEN
                CurrReport.QUIT;
    end;

    var
        recCfgSant: Record 55226;
        recPreDev: Record 55250;
        recTmpPreDev: Record 55250 temporary;
        repDocsGen: Report 55262;
        Text001: Label 'No se han encontrado devoluciones pendientes de clasificar.';
        Text002: Label 'No ha seleccionado ningún filtro ¿Desea clasificar todas las devoluciones pendientes?';
}

