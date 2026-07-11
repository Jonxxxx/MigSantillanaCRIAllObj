page 56028 "Lista clas. devoluciones cer."
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Closed returns classification';
    Editable = false;
    PageType = List;
    SourceTable = 56025;
    SourceTableView = WHERE("Closed" = CONST(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("No."; "No.")
                {
                }
                field("Customer no."; "Customer no.")
                {
                }
                field("Customer name"; "Customer name")
                {
                }
                field("Receipt date"; "Receipt date")
                {
                }
                field(Procesada; Procesada)
                {
                }
                field("Usuario clasificacion"; "Usuario clasificacion")
                {
                }
                field("Fecha hora clasificacion"; "Fecha hora clasificacion")
                {
                }
                field("Dev. ventas generadas"; "Dev. ventas generadas")
                {
                    DrillDown = false;
                }
                field("Dev. Trans. generadas"; "Dev. Trans. generadas")
                {
                    DrillDown = false;
                }
                field(Comentario; Comentario)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000009>")
            {
                Caption = '&Create documents';
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CR: Record 56025;
                begin
                    CR.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(REPORT::"Clasifica devoluciones", TRUE, FALSE, CR);
                end;
            }
            action("<Action1000000010>")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CR: Record 56025;
                begin
                    CR.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(REPORT::"Listado clas. devoluciones", TRUE, FALSE, CR);
                end;
            }
            action("Imprimir documentos generados")
            {
                Caption = 'Imprimir documentos generados';
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CR: Record 56025;
                begin
                    CR.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(REPORT::"Documentos generados clas. dev", TRUE, FALSE, CR);
                end;
            }
        }
    }

    var
        CreaDev: Report "56000;
}

