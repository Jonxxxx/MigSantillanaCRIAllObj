page 34002200 "Shift schedule"
{
    PageType = List;
    SourceTable = 34002180;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo turno"; Rec."Codigo turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo turno';
                    Visible = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicio';
                }
                field("Hora Fin"; Rec."Hora Fin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Fin';
                }
                field("Hora almuerzo"; Rec."Hora almuerzo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora almuerzo';
                }
            }
        }
    }

    actions
    {
    }
}

