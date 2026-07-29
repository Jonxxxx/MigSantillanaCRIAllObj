page 67100 "Expositores - Eventos"
{
    PageType = List;
    SourceTable = 67050;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo de Expositor"; Rec."Tipo de Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Expositor';
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                }
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                    Visible = false;
                }
                field("Cod. Evento"; Rec."Cod. Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Evento';
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                }
                field("Descripcion Evento"; Rec."Descripcion Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Evento';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
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
                    Caption = 'Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CabPlanEvent: Record 67051;
                        CabPlanEvent2Record: Record 67051;
                        PlanEvent: Page 67102;
                    begin
                        PlanEvent.RecibeParametros("Cod. Expositor", "Tipo de Expositor", "Cod. Evento", CabPlanEvent."Tipo Evento");
                        CabPlanEvent.RESET;
                        CabPlanEvent.SETRANGE("Cod. Taller - Evento", "Cod. Evento");
                        IF CabPlanEvent.FINDFIRST THEN
                            PlanEvent.SETRECORD(CabPlanEvent);

                        PlanEvent.RUNMODAL;

                        CLEAR(PlanEvent);
                    end;
                }
            }
        }
    }
}

