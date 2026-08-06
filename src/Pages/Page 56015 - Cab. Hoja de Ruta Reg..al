page 55240 "Cab. Hoja de Ruta Reg."
{
    // #2655    PLB  08/04/2014: Añadido campo "Placa"
    // #50366   JMB  16/05/2016: Se muestra el campo "Hoja de ruta de orgigen"

    Editable = false;
    PageType = Document;
    SourceTable = 55247;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Hoja Ruta"; Rec."No. Hoja Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Hoja Ruta';
                }
                field("Cod. Transportista"; Rec."Cod. Transportista")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Transportista';
                }
                field("Nombre Transportista"; Rec."Nombre Transportista")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Transportista';
                }
                field("Fecha Planificacion Transporte"; Rec."Fecha Planificacion Transporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Planificacion Transporte';
                }
                field(Placa; Rec.Placa)
                {
                    ApplicationArea = All;
                    ToolTip = 'Placa';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field(Anulada; Rec.Anulada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Anulada';
                }
                field("Hoja de Ruta Origen"; Rec."Hoja de Ruta Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hoja de Ruta Origen';
                }
            }
            part(PageLin; 55241)
            {
                SubPageLink = "No. Hoja Ruta" = FIELD("No. Hoja Ruta");
                SubPageView = SORTING("No. Hoja Ruta", "No. Linea")
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            systempart(Notes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000014>")
            {
                Caption = 'Imprimir';
                action("<Action1000000013>")
                {
                    ApplicationArea = All;
                    Caption = '&Resumido';
                    ToolTip = '&Resumido';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(CHRR);
                        REPORT.RUNMODAL(55249, TRUE, FALSE, CHRR);
                    end;
                }
                action("<Action1000000015>")
                {
                    ApplicationArea = All;
                    Caption = '&Detallado';
                    ToolTip = '&Detallado';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(CHRR);
                        REPORT.RUNMODAL(55243, TRUE, FALSE, CHRR);
                    end;
                }
            }
            group("<Action1000000017>")
            {
                Caption = '&Acciones';
                action("<Action1000000018>")
                {
                    ApplicationArea = All;
                    Caption = '&Void';
                    ToolTip = '&Void';
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF UserSetUp.GET(USERID) THEN BEGIN
                            IF NOT UserSetUp."Anula Hoja de Ruta" THEN
                                ERROR(Error001);
                            Anulada := TRUE;
                            MODIFY;
                        END
                        ELSE
                            ERROR(Error001);
                    end;
                }
            }
        }
    }

    var
        CHRR: Record 55247;
        UserSetUp: Record 91;
        Error001: Label 'User cannot void Route Guide';
}

