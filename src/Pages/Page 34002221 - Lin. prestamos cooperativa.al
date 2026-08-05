page 55862 "Lin. prestamos cooperativa"
{
    Caption = 'Cooperative loan lines';
    Editable = false;
    PageType = ListPart;
    SourceTable = 55839;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Tipo prestamo"; Rec."Tipo prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo prestamo';
                    Visible = false;
                }
                field("Fecha Transaccion"; Rec."Fecha Transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Transaccion';
                    Visible = false;
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
                field(Capital; Rec.Capital)
                {
                    ApplicationArea = All;
                    ToolTip = 'Capital';
                }
                field(Saldo; Rec.Saldo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo';
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

