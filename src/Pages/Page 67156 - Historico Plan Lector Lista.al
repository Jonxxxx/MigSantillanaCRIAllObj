page 67156 "Historico Plan Lector Lista"
{
    ApplicationArea = Basic,Suite,Service;
    CardPageID = "Historico Plan Lector Ficha";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67095;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Campaña;Campaña)
                {
                }
                field("Cod. Colegio";"Cod. Colegio")
                {
                }
                field("Nombre Colegio";"Nombre Colegio")
                {
                }
                field("Cod. Local";"Cod. Local")
                {
                }
                field("Descripcion Local";"Descripcion Local")
                {
                }
                field("Cod. Turno";"Cod. Turno")
                {
                }
                field("Descripcion Turno";"Descripcion Turno")
                {
                }
                field(Distrito;Distrito)
                {
                }
                field("Cod. Delegacion";"Cod. Delegacion")
                {
                }
                field("Descripción Delegacion";"Descripción Delegacion")
                {
                }
            }
        }
    }

    actions
    {
    }
}

