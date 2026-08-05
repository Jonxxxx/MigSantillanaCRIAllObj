page 55601 "Grupo de Colegios"
{
    PageType = List;
    SourceTable = 55651;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Grupo"; Rec."Cod. Grupo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grupo';
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
        area(creation)
        {
            action("Asociar Colegios")
            {
                ApplicationArea = All;
                Caption = 'Asociar Colegios';
                ToolTip = 'Asociar Colegios';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 55602;
                RunPageLink = "Cod. grupo" = FIELD("Cod. Grupo");
            }
        }
    }
}

