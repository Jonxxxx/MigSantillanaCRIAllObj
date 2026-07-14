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
                field("Cod. Grupo"; "Cod. Grupo")
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
        area(creation)
        {
            action("Asociar Colegios")
            {
                Caption = 'Asociar Colegios';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 67143;
                RunPageLink = "Cod. grupo" = FIELD("Cod. Grupo");
            }
        }
    }
}

