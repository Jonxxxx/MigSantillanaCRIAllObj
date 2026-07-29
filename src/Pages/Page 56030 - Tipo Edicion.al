page 56030 "Tipo Edicion"
{
    Caption = 'Edtion Type';
    PageType = List;
    SourceTable = 56004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Tipo Edicion"; Rec."Cod. Tipo Edicion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Tipo Edicion';
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

