page 67170 "Documentos operac. comerciales"
{
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = WHERE("Tipo registro" = CONST(28));

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

