page 34002222 "Lista Hist. Prest. Cooperativa"
{
    Caption = 'Posted Cooperative Loans List';
    CardPageID = "Cab. Hist. prest. cooperativa";
    Editable = false;
    PageType = List;
    SourceTable = 34002199;

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
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                }
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                }
                field("Tipo prestamo"; Rec."Tipo prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo prestamo';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("% Interes"; Rec."% Interes")
                {
                    ApplicationArea = All;
                    ToolTip = '% Interes';
                }
                field("Cantidad de Cuotas"; Rec."Cantidad de Cuotas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Cuotas';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("Motivo Prestamo"; Rec."Motivo Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamo';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
                }
                field("Importe Pendiente"; Rec."Importe Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente';
                }
                field("Motivo de cierre"; Rec."Motivo de cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo de cierre';
                }
            }
        }
    }

    actions
    {
    }
}

