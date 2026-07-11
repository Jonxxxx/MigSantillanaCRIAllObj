page 67089 "Equipos Talleres y Eventos"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = 67059;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Codigo Equipo"; "Codigo Equipo")
                {
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Descripcion Equipo"; "Descripcion Equipo")
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("Costo Unitario"; "Costo Unitario")
                {
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

