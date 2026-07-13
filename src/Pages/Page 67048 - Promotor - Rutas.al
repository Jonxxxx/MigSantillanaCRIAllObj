page 67048 "Promotor - Rutas"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67044;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field("Cod. Ruta"; "Cod. Ruta")
                {
                }
                field("Descripcion Ruta"; "Descripcion Ruta")
                {
                    Editable = false;
                }
                field("Cod. Zona"; "Cod. Zona")
                {
                }
                field("Descripcion zona"; "Descripcion zona")
                {
                    Editable = false;
                }
                field("Cod. Supervisor"; "Cod. Supervisor")
                {
                }
                field("Nombre Supervisor"; "Nombre Supervisor")
                {
                    Editable = false;
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Descripcion Delegacion"; "Descripcion Delegacion")
                {
                }
            }
        }
    }

    actions
    {
    }
}

