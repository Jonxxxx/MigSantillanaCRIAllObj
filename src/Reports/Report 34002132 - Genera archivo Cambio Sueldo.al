report 55773 "Genera archivo Cambio Sueldo"
{
    Caption = 'Genera Change of Salary file';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. nomina"; 55758)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = Periodo, "Tipo de nomina";

            trigger OnAfterGetRecord()
            begin
                ConfNomina.GET();
                ConfNomina.TESTFIELD("Codeunit Archivos Electronicos");
                "Tipo Archivo" := 2;
                CODEUNIT.RUN(ConfNomina."Codeunit Archivos Electronicos", "Historico Cab. nomina");
                CurrReport.BREAK;
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
        ConfNomina: Record 55744;
        Empresa: Record 55741;
        Err001: Label 'Missing Bank''s information from Company Setup';
        Err002: Label 'The process will be canceled \the bank account is missing for employee %1';
        Text001: Label 'Payroll period ';
        Text002: Label 'Text documents (*.txt) |*.txt|Word Documents (*.doc*)|*.doc*|All files (*.*)|*.*';
}

