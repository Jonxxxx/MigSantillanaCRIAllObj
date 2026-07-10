codeunit 56001 "Trae Inv. Consig"
{
    Permissions = TableData 32 = rm;

    trigger OnRun()
    begin
    end;

    var
        SalesLine1Record 37;
        SalesLine Record: 37;
        NoPedidoActual: Code[20];
        CFuncSantillana: Codeunit 56000;
        TransRecLines Record: 5747;
        NoLinea: Integer;
        ItemLedgerEntry Record: 32;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';

    procedure CalcInvConsig(CodCliente: Code[20])
    begin
        CLEARALL;
        NoPedidoActual := CFuncSantillana.EnviaNoTransferencia;
        Counter := 0;
        CounterTotal := 0;

        //Buscamos lineas pedido de venta a consignacion
        TransRecLines.RESET;
        TransRecLines.SETCURRENTKEY("Transfer-to Code");
        TransRecLines.SETRANGE("Transfer-to Code", CodCliente);
        CounterTotal := TransRecLines.COUNT;
        Window.OPEN(Text001);

        IF TransRecLines.FINDSET THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, TransRecLines."Document No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", SalesLine1."Document Type"::Order);
                SalesLine1.SETRANGE("Document No.", NoPedidoActual);
                IF SalesLine1.FINDLAST THEN
                    NoLinea := SalesLine1."Line No."
                ELSE
                    NoLinea := 0;

                NoLinea += 10000;
                SalesLine.INIT;
                SalesLine."Document Type" := SalesLine."Document Type"::Order;
                SalesLine."Document No." := NoPedidoActual;
                SalesLine."Line No." := NoLinea;
                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                SalesLine.VALIDATE("No.", TransRecLines."Item No.");

                //Se busca el No. de mov. producto correspondiente a la linea para pasarla a la linea de pedidos
                //de venta
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
                ItemLedgerEntry.SETRANGE("Document No.", TransRecLines."Document No.");
                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                ItemLedgerEntry.SETRANGE("Document Line No.", TransRecLines."Line No.");
                ItemLedgerEntry.SETRANGE("Location Code", TransRecLines."Transfer-to Code");
                IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                    SalesLine.VALIDATE("No. Mov. Prod. Cosg. a Liq.", ItemLedgerEntry."Entry No.");

                    //La cantidad que se pasa a las lineas de venta es la pendiente en el
                    //Mov. producto
                    SalesLine.VALIDATE(Quantity, ItemLedgerEntry."Cant. Consignacion Pendiente");

                    SalesLine.VALIDATE("Unit of Measure Code", TransRecLines."Unit of Measure Code");
                    //GRN        SalesLine.VALIDATE("Unit Price",TransRecLines."Precio Venta Consignacion");
                    SalesLine.VALIDATE(SalesLine."Line Discount %", TransRecLines."Descuento % Consignacion");
                    SalesLine.VALIDATE("No. Pedido Consignacion", TransRecLines."Document No.");
                    SalesLine.VALIDATE("No. Linea Pedido Consignacion", TransRecLines."Line No.");

                    //si la cantidad pendiente es 0 no sube la linea al pedido.
                    IF SalesLine.Quantity > 0 THEN
                        SalesLine.INSERT(TRUE);
                END;
            UNTIL TransRecLines.NEXT = 0;

        Window.CLOSE;
    end;
}

