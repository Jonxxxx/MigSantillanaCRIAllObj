page 53000 "Tareas Impresora Fiscal"
{
    Caption = 'Fiscal Printer Tasks';

    layout
    {
        area(content)
        {
            group("Para Reporte de cierres por fechas")
            {
                Caption = 'Para Reporte de cierres por fechas';
                Visible = false;
                field(FechaDesde; FechaDesde)
                {
                    ApplicationArea = All;
                }
                field(FechaHasta; FechaHasta)
                {
                    ApplicationArea = All;
                }
                field(Detallado; Detallado)
                {
                    ApplicationArea = All;
                    Caption = 'Detallado';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("<Action1000000004>")
            {
                Caption = '&Printed';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // TODO: Manual review - The fiscal-printer close-Z sequence depends on removed OCX hardware integration and cannot operate in SaaS.
                    // Original code preserved below.
                    // cuImpFisc.AbrePuerto;
                    // cuImpFisc.CierreZ('P');
                    // cuImpFisc.CerrarPrinter;
                end;
            }
            action("&Cierre X")
            {
                Caption = '&Cierre X';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // TODO: Manual review - The fiscal-printer close-X sequence depends on removed OCX hardware integration and cannot operate in SaaS.
                    // Original code preserved below.
                    // cuImpFisc.AbrePuerto;
                    // cuImpFisc.CierreX('P');
                    // cuImpFisc.CerrarPrinter;
                end;
            }

            action("<Action1000000005>")
            {
                Caption = '&Daily Close by date';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    // TODO: Manual review - The fiscal audit report block depends on removed OCX hardware integration and requires an external-service redesign.
                    /*
                    cuImpFisc.AbrePuerto;
                    IF Detallado THEN
                        cuImpFisc.RepAuditPorFecha(FechaDesde, FechaHasta, 'O')
                    ELSE
                        cuImpFisc.RepAuditPorFecha(FechaDesde, FechaHasta, 'G');
                    cuImpFisc.CerrarPrinter;*/
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ConfSant.GET;
        ConfSant.TESTFIELD("Funcionalidad Imp. Fiscal Act.");
    end;

    var
        UserSetUp: Record 91;
        ConfSant: Record 56001;
        // TODO: Manual review - Codeunit 53000 exposes printer methods whose OCX implementation was removed, so invoking them would not perform fiscal printing.
        // Original code: cuImpFisc: Codeunit 53000;
        FechaDesde: Date;
        FechaHasta: Date;
        Detallado: Boolean;
}

