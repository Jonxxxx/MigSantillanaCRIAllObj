page 55873 "Lin. Entrenamientos"
{
    Caption = 'Training lines';
    PageType = ListPart;
    SourceTable = 55846;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                    Visible = false;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                    Visible = false;
                }
                field(Disponible; Rec.Disponible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Disponible';
                    Visible = false;
                }
                field("Tipo de Instructor"; Rec."Tipo de Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Instructor';
                    Visible = false;
                }
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                    Visible = false;
                }
                field("Nombre Instructor"; Rec."Nombre Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Instructor';
                    Visible = false;
                }
                field(Avisado; Rec.Avisado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Avisado';
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
                field("Nro. De asistentes reales"; Rec."Nro. De asistentes reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nro. De asistentes reales';
                }
                field(Observacion; Rec.Observacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observacion';
                }
                field(Objetivo; Rec.Objetivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo';
                }
                field("Descripcion observacion"; Rec."Descripcion observacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion observacion';
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
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
                }
                field("Hora Final"; Rec."Hora Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Final';
                }
                field("Area Curricular"; Rec."Area Curricular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Curricular';
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
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
                    ApplicationArea = All;
                    Caption = 'Attendees';
                    ToolTip = 'Attendees';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page 55874;
                    RunPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                                  "Fecha programacion" = FIELD("Fecha programacion");
                }
            }
        }
    }

    var
        AsistentesEnt: Record 55847;
        pAsistentesEnt: Page 55874;
}

