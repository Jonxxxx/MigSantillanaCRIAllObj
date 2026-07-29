page 56029 Edicion
{
    Caption = 'Edition';
    PageType = List;
    SourceTable = 56007;

    layout
    {
        area(content)
        {
            repeater(Group)
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
    }
}

