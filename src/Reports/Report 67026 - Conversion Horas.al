report 67026 "Conversion Horas"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Programac. Talleres y Eventos"; 67015)
        {
            DataItemTableView = SORTING(Cod. Taller - Evento, Tipo Evento, Tipo de Expositor, Expositor, Fecha programacion, Secuencia);

            trigger OnAfterGetRecord()
            begin
                "Horas Pedagógicas" := ROUND("Horas dictadas" * 60 / 40, 1);
                MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Proceso finalizado');
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

    trigger OnPreReport()
    var
        Text001: Label 'Se realizará una conversión de horas programadas a horas pedagógicas. ¿Desea continuar?';
    begin
        IF NOT CONFIRM(Text001) THEN
            CurrReport.QUIT;
    end;
}

