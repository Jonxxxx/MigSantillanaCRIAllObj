report 67010 "Proceso Inic. Docentes -  CDS"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Docentes; 67001)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                "intCampaña": Integer;
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                ColDoc.RESET;
                ColDoc.SETRANGE("Cod. Docente", "No.");
                ColDoc.SETRANGE(Principal, TRUE);
                IF NOT ColDoc.FINDFIRST THEN
                    ColDoc.INIT;


                CLEAR(HistCDS);

                //HistCDS.Campana := ConfAPS.Campana - 1;

                IF ConfAPS.Campana <> '' THEN
                    IF EVALUATE(intCampaña, ConfAPS.Campana) THEN
                        HistCDS.Campana := FORMAT(intCampaña - 1);

                HistCDS."Cod. Docente" := "No.";
                HistCDS."Pertenece al CDS" := "Pertenece al CDS";
                HistCDS."Cod. CDS" := "Cod. CDS";
                HistCDS."Ult. fecha activacion" := "Ult. fecha activacion";
                HistCDS."Cod. Colegio" := ColDoc."Cod. Colegio";
                HistCDS."Cod. Nivel" := ColDoc."Cod. Nivel";
                IF HistCDS.INSERT THEN;

                "Pertenece al CDS" := FALSE;
                "Ult. fecha activacion" := 0D;
                MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE(Msg001);
            end;

            trigger OnPreDataItem()
            begin
                ConfAPS.GET();
                CounterTotal := COUNT;
                Window.OPEN(Text001);
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

    var
        ConfAPS: Record 67000;
        HistCDS: Record 67072;
        ColDoc: Record 67043;
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Msg001: Label 'All the teachers has been processed, please check the updates';
}

