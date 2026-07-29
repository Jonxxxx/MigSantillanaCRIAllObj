page 50029 "Condiciones de la venta"
{
    PageType = List;
    SourceTable = 50029;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field("Condicion de la Venta"; Rec."Condicion de la Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Condicion de la Venta';
                }
                field(Inactivo; Rec.Inactivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactivo';
                }
            }
        }
    }

    actions
    {
    }
}

