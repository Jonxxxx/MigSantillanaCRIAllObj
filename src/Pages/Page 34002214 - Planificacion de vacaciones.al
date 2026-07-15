page 34002214 "Planificacion de vacaciones"
{
    Caption = 'Vacation planning';
    PageType = List;
    SourceTable = 34002191;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. empleado"; "No. empleado")
                {
                }
                field("Fecha inicio planificada"; "Fecha inicio planificada")
                {
                }
                field("Fecha fin planificada"; "Fecha fin planificada")
                {
                }
                field("Dias acumulados actual"; "Dias acumulados actual")
                {
                }
                field("Dias acumulados estimados"; "Dias acumulados estimados")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Calendar")
            {
                Caption = '&Calendar';
                action("Suggest vacation")
                {
                    Caption = 'Suggest vacation';
                    Image = AbsenceCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver REPORT.RUNMODAL(REPORT::"Proceso proponer vacaciones", TRUE, FALSE);
                    end;
                }
            }
        }
    }
}

