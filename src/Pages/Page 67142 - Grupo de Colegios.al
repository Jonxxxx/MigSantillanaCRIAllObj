page 67142 "Grupo de Colegios"
{
    PageType = List;
    SourceTable = 67089;

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
                RunObject = Page 67143;
                RunPageLink = "Cod. grupo" = FIELD("Cod. Grupo");
            }
        }
    }
}

