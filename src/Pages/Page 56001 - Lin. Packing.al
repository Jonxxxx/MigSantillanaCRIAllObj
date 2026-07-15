page 56001 "Lin. Packing"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadida opcion para reabrir caja.
    //                                   Cambios para funcionar correctamente en
    //                                   BBDD sin gestion almacén.
    // #4191  PLB  30/09/2014  Añadido atajo de teclado a "Contenido caja" -> Mayús+Ctrl+D

    Caption = 'Packing Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 56031;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Caja"; "No. Caja")
                {
                }
                field("Fecha Apertura Caja"; "Fecha Apertura Caja")
                {
                }
                field("Fecha Cierre Caja"; "Fecha Cierre Caja")
                {
                }
                field("Estado Caja"; "Estado Caja")
                {
                }
                field("No. Palet"; "No. Palet")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000008>")
            {
                Caption = '&Eliminar Caja';

                trigger OnAction()
                begin
                    IF CONFIRM(txt0001, FALSE) THEN BEGIN
                        DELETE;
                    END;
                end;
            }

            action("<Action1000000011>")
            {
                Caption = '&Box Content';
                InFooterBar = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 56003;
                RunPageLink = "No. Packing" = FIELD("No."),
                              "No. Caja" = FIELD("No. Caja"),
                              "No. Picking" = FIELD("No. Picking"),
                              "Tipo pedido" = FIELD("Tipo pedido"),
                              "No. Pedido" = FIELD("No. Pedido");
                RunPageView = SORTING("No. Packing", "No. Caja", "No. Picking", "No. Producto", "No. Linea")
                              ORDER(Ascending);
                ShortCutKey = 'Shift+Ctrl+D';
            }
            group("<Action1000000010>")
            {
                Caption = '&Imprimir';
                action("<Action1000000006>")
                {
                    Caption = '&Print Box Tag';

                    trigger OnAction()
                    begin
                        ConfSant.GET;
                        ConfSant.TESTFIELD("ID Reporte Etiqueta de Caja");
                        CurrPage.SETSELECTIONFILTER(LinPack);
                        REPORT.RUNMODAL(56019, TRUE, TRUE, LinPack);
                    end;
                }
            }
            action("<Action1000000012>")
            {
                Caption = '&Reabrir Caja';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM(txt005, FALSE) THEN
                        ReabrirCaja;
                end;
            }
        }
    }

    var
        txt0001: Label 'Confirm that you want to delete the selected box';
        LinPack: Record 56031;
        ConfSant: Record 56001;
        txt005: Label 'Confirm that you want to open the box';

    procedure ReabrirCaja()
    var
    //TODO: Ver FuncSant: Codeunit 56000;
    begin
        //TODO: Ver FuncSant.ReabrirCajaPacking(Rec);
    end;
}

