page 34002138 "Lista Mov. CxC Empleados"
{
    CardPageID = "Historico Prestamos";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002146;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
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
                    Visible = false;
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
                    Visible = false;
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Employee")
            {
                Caption = '&Employee';
                action("Close Loan")
                {
                    ApplicationArea = All;
                    Caption = 'Close Loan';
                    ToolTip = 'Close Loan';
                    Image = AdjustItemCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        // TODO: Manual review - Custom report 34002142 is unavailable as the required object type.
                        // Original code: CierraPrestamo: Report 34002142;
                        HCP: Record 34002146;
                    begin
                        CurrPage.SETSELECTIONFILTER(HCP);
                        // TODO: Manual review - The custom Cierra Prestamos report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Cierra Prestamos", TRUE, FALSE, HCP);
                    end;
                }
            }
        }
    }
}

