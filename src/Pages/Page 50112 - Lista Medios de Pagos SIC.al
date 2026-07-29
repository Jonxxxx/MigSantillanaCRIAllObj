page 50112 "Lista Medios de Pagos SIC"
{
    Editable = false;
    PageType = List;
    SourceTable = 50113;

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
                field("No. documento Pos"; Rec."No. documento Pos")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento Pos';
                }
                field("No. linea"; Rec."No. linea")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. linea';
                }
                field("Cod. medio de pago"; Rec."Cod. medio de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. medio de pago';
                }
                field("Cod. cliente"; Rec."Cod. cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. cliente';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Cod. divisa"; Rec."Cod. divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa';
                }
                field("Tasa de cambio"; Rec."Tasa de cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tasa de cambio';
                }
                field("Source Counter"; Rec."Source Counter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Source Counter';
                }
                field(Transferido; Rec.Transferido)
                {
                    ApplicationArea = All;
                    ToolTip = 'Transferido';
                }
            }
        }
    }

    actions
    {
    }
}

