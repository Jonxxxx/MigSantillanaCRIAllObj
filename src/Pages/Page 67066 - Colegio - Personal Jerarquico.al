page 67066 "Colegio - Personal Jerarquico"
{
    PageType = Card;
    SourceTable = 67056;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
            }
            part(PagePart; 67067)
            {
                SubPageLink = "Cod. Colegio" = FIELD("Cod. Colegio"),
                              "Cod. Docente" = FIELD("Cod. Local"),
                              "Nombre colegio" = FIELD("Cod. Nivel"),
                              "Nombre docente" = FIELD("Cod. Turno");
            }
        }
    }

    actions
    {
    }
}

