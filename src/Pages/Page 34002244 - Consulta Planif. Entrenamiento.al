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
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                    Visible = false;
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                    Visible = false;
                }
                field("Fecha de realizacion"; "Fecha de realizacion")
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Nro. De asistentes reales"; "Nro. De asistentes reales")
                {
                }
                field("Horas dictadas"; "Horas dictadas")
                {
                    Visible = false;
                }
                field(Secuencia; Secuencia)
                {
                    Visible = false;
                }
                field(Estado; Estado)
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                    Visible = false;
                }
                field("Hora Final"; "Hora Final")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

