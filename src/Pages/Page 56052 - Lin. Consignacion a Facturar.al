page 56052 "Lin. Consignacion a Facturar"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table56011;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Cantidad a Facturar"; "Cantidad a Facturar")
                {
                }
                field(Marcada; Marcada)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Excel Document")
            {
                Caption = 'Import Excel Document';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FuncSant.RecibeNoDoc(NoPedido);
                    REPORT.RUNMODAL(56027);
                    CurrPage.UPDATE;
                end;
            }
            separator()
            {
            }
            action("Update Discounts")
            {
                Caption = 'Update Discounts';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(PageActDesc);
                    PageActDesc.RecibeNoPedido(NoPedido);
                    PageActDesc.RUNMODAL;
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        Counter := 0;
        CounterTotal := 0;

        RESET;
        SETRANGE("Document Type", "Document Type"::Order);
        SETRANGE("Document No.", NoPedido);
        SETRANGE("ID Usuario", USERID);
        SETRANGE(Marcada, TRUE);
        IF FINDSET THEN BEGIN
            Window.OPEN(Text001);
            CounterTotal := COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, "Document No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                SalesLine1.RESET;
                SalesLine1.SETRANGE(SalesLine1."Document Type", SalesLine1."Document Type"::Order);
                SalesLine1.SETRANGE(SalesLine1."Document No.", NoPedido);
                IF SalesLine1.FINDLAST THEN
                    NoLinea := SalesLine1."Line No."
                ELSE
                    NoLinea := 0;

                NoLinea += 10000;
                SalesLine.INIT;
                SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                SalesLine.VALIDATE("Document No.", NoPedido);
                SalesLine.VALIDATE("Line No.", NoLinea);
                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                SalesLine.VALIDATE("No.", "No.");

                SalesLine.VALIDATE("No. Mov. Prod. Cosg. a Liq.", "No. Mov. Prod. Cosg. a Liq.");

                //La cantidad que se pasa a las lineas de venta es la pendiente en el
                //Mov. producto
                SalesLine.VALIDATE(Quantity, "Cantidad a Facturar");
                SalesLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
                SalesLine.VALIDATE("No. Pedido Consignacion", "No. Pedido Consignacion");
                SalesLine.VALIDATE("No. Linea Pedido Consignacion", "No. Linea Pedido Consignacion");
                SalesLine.VALIDATE("Line Discount %", "Line Discount %");
                SalesLine.INSERT(TRUE);

            UNTIL NEXT = 0;
        END;
        Window.CLOSE;

        RESET;
        SETRANGE("ID Usuario", USERID);
        DELETEALL;
    end;

    trigger OnOpenPage()
    begin
        RESET;
        SETRANGE("ID Usuario", USERID);
    end;

    var
        NoPedido: Code[20];
        SalesLine1Record: Record 37;
        SalesLine: Record 37;
        rConsAFact Record: 56011" temporary;
        NoLinea: Integer;
        SH: Record 36;
        rLinCons Record: 56011" temporary;
        rItem: Record 27;
        rLCF: Record 56011;
        FuncSant: Codeunit 56000;
        PageActDesc: Page56053;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';

    procedure RecibeNoPedido(NoPedido_Loc: Code[20])
    begin
        NoPedido := NoPedido_Loc;
    end;
}

