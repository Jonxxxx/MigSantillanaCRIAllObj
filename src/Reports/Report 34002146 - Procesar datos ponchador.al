report 55787 "Procesar datos ponchador"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Distrib. Control de asis. Proy"; 55804)
        {
            DataItemTableView = SORTING("Cod. Empleado", "Fecha registro", "Hora registro", "No. Linea");
            RequestFilterFields = "Job No.", "Fecha registro";

            trigger OnAfterGetRecord()
            begin

                CurrReport.BREAK;
            end;

            trigger OnPreDataItem()
            begin
                FechaIni := GETRANGEMIN("Fecha registro");
                FechaFin := GETRANGEMAX("Fecha registro");
                FuncNom.ProcesaControlAsistencia(FechaIni, FechaFin);
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
        //Buscamos la configuracion
        ConfNomina.GET();

        //Verificamos que los conceptos esten configurados
        //ConfNomina.TESTFIELD("Concepto Horas Ext. 100%");
        ConfNomina.TESTFIELD("Concepto Horas Ext. 35%");
        ConfNomina.TESTFIELD("Concepto Horas nocturnas");
        ConfNomina.TESTFIELD("Concepto Dias feriados");
        ConfNomina.TESTFIELD("Concepto Sal. Base");
    end;

    var
        ConfNomina: Record 55744;
        FuncNom: Codeunit 55745;
        FechaIni: Date;
        FechaFin: Date;
}

