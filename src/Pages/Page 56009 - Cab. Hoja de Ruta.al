page 56009 "Cab. Hoja de Ruta"
{
    // #2655 PLB 08/04/2014: Añadido campo "Placa"
    // #29576  08/09/2015   FAA    Se agrega campo "Ruta de Distribucion" y otras modificaciones.

    PageType = Document;
    SourceTable = 56020;

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
                    Editable = false;
                }
                field(Chofer; Chofer)
                {
                }
                field("Nombre Chofer"; "Nombre Chofer")
                {
                    Editable = false;
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
                field("No. Ruta Distribucion"; "No. Ruta Distribucion")
                {
                    Caption = 'No. Ruta Distribucion';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);    //#29576
                    end;
                }
                field("Nombre de Ruta"; "Nombre de Ruta")
                {
                    Editable = false;
                }
            }
            part(Pagelin; 56010)
            {
                SubPageLink = "No. Hoja Ruta" = FIELD("No. Hoja Ruta");
                SubPageView = SORTING("No. Hoja Ruta", "No. Linea")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Generate Guide Number")
            {
                Caption = '&Generate Guide Number';
                Promoted = true;
                PromotedCategory = Process;
            }
            group("<Action1000000009>")
            {
                Caption = '&Post';
                action("<Action1000000010>")
                {
                    Caption = '&Registrar';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver IF CONFIRM(txt001) THEN
                        //TODO: Ver     FunSant.RegHojaEnv(Rec, FALSE);
                    end;
                }
                action("&Post And Print")
                {
                    Caption = '&Post And Print';
                    Image = PostPrint;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver IF CONFIRM(txt002) THEN
                        //TODO: Ver     FunSant.RegHojaEnv(Rec, TRUE);
                    end;
                }
                action("Actualizar Lineas")
                {
                    Caption = 'Actualizar Lineas';
                    Ellipsis = true;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recLinHojaRuta: Record 56021;
                    begin
                        recLinHojaRuta.ActualizarLineas("No. Hoja Ruta", "No. Ruta Distribucion");
                    end;
                }
            }
        }
    }

    var
        LHR: Record 56021;
        CHRR: Record 56022;
        LHRR: Record 56023;
        NoSeriesMngm: Codeunit "No. Series";
        SRS: Record 311;
        txt001: Label 'Confirm that you want to post the Route Sheet';
        txt002: Label 'Confirm that you want to Post and Print the Route Sheet';
        LHRR1Record: Record 56023;
        //TODO: Ver FunSant: Codeunit 56000;
        rCHRL: Record 56020;
}

