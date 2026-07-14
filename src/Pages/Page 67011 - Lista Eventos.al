page 67011 "Lista Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Talleres - Eventos";
    Editable = false;
    PageType = List;
    SourceTable = 67011;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Tipo de Evento"; "Tipo de Evento")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Fecha creacion"; "Fecha creacion")
                {
                }
                field("Capacidad de vacantes"; "Capacidad de vacantes")
                {
                }
                field("Horas programadas"; "Horas programadas")
                {
                }
            }
        }
        area(factboxes)
        {
            part(PageEventos; 67117)
            {
                SubPageLink = "Cod. Evento" = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

