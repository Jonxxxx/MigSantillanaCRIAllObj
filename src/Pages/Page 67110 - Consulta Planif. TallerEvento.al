page 55569 "Consulta Planif. Taller/Evento"
{
    Caption = 'View Assist. Workshop/Events';
    PageType = ListPart;
    SourceTable = 55482;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                    Visible = false;
                }
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                    Visible = false;
                }
                field("Fecha de realizacion"; Rec."Fecha de realizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de realizacion';
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                }
                field("Nro. De asistentes reales"; Rec."Nro. De asistentes reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nro. De asistentes reales';
                }
                field("Horas dictadas"; Rec."Horas dictadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas dictadas';
                    Visible = false;
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Visible = false;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Hora de Inicio"; Rec."Hora de Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora de Inicio';
                    Visible = false;
                }
                field("Hora Final"; Rec."Hora Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Final';
                    Visible = false;
                }
                field("CabPlanEventoTotal registrados";
                CabPlanEvento."Total registrados")
                {
                    ApplicationArea = All;
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
        CabPlanEvento: Record 55518;
        SelDoc: Page 55562;
        TotDocentes: Integer;
        TotSeleccionados: Integer;
        TotReg: Integer;

    procedure AbrirPagAsistentes()
    var
        ATE: Record 55483;
        ATE2: Record 55483;
        PagATE: Page 55483;
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

