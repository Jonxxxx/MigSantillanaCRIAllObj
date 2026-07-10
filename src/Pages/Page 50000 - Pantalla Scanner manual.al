page 50000 "Pantalla Scanner manual"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            group()
            {
                field(; '')
                {
                    CaptionClass = Text19049871;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(; '')
                {
                    CaptionClass = Text19037213;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(; '')
                {
                    CaptionClass = Text19065178;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(NoDocumento; NoDocumento)
                {
                    Editable = false;
                }
                field(CodBarras; cCodBarras)
                {
                }
                field(; '')
                {
                    CaptionClass = FORMAT(DescPro);
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Cant; wCantidad)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Intro)
            {
                Caption = 'Aceptar';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    BuscarEnPedido;
                end;
            }
        }
    }

    var
        NoDocumento: Code[20];
        TipoDocumento: Option;
        DescPro: Text[200];
        wCantidad: Decimal;
        cCodBarras: Code[20];
        rUdadMedProd Record: 5404;
        rTransferLine Record: 5741;
        txt0001: Label 'Producto no se encuentra en Lineas de Transferencia %1 %2';
        txt0002: Label 'No se encuentra el codigo de barra %2';
        Text19049871: Label 'No. Documento';
        Text19037213: Label 'Cod. Barras';
        Text19065178: Label 'Cantidad';

    procedure RecibeParam(NoPedido: Code[20])
    begin
        NoDocumento := NoPedido;
    end;

    procedure BuscarEnPedido()
    var
        rItemCrossRe Record: 5717;
        rItem: Record 27;
    begin
        IF cCodBarras <> '' THEN BEGIN
            rItemCrossRe.RESET;
            rItemCrossRe.SETRANGE(rItemCrossRe."Cross-Reference Type", rItemCrossRe."Cross-Reference Type"::"Bar Code");
            rItemCrossRe.SETRANGE(rItemCrossRe."Cross-Reference No.", cCodBarras);
            IF rItemCrossRe.FIND('-') THEN BEGIN
                IF rItem.GET(rItemCrossRe."Item No.") THEN BEGIN
                    DescPro := rItem.Description;
                    CurrPage.UPDATE;
                END;
                //Buscamo linea en el pedido
                rTransferLine.RESET;
                rTransferLine.SETRANGE(rTransferLine."Document No.", NoDocumento);
                rTransferLine.SETRANGE(rTransferLine."Item No.", rItem."No.");
                IF rTransferLine.FINDFIRST THEN BEGIN
                    rTransferLine."Qty. to Ship" += wCantidad;
                    rTransferLine.VALIDATE("Qty. to Ship");
                    rTransferLine.MODIFY(TRUE);
                END
                ELSE
                    MESSAGE(txt0001, rItem."No.", rItem.Description);
            END
            ELSE
                MESSAGE(txt0002, cCodBarras);
        END;
    end;

    local procedure cCodBarrasOnDeactivate()
    var
        rItemCrossRe Record: 5717;
        rItem: Record 27;
    begin
        rItemCrossRe.RESET;
        rItemCrossRe.SETRANGE(rItemCrossRe."Cross-Reference Type", rItemCrossRe."Cross-Reference Type"::"Bar Code");
        rItemCrossRe.SETRANGE(rItemCrossRe."Cross-Reference No.", cCodBarras);
        IF rItemCrossRe.FIND('-') THEN BEGIN
            IF rItem.GET(rItemCrossRe."Item No.") THEN
                IF rItemCrossRe."Unit of Measure" <> '' THEN BEGIN
                    rUdadMedProd.GET(rItem."No.", rItemCrossRe."Unit of Measure");
                    DescPro := rItem.Description;
                    CurrPage.UPDATE;
                END;
        END;
    end;
}

