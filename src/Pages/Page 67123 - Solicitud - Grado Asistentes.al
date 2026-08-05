page 55582 "Solicitud - Grado Asistentes"
{
    PageType = List;
    SourceTable = 55548;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("No. Asistentes"; Rec."No. Asistentes")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes';
                }
            }
        }
    }

    actions
    {
    }
}

