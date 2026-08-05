page 55627 "Detalle Atenciones"
{
    PageType = List;
    SourceTable = 55559;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Precio Unitario"; Rec."Precio Unitario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio Unitario';
                }
                field("Monto total"; Rec."Monto total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto total';
                }
            }
        }
    }

    actions
    {
    }
}

