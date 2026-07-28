page 34002138 "Lista Mov. CxC Empleados"
{
    CardPageID = "Historico Préstamos";
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
                field("No. Préstamo"; "No. Préstamo")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Fecha Registro CxC"; "Fecha Registro CxC")
                {
                }
                field("Tipo CxC"; "Tipo CxC")
                {
                }
                field("Importe Original"; "Importe Original")
                {
                }
                field(Cuotas; Cuotas)
                {
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field(Pendiente; Pendiente)
                {
                }
                field("Tipo Contrapartida"; "Tipo Contrapartida")
                {
                }
                field("Cta. Contrapartida"; "Cta. Contrapartida")
                {
                }
                field("Fecha Inicio Deduccion"; "Fecha Inicio Deduccion")
                {
                }
                field("Nro. Solicitud CK"; "Nro. Solicitud CK")
                {
                }
                field("Importe Pendiente Cte."; "Importe Pendiente Cte.")
                {
                }
                field("% Cuota"; "% Cuota")
                {
                    Visible = false;
                }
                field("Importe Pendiente"; "Importe Pendiente")
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Importe Cuota"; "Importe Cuota")
                {
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                    Visible = false;
                }
                field("Motivo Prestamos"; "Motivo Prestamos")
                {
                }
                field(Correccion; Correccion)
                {
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
                    Caption = 'Close Loan';
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

