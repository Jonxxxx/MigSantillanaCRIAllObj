report 34002133 "Genera archivo Var. Sueldo"
{
    Caption = 'Genera Salary''s variation file';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = Periodo, "Tipo de nomina";

            trigger OnAfterGetRecord()
            begin
                ConfNomina.GET();
                ConfNomina.TESTFIELD("Codeunit Archivos Electronicos");
                "Tipo Archivo" := 3;
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
        ConfNomina: Record 34002103;
        Empresa: Record 34002100;
        Err001: Label 'Missing Bank''s information from Company Setup';
        Err002: Label 'The process will be canceled \the bank account is missing for employee %1';
        Text001: Label 'Payroll period ';
        Text002: Label 'Text documents (*.txt) |*.txt|Word Documents (*.doc*)|*.doc*|All files (*.*)|*.*';
}

