page 51004 "Lin. Cupon"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 51010;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Precio Venta"; Rec."Precio Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio Venta';
                }
                field("% Descuento"; Rec."% Descuento")
                {
                    ApplicationArea = All;
                    ToolTip = '% Descuento';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Cantidad Pendiente"; Rec."Cantidad Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Pendiente';
                }
            }
        }
    }

    actions
    {
    }
}

