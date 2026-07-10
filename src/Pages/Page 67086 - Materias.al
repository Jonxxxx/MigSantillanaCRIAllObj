page 67086 Materias
{
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro,Codigo)
                      WHERE(Tipo registro=CONST(Materia));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Codigo;Codigo)
                {
                }
                field(Descripcion;Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

