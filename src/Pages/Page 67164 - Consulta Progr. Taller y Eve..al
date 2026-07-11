page 67164 "Consulta Progr. Taller y Eve."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67015;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha programacion"; "Fecha programacion")
                {
                }
                field(FORMAT("Hora de Inicio") + ' - ' + FORMAT("Hora Final"); FORMAT("Hora de Inicio") + ' - ' + FORMAT("Hora Final"))
                {
                    Caption = 'Horario';
                }
                field("Horas dictadas"; "Horas dictadas")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
            }
        }
    }

    actions
    {
    }
}

