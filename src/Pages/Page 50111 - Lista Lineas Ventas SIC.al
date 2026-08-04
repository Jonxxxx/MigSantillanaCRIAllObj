page 55198 "Lista Lineas Ventas SIC"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55111;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field("No. linea"; Rec."No. linea")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. linea';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Cod. Moneda"; Rec."Cod. Moneda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Moneda';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Importe descuento"; Rec."Importe descuento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe descuento';
                }
                field("Precio de venta"; Rec."Precio de venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio de venta';
                }
                field("Unidad de medida"; Rec."Unidad de medida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unidad de medida';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Importe ITBIS Incluido"; Rec."Importe ITBIS Incluido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe ITBIS Incluido';
                }
                field(codproducto; Rec.codproducto)
                {
                    ApplicationArea = All;
                    ToolTip = 'codproducto';
                }
                field(Transferido; Rec.Transferido)
                {
                    ApplicationArea = All;
                    ToolTip = 'Transferido';
                }
                field(ITBIS; Rec.ITBIS)
                {
                    ApplicationArea = All;
                    ToolTip = 'ITBIS';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                }
                field(Origen; Rec.Origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'Origen';
                }
                field(Cupon; Rec.Cupon)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cupon';
                }
                field("No. documento SIC"; Rec."No. documento SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento SIC';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

