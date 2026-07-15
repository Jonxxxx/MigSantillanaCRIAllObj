page 34002140 "Gpo. Contable Empleados"
{
    PageType = List;
    SourceTable = 34002104;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
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
        area(processing)
        {
            action("&Setup")
            {
                Caption = '&Setup';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 34002141;
                RunPageLink = Codigo = FIELD(Codigo);
            }
        }
    }
}

