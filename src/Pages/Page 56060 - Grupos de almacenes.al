page 56060 "Grupos de almacenes"
{
    // 001 RRT 02.06.2014

    PageType = List;
    SourceTable = Table56058;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Grupo; Grupo)
                {
                }
                field(Descripción; Descripción)
                {
                }
            }
            part(AlmacenesRelacionados; 56061)
            {
                SubPageLink = Grupo = FIELD("Grupo");
            }
        }
    }

    actions
    {
    }
}

