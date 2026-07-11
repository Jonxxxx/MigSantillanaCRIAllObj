page 67127 "Historico Colegio - Grados"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67069;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
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
                field("Fecha Decision"; "Fecha Decision")
                {
                }
                field(Campana; Campana)
                {
                }
            }
        }
    }

    actions
    {
    }
}

