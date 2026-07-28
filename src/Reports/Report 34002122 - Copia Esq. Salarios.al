report 34002122 "Copia Esq. Salarios"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Empl.GET(AEmpl);
                //Empl.TESTFIELD("Job Type Code");
                EsqSalFrom.SETRANGE("No. empleado", "No.");
                IF EsqSalFrom.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        EsqSalTo.COPY(EsqSalFrom);
                        EsqSalTo."No. empleado" := AEmpl;
                        EsqSalTo.Cargo := Empl."Job Type Code";
                        EsqSalTo.Cantidad := 0;
                        EsqSalTo.Importe := 0;
                        EsqSalTo.INSERT(TRUE);
                    UNTIL EsqSalFrom.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("A empleado"; AEmpl)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Empl: Record 5200;
        EsqSalFrom: Record 34002115;
        EsqSalTo: Record 34002115;
        AEmpl: Code[20];
}

