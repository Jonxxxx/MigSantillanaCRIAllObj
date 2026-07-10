page 67014 "Materiales Talleres y Eventos"
{
    ApplicationArea = Basic,Suite,Service;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = Table67014;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Taller - Evento";"Cod. Taller - Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Description Taller";"Description Taller")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento";"Tipo Evento")
                {
                }
                field("Tipo de Material";"Tipo de Material")
                {
                }
                field("Codigo Material";"Codigo Material")
                {
                }
                field("Description Material";"Description Material")
                {
                }
                field(Cantidad;Cantidad)
                {
                }
                field("Costo Unitario";"Costo Unitario")
                {
                }
            }
        }
    }

    actions
    {
    }
}

