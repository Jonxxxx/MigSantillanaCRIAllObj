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
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Fecha inicio planificada"; Rec."Fecha inicio planificada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inicio planificada';
                }
                field("Fecha fin planificada"; Rec."Fecha fin planificada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha fin planificada';
                }
                field("Dias acumulados actual"; Rec."Dias acumulados actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias acumulados actual';
                }
                field("Dias acumulados estimados"; Rec."Dias acumulados estimados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias acumulados estimados';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
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
                    ApplicationArea = All;
                    Caption = 'Suggest vacation';
                    ToolTip = 'Suggest vacation';
                    Image = AbsenceCalendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // TODO: Manual review - The custom Proceso proponer vacaciones report is unavailable in the current repository.
                        // Original code: REPORT.RUNMODAL(REPORT::"Proceso proponer vacaciones", TRUE, FALSE);
                    end;
                }
            }
        }
    }
}

