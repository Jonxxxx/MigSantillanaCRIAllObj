report 56038 "Borrar devolu. procesadas"
{
    Caption = 'Delete Returns classification';
    ProcessingOnly = true;

    dataset
    {
        dataitem(PreDev; 56025)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Closed = CONST(True),
                                      Procesada = CONST(True));
            RequestFilterFields = "No.", "Customer no.", "Receipt date";

            trigger OnAfterGetRecord()
            begin
                dlgProgreso.UPDATE(2, "No.");

                BorrarLineas;
                BorrarDocsClas;
                DELETE;

                intProcesados += 1;
                dlgProgreso.UPDATE(3, ROUND(intProcesados / intTotal * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                dlgProgreso.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                dlgProgreso.OPEN(Text003 + Text004 + Text005);
                dlgProgreso.UPDATE(1, Text002);

                intTotal := COUNT;
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
    begin
        IF NOT CONFIRM(Text006, FALSE) THEN
            CurrReport.QUIT;
    end;

    var
        recDocClas: Record 56013;
        dlgProgreso: Dialog;
        dtImpresion: DateTime;
        intTotal: Integer;
        intProcesados: Integer;
        Text001: Label 'Automatic return from customer %1';
        Text002: Label 'Clasificando devoluciones';
        Text003: Label '#############################1\\';
        Text004: Label 'Devolucion    ###############2\\';
        Text005: Label '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@3';
        Text006: Label '¿Esta seguro de que des eliminar las devoluciones procesadas?';

    procedure BorrarLineas()
    var
        recLinDev: Record 56026;
    begin
        recLinDev.RESET;
        recLinDev.SETRANGE("No. Documento", PreDev."No.");
        recLinDev.DELETEALL;
    end;

    procedure BorrarDocsClas()
    begin
        recDocClas.RESET;
        recDocClas.SETRANGE("No. clas. devoluciones", PreDev."No.");
        recDocClas.DELETEALL;
    end;
}

