page 34002167 "Dimensiones Contabilizacion"
{
    PageType = List;
    SourceTable = 34002132;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Dimension"; Rec."Cod. Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension';
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Orden';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Requerida; Rec.Requerida)
                {
                    ApplicationArea = All;
                    ToolTip = 'Requerida';
                }
                field("Validar en"; Rec."Validar en")
                {
                    ApplicationArea = All;
                    ToolTip = 'Validar en';
                }
            }
        }
    }

    actions
    {
    }
}

