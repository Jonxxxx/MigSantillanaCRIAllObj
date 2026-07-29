page 56070 "Lin. Crea Cup. Lote"
{
    PageType = ListPart;
    SourceTable = 51011;

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
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("% Descuento"; Rec."% Descuento")
                {
                    ApplicationArea = All;
                    ToolTip = '% Descuento';
                }
            }
        }
    }

    actions
    {
    }
}

