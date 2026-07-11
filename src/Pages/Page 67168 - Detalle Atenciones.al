page 67168 "Detalle Atenciones"
{
    PageType = List;
    SourceTable = 67100;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tipo; Tipo)
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripción; Descripción)
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("Precio Unitario"; "Precio Unitario")
                {
                }
                field("Monto total"; "Monto total")
                {
                }
            }
        }
    }

    actions
    {
    }
}

