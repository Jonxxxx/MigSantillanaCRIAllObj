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
                field("Tipo de Expositor"; "Tipo de Expositor")
                {
                }
                field("Cod. Expositor"; "Cod. Expositor")
                {
                }
                field("Tipo de Evento"; "Tipo de Evento")
                {
                    Visible = false;
                }
                field("Cod. Evento"; "Cod. Evento")
                {
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                }
                field("Descripcion Evento"; "Descripcion Evento")
                {
                }
                field(Delegacion; Delegacion)
                {
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

