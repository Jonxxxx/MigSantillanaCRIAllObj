report 55783 "Cierra Prestamos"
{
    Caption = 'Close Loans';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Historico Cab. Prestamo"; 55787)
        {
            CalcFields = "Importe Pendiente";
            DataItemTableView = SORTING("Employee No.", "No. Prestamo")
                                WHERE(Pendiente = CONST(true));
            RequestFilterFields = "No. Prestamo", "Employee No.";

            trigger OnAfterGetRecord()
            begin
                IF "Importe Pendiente" = 0 THEN
                    CurrReport.SKIP;

                HLP.RESET;
                HLP.SETRANGE("No. Prestamo", "No. Prestamo");
                IF NOT HLP.FINDLAST THEN
                    HLP."No. Linea" := 0;

                HLP2.INIT;
                HLP2."No. Prestamo" := "No. Prestamo";
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
        HLP: Record 55788;
        Txt0001: Label 'To fix open balance';
        HLP2: Record 55788;
}

