page 67183 "Area Curricular - APS"
{
    PageType = List;
    SourceTable = 67002;
    SourceTableView = WHERE("Tipo registro" = CONST(29));

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

