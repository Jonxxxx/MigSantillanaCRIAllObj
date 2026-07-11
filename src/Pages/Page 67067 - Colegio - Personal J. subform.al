page 67067 "Colegio - Personal J. subform"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67043;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Nombre colegio"; "Nombre colegio")
                {
                    Visible = false;
                }
                field("Aplica Jerarquia Puestos"; "Aplica Jerarquia Puestos")
                {
                }
                field("Cod. Docente"; "Cod. Docente")
                {
                }
                field("Nombre docente"; "Nombre docente")
                {
                    Editable = false;
                }
                field("Cod. Cargo"; "Cod. Cargo")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                    Editable = false;
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                }
            }
        }
    }

    actions
    {
    }
}

