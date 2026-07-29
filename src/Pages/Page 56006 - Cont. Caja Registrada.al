page 56006 "Cont. Caja Registrada"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 56035;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Producto"; Rec."No. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Producto';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. Barras"; Rec."Cod. Barras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Barras';
                }
                field("Cod. Unidad de Medida"; Rec."Cod. Unidad de Medida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Unidad de Medida';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("No. Picking"; Rec."No. Picking")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Picking';
                }
                field("No. Linea Picking"; Rec."No. Linea Picking")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Linea Picking';
                }
            }
        }
    }

    actions
    {
    }
}

