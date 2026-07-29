page 34002244 "Consulta Planif. Entrenamiento"
{
    PageType = ListPart;
    SourceTable = 34002202;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
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
            }
        }
    }

    actions
    {
    }
}

