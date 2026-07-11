page 56061 "Productos x Almacen Subform"
{
    // 001 RRT 02.06.2014

    PageType = ListPart;
    SourceTable = 56059;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Almacen; Almacen)
                {
                }
                field("Nombre Almacen"; "Nombre Almacen")
                {
                }
            }
        }
    }

    actions
    {
    }
}

