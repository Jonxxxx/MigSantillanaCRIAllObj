report 34002142 "Cierra Prestamos"
{
    Caption = 'Close Loans';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. Pr´Š¢stamo"; 34002146)
        {
            CalcFields = "Importe Pendiente";
            DataItemTableView = SORTING("Employee No.", "No. Pr´Š¢stamo")
                                WHERE(Pendiente = CONST(true));
            RequestFilterFields = "No. Pr´Š¢stamo", "Employee No.";

            trigger OnAfterGetRecord()
            begin
                IF "Importe Pendiente" = 0 THEN
                    CurrReport.SKIP;

                HLP.RESET;
                HLP.SETRANGE("No. Pr´Š¢stamo", "No. Pr´Š¢stamo");
                IF NOT HLP.FINDLAST THEN
                    HLP."No. Linea" := 0;

                HLP2.INIT;
                HLP2."No. Pr´Š¢stamo" := "No. Pr´Š¢stamo";
                HLP2."No. Linea" := HLP."No. Linea" + 1000;
                HLP2."Tipo CxC" := "Tipo CxC";
                HLP2."No. Cuota" := HLP."No. Cuota" + 1;
                HLP2."Fecha Transaccion" := TODAY;
                HLP2."Codigo Empleado" := "Employee No.";
                HLP2.VALIDATE(Importe, "Importe Pendiente" * -1);
                HLP2.INSERT(TRUE);


                Pendiente := FALSE;
                Correccion := TRUE;
                MODIFY;
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
        HLP: Record 34002147;
        Txt0001: Label 'To fix open balance';
        HLP2: Record 34002147;
}

