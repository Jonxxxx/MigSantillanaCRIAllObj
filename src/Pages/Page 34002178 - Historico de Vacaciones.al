page 55819 "Historico de Vacaciones"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 55782;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Visible = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field("Fecha Fin"; Rec."Fecha Fin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Fin';
                }
                field(Dias; Rec.Dias)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias';
                }
                field("Tipo calculo"; Rec."Tipo calculo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo calculo';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

