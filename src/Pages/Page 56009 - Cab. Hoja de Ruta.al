page 55234 "Cab. Hoja de Ruta"
{
    // #2655 PLB 08/04/2014: Añadido campo "Placa"
    // #29576  08/09/2015   FAA    Se agrega campo "Ruta de Distribucion" y otras modificaciones.

    PageType = Document;
    SourceTable = 55245;

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
                    Editable = false;
                }
                field(Chofer; Rec.Chofer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Chofer';
                }
                field("Nombre Chofer"; Rec."Nombre Chofer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Chofer';
                    Editable = false;
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
                field("No. Ruta Distribucion"; Rec."No. Ruta Distribucion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Ruta Distribucion';
                    Caption = 'No. Ruta Distribucion';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);    //#29576
                    end;
                }
                field("Nombre de Ruta"; Rec."Nombre de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre de Ruta';
                    Editable = false;
                }
            }
            part(Pagelin; 55235)
            {
                SubPageLink = "No. Hoja Ruta" = FIELD("No. Hoja Ruta");
                SubPageView = SORTING("No. Hoja Ruta", "No. Linea")
                              ORDER(Ascending);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Generate Guide Number")
            {
                ApplicationArea = All;
                Caption = '&Generate Guide Number';
                ToolTip = '&Generate Guide Number';
                Promoted = true;
                PromotedCategory = Process;
            }
            group("<Action1000000009>")
            {
                Caption = '&Post';
                action("<Action1000000010>")
                {
                    ApplicationArea = All;
                    Caption = '&Registrar';
                    ToolTip = '&Registrar';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM(txt001) THEN
                            FunSant.RegHojaEnv(Rec, FALSE);
                    end;
                }
                action("&Post And Print")
                {
                    ApplicationArea = All;
                    Caption = '&Post And Print';
                    ToolTip = '&Post And Print';
                    Image = PostPrint;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM(txt002) THEN
                            FunSant.RegHojaEnv(Rec, TRUE);
                    end;
                }
                action("Actualizar Lineas")
                {
                    ApplicationArea = All;
                    Caption = 'Actualizar Lineas';
                    ToolTip = 'Actualizar Lineas';
                    Ellipsis = true;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recLinHojaRuta: Record 55246;
                    begin
                        recLinHojaRuta.ActualizarLineas("No. Hoja Ruta", "No. Ruta Distribucion");
                    end;
                }
            }
        }
    }

    var
        LHR: Record 55246;
        CHRR: Record 55247;
        LHRR: Record 55248;
        NoSeriesMngm: Codeunit "No. Series";
        SRS: Record 311;
        txt001: Label 'Confirm that you want to post the Route Sheet';
        txt002: Label 'Confirm that you want to Post and Print the Route Sheet';
        LHRR1Record: Record 55248;
        FunSant: Codeunit 55225;
        rCHRL: Record 55245;
}

