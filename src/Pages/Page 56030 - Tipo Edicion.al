page 55255 "Tipo Edicion"
{
    Caption = 'Edtion Type';
    PageType = List;
    SourceTable = 55229;

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

