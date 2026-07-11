page 56067 "Chofer por Transportista"
{
    // #2655 PLB 08/04/2014: Añadido campos calculados "Activo" y "Observaciones"

    Caption = 'Chofer por Transportista';
    PageType = List;
    SourceTable = 56042;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Chofer"; "Cod. Chofer")
                {
                }
                field("Nombre Chofer"; "Nombre Chofer")
                {
                }
                field("No. Licencia"; "No. Licencia")
                {
                }
                field("Chofer activo"; "Chofer activo")
                {
                }
                field("Observaciones chofer"; "Observaciones chofer")
                {
                }
            }
        }
    }

    actions
    {
    }
}

