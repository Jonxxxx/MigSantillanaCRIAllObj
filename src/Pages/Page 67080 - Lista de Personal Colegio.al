page 67080 "Lista de Personal Colegio"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = Card;
    SourceTable = 67057;
    UsageCategory = Lists;

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
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Visible = false;
                }
                field("Cod. Local"; "Cod. Local")
                {
                    Visible = false;
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                    Visible = false;
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                    Visible = false;
                }
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("Nombre Empleado"; "Nombre Empleado")
                {
                }
                field("Cod. Cargo"; "Cod. Cargo")
                {
                }
                field("Descripcion Cargo"; "Descripcion Cargo")
                {
                }
            }
        }
    }

    actions
    {
    }
}

