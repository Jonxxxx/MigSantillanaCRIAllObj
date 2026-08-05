page 55482 "Programac. Talleres y Eventos"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = 55482;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Visible = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Visible = false;
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                }
                field("Fecha de realizacion"; Rec."Fecha de realizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de realizacion';
                }
                field(Avisado; Rec.Avisado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Avisado';
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
                field("Hora de Inicio"; Rec."Hora de Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora de Inicio';
                }
                field("Hora Final"; Rec."Hora Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Final';
                }
                field("Horas dictadas"; Rec."Horas dictadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas dictadas';
                    Editable = false;
                }
                field("Horas Pedagogicas"; Rec."Horas Pedag gicas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas Pedag gicas';
                }
                field(Expositor; Rec.Expositor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositor';
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                    Editable = false;
                    Visible = false;
                }
                field("Fecha propuesta"; Rec."Fecha propuesta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha propuesta';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Hora Inicio Propuesta"; Rec."Hora Inicio Propuesta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicio Propuesta';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Hora Fin Propuesta"; Rec."Hora Fin Propuesta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Fin Propuesta';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field(Observacion; Rec.Observacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observacion';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Asistentes)
            {

                ApplicationArea = All;
                Caption = 'Asistentes';
                ToolTip = 'Asistentes';
                trigger OnAction()
                begin

                    CLEAR(pAsistentes);
                    rAsistentes.RESET;
                    rAsistentes.FILTERGROUP(2);
                    rAsistentes.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                    rAsistentes.SETRANGE("Tipo Evento", "Tipo Evento");
                    rAsistentes.SETRANGE(Secuencia, Secuencia);
                    rAsistentes.SETRANGE("Cod. Expositor", Expositor);
                    rAsistentes.SETRANGE(rAsistentes."No Linea Programac.", "No. Linea");
                    rAsistentes.FILTERGROUP(0);
                    pAsistentes.SETTABLEVIEW(rAsistentes);
                    pAsistentes.RecibeProgEvento("No. Linea");
                    pAsistentes.RUN;
                end;
            }
        }
    }

    var
        rAsistentes: Record 55483;
        pAsistentes: Page 55483;
}

