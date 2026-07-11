page 67167 "Lista Atenciones"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = WHERE("Tipo registro" = CONST(Atenciones));
    UsageCategory = Lists;

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
                field("Costo Unitario"; "Costo Unitario")
                {
                }
            }
        }
    }

    actions
    {
    }
}

