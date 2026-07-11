page 56015 "Cab. Hoja de Ruta Reg."
{
    // #2655    PLB  08/04/2014: Añadido campo "Placa"
    // #50366   JMB  16/05/2016: Se muestra el campo "Hoja de ruta de orgigen"

    Editable = false;
    PageType = Document;
    SourceTable = 56022;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Hoja Ruta"; "No. Hoja Ruta")
                {
                }
                field("Cod. Transportista"; "Cod. Transportista")
                {
                }
                field("Nombre Transportista"; "Nombre Transportista")
                {
                }
                field("Fecha Planificacion Transporte"; "Fecha Planificacion Transporte")
                {
                }
                field(Placa; Placa)
                {
                }
                field(Comentario; Comentario)
                {
                }
                field(Hora; Hora)
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field(Anulada; Anulada)
                {
                }
                field("Hoja de Ruta Origen"; "Hoja de Ruta Origen")
                {
                }
            }
            part(; 56016)
            {
                SubPageLink = No. Hoja Ruta=FIELD("No. Hoja Ruta");
                    SubPageView = SORTING(No. Hoja Ruta,No. Linea)
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            systempart(; MyNotes)
            {
            }
            systempart(; Links)
            {
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
                    Caption = '&Resumido';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(CHRR);
                        REPORT.RUNMODAL(56024, TRUE, FALSE, CHRR);
                    end;
                }
                action("<Action1000000015>")
                {
                    Caption = '&Detallado';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(CHRR);
                        REPORT.RUNMODAL(56018, TRUE, FALSE, CHRR);
                    end;
                }
            }
            group("<Action1000000017>")
            {
                Caption = '&Acciones';
                action("<Action1000000018>")
                {
                    Caption = '&Void';
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
        CHRR: Record 56022;
        UserSetUp: Record 91;
        Error001: Label 'User cannot void Route Guide';
}

