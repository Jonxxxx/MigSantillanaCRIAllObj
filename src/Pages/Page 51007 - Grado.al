page 51007 Grado
{
    Caption = 'Grade';
    PageType = List;
    SourceTable = 51012;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
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

