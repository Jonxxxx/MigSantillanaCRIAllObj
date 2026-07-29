page 34002223 "Cab. Hist. prest. cooperativa"
{
    Caption = 'Posted Cooperative Loans Header';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 34002199;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
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
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
                field("Motivo Prestamo"; Rec."Motivo Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamo';
                }
                field("Importe Pendiente"; Rec."Importe Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Pendiente; Rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pendiente';
                }
                field("Motivo de cierre"; Rec."Motivo de cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo de cierre';
                }
            }
            part("Cooperative loans lines"; 34002224)
            {
                Caption = 'Cooperative loans lines';
                SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                action("Pause fee")
                {
                    ApplicationArea = All;
                    Caption = 'Pause fee';
                    ToolTip = 'Pause fee';
                    Image = Pause;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Msg001, FALSE) THEN
                            EXIT;

                        IF Status = Status::Pausado THEN
                            EXIT;

                        Status := Status::Pausado;
                        "Fecha de pausa" := TODAY;
                        MODIFY
                    end;
                }
                action("Activate fee")
                {
                    ApplicationArea = All;
                    Caption = 'Activate fee';
                    ToolTip = 'Activate fee';
                    Image = ActivateDiscounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        IF Status <> Status::Pausado THEN
                            EXIT;

                        Status := Status::Activo;
                        "Fecha de pausa" := 0D;
                        MODIFY
                    end;
                }
            }
        }
    }

    var
        Msg001: Label 'If you put the loan on pause, the system will not calculate the discount for the fe payment in the next payroll. \ Do you want to continue?';
}

