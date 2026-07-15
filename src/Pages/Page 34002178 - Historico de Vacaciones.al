page 34002178 "Historico de Vacaciones"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 34002141;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. empleado"; "No. empleado")
                {
                    Visible = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field("Fecha Fin"; "Fecha Fin")
                {
                }
                field(Dias; Dias)
                {
                }
                field("Tipo calculo"; "Tipo calculo")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

