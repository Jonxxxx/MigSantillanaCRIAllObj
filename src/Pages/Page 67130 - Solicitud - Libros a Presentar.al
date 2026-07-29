page 67130 "Solicitud - Libros a Presentar"
{
    PageType = List;
    SourceTable = 67085;

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
                field("Descripcion Producto"; Rec."Descripcion Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Producto';
                }
                field("Horas por semana"; Rec."Horas por semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas por semana';
                }
                field("Año adopcion"; Rec."Ano adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano adopcion';
                }
            }
        }
    }

    actions
    {
    }
}

