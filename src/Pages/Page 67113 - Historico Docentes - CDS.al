page 67113 "Historico Docentes - CDS"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = List;
    SourceTable = 67072;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Docente"; "Cod. Docente")
                {
                    Visible = false;
                }
                field(Campana; Campana)
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field("Cod. CDS"; "Cod. CDS")
                {
                }
                field("Ult. fecha activacion"; "Ult. fecha activacion")
                {
                }
            }
        }
    }

    actions
    {
    }
}

