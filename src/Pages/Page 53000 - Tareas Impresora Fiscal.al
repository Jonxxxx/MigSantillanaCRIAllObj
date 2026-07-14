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
                }
                field(FechaHasta; FechaHasta)
                {
                }
                field(Detallado; Detallado)
                {
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
                    //TODO: Ver cuImpFisc.AbrePuerto;
                    //TODO: Ver cuImpFisc.CierreZ('P');
                    //TODO: Ver cuImpFisc.CerrarPrinter;
                end;
            }
            action("&Cierre X")
            {
                Caption = '&Cierre X';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TODO: Ver cuImpFisc.AbrePuerto;
                    //TODO: Ver cuImpFisc.CierreX('P');
                    //TODO: Ver cuImpFisc.CerrarPrinter;
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
                    //TODO: Ver 
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
        //TODO: Ver cuImpFisc: Codeunit 53000;
        FechaDesde: Date;
        FechaHasta: Date;
        Detallado: Boolean;
}

