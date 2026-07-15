page 34003007 "Config. Split CC"
{
    PageType = List;
    SourceTable = 34003010;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cta. Contable"; "Cta. Contable")
                {
                    Visible = false;
                }
                field("Descripcion Cta. Contable"; "Descripcion Cta. Contable")
                {
                }
                field("Dimension Code"; "Dimension Code")
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("% a distribuir"; "% a distribuir")
                {
                }
            }
        }
    }

    actions
    {
    }
}

