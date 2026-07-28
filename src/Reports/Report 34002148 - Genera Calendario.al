report 34002148 "Genera Calendario"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                Date.RESET;
                Date.SETRANGE("Period Type", Date."Period Type"::Date);
                Date.SETRANGE("Period Start", DMY2DATE(1, 1, Ano), DMY2DATE(31, 12, Ano));
                //Date.SETRANGE("Period End",DMY2DATE(31,12,Ano));
                Date.FINDSET;
                REPEAT
                    Calend.INIT;
                    Calend.Fecha := Date."Period Start";
                    //  Calend.Texto
                    IF Date."Period No." = 7 THEN
                        Calend."No laborable" := TRUE
                    ELSE
                        IF (Date."Period No." = 6) AND (SabadosNoLaborables) THEN
                            Calend."No laborable" := TRUE;

                    Calend."Dia de la semana" := Date."Period No.";
                    Calend.Semana := DATE2DWY(Date."Period Start", 2);
                    Calend.Periodo := DATE2DMY(Date."Period Start", 2);
                    Calend.Ano := Ano;
                    Calend.Mes := DATE2DMY(Date."Period Start", 2);
                    IF Calend.INSERT THEN;
                    Cont += 1;
                    IF Cont > 366 THEN
                        EXIT;
                UNTIL Date.NEXT = 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Ano; Ano)
                {
                    Caption = 'Year to generate';
                }
                field(SabadosNoLaborables; SabadosNoLaborables)
                {
                    Caption = 'Saturdays are not working days';
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
        Date: Record 2000000007;
        Date2: Record 2000000007;
        Calend: Record 34002134;
        Ano: Integer;
        SabadosNoLaborables: Boolean;
        Cont: Integer;
}

