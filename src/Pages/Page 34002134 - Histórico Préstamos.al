page 34002134 "Historico Préstamos"
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
                }
                field("No. Mov. Cliente"; "No. Mov. Cliente")
                {
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
                }
                field("Motivo Prestamos"; "Motivo Prestamos")
                {
                }
                field(Correccion; Correccion)
                {
                }
            }
            //TODO: Ver part(PartPage; 34002135)
            //TODO: Ver {
            //TODO: Ver     SubPageLink = "No. Préstamo" = FIELD("No. Préstamo");
            //TODO: Ver }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Imprimir")
            {
                Caption = '&Imprimir';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(rPrestamo);
                    //TODO: Ver REPORT.RUN(REPORT::"Lista Mov. CxC Empl.", TRUE, TRUE, rPrestamo);
                end;
            }
        }
    }

    var
        rPrestamo: Record 34002146;
    //TODO: Ver ImprInfor: Codeunit 228;
}

