page 34002134 "Historico Prestamos"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    SourceTable = 34002146;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
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
                field("Fecha Registro CxC"; Rec."Fecha Registro CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro CxC';
                }
                field("Tipo CxC"; Rec."Tipo CxC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo CxC';
                }
                field("Importe Original"; Rec."Importe Original")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Original';
                }
                field(Cuotas; Rec.Cuotas)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuotas';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field(Pendiente; Rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pendiente';
                }
                field("Tipo Contrapartida"; Rec."Tipo Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Contrapartida';
                }
                field("Cta. Contrapartida"; Rec."Cta. Contrapartida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contrapartida';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("Nro. Solicitud CK"; Rec."Nro. Solicitud CK")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nro. Solicitud CK';
                }
                field("Importe Pendiente Cte."; Rec."Importe Pendiente Cte.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente Cte.';
                }
                field("% Cuota"; Rec."% Cuota")
                {
                    ApplicationArea = All;
                    ToolTip = '% Cuota';
                }
                field("No. Mov. Cliente"; Rec."No. Mov. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mov. Cliente';
                }
                field("Importe Pendiente"; Rec."Importe Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente';
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
                field("Importe Cuota"; Rec."Importe Cuota")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Cuota';
                }
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
                }
                field("Motivo Prestamos"; Rec."Motivo Prestamos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamos';
                }
                field(Correccion; Rec.Correccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Correccion';
                }
            }
            // TODO: Manual review - Custom page 34002135 is unavailable, so the loan-history part and SubPageLink cannot be restored.
            // Original code preserved below.
            // part(PartPage; 34002135)
            // {
            //     SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Imprimir")
            {
                ApplicationArea = All;
                Caption = '&Imprimir';
                ToolTip = '&Imprimir';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(rPrestamo);
                    // TODO: Manual review - The custom Lista Mov. CxC Empl. report is unavailable in the current repository.
                    // Original code: REPORT.RUN(REPORT::"Lista Mov. CxC Empl.", TRUE, TRUE, rPrestamo);
                end;
            }
        }
    }

    var
        rPrestamo: Record 34002146;
    // TODO: Manual review - The Document-Print declaration has no active caller in this page and does not restore the missing custom report.
    // Original code: ImprInfor: Codeunit 228;
}

