page 55243 "Inventario Disponible"
{
    Editable = false;
    PageType = List;
    SourceTable = 55249;

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
                field("Cod. Almancen"; Rec."Cod. Almancen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Almancen';
                }
                field(Inventario; Rec.Inventario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inventario';
                }
                field("Fecha Ult. Actualizacion"; Rec."Fecha Ult. Actualizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Ult. Actualizacion';
                }
                field("Linea de Negocio"; Rec."Linea de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Linea de Negocio';
                }
                field("Cod. Categoria Producto"; Rec."Cod. Categoria Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Categoria Producto';
                }
                field("Nombre Categoria Producto"; Rec."Nombre Categoria Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Categoria Producto';
                }
            }
        }
    }

    actions
    {
    }
}

