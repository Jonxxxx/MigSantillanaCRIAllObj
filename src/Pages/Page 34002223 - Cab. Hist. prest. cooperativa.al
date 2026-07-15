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
                field("No. Prestamo"; "No. Prestamo")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Tipo de miembro"; "Tipo de miembro")
                {
                }
                field("Tipo prestamo"; "Tipo prestamo")
                {
                }
                field(Importe; Importe)
                {
                }
                field("% Interes"; "% Interes")
                {
                }
                field("Cantidad de Cuotas"; "Cantidad de Cuotas")
                {
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                }
                field("Fecha Inicio Deduccion"; "Fecha Inicio Deduccion")
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Motivo Prestamo"; "Motivo Prestamo")
                {
                }
                field("Importe Pendiente"; "Importe Pendiente")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Pendiente; Pendiente)
                {
                }
                field("Motivo de cierre"; "Motivo de cierre")
                {
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
                    Caption = 'Pause fee';
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
                    Caption = 'Activate fee';
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

