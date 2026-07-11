page 67015 "Programac. Talleres y Eventos"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = 67015;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Visible = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Visible = false;
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                }
                field("Fecha de realizacion"; "Fecha de realizacion")
                {
                }
                field(Avisado; Avisado)
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Nro. De asistentes reales"; "Nro. De asistentes reales")
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                }
                field("Hora Final"; "Hora Final")
                {
                }
                field("Horas dictadas"; "Horas dictadas")
                {
                    Editable = false;
                }
                field("Horas Pedagógicas"; "Horas Pedagógicas")
                {
                }
                field(Expositor; Expositor)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha propuesta"; "Fecha propuesta")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Hora Inicio Propuesta"; "Hora Inicio Propuesta")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Hora Fin Propuesta"; "Hora Fin Propuesta")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field(Observacion; Observacion)
                {
                }
                field(Estado; Estado)
                {
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
                Caption = 'Asistentes';

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
        rAsistentes: Record 67016;
        pAsistentes: Page 67016;
}

