page 67058 "Docentes - Aficiones"
{
    PageType = Card;
    SourceTable = 67048;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Docente"; "Cod. Docente")
                {
                    Visible = false;
                }
                field("Nombre Docente"; "Nombre Docente")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. aficion"; "Cod. aficion")
                {
                }
                field("Descripcion aficion"; "Descripcion aficion")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

