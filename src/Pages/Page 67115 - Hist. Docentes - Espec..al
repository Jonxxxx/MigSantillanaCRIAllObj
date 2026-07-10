page 67115 "Hist. Docentes - Espec."
{
    ApplicationArea = Basic,Suite,Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67074;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Campana;Campana)
                {
                }
                field("Cod. Docente";"Cod. Docente")
                {
                    Visible = false;
                }
                field("Cod. Nivel";"Cod. Nivel")
                {
                }
                field("Cod. Especialidad";"Cod. Especialidad")
                {
                }
                field("Descripcion especialidad";"Descripcion especialidad")
                {
                    Editable = false;
                }
                field("Cod. grado";"Cod. grado")
                {
                }
                field("Nombre Docente";"Nombre Docente")
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

