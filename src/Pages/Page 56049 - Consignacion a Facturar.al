page 56049 "Consignacion a Facturar"
{
    Caption = 'Consignment to Invoice';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 56012;

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
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
                field("Precio Venta Consignacion"; "Precio Venta Consignacion")
                {
                    Editable = false;
                }
                field("Descuento % Consignacion"; "Descuento % Consignacion")
                {
                    Editable = false;
                }
                field("Importe Consignacion"; "Importe Consignacion")
                {
                    Editable = false;
                }
                field("No. Pedido Consignacion"; "No. Pedido Consignacion")
                {
                    Editable = false;
                }
                field(Marcada; Marcada)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        Ejecuta;
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("ID Usuario", USERID);
    end;

    var
        NoPedido: Code[20];
        SalesLine1Record: Record 37;
        SalesLine: Record 37;
        rConsAFact: Record 56012;
        NoLinea: Integer;
        TransferLine1Record: Record 5741;
        TransferLines: Record 5741;
        DescrProd: Text[200];
        rItem: Record 27;

    procedure RecibeNoPedido(NoPedido_Loc: Code[20])
    begin
        NoPedido := NoPedido_Loc;
    end;

    procedure Ejecuta()
    begin
        rConsAFact.RESET;
        rConsAFact.SETRANGE("Document No.", NoPedido);
        rConsAFact.SETRANGE("ID Usuario", USERID);
        rConsAFact.SETRANGE(Marcada, TRUE);
        IF rConsAFact.FINDSET THEN
            REPEAT
                TransferLine1.RESET;
                TransferLine1.SETRANGE("Document No.", NoPedido);
                IF TransferLine1.FINDLAST THEN
                    NoLinea := TransferLine1."Line No."
                ELSE
                    NoLinea := 0;

                NoLinea += 10000;
                TransferLines.INIT;
                TransferLines.VALIDATE("Document No.", NoPedido);
                TransferLines.VALIDATE("Line No.", NoLinea);
                TransferLines.VALIDATE("Item No.", rConsAFact."Item No.");

                TransferLines.VALIDATE("No. Mov. Prod. Cosg. a Liq.", rConsAFact."No. Mov. Prod. Cosg. a Liq.");

                //La cantidad que se pasa a las lineas de venta es la pendiente en el
                //Mov. producto
                TransferLines.VALIDATE(Quantity, rConsAFact.Quantity);

                TransferLines.VALIDATE("Unit of Measure Code", rConsAFact."Unit of Measure Code");
                //TransferLines.VALIDATE("Precio Venta Consignacion",rConsAFact."Precio Venta Consignacion");
                //TransferLines.VALIDATE("Descuento % Consignacion",rConsAFact."Descuento % Consignacion");
                TransferLines.VALIDATE("No. Pedido Consignacion", rConsAFact."Document No.");
                TransferLines.VALIDATE("No. Linea Pedido Consignacion", rConsAFact."Line No.");
                TransferLines.VALIDATE(Quantity, rConsAFact.Quantity);
                TransferLines.VALIDATE("Qty. to Ship", rConsAFact.Quantity);
                //TransferLines.VALIDATE("Descuento % Consignacion",rConsAFact."Descuento % Consignacion");
                //TransferLines.VALIDATE("Precio Venta Consignacion",rConsAFact."Precio Venta Consignacion");
                //si la cantidad pendiente es 0 no sube la linea al pedido.
                IF TransferLines.Quantity > 0 THEN
                    TransferLines.INSERT(TRUE);

            UNTIL rConsAFact.NEXT = 0;

        //+PLB
        rConsAFact.RESET;
        rConsAFact.SETRANGE("Document No.", NoPedido);
        rConsAFact.SETRANGE("ID Usuario", USERID);
        rConsAFact.DELETEALL;
        //-PLB
    end;
}

