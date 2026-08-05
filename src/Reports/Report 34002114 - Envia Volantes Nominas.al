report 55755 "Envia Volantes Nominas"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Reco; 55758)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", Periodo, "Tipo de nomina";

            trigger OnAfterGetRecord()
            begin

                Emp.GET("No. empleado");
                ConfEmpresa.GET(Emp.Company);
                IF (Emp."E-Mail" = '') AND (Emp."Company E-Mail" = '') THEN
                    CurrReport.SKIP;

                Contador := Contador + 1;
                Ventana.UPDATE(1, "No. empleado");
                Ventana.UPDATE(2, ROUND(Contador / Contador2 * 10000, 1));

                ConfEmpresa.TESTFIELD("ID  Volante Pago");
                CU.GetReport(ConfEmpresa."ID  Volante Pago", "No. empleado");
                CU.RUN(Reco);
            end;

            trigger OnPostDataItem()
            begin
                Ventana.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                Ventana.OPEN(Text003);
                Contador := 0;
                Contador2 := COUNT;
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
        ConfEmpresa: Record 55741;
        Emp: Record 5200;
        CU: Codeunit 55749;
        Text003: Label 'Processing Employee #1########## \@2@@@@@@@@@@@@@';
        Ventana: Dialog;
        Contador: Decimal;
        Contador2: Decimal;
}

