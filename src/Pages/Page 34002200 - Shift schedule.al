page 34002200 "Shift schedule"
{
    PageType = List;
    SourceTable = 34002180;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo turno"; "Codigo turno")
                {
                    Visible = false;
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Hora Inicio"; "Hora Inicio")
                {
                }
                field("Hora Fin"; "Hora Fin")
                {
                }
                field("Hora almuerzo"; "Hora almuerzo")
                {
                }
            }
        }
    }

    actions
    {
    }
}

