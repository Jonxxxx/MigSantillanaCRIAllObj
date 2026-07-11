page 67037 "Colegio - Grados"
{
    DataCaptionFields = "Cod. Colegio";
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67037;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Visible = false;
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field(Seccion; Seccion)
                {
                }
                field("Cantidad Secciones"; "Cantidad Secciones")
                {
                }
                field("Cantidad Alumnos"; "Cantidad Alumnos")
                {
                }
                field("Cantidad Docentes"; "Cantidad Docentes")
                {
                }
                field("Lista Utiles"; "Lista Utiles")
                {
                }
                field("Lista Competencia"; "Lista Competencia")
                {
                }
                field("Horas Ingles"; "Horas Ingles")
                {
                }
            }
        }
    }

    actions
    {
    }
}

