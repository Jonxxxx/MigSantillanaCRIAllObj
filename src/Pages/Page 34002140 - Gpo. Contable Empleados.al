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
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
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
                ApplicationArea = All;
                Caption = '&Setup';
                ToolTip = '&Setup';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 34002141;
                RunPageLink = Codigo = FIELD(Codigo);
            }
        }
    }
}

