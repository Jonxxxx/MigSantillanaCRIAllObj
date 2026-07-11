page 56066 Choferes
{
    // #2655 PLB 08/04/2014: Añadido campos calculados "Activo" y "Observaciones"

    PageType = List;
    SourceTable = 56041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Chofer"; "Cod. Chofer")
                {
                }
                field(Nombre; Nombre)
                {
                }
                field("No. Licencia"; "No. Licencia")
                {
                }
                field(Activo; Activo)
                {
                }
                field(Observaciones; Observaciones)
                {
                }
            }
        }
    }

    actions
    {
    }
}

