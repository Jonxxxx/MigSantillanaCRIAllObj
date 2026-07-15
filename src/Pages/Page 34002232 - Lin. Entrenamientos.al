page 34002232 "Lin. Entrenamientos"
{
    Caption = 'Training lines';
    PageType = ListPart;
    SourceTable = 34002205;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. entrenamiento"; "No. entrenamiento")
                {
                    Visible = false;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                    Visible = false;
                }
                field(Disponible; Disponible)
                {
                    Visible = false;
                }
                field("Tipo de Instructor"; "Tipo de Instructor")
                {
                    Visible = false;
                }
                field("Cod. Instructor"; "Cod. Instructor")
                {
                    Visible = false;
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                    Visible = false;
                }
                field(Avisado; Avisado)
                {
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                }
                field("Nro. De asistentes reales"; "Nro. De asistentes reales")
                {
                }
                field(Observacion; Observacion)
                {
                }
                field(Objetivo; Objetivo)
                {
                }
                field("Descripcion observacion"; "Descripcion observacion")
                {
                }
                field(Secuencia; Secuencia)
                {
                }
                field(Estado; Estado)
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                }
                field("Hora Final"; "Hora Final")
                {
                }
                field("Area Curricular"; "Area Curricular")
                {
                }
                field(Sala; Sala)
                {
                }
                field(Tipo; Tipo)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Asistentes)
                {
                    Caption = 'Attendees';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page 34002233;
                    RunPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                                  "Fecha programacion" = FIELD("Fecha programacion");
                }
            }
        }
    }

    var
        AsistentesEnt: Record 34002206;
        pAsistentesEnt: Page 34002233;
}

