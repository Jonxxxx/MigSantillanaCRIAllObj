page 67039 "Promotor - Entrega de Muestras"
{
    PageType = Card;
    SourceTable = 67039;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field(Fecha; Fecha)
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field(Estado; Estado)
                {
                }
                field("Fecha Visita"; "Fecha Visita")
                {
                }
                field("Hora Inicial Visita"; "Hora Inicial Visita")
                {
                }
                field("Hora Inicial Final"; "Hora Inicial Final")
                {
                }
                field("Fecha Proxima Visita"; "Fecha Proxima Visita")
                {
                }
                field(Comentario; Comentario)
                {
                }
            }
        }
    }

    actions
    {
    }
}

