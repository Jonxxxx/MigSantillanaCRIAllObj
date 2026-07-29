page 67112 "Solic. Planif. Taller/Evento"
{
    Caption = 'View Assist. Workshop/Events';
    PageType = List;
    SourceTable = 67015;

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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000044>")
            {
                Caption = 'Workshop - Event';
                action("<Action1000000047>")
                {
                    ApplicationArea = All;
                    Caption = 'Assistance';
                    ToolTip = 'Assistance';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67016;
                    RunPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                  "Tipo Evento" = FIELD("Tipo Evento"),
                                  "Secuencia" = FIELD("Secuencia"),
                                  "Cod. Expositor" = FIELD("Expositor");

                    trigger OnAction()
                    var
                        CabPlanEvent: Record 67051;
                        CabPlanEvent2Record: Record 67051;
                        PlanEvent: Page 67102;
                    begin
                        /*
                        PlanEvent.RecibeParametros("Cod. Expositor","Tipo de Expositor","Cod. Evento",CabPlanEvent."Tipo Evento");
                        CabPlanEvent.RESET;
                        CabPlanEvent.SETRANGE("Cod. Taller - Evento","Cod. Evento");
                        IF CabPlanEvent.FINDFIRST THEN
                           PlanEvent.SETRECORD(CabPlanEvent);
                        
                        PlanEvent.RUNMODAL;
                        
                        CLEAR(PlanEvent);
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
        CabPlanEvento.SETRANGE(Expositor,Expositor);
        CabPlanEvento.SETRANGE(Secuencia,Secuencia);
        CabPlanEvento.SETRANGE("Tipo Evento","Tipo Evento");
        CabPlanEvento.FINDFIRST;
        CabPlanEvento.CALCFIELDS("Total registrados");
        */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        VALIDATE("Cod. Taller - Evento", gCodTaller);
        VALIDATE("Tipo Evento", gTipoEvento);
        VALIDATE("Cod. Promotor", gCodPromotor);
        VALIDATE("Cod. Colegio", gCodColegio);
        VALIDATE(Expositor, gCodExpositor);
        VALIDATE("Tipo de Expositor", gTipoExpositor);

        TESTFIELD("Cod. Colegio");
        TESTFIELD("Cod. Promotor");
        TESTFIELD(Expositor);
        TESTFIELD("Cod. Taller - Evento");
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("Cod. Taller - Evento", gCodTaller);
        SETRANGE("Tipo Evento", gTipoEvento);
        SETRANGE("Cod. Promotor", gCodPromotor);
        SETRANGE("Cod. Colegio", gCodColegio);
        SETRANGE(Expositor, gCodExpositor);
        SETRANGE("Tipo de Expositor", gTipoExpositor);
    end;

    var
        CabPlanEvento: Record 67051;
        SelDoc: Page 67103;
        TotDocentes: Integer;
        TotSeleccionados: Integer;
        TotReg: Integer;
        gCodTaller: Code[20];
        gTipoEvento: Code[20];
        gCodPromotor: Code[20];
        gCodColegio: Code[20];
        gCodExpositor: Code[20];
        gTipoExpositor: Integer;

    procedure RecibeParametros(CodTaller: Code[20]; TipoEvento: Code[20]; CodPromotor: Code[20]; CodColegio: Code[20]; CodExpositor: Code[20]; TipoExpositor: Integer)
    begin
        gCodTaller := CodTaller;
        gTipoEvento := TipoEvento;
        gCodPromotor := CodPromotor;
        gCodColegio := CodColegio;
        gCodExpositor := CodExpositor;
        gTipoExpositor := TipoExpositor;
    end;

    procedure AbrirPagAsistentes()
    var
        ATE: Record 67016;
        ATE2: Record 67016;
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
        IF ATE.FINDFIRST THEN;

        PagATE.SETTABLEVIEW(ATE);
        PagATE.RUNMODAL;
        CLEAR(PagATE);
    end;
}

