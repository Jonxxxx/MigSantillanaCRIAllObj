page 56131 "Distribucción de Rutas"
{
    // #29481  03/09/2015  FAA   Creada para este desarrollo.

    PageType = List;
    SourceTable = 56071;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field("Nombre de Ruta"; "Nombre de Ruta")
                {
                }
                field(CP; CP)
                {
                }
                field(City; City)
                {
                }
                field("Region Code"; "Region Code")
                {
                }
                field(Country; Country)
                {
                }
                field(Colonia; Colonia)
                {
                }
                field("Tiempo de Envio"; "Tiempo de Envio")
                {
                }
            }
        }
    }

    actions
    {
    }
}

