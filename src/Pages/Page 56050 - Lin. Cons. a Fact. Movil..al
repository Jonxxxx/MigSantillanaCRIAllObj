page 56050 "Lin. Cons. a Fact. Movil."
{
    Caption = 'Consignment Line to invoice';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 56017;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field("Description 2; "Description 2")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    Editable = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&OK")
            {
                Caption = '&OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    RESET;
                    SETRANGE("Document Type","Document Type"::Order);
                    SETRANGE("ID Usuario",USERID);
                    SETRANGE(Marcada,TRUE);
                    IF FINDSET THEN
                      REPEAT
                        SalesLine1.RESET;
                        SalesLine1.SETRANGE(SalesLine1."Document Type",SalesLine1."Document Type"::Order);
                        SalesLine1.SETRANGE(SalesLine1."Document No.",NoPedido);
                        IF SalesLine1.FINDLAST THEN
                          NoLinea := SalesLine1."Line No."
                        ELSE
                          NoLinea := 0;
                    
                        NoLinea += 10000;
                        SalesLine.INIT;
                        SalesLine.VALIDATE("Document Type",SalesLine."Document Type"::Order);
                        SalesLine.VALIDATE("Document No.",NoPedido);
                        SalesLine.VALIDATE("Line No.",NoLinea);
                        SalesLine.VALIDATE(Type,SalesLine.Type::Item);
                        SalesLine.VALIDATE("No.","No.");
                    
                        SalesLine.VALIDATE("No. Mov. Prod. Cosg. a Liq.","No. Mov. Prod. Cosg. a Liq.");
                    
                        //La cantidad que se pasa a las lineas de venta es la pendiente en el
                        //Mov. producto
                        SalesLine.VALIDATE(Quantity,"Cantidad a Facturar");
                    
                        SalesLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
                    
                        //el precio de venta es el actual. confirmado por Robert Molina el 22 Julio 2011
                        {
                        SalesLine.VALIDATE("Unit Price",TransRecLines."Precio Venta Consignacion");
                        SalesLine.VALIDATE(SalesLine."Line Discount %",TransRecLines."Descuento % Consignacion");
                        }
                        SalesLine.VALIDATE("No. Pedido Consignacion","No. Pedido Consignacion");
                        SalesLine.VALIDATE("No. Linea Pedido Consignacion","No. Linea Pedido Consignacion");
                        SalesLine.INSERT(TRUE);
                    
                      UNTIL NEXT = 0;
                    CurrPage.CLOSE;
                     */

                end;
            }
            action("&Cancel")
            {
                Caption = '&Cancel';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        RESET;
        SETRANGE("ID Usuario", USERID);
        DELETEALL;

        LlenaTabla;
    end;

    var
        rConsAFact Record: 56017" temporary;
        NoLinea: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        rLinCons Record: 56017" temporary;
        rItem: Record 27;
        rLCF: Record 56017;
        NoCliente: Code[20];
        Cust: Record 18;

    procedure RecibeNoCliente(NoCliente_Loc: Code[20])
    begin
        NoCliente := NoCliente_Loc;
    end;

    procedure LlenaTabla()
    var
        NoPedidoActual: Code[20];
        SalesHeader: Record 36;
        SalesLine Record: 37" temporary;
        TransHeader1Record: Record 5740;
        SalesLine1Record: Record 37;
        TransRecHeader: Record 5746;
        TransRecLines: Record 5747;
        TransRecHeader1Record: Record 5746;
        TransRecLines1Record: Record 5747;
        ItemLedgerEntry: Record 32;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
    begin
        Cust.GET(NoCliente);
        Cust.TESTFIELD("Cod. Almacen Consignacion");

        Counter := 0;
        CounterTotal := 0;

        Window.OPEN(Text001);

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", Cust."Cod. Almacen Consignacion");
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            CounterTotal := ItemLedgerEntry.COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, ItemLedgerEntry."Document No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                IF ItemLedgerEntry."Remaining Quantity" <> 0 THEN BEGIN
                    //En caso de que el producto ya esté se suma la cantidad
                    //Cod. Cliente,No.,ID Usuario
                    rLCF.RESET;
                    rLCF.SETRANGE("Cod. Cliente", Cust."No.");
                    rLCF.SETRANGE("No.", ItemLedgerEntry."Item No.");
                    rLCF.SETRANGE("ID Usuario", USERID);
                    rLCF.SETRANGE("Unit of Measure Code", ItemLedgerEntry."Unit of Measure Code");
                    IF rLCF.FINDFIRST THEN BEGIN
                        rLCF.Quantity += ItemLedgerEntry."Remaining Quantity";
                        rLCF."Cantidad a Facturar" += ItemLedgerEntry."Remaining Quantity";
                        rLCF.MODIFY;
                    END
                    ELSE BEGIN
                        NoLinea := NoLinea + 10000;
                        INIT;
                        VALIDATE("Line No.", NoLinea);
                        VALIDATE("No.", ItemLedgerEntry."Item No.");
                        VALIDATE("ID Usuario", USERID);
                        VALIDATE(Quantity, ItemLedgerEntry."Remaining Quantity");
                        VALIDATE("Cantidad a Facturar", ItemLedgerEntry."Remaining Quantity");
                        VALIDATE("Unit of Measure Code", ItemLedgerEntry."Unit of Measure Code");
                        rItem.GET(ItemLedgerEntry."Item No.");
                        VALIDATE(Description, rItem.Description);
                        VALIDATE("Cod. Cliente", Cust."No.");
                        VALIDATE("Description 2", Cust.Name);
                        INSERT;
                    END;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        Window.CLOSE;
    end;
}

