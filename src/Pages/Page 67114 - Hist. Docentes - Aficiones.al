page 67114 "Hist. Docentes - Aficiones"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67075;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Campana; Campana)
                {
                }
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

