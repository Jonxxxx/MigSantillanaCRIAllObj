page 67110 "Consulta Planif. Taller/Evento"
{
    Caption = 'View Assist. Workshop/Events';
    PageType = ListPart;
    SourceTable = 67015;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                    Visible = false;
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                    Visible = false;
                }
                field("Fecha de realizacion"; "Fecha de realizacion")
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Nro. De asistentes reales"; "Nro. De asistentes reales")
                {
                }
                field("Horas dictadas"; "Horas dictadas")
                {
                    Visible = false;
                }
                field(Secuencia; Secuencia)
                {
                    Visible = false;
                }
                field(Estado; Estado)
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                    Visible = false;
                }
                field("Hora Final"; "Hora Final")
                {
                    Visible = false;
                }
                field(CabPlanEvento."Total registrados";
                    CabPlanEvento."Total registrados")
                {
                    Caption = 'Total registered';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        CabPlanEvento.SETRANGE(Expositor, Expositor);
        CabPlanEvento.SETRANGE(Secuencia, Secuencia);
        CabPlanEvento.SETRANGE("Tipo Evento", "Tipo Evento");
        CabPlanEvento.FINDFIRST;
        CabPlanEvento.CALCFIELDS("Total registrados");
    end;

    var
        CabPlanEvento: Record 67051;
        SelDoc: Page 67103;
        TotDocentes: Integer;
        TotSeleccionados: Integer;
        TotReg: Integer;

    procedure AbrirPagAsistentes()
    var
        ATE: Record 67016;
        ATE2Record: Record 67016;
        PagATE: Page 67016;
    begin
        //MESSAGE('%1',Rec);
        ATE.RESET;
        ATE.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        ATE.SETRANGE("Tipo Evento", "Tipo Evento");
        ATE.SETRANGE(Secuencia, Secuencia);
        ATE.SETRANGE("Cod. Expositor", Expositor);
        ATE.SETRANGE("Fecha programacion", 0D);
        IF ATE.FINDSET THEN BEGIN
            REPEAT
                CLEAR(ATE2);
                ATE2.TRANSFERFIELDS(ATE);
                ATE2."Fecha programacion" := "Fecha programacion";
                IF ATE2.INSERT(TRUE) THEN;
            UNTIL ATE.NEXT = 0;
            COMMIT;
        END;

        ATE.RESET;
        ATE.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        ATE.SETRANGE("Tipo Evento", "Tipo Evento");
        ATE.SETRANGE(Secuencia, Secuencia);
        ATE.SETRANGE("Cod. Expositor", Expositor);
        ATE.SETRANGE("Fecha programacion", "Fecha programacion");
        ATE.FINDFIRST;

        PagATE.SETTABLEVIEW(ATE);
        PagATE.RUNMODAL;
        CLEAR(PagATE);
    end;
}

