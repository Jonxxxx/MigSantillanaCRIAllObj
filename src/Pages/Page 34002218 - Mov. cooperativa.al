page 34002218 "Mov. cooperativa"
{
    Caption = 'Cooperative entries';
    Editable = false;
    PageType = ListPart;
    SourceTable = 34002196;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Movimiento"; Rec."No. Movimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Movimiento';
                }
                field("Tipo miembro"; Rec."Tipo miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo miembro';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field("Tipo transaccion"; Rec."Tipo transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo transaccion';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
            }
        }
    }

    actions
    {
    }
}

