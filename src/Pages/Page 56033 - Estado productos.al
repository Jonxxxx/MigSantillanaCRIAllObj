page 56033 "Estado productos"
{
    // #6357  PLB   05/11/2014  Se ha creado la page

    PageType = List;
    SourceTable = 56008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

