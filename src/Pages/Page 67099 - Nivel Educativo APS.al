page 67099 "Nivel Educativo APS"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67022;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                }
            }
        }
    }

    actions
    {
    }
}

