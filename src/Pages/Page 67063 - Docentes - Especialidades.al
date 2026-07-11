page 67063 "Docentes - Especialidades"
{
    PageType = Card;
    SourceTable = 67018;

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
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Especialidad"; "Cod. Especialidad")
                {
                }
                field("Descripcion especialidad"; "Descripcion especialidad")
                {
                    Editable = false;
                }
                field("Cod. grado"; "Cod. grado")
                {
                }
                field("Nombre Docente"; "Nombre Docente")
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

