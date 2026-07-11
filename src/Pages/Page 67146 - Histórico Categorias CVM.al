page 67146 "Histórico Categorias CVM"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67093;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Campaña; Campaña)
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Grupo Negocio"; "Grupo Negocio")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field(Categoria; Categoria)
                {
                }
            }
        }
    }

    actions
    {
    }
}

