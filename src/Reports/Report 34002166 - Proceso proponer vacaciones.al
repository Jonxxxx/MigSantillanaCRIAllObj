report 55807 "Proceso proponer vacaciones"
{
    Caption = 'Propose vacation';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; 5200)
        {
            RequestFilterFields = "No.", "Employee Posting Group", Departamento, "Job Type Code";

            trigger OnAfterGetRecord()
            begin
                PlanVac.VALIDATE("No. empleado", "No.");
                IF NOT PlanVac.INSERT(TRUE) THEN
                    PlanVac.MODIFY(TRUE);

                Contador := Contador + 1;
                Ventana.UPDATE(1, ROUND(Contador / AModificar, 1));
            end;

            trigger OnPostDataItem()
            begin
                Ventana.CLOSE;
                MESSAGE(Msg001);
            end;

            trigger OnPreDataItem()
            begin
                AModificar := COUNT;
                Ventana.OPEN(Text001);

                AModificar := AModificar / 10000;
                Contador := 0;
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
        PlanVac: Record 55832;
        Text001: Label 'Processing ...          \\    @1@@@@@@@@@@@@@    \';
        Msg001: Label 'End of process';
        Ventana: Dialog;
        AModificar: Decimal;
        Contador: Decimal;
}

