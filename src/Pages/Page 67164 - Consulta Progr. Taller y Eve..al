page 55623 "Consulta Progr. Taller y Eve."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55482;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                }
                field(FechaInicioFinal; FORMAT("Hora de Inicio") + ' - ' + FORMAT("Hora Final"))
                {
                    ApplicationArea = All;
                    Caption = 'Horario';
                }
                field("Horas dictadas"; Rec."Horas dictadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas dictadas';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
            }
        }
    }

    actions
    {
    }
}

