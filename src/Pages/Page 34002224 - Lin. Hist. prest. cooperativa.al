page 55865 "Lin. Hist. prest. cooperativa"
{
    PageType = ListPart;
    SourceTable = 55841;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Prestamo"; Rec."No. Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Prestamo';
                    Visible = false;
                }
                field("Codigo Empleado"; Rec."Codigo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Empleado';
                    Visible = false;
                }
                field("No. Cuota"; Rec."No. Cuota")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuota';
                }
                field("Fecha Transaccion"; Rec."Fecha Transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Transaccion';
                }
                field("Saldo inicial"; Rec."Saldo inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo inicial';
                }
                field(Interes; Rec.Interes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Interes';
                }
                field("Importe cuota"; Rec."Importe cuota")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe cuota';
                }
                field(Amortizacion; Rec.Amortizacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amortizacion';
                }
                field("Saldo final"; Rec."Saldo final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo final';
                }
                field("Importe mora"; Rec."Importe mora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe mora';
                    Visible = false;
                }
                field("Fecha mora"; Rec."Fecha mora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha mora';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

