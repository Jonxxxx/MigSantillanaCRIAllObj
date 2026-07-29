page 56034 "Sello/Marca"
{
    // #6357  PLB   05/11/2014  Se ha creado la page

    PageType = List;
    SourceTable = 56003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Sello/Marca"; Rec."Cod. Sello/Marca")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Sello/Marca';
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
    }
}

