page 56017 "Cab. Hoja de Ruta Reg. List"
{
    CardPageID = "Cab. Hoja de Ruta Reg.";
    Editable = false;
    PageType = List;
    SourceTable = 56022;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Hoja Ruta"; "No. Hoja Ruta")
                {
                }
                field("Cod. Transportista"; "Cod. Transportista")
                {
                }
                field("Fecha Planificacion Transporte"; "Fecha Planificacion Transporte")
                {
                }
                field(Comentario; Comentario)
                {
                }
                field(Hora; Hora)
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field("Hoja de Ruta Origen"; "Hoja de Ruta Origen")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
    }
}

