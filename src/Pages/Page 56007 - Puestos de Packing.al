page 56007 "Puestos de Packing"
{
    Caption = 'Packing Position';
    PageType = List;
    SourceTable = 56036;

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
                field("Control Peso"; "Control Peso")
                {
                }
                field("Usuario Asignado"; "Usuario Asignado")
                {
                }
            }
        }
    }

    actions
    {
    }
}

