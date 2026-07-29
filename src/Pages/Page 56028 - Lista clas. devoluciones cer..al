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
            repeater(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Customer no."; Rec."Customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer no.';
                }
                field("Customer name"; Rec."Customer name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer name';
                }
                field("Receipt date"; Rec."Receipt date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Receipt date';
                }
                field(Procesada; Rec.Procesada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Procesada';
                }
                field("Usuario clasificacion"; Rec."Usuario clasificacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario clasificacion';
                }
                field("Fecha hora clasificacion"; Rec."Fecha hora clasificacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha hora clasificacion';
                }
                field("Dev. ventas generadas"; Rec."Dev. ventas generadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dev. ventas generadas';
                    DrillDown = false;
                }
                field("Dev. Trans. generadas"; Rec."Dev. Trans. generadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dev. Trans. generadas';
                    DrillDown = false;
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
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
                ApplicationArea = All;
                Caption = '&Create documents';
                ToolTip = '&Create documents';
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
                ApplicationArea = All;
                Caption = '&Print';
                ToolTip = '&Print';
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
                ApplicationArea = All;
                Caption = 'Imprimir documentos generados';
                ToolTip = 'Imprimir documentos generados';
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
        CreaDev: Report 56000;
}

